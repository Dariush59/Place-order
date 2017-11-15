<?php

use Illuminate\Http\Request;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::get('/products', 'ProductController@getProducts');
Route::post('/product/packages', 'ProductController@assignSplitRules');
Route::post('/product/convert/jsontocsv', 'ConvertJsonToCsvController@getJsonToCsvConvent');
