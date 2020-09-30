" Plugins
call plug#begin('~/.local/share/nvim/site/autoload')

Plug 'morhetz/gruvbox'

call plug#end()

" ======== set stuff ========
set number relativenumber

" Copy indent from current line when starting a new line
set autoindent

" Smart autoindenting for programming
set smartindent
set wrap
set incsearch
set ignorecase

set modeline
set modelines=5

" Search becomes case sensitive when uppercase chars are present
set smartcase
set splitbelow splitright
set history=500
set magic
set showmatch
set ruler
set hid
set scrolloff=3

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path=.*/**

" Display all matching files when we tab complete
set wildmenu
set wildmode=list:longest,full
set wildignore+=**/node_modules/**,**/.git/**,**/.idea/**

" Linebreak on 200 characters
set lbr
set tw=200

" Disable backups - most stuff is in VCS anyway
set nobackup
set nowb
set noswapfile

" Tab size
" TODO: Should be using smarttabs instead
set tabstop=4
set shiftwidth=4

" Autoread when file is changed from the outside
set autoread
autocmd FocusGained,BufEnter * checktime

" Folding

" Enable filetype plugins
filetype plugin on
filetype indent on
syntax enable

autocmd vimenter * colorscheme gruvbox

" Light or dark theme
let theme = system('readlink -f ${XDG_CONFIG_HOME}/X11/current_theme | sed "s/^.*_//g"')
if theme == "light\n"
	set bg=light
	autocmd vimenter * highlight EndOfBuffer ctermfg=15
	highlight EndOfBuffer ctermfg=15
elseif theme == "dark\n"
	autocmd vimenter * highlight Normal ctermbg=none
	autocmd vimenter * highlight EndOfBuffer ctermfg=0
	highlight Normal ctermbg=none
	highlight EndOfBuffer ctermfg=0
endif

" ======== remaps ========
let mapleader=","

vnoremap <C-c> "+y
nnoremap Q @@

" Increment number
noremap <C-i> <C-a>

" Substitute
nnoremap <leader>sg :%s//g<LEFT><LEFT>
nnoremap <leader>sc :%s//gc<LEFT><LEFT><LEFT>
xnoremap <leader>sg :s//g<LEFT><LEFT>
xnoremap <leader>sc :s//gc<LEFT><LEFT><LEFT>

" Remove search highlights
noremap  <leader>c <Cmd>noh<CR>


" Quicker access to Ex commands
nnoremap ; :
xnoremap ; :

" Find files
noremap <C-p> :fin

" Space jumps to end of line
nnoremap <Space> $
xnoremap <Space> $

" Select all
noremap <C-a> ggVG
noremap <C-v> "+P
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" ======= abbrevs ========
iab hbs #!/bin/sh
iab myvim $MYVIMRC

" ======== autocmds ========
" Delete trailing whitespace and newlines on save
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e

" Reload sxhkd bindings after writing the file
autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Reload xrdb and alacritty colors after writing the file
autocmd BufWritePost *.Xresources !xrdb -merge $HOME/.config/X11/.Xresources && xres_alacritty

" Source zshrc and zprofile after editing them
autocmd BufWritePost .zprofile !source ${ZDOTDIR}/.zprofile
autocmd BufWritePost .zshrc !source ${ZDOTDIR}/.zshrc

augroup VimReload
autocmd!
	autocmd BufRead $MYVIMRC loadview
	autocmd BufWritePre $MYVIMRC mkview
	autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" vim: foldcolumn=2
