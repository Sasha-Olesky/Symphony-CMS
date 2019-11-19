<?php

	Class Extension_ImageCropper extends Extension{

		public function install(){
			return Symphony::Database()->query("
				CREATE TABLE `tbl_fields_imagecropper` (
					`id` int(11) unsigned NOT NULL auto_increment,
					`field_id` int(11) unsigned NOT NULL,
					`related_field_id` int(11) unsigned NOT NULL,
					`min_width` int(11) unsigned NOT NULL,
					`min_height` int(11) unsigned NOT NULL,
					`ratios` text, 
					PRIMARY KEY  (`id`),
					KEY `field_id` (`field_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
			");
		}
		public function getSubscribedDelegates() {
			return array(
				array(
					'page' => '/backend/',
					'delegate' => 'InitaliseAdminPageHead',
					'callback' => '__appendAdminPageAssets'
				)
			);
		}
		public function uninstall() {
			Symphony::Database()->query("DROP TABLE `tbl_fields_imagecropper`");
		}
		protected $adminHeadersAppended = false;

		public function __appendAdminPageAssets($context) {   
			if (!$this->adminHeadersAppended && Administration::instance()) {
				$assets_path = '/extensions/imagecropper/assets/';
				//Administration::instance()->Page->addStylesheetToHead(URL . $assets_path . 'jquery.Jcrop.min.css', 'screen', 120, false);
				//Administration::instance()->Page->addStylesheetToHead(URL . $assets_path . 'jquery-ui-1.8.20.custom.css', 'screen', 130, false);
				//Administration::instance()->Page->addStylesheetToHead(URL . $assets_path . 'imagecropper.publish.css', 'screen', 140, false);
				Administration::instance()->Page->addScriptToHead(URL . $assets_path . 'jquery.Jcrop.js', 430, false);
				//Administration::instance()->Page->addScriptToHead(URL . $assets_path . 'jquery-ui-1.8.20.custom.min.js', 440, false);
				Administration::instance()->Page->addScriptToHead(URL . $assets_path . 'imagecropper.publish.js', 450, false);
				$this->adminHeadersAppended = true;
			}
		}
	}