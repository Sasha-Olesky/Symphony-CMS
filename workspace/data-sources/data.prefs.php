<?php

class datasourceprefs extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'prefs';
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

    public $dsParamINCLUDEDELEMENTS = array(
        'meta-desc: unformatted',
        'meta-tags',
        'show-news',
        'open-first-block',
        'email',
        'phone',
        'facebook',
        'twitter',
        'instagram',
        'linkedin',
        'gdpr-message: formatted',
        'accept-btn',
        'init-lat',
        'init-lng',
        'init-zoom',
        'holding-message: formatted',
        'holding-background-hex'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array();
    }

    public function about()
    {
        return array(
            'name' => 'Prefs',
            'author' => array(
                'name' => 'Jo Wimborne',
                'website' => 'http://rhydycarwest.com',
                'email' => 'jowimborne@thinkorchard.com'),
            'version' => 'Symphony 2.7.0',
            'release-date' => '2018-06-15T09:07:00+00:00'
        );
    }

    public function getSource()
    {
        return '23';
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