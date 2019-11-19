<?php
    $settings = array(


        ###### ADMIN ######
        'admin' => array(
            'max_upload_size' => '95242880',
            'upload_blacklist' => '/\\.(?:php[34567s]?|phtml)$/i',
        ),
        ########


        ###### SYMPHONY ######
        'symphony' => array(
            'admin-path' => 'symphony',
            'pagination_maximum_rows' => '20',
            'association_maximum_rows' => '5',
            'lang' => 'en',
            'pages_table_nest_children' => 'no',
            'version' => '2.7.10',
            'cookie_prefix' => 'sym-',
            'session_gc_divisor' => '10',
            'cell_truncation_length' => '75',
            'enable_xsrf' => 'no',
            'error_reporting_all' => 'no',
        ),
        ########


        ###### LOG ######
        'log' => array(
            'archive' => '1',
            'maxsize' => '102400',
            'filter' => 24575,
        ),
        ########


        ###### DATABASE ######
        'database' => array(
            'host' => 'localhost',
            'port' => '3306',
            'user' => 'db_admin',
            'password' => 'rFsc2%09',
            'db' => 'rhydycarwest',
            'tbl_prefix' => 'sym_',
            'query_caching' => 'on',
            'query_logging' => 'on',
        ),
        ########


        ###### PUBLIC ######
        'public' => array(
            'display_event_xml_in_source' => 'no',
        ),
        ########


        ###### GENERAL ######
        'general' => array(
            'sitename' => 'Rhydycar West',
            'useragent' => 'Symphony/2.7.10',
        ),
        ########


        ###### FILE ######
        'file' => array(
            'write_mode' => '0644',
        ),
        ########


        ###### DIRECTORY ######
        'directory' => array(
            'write_mode' => '0755',
        ),
        ########


        ###### REGION ######
        'region' => array(
            'time_format' => 'g:i a',
            'date_format' => 'm/d/Y',
            'datetime_separator' => ' ',
            'timezone' => 'Europe/London',
        ),
        ########


        ###### CACHE_DRIVER ######
        'cache_driver' => array(
            'default' => 'database',
        ),
        ########


        ###### IMAGE ######
        'image' => array(
            'cache' => '1',
            'quality' => '90',
            'allow_origin' => null,
            'disable_regular_rules' => 'no',
            'disable_upscaling' => 'yes',
            'disable_proxy_transform' => 'no',
        ),
        ########


        ###### MAINTENANCE_MODE ######
        'maintenance_mode' => array(
            'enabled' => 'no',
            'ip_whitelist' => null,
            'useragent_whitelist' => null,
        ),
        ########


        ###### REDACTOR ######
        'redactor' => array(
            'lang' => 'en',
            'direction_ltr' => 'yes',
            'enable_toolbar' => 'yes',
            'enable_source' => 'yes',
            'enable_focus' => 'no',
            'enable_shortcuts' => 'yes',
            'enable_autoresizing' => 'yes',
            'enable_cleanup' => 'yes',
            'enable_fixed' => 'no',
            'enable_fixedbox' => 'no',
            'enable_paragraphy' => 'yes',
            'enable_convertlinks' => 'yes',
            'enable_convertdivs' => 'yes',
            'enable_fileupload' => 'no',
            'enable_imageupload' => 'yes',
            'enable_overlay' => 'yes',
            'enable_observeimages' => 'yes',
            'enable_airmode' => 'no',
            'enable_wym' => 'yes',
            'enable_mobile' => 'yes',
            'buttons' => 'html,formatting,bold,italic,deleted,unorderedlist,orderedlist,outdent,indent,image,video,file,table,link,fontcolor,backcolor,alignleft,aligncenter,alignright,justify,horizontalrule',
            'airbuttons' => 'formatting,bold,italic,deleted,unorderedlist,orderedlist,outdent,indent,fontcolor,backcolor',
            'allowedtags' => 'code,span,div,label,a,br,p,b,i,del,strike,u,img,video,audio,iframe,object,embed,param,blockquote,mark,cite,small,ul,ol,li,hr,dl,dt,dd,sup,sub,big,pre,figure,figcaption,strong,em,table,tr,td,th,tbody,thead,tfoot,h1,h2,h3,h4,h5,h6',
            'filepath' => 'C:\\wamp64\\www\\YellowSubGeo/workspace/redactor/files',
            'imagepath' => 'C:\\wamp64\\www\\YellowSubGeo/workspace/redactor/images',
        ),
        ########


        ###### SORTING ######
        'sorting' => array(
            'section_navigation_sortby' => '11',
            'section_section-1_sortby' => '20',
            'section_pages_sortby' => '51',
            'section_case-studies_sortby' => '69',
            'section_home_sortby' => '84',
            'section_blog_sortby' => '25',
            'section_blog_order' => 'desc',
            'section_contact_sortby' => '243',
            'section_contact_order' => 'asc',
            'section_timeline-milestones_sortby' => '307',
            'section_test-poll_sortby' => '318',
            'section_test-poll_order' => 'desc',
            'section_homepage-block_sortby' => '366',
            'section_projectlaunch_sortby' => '434',
            'section_projectlaunch_order' => 'asc',
            'section_suggestions_sortby' => '480',
            'section_suggestions_order' => 'asc',
        ),
        ########


        ###### EMAIL ######
        'email' => array(
            'default_gateway' => 'sendmail',
        ),
        ########


        ###### EMAIL_SENDMAIL ######
        'email_sendmail' => array(
            'from_name' => 'Rhydycar West',
            'from_address' => 'info@rhydycarwest.com',
        ),
        ########


        ###### EMAIL_SMTP ######
        'email_smtp' => array(
            'helo_hostname' => null,
            'from_name' => null,
            'from_address' => null,
            'host' => '127.0.0.1',
            'port' => '25',
            'secure' => 'no',
            'auth' => '0',
            'username' => 'jo',
            'password' => 'thinkorchard123',
        ),
        ########


        ###### FILEBROWSER ######
        'filebrowser' => array(
            'show-hidden' => 'no',
            'start-location' => null,
            'archive-name' => null,
        ),
        ########


        ###### GLOBALRESOURCELOADER ######
        'globalresourceloader' => array(
            'ds-names' => 'a_poll,best_thing,colours,contact_form,footer_navigation,header_navigation,is_form,main_navigation,polls,prefs,secondary_footer_navigation,storage,test_poll,translation_fields',
            'event-names' => 'a_poll,best_thing,language_redirect,storage_action,test_poll',
        ),
        ########


        ###### CKEDITOR ######
        'ckeditor' => array(
            'styles' => null,
        ),
        ########


        ###### MULTILINGUAL ######
        'multilingual' => array(
            'languages' => 'en, cy',
        ),
        ########


        ###### LANGUAGE_REDIRECT ######
        'language_redirect' => array(
            'language_codes' => 'en, cy',
        ),
        ########


        ###### CLIENT_LOGO ######
        'client_logo' => array(
            'path' => 'assets/images/rhydycar_west_white.png',
        ),
        ########


        ###### DOCUMENTATION ######
        'documentation' => array(
            'text-formatter' => 'none',
            'button-text' => 'Documentation',
        ),
        ########


        ###### GOOGLE_RECAPTCHA ######
        'google_recaptcha' => array(
            'recaptcha-secret-id' => '6Le0Jl0UAAAAAEveyu_jCbCcfqIWWAuHvHfMIAjn',
            'recaptcha-sitekey' => '6Le0Jl0UAAAAAPHxw6yv-ZJQH83UyVOB_-BDHjVf',
        ),
        ########


        ###### TINYMCE ######
        'tinymce' => array(
            'imagepath' => '/var/www/vhosts/rhydycarwest.com/httpdocs/workspace/tinymce/images/',
        ),
        ########
    );
