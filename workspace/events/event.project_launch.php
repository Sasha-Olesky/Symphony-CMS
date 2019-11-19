<?php

class eventproject_launch extends SectionEvent
{
    public $ROOTELEMENT = 'project-launch';

    public $eParamFILTERS = array(
        'google_recaptcha'
    );

    public static function about()
    {
        return array(
            'name' => 'Project Launch',
            'author' => array(
                'name' => 'Jo Wimborne',
                'website' => 'http://rhydycar.thinkorchard.com',
                'email' => 'jowimborne@thinkorchard.com'),
            'version' => 'Symphony 2.7.0',
            'release-date' => '2018-06-14T09:06:45+00:00',
            'trigger-condition' => 'action[project-launch]'
        );
    }

    public static function getSource()
    {
        return '70';
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
                <pre class="XML"><code>&lt;project-launch result="success" type="create | edit">
    &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/project-launch></code></pre>
                <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned.</p>
                <pre class="XML"><code>&lt;project-launch result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;field-name type="invalid | missing" />
...&lt;/project-launch></code></pre>
                <p>The following is an example of what is returned if any options return an error:</p>
                <pre class="XML"><code>&lt;project-launch result="error">
    &lt;message>Entry encountered errors when saving.&lt;/message>
    &lt;filter name="admin-only" status="failed" />
    &lt;filter name="send-email" status="failed">Recipient not found&lt;/filter>
...&lt;/project-launch></code></pre>
                <h3>Example Front-end Form Markup</h3>
                <p>This is an example of the form markup you can use on your frontend:</p>
                <pre class="XML"><code>&lt;form method="post" action="{$current-url}/" enctype="multipart/form-data">
    &lt;input name="MAX_FILE_SIZE" type="hidden" value="95242880" />
    &lt;label>First Name
        &lt;input name="fields[first]" type="text" />
    &lt;/label>
    &lt;label>Last Name
        &lt;input name="fields[last]" type="text" />
    &lt;/label>
    &lt;label>Email
        &lt;input name="fields[email]" type="text" />
    &lt;/label>
    &lt;label>Organisation
        &lt;input name="fields[org]" type="text" />
    &lt;/label>
    &lt;label>Can Attend
        &lt;select name="fields[attend]">
            &lt;option value="Yes">Yes&lt;/option>
            &lt;option value="No">No&lt;/option>
        &lt;/select>
    &lt;/label>
    &lt;label>Response Date
        &lt;input name="fields[date]" type="text" />
    &lt;/label>
    &lt;input name="action[project-launch]" type="submit" value="Submit" />
&lt;/form></code></pre>
                <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
                <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
                <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
                <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://rhydycar.thinkorchard.com/success/" /></code></pre>';
    }

    public function load()
    {
        if (isset($_POST['action']['project-launch'])) {
            return $this->__trigger();
        }
    }

}
