<?php

require_once(EXTENSIONS . '/storage/data-sources/datasource.storage.php');

Class datasourcestorage extends StorageDatasource {

    public $dsParamROOTELEMENT = 'storage';
    public $dsParamPARAMS = 0;
    public $dsParamGROUPS = array(
        
    );

    public function __construct($env=null, $process_params=true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Storage',
            'author' => array(
                'name' => 'Jo Wimborne',
                'website' => 'http://rhydycar.thinkorchard.com',
                'email' => 'jowimborne@thinkorchard.com'),
            'version' => 'Symphony 2.7.0',
            'release-date' => '2018-06-13T13:13:30+00:00'
        );
    }

    public function allowEditorToParse()
    {
        return true;
    }
}