# CS Content System (Templating / MVC Framework)

Generic MVC-style framework designed to leverage the power of a templating system and PHP includes, all running through a single display script. Allows incredibly fast building of an intelligent website without having to write a script for every page. Separate HTML from code, intelligently build pages using path-based script and template inheritance.

##  HOW THE SYSTEM WORKS:::


### TEMPLATE FILES:
Automatically loads templates based on the URL, and optionally includes scripts in the includes directory.
 
### MAIN SECTION:

For the main section, i.e. "/content", it requires a template in a directory of that name beneath /templates, with a file called "index.content.tmpl"... i.e. /templatee/content/index.content.tmpl.
 		
### SUB SECTIONS:
 			
For any subsection to be valid, i.e. "/content/members", it must have an associated template, e.g. "/templates/content/members.content.tmpl". If a subdirectory with an index.content.tmpl file exists, it will be used instead of the file in the sub directory (i.e. "/templates/content/members/index.content.tmpl").

### SUB SECTION TEMPLATE INHERITANCE:

All pages load the base set of "shared" templates, which are in the form "<section>.shared.tmpl" in the root of the templates directory.  Shared files within each directory, in the form "<section>.shared.tmpl", will be loaded for ANY subsection.

For any subsection, it inherits a previous section's templates in the following manner (any "content" templates are ignored for inheritance, as they're require for page load).


 				/content							---> /templates/content/index.*.tmpl
	 
 				/content/members					|--> /templates/content/index.*.tmpl
 													`--> /templates/content/members.*.tmpl
	 
 				/content/members/test				|--> /templates/content/index.*.tmpl
 													|--> /templates/content/members.*.tmpl
 													|--> /templates/content/members/index.*.tmpl
 													`--> /templates/content/members/test.*.tmpl
### AUTOMATIC INCLUDES:

Much in the same way templates are included, so are scripts, from the /includes directory, though the logic is decidedly simpler: all scripts must have the extension of ".inc", and must have either the section's name as the first part of the filename, or "shared".  Shared scripts will be loaded for ALL subsections.
 
### INCLUDES INHERITANCE:

The template inheritance scheme is as laid-out below.  The content system will go as far into the includes directory as it can for the given section, regardless of if any intermediate files are missing.
 
It is important to note that the content system will NOT regard a section as valid if there are include scripts but no templates.
 			
	/content							|--> /includes/shared.inc
										`--> /includes/content.inc

	/content/members					|--> /includes/shared.inc
 										|--> /includes/content.inc
 										|--> /includes/content/shared.inc
 										`--> /includes/content/members.inc
 
 	/content/members/test				|--> /includes/shared.inc
 										|--> /includes/content.inc
 										|--> /includes/content/shared.inc
 										|--> /includes/content/members.inc
 										|--> /includes/content/members/shared.inc
 										`--> /includes/content/members/test.inc

