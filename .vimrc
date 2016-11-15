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

" Set the leader to <Space>
let mapleader = "\<Space>"

" Some easy ways to get out of insert mode
inoremap jk <Esc>
inoremap kj <Esc>

" Key Mappings
noremap <F7> :tabp<Enter>
noremap <F8> :tabn<Enter>

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

" Map <Leader>w to write the current buffer
noremap <Leader>w :write<Enter>

" Map <Leader>q to save and quit
noremap <Leader>q :wq<Enter>

" Map <Leader>Q to quit immediately
noremap <Leader>Q :q!<Enter>

" Map <Leader>i to show the current buffers
noremap <Leader>i :buffers<Enter>

" Map <Leader>l to move forward a buffer
noremap <Leader>j :bnext<Enter>

" Map <Leader>h to move back a buffer
noremap <Leader>k :bprevious<Enter>

" Map <Leader>h to use xxd to render a hexdump of the file
noremap <Leader>h :%!xxd -c 32<Enter>

" Map <Leader>h to use xxd to revert a hexdump to ascii
noremap <Leader>H :%!xxd -c 32 -r<Enter>
