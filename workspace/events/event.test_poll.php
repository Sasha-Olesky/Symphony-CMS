<?php

class eventtest_poll extends SectionEvent
{
    public $ROOTELEMENT = 'test-poll';

    public $eParamFILTERS = array(
        
    );

    public static function about()
    {
        return array(
            'name' => 'Test Poll',
            'author' => array(
                'name' => 'Jo Wimborne',
                'website' => 'http://rhydycar.thinkorchard.com',
                'email' => 'jowimborne@thinkorchard.com'),
            'version' => 'Symphony 2.7.0',
            'release-date' => '2018-05-04T15:46:28+00:00',
            'trigger-condition' => 'action[test-poll]'
        );
    }

    public static function getSource()
    {
        return '53';
    }

    public static function allowEditorToParse()
    {
        return true;
    }

    public static function documentation()
    {
        return '
                <h3>Success and Failure XML Examples</h3>
                <p>When saved successfully, the following XML will be returned:</p>
                <pre class="XML"><code>&lt;test-poll result="success" type="create | edit">
    &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/test-poll></code></pre>
                <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned.</p>
                <pre class="XML"><code>&lt;test-poll result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;field-name type="invalid | missing" />
...&lt;/test-poll></code></pre>
                <h3>Example Front-end Form Markup</h3>
                <p>This is an example of the form markup you can use on your frontend:</p>
                <pre class="XML"><code>&lt;form method="post" action="{$current-url}/" enctype="multipart/form-data">
    &lt;input name="MAX_FILE_SIZE" type="hidden" value="95242880" />
    &lt;label>Option 1
        &lt;input name="fields[option-1]" type="checkbox" value="yes" />
    &lt;/label>
    &lt;label>Option 2
        &lt;input name="fields[option-2]" type="checkbox" value="yes" />
    &lt;/label>
    &lt;label>Email
        &lt;input name="fields[email]" type="text" />
    &lt;/label>
    &lt;input name="action[test-poll]" type="submit" value="Submit" />
&lt;/form></code></pre>
                <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
                <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
                <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
                <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://rhydycar.thinkorchard.com/success/" /></code></pre>';
    }

    public function load()
    {
        if (isset($_POST['action']['test-poll'])) {
            return $this->__trigger();
        }
    }

}
