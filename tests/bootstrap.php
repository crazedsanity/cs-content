<?php

echo "RUNNING (". __FILE__ .")!!!!\n";
require_once(dirname(__FILE__) .'/../vendor/autoload.php');
require_once(__DIR__ .'/../src/cs_content/GenericPage.class.php');
require_once(__DIR__ .'/../src/cs_content/ContentSystem.class.php');

// set the timezone to avoid spurious errors from PHP
date_default_timezone_set("America/Chicago");
