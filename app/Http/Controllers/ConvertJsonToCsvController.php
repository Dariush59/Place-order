<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ConvertJsonToCsvController extends Controller
{
    private $row;

    public function getJsonToCsvConvent(Request $request)
    {
        try{
            $request = $request->getContent();
            if (empty($request))
                throw new Exception("NULL_REQUEST");

            $this->getObjectDetails(json_decode($request, true));

            $file = fopen('csv/excel.csv', 'w');
            fputcsv($file, array_keys($this->row));

            $condition = true;
            $index = 0;
            $arrayLength = 0;
            while ($condition) {
                $rowArray = [];
                foreach ($this->row as $key => $value) {

                    if ($arrayLength < count($value) )
                        $arrayLength = count($value);

                    if (isset($this->row[$key][$index]))
                        $rowArray[] = $this->row[$key][$index];
                    else
                        $rowArray[] ='';
                }
                fputcsv($file, $rowArray);
                $index++;
                if ($index >= $arrayLength)
                    $condition = false;
            }

            return ['data' => "Done"];
        }
        catch(Exception $e){
            throw new Exception( $e->getMessage() );
        }
        finally{
            if (file_exists('./csv/excel.csv') && isset($file))
                fclose($file);
        }
    }

    private function getObjectDetails($value)
    {
        try{
            foreach ( $value as $deepKey => $deepValue ){
                if( is_array ( $deepValue ))
                    $this->getObjectDetails( $deepValue );
                else
                    $this->row[$deepKey][] = $deepValue;
            }
        }
        catch(Exception $e){
            throw new Exception( $e->getMessage() );
        }
    }
}