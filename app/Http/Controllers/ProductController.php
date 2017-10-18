<?php

namespace App\Http\Controllers;
//use Illuminate\Support\Facades\Request;
use Illuminate\Http\Request;

use App\Product;
use function PHPSTORM_META\map;

class ProductController extends Controller
{
    public  function getProducts(){

        $products = Product::all(['id', 'name', 'price', 'weight']);

        if(is_object($products)){
            return response()->json(['data'=> $products ],200);
        }

    }


    public  function assignSplitRules(Request $request){
        $products = Product::findMany($request->get('packages'))
            ->sortByDesc('price')
            ->values()
            ->all();


        $priceList = array_column($products, 'price' , 'id');
//        $priceSortList = collect($products)->sortByDesc('price')->all(); //collect($products)->sortBy('price')->reverse()->toArray();
//        $priceSum =array_sum($priceList);
        $priceMax = max($priceList);
        $priceMin = min($priceList);
        $priceAvg = round(($priceMax + $priceMin) / 2);

        $weightList = array_column($products, 'weight' , 'id');
        $weightSortList = collect($products)->sortByDesc('weight')->toArray();
//        $weightSum =array_sum($weightList);
        $weightMax = max($weightList);
        $weightMin = min($weightList);
        $weightAvg = round(($weightMax + $weightMin) / 2);


        $total = $this->getTotalValue($products);

        $sortedProducts = [];
        foreach ($products as $price){
            $sortedProducts[] = $price;
            $sortedProducts[] = array_values($weightSortList)[0];
            array_shift($weightSortList);
        }

        $unique = collect($sortedProducts)->unique('id');
        $unique->values()->all();

        $myProducts = $unique;


        if($total['price'] <= 250){
            $total['courierCharges'] = $this->getCourierCharges($total['weight']);
            return response()->json($total);
        }
        else{

            $packageNo = ceil($total['price']/250);
            $maxWeight = ceil($total['weight']/$packageNo);
            $packageData = [];
            for ($i = 0 ;$i < $packageNo ; $i++ ){
                $packageData[$i]['packageTotalPrice'] =  0;
                $packageData[$i]['packageTotalWeight'] =  0;
            }
            foreach ( $myProducts as $product){

                if ($maxWeight > $product['weight']){

                    for ($index = 0 ;$index < $packageNo ; $index++ ){

                        if ( 250 > $packageData[$index]['packageTotalPrice'] + $product['price'] ){
                            if(  ($product['price']  == $priceMax)  || ($product['weight'] == $weightMax)  ){
                                $packageData[$index]['packageTotalPrice'] =  $packageData[$index]['packageTotalPrice'] + $product['price'] ;
                                $packageData[$index]['packageTotalWeight'] = $packageData[$index]['packageTotalWeight'] + $product['weight'];
                                $packageData[$index]['packageItems'][] = $product['name'];
                                break;
                            }
                            elseif ( ($product['price']  > $priceAvg && $product['price']  != $priceMax)  || ($product['weight'] > $weightAvg && $product['weight'] != $weightMax)){
                                $packageData[$index]['packageTotalPrice'] =  $packageData[$index]['packageTotalPrice'] + $product['price'] ;
                                $packageData[$index]['packageTotalWeight'] = $packageData[$index]['packageTotalWeight'] + $product['weight'];
                                $packageData[$index]['packageItems'][] = $product['name'];
                                break;
                            }
                            else{
                                if (!$index)
                                    if( $packageData[$index]['packageTotalWeight']  >= $packageData[$index + 1]['packageTotalWeight'] ){$index++;}
                                $packageData[$index]['packageTotalPrice'] =  $packageData[$index]['packageTotalPrice'] + $product['price'] ;
                                $packageData[$index]['packageTotalWeight'] = $packageData[$index]['packageTotalWeight'] + $product['weight'];
                                $packageData[$index]['packageItems'][] = $product['name'];
                                break;
                            }

                        }

                    }

                }
            }
        }

        $results = array_map(function($element) {
            if( $element['packageTotalWeight'])
                $element['courierCharges'] = $this->getCourierCharges($element['packageTotalWeight']);

            return $element ;
        },
            $packageData
        );

        if(!$results[count($results) -1]["packageTotalPrice"])
            $results[count($results) - 1] = null;

        return response()->json(array_filter($results));
    }


    private function getTotalValue($products){

        $totalWeight = null;
        $totalPrice = null;
        $items=[];

        foreach ( $products as $product){




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

    private function getCourierCharges($weight){
        $fare = null;
        if ($weight > 1000 && $weight <= 5000 ){ $fare = 20; }
        if ($weight > 500 && $weight <= 1000){ $fare = 15; }
        if ($weight > 200 && $weight <= 500){ $fare = 10; }
        if ($weight <= 200){ $fare = 5; }

        return $fare;

    }



}