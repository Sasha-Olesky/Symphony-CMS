<?php

class eventcontact extends SectionEvent
{
    public $ROOTELEMENT = 'contact';

    public $eParamFILTERS = array(
        'etm-contact-form-notification'
    );

    public static function about()
    {
        return array(
            'name' => 'Contact',
            'author' => array(
                'name' => 'Jo Wimborne',
                'website' => 'http://yellowsubgeo.com',
                'email' => 'jowimborne@thinkorchard.com'),
            'version' => 'Symphony 2.7.0',
            'release-date' => '2018-01-29T14:58:20+00:00',
            'trigger-condition' => 'action[contact]'
        );
    }

    public static function getSource()
    {
        return '27';
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
                <pre class="XML"><code>&lt;contact result="success" type="create | edit">
    &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/contact></code></pre>
                <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned.</p>
                <pre class="XML"><code>&lt;contact result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;field-name type="invalid | missing" />
...&lt;/contact></code></pre>
                <p>The following is an example of what is returned if any options return an error:</p>
                <pre class="XML"><code>&lt;contact result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;filter name="admin-only" status="failed" />
    &lt;filter name="send-email" status="failed">Recipient not found&lt;/filter>
...&lt;/contact></code></pre>
                <h3>Example Front-end Form Markup</h3>
                <p>This is an example of the form markup you can use on your frontend:</p>
                <pre class="XML"><code>&lt;form method="post" action="{$current-url}/" enctype="multipart/form-data">
    &lt;input name="MAX_FILE_SIZE" type="hidden" value="95242880" />
    &lt;label>Name
        &lt;input name="fields[name]" type="text" />
    &lt;/label>
    &lt;label>Email
        &lt;input name="fields[email]" type="text" />
    &lt;/label>
    &lt;label>Message
        &lt;textarea name="fields[message]" rows="15" cols="50">&lt;/textarea>
    &lt;/label>
    &lt;label>Site Location
        &lt;input name="fields[location]" type="text" />
    &lt;/label>
    &lt;label>Date
        &lt;input name="fields[date]" type="text" />
    &lt;/label>
    &lt;input name="action[contact]" type="submit" value="Submit" />
&lt;/form></code></pre>
                <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
                <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
                <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
                <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://yellowsubgeo.com/success/" /></code></pre>';
    }

    public function load()
    {
        if (isset($_POST['action']['contact'])) {
            return $this->__trigger();
        }
    }

}
