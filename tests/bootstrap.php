<?php

echo "RUNNING (". __FILE__ .")!!!!\n";
require_once(dirname(__FILE__) .'/../AutoLoader.class.php');

// set the timezone to avoid spurious errors from PHP
date_default_timezone_set("America/Chicago");

AutoLoader::registerDirectory(dirname(__FILE__) .'/../');
