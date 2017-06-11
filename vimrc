"-----------------------------------------------------------------------------
"----------------- CHANGES BACKPORTED FROM FRUGALWARE VIMRC ------------------
"-----------------------------------------------------------------------------

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set backupext=.bak      " change the default backup extension from ~ to .bak
set nobackup            " do not keep a backup file, use versions instead
"set patchmode=.orig     " backup the original file the first time it is modified
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set incsearch           " do incremental searching
set scrolloff=2         " keep at least two lines of context

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
" (but just in normal and visual mode for now)
if has('mouse')
	set mouse=nv
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
	set bg=dark
	set guifont=Source\ Code\ Pro\ Medium\ 11
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

	" Enable file type detection.
	" Use the default filetype settings, so that mail gets 'tw' set to 72,
	" 'cindent' is on in C files, etc.
	" Also load indent files, to automatically do language-dependent indenting.
	filetype plugin indent on

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

let g:recent_vim=has('nvim') || v:version > 704

if g:recent_vim
	set colorcolumn=95 " 95-character line coloring
	" folding
	set foldmethod=syntax " syntax option is slow with large files, set it by hand when needed
	set foldlevel=99

	" persistent undo
	set undodir=~/.vim/undodir
	set undofile
endif

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
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'thinca/vim-localrc', Cond(g:recent_vim)
"Plug 'tpope/vim-sleuth'
Plug 'ciaranm/detectindent'
Plug 'jszakmeister/vim-togglecursor', Cond(g:recent_vim)
call plug#end()

colorscheme molokai
set lazyredraw " Don't update the display while executing macros
set updatetime=500 " refresh time
set virtualedit=block " Allow the cursor to go in to invalid places in visual block mode
set wildmode=longest,list,full
set wildmenu " Make the command line completion better
set completeopt=menuone,preview
set t_Co=256
set synmaxcol=800 " Don't try to highlight lines longer than 800 characters.
set hidden " allows buffers to be hidden
set ls=2 " always shown statusbar
set number " enable row numbers
set cursorline
set undolevels=1000
set splitright splitbelow
set tags=./tags,tags;
runtime! ftplugin/man.vim " allow to use the :Map command and <leader>K

" highlight tabs and trailing spaces
highlight SpecialKey ctermfg=DarkRed guifg=DarkRed
set listchars=tab:>-,trail:~
set list

autocmd InsertLeave * set nopaste " Disable paste mode when leaving insert mode
set pastetoggle=<leader>p

" Allow saving of files as sudo when I forgot to start vim as root
command Sudow w !sudo tee % > /dev/null

" set spell checking for git commit messages
autocmd Filetype gitcommit setlocal spell
" always set the cursor at the first line when editing git commit messages
autocmd Filetype gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Don't move on *
"nnoremap * *<c-o>
nnoremap * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>

" highlight when double ckicking with mouse
" set mouse=a is needed
" do not use noremap here since we want the same behaviour as *
map <2-LeftMouse> *
imap <2-LeftMouse> <c-o>*

" use <leader>+space as shortcut to nohlsearch
nnoremap <leader><space> :noh<cr>

" handy shortcuts to move between buffers
if g:recent_vim
	nmap <leader><Left> :CtrlSpaceGoUp<CR>
	nmap <leader><Right> :CtrlSpaceGoDown<CR>
else
	nmap <leader><Left> :bprevious<CR>
	nmap <leader><Right> :bnext<CR>
endif

" ESC is so far away
imap jk <ESC>l
imap <c-c> <ESC>

" close annoying preview window when done
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<C-o>:pc\<CR>" : "\<C-g>u\<CR>"


"-----------------------------------------------------------------------------
"------------------------ PLUGINS CONFIGURATION ------------------------------
"-----------------------------------------------------------------------------

" plugin taglist
nnoremap <silent> <F2> :TagbarToggle<CR>
nnoremap <silent> <F3> :TagbarOpenAutoClose<CR>
nnoremap <silent> <F4> :Explore<CR>

"plugin syntastic
"let g:syntastic_mode_map['mode'] = 'passive'
let g:syntastic_mode_map = {'mode': 'passive'}
nnoremap <silent> <leader>cc :SyntasticCheck<CR>

" plugin detectindent
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
