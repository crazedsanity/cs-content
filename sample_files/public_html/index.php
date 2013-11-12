<?php

require(dirname(__FILE__) ."/../lib/includes.php");

$contentObj = new contentSystem();
$siteConfig = new cs_siteConfig(dirname(__FILE__) .'/../conf/siteConfig.xml');
$contentObj->inject_var('siteConfig', $siteConfig);
$contentObj->finish();



?>
