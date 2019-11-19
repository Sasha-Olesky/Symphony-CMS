<?php

class datasourcenews extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'news';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'yes';
    public $dsParamLIMIT = '9';
    public $dsParamSTARTPAGE = '{$url-page:1}';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        'system:id' => '{$id}',
        '28' => 'yes',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'system:pagination',
        'title-en: formatted',
        'title-cy: formatted',
        'abstract-en: formatted',
        'abstract-cy: formatted',
        'content: *',
        'accent',
        'date',
        'author',
        'guest-author',
        'featured-image',
        'crop',
        'header-img'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'News',
            'author' => array(
                'name' => 'Jo Wimborne',
                'website' => 'http://rhydycar.thinkorchard.com',
                'email' => 'jowimborne@thinkorchard.com'),
            'version' => 'Symphony 2.7.0',
            'release-date' => '2018-06-01T14:35:51+00:00'
        );
    }

    public function getSource()
    {
        return '5';
    }

    public function allowEditorToParse()
    {
        return true;
    }

    public function execute(array &$param_pool = null)
    {
        $result = new XMLElement($this->dsParamROOTELEMENT);

        try{
            $result = parent::execute($param_pool);
        } catch (FrontendPageNotFoundException $e) {
            // Work around. This ensures the 404 page is displayed and
            // is not picked up by the default catch() statement below
            FrontendPageNotFoundExceptionHandler::render($e);
        } catch (Exception $e) {
            $result->appendChild(new XMLElement('error', $e->getMessage() . ' on ' . $e->getLine() . ' of file ' . $e->getFile()));
            return $result;
        }

        if ($this->_force_empty_result) {
            $result = $this->emptyXMLSet();
        }

        if ($this->_negate_result) {
            $result = $this->negateXMLSet();
        }

        return $result;
    }
}