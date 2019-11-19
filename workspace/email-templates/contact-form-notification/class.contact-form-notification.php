<?php

class Contact_form_notificationEmailTemplate extends EmailTemplate
{
    public $datasources = Array(
 			'contact_form',);
    public $layouts = Array(
 			'plain' => 'template.plain.xsl',);
    public $subject = 'Message from {//data/contact-form/entry/name} via contact form';
    public $reply_to_name = '{//data/contact-form/entry/name}';
    public $reply_to_email_address = '{//data/contact-form/entry/email}';
    public $recipients = 'jordan@rhydycarwest.com';
    public $attachments = '';

    public $editable = true;

    public $about = Array(
        'name' => 'Contact-Form-Notification',
        'version' => '1.0',
        'author' => array(
            'name' => 'David Thomas',
            'website' => 'http://rhydycarwest.com',
            'email' => 'david@thinkorchard.com'
        ),
        'release-date' => '2018-10-25T16:10:28+00:00'
    );
}
