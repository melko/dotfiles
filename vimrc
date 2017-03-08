" changes backported from frugalware vimrc

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
		"autocmd FileType text setlocal textwidth=78
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

	set autoindent                " always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		\ | wincmd p | diffthis
endif

" fine backport from frugalware

function! Bye(bang)
	if len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
		if a:bang
			:quit!
		else
			:quit
		endif
	else
		if a:bang == 0
			:bdelete!
		else
			:bdelete
		endif
	endif
endfunction

if v:version < 704
	let g:pathogen_disabled = ['jedi-vim', 'vim-startify', 'syntastic', 'tagbar', 'ultisnips']
else
	set colorcolumn=94 " 90-character line coloring
	" folding
	set foldmethod=syntax " syntax option is slow with large files, set it by hand when needed
	set foldlevel=99

	" persistent undo
	set undodir=~/.vim/undodir
	set undofile
endif
call pathogen#infect()
call pathogen#helptags()

set t_Co=256
"let g:inkpot_black_background = 1
colorscheme molokai
"colorscheme desert
"highlight Pmenu ctermfg=Black ctermbg=DarkMagenta
set hidden " allows buffers to be hidden
set ls=2 "imposta la statusbar sempre visibile
set number "abilita i numeri di riga
set cursorline
set undolevels=1000
set splitright splitbelow
set tags=./tags,tags;
set cscopetag
imap jk <ESC>l
imap <c-c> <ESC>
runtime! ftplugin/man.vim " allow to use the :Map command and <leader>K
nmap <leader><Left> :bprevious<CR>
nmap <leader><Right> :bnext<CR>
" often I want to just close a buffer and I end up closing the whole session
"command -bang Q exec Bye(<bang>0)
"command -bang WQ write<bar>exec Bye(<bang>0)
"cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'Q' : 'q')<CR>
"cabbrev wq <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'WQ' : 'wq')<CR>
"let mapleader = ","

"plugin taglist
nnoremap <silent> <F2> :TagbarToggle<CR>
nnoremap <silent> <F3> :TagbarOpenAutoClose<CR>
nnoremap <silent> <F4> :Explore<CR>

"plugin syntastic
"let g:syntastic_mode_map['mode'] = 'passive'
let g:syntastic_mode_map = {'mode': 'passive'}
nnoremap <silent> <leader>cc :SyntasticCheck<CR>

"highlight tabs and trailing spaces
highlight SpecialKey ctermfg=DarkRed guifg=DarkRed
set listchars=tab:>-,trail:~
set list

" Allow saving of files as sudo when I forgot to start vim using sudo.
command Sudow w !sudo tee % > /dev/null

set synmaxcol=800 " Don't try to highlight lines longer than 800 characters.

" Don't move on *
"nnoremap * *<c-o>
nnoremap * :let @/ = '\<'.expand('<cword>').'\>'\|set hlsearch<C-M>
" highlight when double ckicking with mouse
" set mouse=a is needed
" do not use noremap here since we want the same behaviour as *
map <2-LeftMouse> *
imap <2-LeftMouse> <c-o>*
" Keep search matches in the middle of the window.
"nnoremap n nzz
"nnoremap N Nzz

au InsertLeave * set nopaste " Disable paste mode when leaving insert mode
set pastetoggle=<leader>p

set lazyredraw " Don't update the display while executing macros
set virtualedit=block " Allow the cursor to go in to invalid places in visual block mode
set wildmode=longest,list,full
set wildmenu " Make the command line completion better
set completeopt=menuone,preview
inoremap <expr> <CR> pumvisible() ? "\<C-y>\<C-o>:pc\<CR>" : "\<C-g>u\<CR>"
set updatetime=500 " refresh time

" use <leader>+space as shortcut to nohlsearch
nnoremap <leader><space> :noh<cr>

" set spell checking for git commit messages
autocmd Filetype gitcommit setlocal spell

" The Silver Searcher
if executable('ag')
	" Use ag over grep
	set grepprg=ag\ --nogroup\ --nocolor

	" Add command :Ag
	command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

	" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

	" ag is fast enough that CtrlP doesn't need to cache
	let g:ctrlp_use_caching = 0
endif

" ultisnips and youcompleteme
"let g:UltiSnipsExpandTrigger = "<c-j>"
"let g:ycm_autoclose_preview_window_after_completion=1
"map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" supertab
"let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" silly jedi-vim trying to guess what is the best for me
let g:jedi#auto_vim_configuration = 0

" configuration for vim-airline plugin
let g:airline#extensions#tabline#enabled = 1 "list of buffers on top
let g:airline#extensions#tabline#fnamemod = ':t' " just show filename without path
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
if !exists("my_auto_commands_loaded")
	let my_auto_commands_loaded = 1
	" Large files are > 80K
	let g:LargeFile = 1024*80
	augroup LargeFile
		autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set foldmethod=manual | endif
		"autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload buftype=nowrite undolevels=-1 | else | set eventignore-=FileType | endif
	augroup END
endif
