<?php

interface cs_template_reader {
	public function __construct($location);
	public function read(); // should return contents of the template
	public function getSource();//returns contents after calling read()
}
