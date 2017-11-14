<?php

namespace App;

use Illuminate\Database\Eloquent\Model;


/**
 * Class Product
 * @package App
 */
class Product extends Model
{

    private $products;
    private $weightSortList;
    private $priceMax;
    private $weightMax;
    private $priceAvg;
    private $weightAvg;

    protected $fillable = [
        'name', 'price', 'weight'
    ];

    /**
     * @return \Illuminate\Database\Eloquent\Collection|static[]
     * @throws \Exception
     */
    public function getProducts(){
        try {
            return self::all(['id', 'name', 'price', 'weight']);
        }
        catch (\QueryException $ex) {
            throw new \Exception($ex->getMessage());
        }
    }

    /**
     * @param $request
     * @return array
     * @throws \Exception
     */
    public  function assignSplitRules($request){
        try{
            $this->products = self::findMany($request->get('packages'))
                ->sortByDesc('price')
                ->values()
                ->all();

            $priceList = array_column($this->products, 'price' , 'id');
            $this->priceMax = max($priceList);
            $priceMin = min($priceList);
            $this->priceAvg = round(($this->priceMax + $priceMin) / 2);

            $weightList = array_column($this->products, 'weight' , 'id');
            $this->weightSortList = collect($this->products)->sortByDesc('weight')->toArray();
            $this->weightMax = max($weightList);
            $weightMin = min($weightList);
            $this->weightAvg = round(($this->weightMax + $weightMin) / 2);

            return $this->getSort();
        }
        catch (\QueryException $ex) {
            throw new \Exception($ex->getMessage());
        }

    }

    /**
     * @return array
     */
    private function getTotalValue(){

        $totalWeight = null;
        $totalPrice = null;
        $items=[];

        foreach ( $this->products as $product){

            if( isset($product->price)){
                $totalPrice +=  $product->price;
            }

            if( isset($product->weight))
                $totalWeight +=  $product->weight;

            if( isset($product->name))
                $items[] = $product->name;
        }

        return ['price'=> $totalPrice, 'weight'=> $totalWeight, 'items'=>$items];
    }

    /**
     * @param $weight
     * @return int|null
     */
    private function getCourierCharges($weight){
        $fare = null;
        if ($weight > 1000 && $weight <= 5000 ){ $fare = 20; }
        if ($weight > 500 && $weight <= 1000){ $fare = 15; }
        if ($weight > 200 && $weight <= 500){ $fare = 10; }
        if ($weight <= 200){ $fare = 5; }

        return $fare;

    }

    /**
     * @return array
     */
    private function getSort()
    {
        $total = $this->getTotalValue();
        $sortedProducts = [];
        foreach ($this->products as $price) {
            $sortedProducts[] = $price;
            $sortedProducts[] = array_values($this->weightSortList)[0];
            array_shift($this->weightSortList);
        }

        $uniqueProducts = collect($sortedProducts)->unique('id');
        $uniqueProducts->values()->all();

        if ($total['price'] <= 250) {
            $total['courierCharges'] = $this->getCourierCharges($total['weight']);
            return $total;
        } else {

            $packageNo = ceil($total['price'] / 250);
            $maxWeight = ceil($total['weight'] / $packageNo);
            $packageData = [];
            for ($i = 0; $i < $packageNo; $i++) {
                $packageData[$i]['packageTotalPrice'] = 0;
                $packageData[$i]['packageTotalWeight'] = 0;
            }
            $packageData = $this->applyLogic($uniqueProducts, $maxWeight, $packageNo, $packageData);
        }

        $results = array_map(function ($element) {
            if ($element['packageTotalWeight'])
                $element['courierCharges'] = $this->getCourierCharges($element['packageTotalWeight']);

            return $element;
        },
            $packageData
        );

        if (!$results[count($results) - 1]["packageTotalPrice"])
            $results[count($results) - 1] = null;

        return array_filter($results);
    }

    /**
     * @param $products
     * @param $maxWeight
     * @param $packageNo
     * @param $packageData
     * @return mixed
     */
    private function applyLogic($products, $maxWeight, $packageNo, $packageData)
    {
        foreach ($products as $product) {

            if ($maxWeight > $product['weight']) {

                for ($index = 0; $index < $packageNo; $index++) {

                    if (250 > $packageData[$index]['packageTotalPrice'] + $product['price']) {
                        if (($product['price'] == $this->priceMax) || ($product['weight'] == $this->weightMax)) {
                            $packageData[$index]['packageTotalPrice'] = $packageData[$index]['packageTotalPrice'] + $product['price'];
                            $packageData[$index]['packageTotalWeight'] = $packageData[$index]['packageTotalWeight'] + $product['weight'];
                            $packageData[$index]['packageItems'][] = $product['name'];
                            break;
                        } elseif (($product['price'] > $this->priceAvg && $product['price'] != $this->priceMax) || ($product['weight'] > $this->weightAvg && $product['weight'] != $this->weightMax)) {
                            $packageData[$index]['packageTotalPrice'] = $packageData[$index]['packageTotalPrice'] + $product['price'];
                            $packageData[$index]['packageTotalWeight'] = $packageData[$index]['packageTotalWeight'] + $product['weight'];
                            $packageData[$index]['packageItems'][] = $product['name'];
                            break;
                        } else {
                            if (!$index)
                                if ($packageData[$index]['packageTotalWeight'] >= $packageData[$index + 1]['packageTotalWeight']) {
                                    $index++;
                                }
                            $packageData[$index]['packageTotalPrice'] = $packageData[$index]['packageTotalPrice'] + $product['price'];
                            $packageData[$index]['packageTotalWeight'] = $packageData[$index]['packageTotalWeight'] + $product['weight'];
                            $packageData[$index]['packageItems'][] = $product['name'];
                            break;
                        }

                    }

                }

            }
        }
        return $packageData;
    }

}