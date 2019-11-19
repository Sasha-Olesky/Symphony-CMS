<?php

class datasourcemessages extends SectionDatasource
{
    public $dsParamROOTELEMENT = 'messages';
    public $dsParamORDER = 'random';
    public $dsParamPAGINATERESULTS = 'yes';
    public $dsParamLIMIT = '1';
    public $dsParamSTARTPAGE = '1';
    public $dsParamREDIRECTONEMPTY = 'no';
    public $dsParamREDIRECTONFORBIDDEN = 'no';
    public $dsParamREDIRECTONREQUIRED = 'no';
    public $dsParamREQUIREDPARAM = '$ds-is-homepage.is-homepage';
    public $dsParamSORT = 'system:id';
    public $dsParamHTMLENCODE = 'no';
    public $dsParamASSOCIATEDENTRYCOUNTS = 'no';

    public $dsParamINCLUDEDELEMENTS = array(
        'message-en: formatted',
        'message-cy: formatted'
    );

    public function __construct($env = null, $process_params = true)
    {
        parent::__construct($env, $process_params);
        $this->_dependencies = array('$ds-is-homepage.is-homepage');
    }

    public function about()
    {
        return array(
            'name' => 'Messages',
            'author' => array(
                'name' => 'Jo Wimborne',
                'website' => 'http://rhydycar.thinkorchard.com',
                'email' => 'jowimborne@thinkorchard.com'),
            'version' => 'Symphony 2.7.0',
            'release-date' => '2018-06-06T10:12:29+00:00'
        );
    }

    public function getSource()
    {
        return '64';
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