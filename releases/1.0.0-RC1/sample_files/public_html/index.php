<?php

require(dirname(__FILE__) . "/../lib/cs-content/cs_globalFunctions.class.php");
$gf = new cs_globalFunctions;
$gf->conditional_header("/content/index.php");
exit;

?>
