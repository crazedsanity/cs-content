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

if (! defined('SIMPLE_TEST')) {
	define('SIMPLE_TEST', 'simpletest/');
}
require_once(SIMPLE_TEST . 'unit_tester.php');
require_once(SIMPLE_TEST . 'reporter.php');

require_once(dirname(__FILE__) .'/testOfCSContent.php');


$test = &new TestOfCSContent();
$test->run(new HtmlReporter());

?>
