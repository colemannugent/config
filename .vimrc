set nocompatible

" Now we can turn our filetype functionality back on
filetype plugin indent on

"Sets the default color scheme
:color desert

"Enables mouse support
:set mouse=a

"Enables syntax highlighting
:syntax on

"allow backspace key
set backspace=indent,eol,start

"Enables line numbers
set number

"Key Mappings
map <F7> :tabp<CR>
map <F8> :tabn<CR>

"Explicitly set the tab behavoiur
set tabstop=8
set softtabstop=0 
set noexpandtab 
set shiftwidth=8
