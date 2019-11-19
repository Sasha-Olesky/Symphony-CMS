<?php

class datasourcepages_suggestions extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'pages-suggestions';
    public $dsParamORDER = 'desc';
    public $dsParamPAGINATERESULTS = 'no';
    public $dsParamLIMIT = '20';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamFILTERS = array(
        '278' => 'suggestions',
    );

    public $dsParamINCLUDEDELEMENTS = array(
        'title-en',
        'title-cy',
        'blurb-en: formatted',
        'blurb-cy: formatted',
        'content: *',
        'back-en',
        'back-cy',
        'back-btn-en',
        'back-btn-cy',
        'accent-hex',
        'header-img',
        'meta-description: unformatted',
        'meta-keywords'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Pages-Suggestions',
            'author' => array(
                'name' => 'David Thomas',
                'website' => 'http://rhydycarwest.com',
                'email' => 'david@thinkorchard.com'),
            'version' => 'Symphony 2.7.0',
            'release-date' => '2018-06-15T18:31:14+00:00'
        );
    }

    public function getSource()
    {
        return '1';
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