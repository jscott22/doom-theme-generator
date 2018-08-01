# doom-theme-generator

A theme generator for https://github.com/hlissner/emacs-doom-themes

### Setup

Intall dependencies  
``pip install jinja2 chroma``


Go into the directory where doom-themes is installed  
``cd your/path/to/doom-themes``


Clone this repository  
``git clone https://gitlab.com/valtrok/doom-theme-generator.git``

### Usage

First go to http://terminal.sexy/ and export a theme in JSON format, then place this file in your doom-theme directory.  
To generate a theme from the colorscheme you just dowloaded, type this command :  
``python doom-theme-generator.py <colorscheme_file> <name_of_the_theme>``


Example :  
``python doom-theme-generator.py ocean.dark.txt ocean``
