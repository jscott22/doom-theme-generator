# doom-theme-generator

doom-theme-generator is a python program that "compiles" http://terminal.sexy/ colorschemes into valid themes for hlissner's [emacs-doom-themes](https://github.com/hlissner/emacs-doom-themes)

### Setup

Intall dependencies  
``pip install jinja2 chroma``


Go into your doom-themes installation directory  
``cd your/path/to/doom-themes``


Clone this repository  
``git clone https://gitlab.com/valtrok/doom-theme-generator.git``

### Usage

First go to http://terminal.sexy/ and export a colorscheme in JSON format, then place this file in your doom-theme directory.  
Generate a theme from the colorscheme you just dowloaded :  
``python doom-theme-generator.py <colorscheme_file> <name_of_the_theme>``


Don't forget to add this line in your .emacs  
``(load-theme 'doom-<name_of_the_theme> t)``


#### Example :

``python doom-theme-generator.py ocean.dark.txt ocean``


.emacs :  
``(load-theme 'doom-ocean t)``
