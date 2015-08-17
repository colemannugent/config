set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'chriskempson/base16-vim'
Plugin 'bling/vim-airline'
Plugin 'Valloric/YouCompleteMe'
Plugin 'othree/html5.vim'

" All of your Plugins must be added before the following line
call vundle#end()  

" Now we can turn our filetype functionality back on
filetype plugin indent on

"Sets the default color scheme
:color desert

"Enables mouse support
:set mouse=a

"Enables syntax highlighting
:syntax on

"Enables line numbers
set number

"Key Mappings
map <F7> :tabp<CR>
map <F8> :tabn<CR>
