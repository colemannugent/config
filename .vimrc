set nocompatible

" Now we can turn our filetype functionality back on
filetype plugin indent on

" Enable solarized color scheme
set background=dark
colorscheme solarized

" Enable relative line numbering
set relativenumber

" Show a line at the 80 character mark
set colorcolumn=80

" Enables mouse support
set mouse=a

" Enables syntax highlighting
syntax on

" Enables line numbers
set number

" Key Mappings
map <F7> :tabp<CR>
map <F8> :tabn<CR>

" Explicitly set the tab behavoiur
set tabstop=8
set softtabstop=0 
set noexpandtab 
set shiftwidth=8

" Enable persistent undo
if has('persistent_undo')
	call system('mkdir -p ~/.vim/undo')
	set undodir=~/.vim/undo
	set undofile
endif

" Save the file, even if I am still pressing shift
command W w

" Setup a "IDE" mode
function SetupIDE()
        let g:netrw_banner = 0          " Turn off the banner in netrw
        let g:netrw_liststyle = 3       " Set the preffered list style
        let g:netrw_browse_split = 4    " Open files in one split
        let g:netrw_winsize = 12        " Set window size
        Vexplore
endfunction

" Define a command to setup "IDE" mode
command IDE call SetupIDE()

" Map <Leader>I to enter "IDE" mode
noremap <Leader>I :IDE<Enter>
