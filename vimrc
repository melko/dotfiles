" before starting set every option to default value
" since distros usually like to have a default vimrc
" which could cause different setups
set all&

let g:recent_vim=has('nvim') || v:version > 704

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set fileencodings=ucs-bom,utf-8,default,latin1

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files we are not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

set undolevels=1000
set backupext=.bak      " change the default backup extension from ~ to .bak
set nobackup            " do not keep a backup file, use versions instead
"set patchmode=.orig     " backup the original file the first time it is modified

set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set scrolloff=2         " keep at least two lines of context
set hidden              " allows buffers to be hidden

set t_Co=256
set synmaxcol=800       " Don't try to highlight lines longer than 800 characters.
set lazyredraw          " Don't update the display while executing macros
set updatetime=500      " refresh time

set wildmode=longest,list,full
set wildmenu            " Make the command line completion better
set completeopt=menuone,preview

set ls=2                " always shown statusbar
set number              " enable row numbers
set cursorline          " highlight the screen line of the cursor
set virtualedit=block   " Allow the cursor to go in to invalid places in visual block mode

set splitright splitbelow " put the new window right/below the current one

set tags=./tags,tags;   " search for the tags file in the current folder and beyond

" highlight tabs and trailing spaces
highlight SpecialKey ctermfg=DarkRed guifg=DarkRed
set listchars=tab:>-,trail:~
set list

if g:recent_vim
	set colorcolumn=95 " 95-character line coloring
	" folding
	set foldmethod=syntax " syntax option is slow with large files, set it by hand when needed
	set foldlevel=99

	" persistent undo
	set undodir=~/.vim/undodir
	set undofile
endif

autocmd InsertLeave * set nopaste " Disable paste mode when leaving insert mode
set pastetoggle=<leader>p

" use <leader>+space as shortcut to nohlsearch
nnoremap <leader><space> :noh<cr>

" Don't move on *
"nnoremap * *<c-o>
nnoremap * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

" highlight when double ckicking with mouse
" set mouse=a is needed
" do not use noremap here since we want the same behaviour as *
map <2-LeftMouse> *
imap <2-LeftMouse> <c-o>*

" ESC is so far away
inoremap jk <ESC>l
inoremap <c-c> <ESC>

" wrap cursor when moving past begin/end of a line
set whichwrap+=<,>,h,l

" handy shortcuts to move between buffers
if g:recent_vim
	nmap <leader><Left> :CtrlSpaceGoUp<CR>
	nmap <leader><Right> :CtrlSpaceGoDown<CR>
	nmap <leader><leader><Left> :bprevious<CR>
	nmap <leader><leader><Right> :bnext<CR>
else
	nmap <leader><Left> :bprevious<CR>
	nmap <leader><Right> :bnext<CR>
endif

" set spell checking for git commit messages
autocmd Filetype gitcommit setlocal spell
" always set the cursor at the first line when editing git commit messages
autocmd Filetype gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Allow saving of files as sudo when I forgot to start vim as root
command Sudow w !sudo tee % > /dev/null

" close annoying preview window when done
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<C-o>:pc\<CR>" : "\<C-g>u\<CR>"

"-----------------------------------------------------------------------------
"----------------- CHANGES BACKPORTED FROM FRUGALWARE VIMRC ------------------
"-----------------------------------------------------------------------------

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" (but just in normal and visual mode for now)
if has('mouse')
	set mouse=nv
endif

" mouse right-click opens a popup menu
if has("gui_running")
	set mousemodel=popup_setpos
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
	set bg=dark
	"set guifont=Source\ Code\ Pro\ Medium\ 11
	set guifont=Hack\ 11
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on
	set omnifunc=syntaxcomplete#Complete

	" Put these in an autocmd group, so that we can delete them easily.
	augroup vimrcEx
		au!

		" For all text files set 'textwidth' to 78 characters.
		" autocmd FileType text setlocal textwidth=78
		set wrap

		" When editing a file, always jump to the last known cursor position.
		" Don't do it when the position is invalid or when inside an event handler
		" (happens when dropping a file on gvim).
		" Also don't do it when the mark is in the first line, that is the default
		" position when opening a file.
		autocmd BufReadPost *
			\ if line("'\"") > 1 && line("'\"") <= line("$") |
			\   exe "normal! g`\"" |
			\ endif

	augroup END

else

	set autoindent " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

"-----------------------------------------------------------------------------
"------------------------ END OF FRUGALWARE BACKPORT -------------------------
"-----------------------------------------------------------------------------

" vim-plug
call plug#begin('~/.vim/plugged')
" helper function
function! Cond(cond, ...)
	let opts = get(a:000, 0, {})
	return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

