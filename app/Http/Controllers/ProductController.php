<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Product;

class ProductController extends Controller
{
    public function getProducts(){
        try {
            $productClass = new Product();
            $products = $productClass->getProducts();

            if(is_object($products)){
                return response()->json(['data'=> $products ],200);
            }
        }
        catch (\Exception $ex){
            return response()->json(['error'=> $ex->getMessage() ],500);
        }
    }


    public  function assignSplitRules(Request $request){

        try {
            $productClass = new Product();
            $rules = $productClass->assignSplitRules($request);

            return response()->json($rules);
        }
        catch (\Exception $ex){
            return response()->json(['error'=> $ex->getMessage() ],500);
        }


    }






}