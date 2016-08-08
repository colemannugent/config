set nocompatible

" Now we can turn our filetype functionality back on
filetype plugin indent on

" Enable solarized color scheme
set background=dark
colorscheme solarized


"Enables mouse support
set mouse=a

"Enables syntax highlighting
syntax on

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

"Enable persistent undo
if has('persistent_undo')
	call system('mkdir -p ~/.vim/undo')
	set undodir=~/.vim/undo
	set undofile
endif