Plug 'davidhalter/jedi-vim', Cond(g:recent_vim)
Plug 'tomasr/molokai'
Plug 'vim-syntastic/syntastic', Cond(g:recent_vim)
Plug 'majutsushi/tagbar', Cond(g:recent_vim)
Plug 'SirVer/ultisnips', Cond(g:recent_vim)
"Plug 'bling/vim-bufferline'
Plug 'vim-ctrlspace/vim-ctrlspace', Cond(g:recent_vim)
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'honza/vim-snippets'
Plug 'mhinz/vim-startify', Cond(g:recent_vim)
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter', Cond(g:recent_vim)
Plug 'ctrlpvim/ctrlp.vim'
Plug 'thinca/vim-localrc', Cond(g:recent_vim)
"Plug 'tpope/vim-sleuth'
Plug 'roryokane/detectindent'
Plug 'jszakmeister/vim-togglecursor', Cond(g:recent_vim)
Plug 'haya14busa/incsearch.vim', Cond(g:recent_vim)
Plug 'easymotion/vim-easymotion'
Plug 'unblevable/quick-scope', Cond(g:recent_vim)
Plug 'ludovicchabant/vim-gutentags', Cond(g:recent_vim)
Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' }
call plug#end()

"-----------------------------------------------------------------------------
"------------------------ PLUGINS CONFIGURATION ------------------------------
"-----------------------------------------------------------------------------

colorscheme molokai " here since molokai is installed with vim-plug
highlight MatchParen ctermfg=166 ctermbg=0

" vim-gutentags
"let g:gutentags_enabled = 0 " do not autoenable for now
let g:gutentags_project_root = ['.guten']
let g:gutentags_add_default_project_roots = 0
let g:gutentags_define_advanced_commands = 1

" plugin taglist
nnoremap <silent> <F2> :TagbarToggle<CR>
nnoremap <silent> <F3> :TagbarOpenAutoClose<CR>
nnoremap <silent> <F4> :Explore<CR>

"plugin syntastic
"let g:syntastic_mode_map['mode'] = 'passive'
let g:syntastic_mode_map = {'mode': 'passive'}
nnoremap <silent> <leader>cc :SyntasticCheck<CR>

" plugin detectindent
let g:detectindent_preferred_indent = 8
augroup detectindent
	autocmd BufReadPost * :DetectIndent
augroup END

" cscope
if has("cscope")
	" load cscope.out going back into hierarchy if necessary
	function! LoadCscope()
		let db = findfile("cscope.out", ".;")
		if (!empty(db))
			let path = strpart(db, 0, match(db, "/cscope.out$"))
			set nocscopeverbose
			exe "cs add " . db . " " . path
			set cscopeverbose
		endif
	endfunction
	autocmd BufEnter /* call LoadCscope()

	set cscopetag
endif

" ripgrep
if executable('rg')
	set grepprg=rg\ --vimgrep\ --no-heading
	command -nargs=+ -complete=file -bar Grep silent! grep! <args>|cwindow|redraw!

	let g:ctrlp_user_command = 'rg --files %s'
	let g:ctrlp_use_caching = 0

	let g:CtrlSpaceGlobCommand = 'rg --files -g ""'
" The Silver Searcher
elseif executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor
	" Add command :Grep
	command -nargs=+ -complete=file -bar Grep silent! grep! <args>|cwindow|redraw!

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0

	" use ag in ctrlspace
	let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

" silly jedi-vim trying to guess what is the best for me
let g:jedi#auto_vim_configuration = 0
" with some modules (e.g. MyHDL) completion is really slow
let g:jedi#popup_on_dot = 0
set noshowmode " needed to show signatures in the status bar
let g:jedi#show_call_signatures = 2 " show signatures in the status bar instead of popup

" configuration for vim-airline plugin
let g:airline#extensions#tabline#enabled = 1        " list of buffers on top
let g:airline#extensions#tabline#fnamemod = ':t'    " just show filename without path
"let g:airline#extensions#tabline#tab_nr_type = 2    " splits and tab number
let g:airline#extensions#tabline#buffer_nr_show = 1 " display buffer index
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" incsearch.vim configuration
if g:recent_vim
	map / <Plug>(incsearch-forward)
	map ? <Plug>(incsearch-backward)
	map g/ <Plug>(incsearch-stay)
endif

" quick-scope configuration
" highlight just on keypress
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" avoid slow down for huge files because of syntax folding
" actually I don't even use folding that much
if !exists("my_auto_commands_loaded")
	let my_auto_commands_loaded = 1
	" Large files are > 80K
	let g:LargeFile = 1024*80
	augroup LargeFile
		autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set foldmethod=manual | endif
		"autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
	augroup END
endif
