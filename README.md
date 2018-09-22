# doom-theme-generator

doom-theme-generator is a python program that "compiles" [terminal.sexy](http://terminal.sexy/) colorschemes into valid themes for hlissner's [emacs-doom-themes](https://github.com/hlissner/emacs-doom-themes)

### Setup

Intall dependencies  
``pip install jinja2 chroma``


Clone this repository  
``git clone https://gitlab.com/valtrok/doom-theme-generator.git``

### Usage

First go to http://terminal.sexy/ and export a colorscheme in JSON format.  
Generate a theme from the colorscheme you just dowloaded :  
``python doom-theme-generator.py <colorscheme_file> <name_of_the_theme>``


Move the generated theme to your doom-themes installation directory  
``mv doom-<name_of_the_theme>-theme.el path/to/your/doom-themes``


Add this line to your .emacs  
``(load-theme 'doom-<name_of_the_theme> t)``


#### Example :

``python doom-theme-generator.py ocean.dark.txt ocean``


.emacs :  
``(load-theme 'doom-ocean t)``
