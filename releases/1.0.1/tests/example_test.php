<?php
/*
 * Created on Jan 13, 2009
 * 
 * FILE INFORMATION:
 * 
 * $HeadURL$
 * $Id$
 * $LastChangedDate$
 * $LastChangedBy$
 * $LastChangedRevision$
 */

require_once(dirname(__FILE__) .'/testOfCSContent.php');


$test = &new TestOfCSContent();
$test->run(new HtmlReporter());

?>
