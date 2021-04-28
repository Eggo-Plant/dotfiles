" Auto install vim-plug if it's missing
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Automatically install missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Load plugins
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }	" Code autocompletion
Plug 'preservim/nerdtree'				" Tree sidebar for multi-file projects
Plug 'junegunn/limelight.vim'				" Run :Limelight to help focus on specific blocks on code
Plug 'bling/vim-airline'				" More config options for the appearance of the currently selected line
Plug 'tpope/vim-commentary'				" Makes it easy to comment out things
Plug 'ap/vim-css-color'					" Provides color highlighting for CSS color codes/names
Plug 'roxma/vim-paste-easy'				" Unbreaks weird indents when pasting things
call plug#end()

" Basic settings
set bg=dark			" Tries to set colors to suit a dark background
set number			" Shows line numbers
syntax on			" Enables syntax highlighting
set mouse=a			" Enables mouse interaction
set nohlsearch			" Removes global highlighting for searching
set ignorecase			" Ignores case when searching
set linebreak			" Tries to prevent breaking a line in the middle of a word
set clipboard+=unnamedplus	" Synchronizes vim clipboard with system clipboard

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Alias Replace all (%s) to S.
nnoremap S :%s//g<Left><Left>

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Limelight color settings
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_paragraph_span = 1

" Some remaps
cnoreabbrev nt NERDTree
cnoreabbrev LL Limelight
cnoreabbrev LL! Limelight!

" Keybinds to move between tiles using ctrl + direction
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-Down> <C-W><C-J>
nnoremap <C-Up> <C-W><C-K>
nnoremap <C-Right> <C-W><C-L>
nnoremap <C-Left> <C-W><C-H>
