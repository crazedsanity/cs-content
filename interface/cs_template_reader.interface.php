<?php

interface cs_template_reader {
	public function read($location); // should return contents of the template
	public function getSource();//returns contents after calling read()
}
