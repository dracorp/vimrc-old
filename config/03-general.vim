" General {{{

if !plugin#isEnabled('vim-sensible') "{{{2
    set autoread                                " read open files again when changed outside Vim
    set scrolloff=4                             " keep 4 lines off the edges of the screen when scrolling
    set backspace=indent,eol,start              " allow backspacing over everything in insert mode
    set incsearch                               " show search matches as you type
    " listchars=tab:> ,trail:-,extends:>,precedes:<,nbsp:+
    set complete-=i                             " do not scan current and included files, on slow machines
"    set nrformats=                              " make <C-a> and <C-x> play well with zero-padded numbers (i.e. don't consider them octal or hex)
    set laststatus=2                            " tell VIM to always put a status line in, even if there is only one window
    set ruler                                   " show the cursor position all the time
    set history=1000                            " remember more commands and search history
endif "}}}
set listchars=tab:>-,eol:$,trail:-,nbsp:%
" display end of lines, TAB, spaces on the end of line, before and after wrap row
" eol, tab, trail, extends, precedes, strings to use in 'list' mode
set nolist                                      " don't show invisible characters by default, but it is enabled for some file types (see later)

set virtualedit=block        " Position cursor anywhere in visual block
set mousehide                " Hide the mouse when typing text
set mouse=v                  " enable using the mouse if terminal emulator supports it (xterm does)
set showmode                 " always show what mode we're currently editing in
set showcmd                  " show (partial) command in the last line of the screen
                             " this also shows visual selection info
set nowrap                     " wrap lines
set magic                    " For regular expressions turn magic on
set shortmess+=I             " hide the launch screen
set shortmess+=c             " don't give |ins-completion-menu| messages.
set fileformats=unix,dos,mac " Prefer Unix over Windows over OS 9 formats
if has('signs') && version >= 800
    set signcolumn=auto          " show signcolumns
endif
set number                   " show line numbers
set relativenumber
set cursorline
set showmatch                " jump to matching parenthesis/bracket
set matchpairs+=<:>          " Add HTML brackets to pair matching
set ignorecase               " ignore case when searching
set smartcase                " ignore case if search pattern is all lowercase, case-sensitive otherwise
if has('patch-7.3.541')
    set formatoptions+=j     " Remove comment leader when joining lines
endif
set fileencodings=ucs-bom,utf-8,default,cp1250,iso8859-2,iso8859-15,iso8859-1,ucs-bom,utf-16le
" }}}

" Editing behaviour {{{
behave xterm                                    " Set behaviour for mouse and selection, affect on selectmode mousemodel keymodel selection
" indention & tabs
set autoindent                                  " always set autoindenting on
set smartindent                                 " smart autoindenting when starting a new line
set copyindent                                  " copy the previous indentation on autoindenting
" 1 tab == 4 spaces
set tabstop=4                                   " a tab is four spaces
set softtabstop=4                               " when hitting <BS>, pretend like a tab is removed, even if spaces
set shiftwidth=4                                " number of spaces to use for autoindenting
set smarttab                                    " insert tabs on the start of a line according to shiftwidth, not tabstop
set expandtab                                   " expand tabs by default (overloadable per file type later)
set shiftround                                  " use multiple of shiftwidth when indenting with '<' and '>'

set virtualedit=                                " allow the cursor to go in to 'invalid' places
"set gdefault                                    " search/replace 'globally' (on a line) by default
set nojoinspaces                                " do not insert 2 spaces after .?! when join lines <J>

set textwidth=79                                " maximum width of text that is being inserted
set wrapmargin=2                                " To wrap text based on a number of columns from the right side
" autoformat: call using gq, see also |fo-table|
set formatoptions+=1                            " long lines are not broken in insert mode
set formatoptions+=t                            " autowrap text using textwidth
set formatoptions-=t
set formatoptions-=c                            " autowrap comments using textwidth
set formatoptions+=o                            " automatically insert the current comment leader after hitting 'o' in Normal mode
set formatoptions+=r                            " as above but after <Enter> in Insert mode
"set formatoptions+=m                            " Also break at a multi-byte character above 255
"set formatoptions+=B                            " When joining lines, don't insert a space between two multi-byte characters

" Enable clipboard if possible
if has('clipboard')
    if has('unnamedplus')                       " When possible use + register for copy-paste
        " Enable to copy to clipboard for operations like yank, delete, change and put
        " http://stackoverflow.com/questions/20186975/vim-mac-how-to-copy-to-clipboard-without-pbcopy
        set clipboard=unnamed,unnamedplus
    else                                        " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif
endif
if has('mac')
	let g:clipboard = {
		\   'name': 'macOS-clipboard',
		\   'copy': {
		\      '+': 'pbcopy',
		\      '*': 'pbcopy',
		\    },
		\   'paste': {
		\      '+': 'pbpaste',
		\      '*': 'pbpaste',
		\   },
		\   'cache_enabled': 0,
		\ }
endif
" }}}

" Various settings {{{
set sessionoptions+=tabpages,globals

set linebreak
set wrapscan                                    " searches wrap around the end of file
set autowrite                                   " write a modified buffer on each :next , ...
set confirm
" backspace, space, <left>, <right>
set whichwrap=b,s,<,>,[,],h,l                   " which keys move the cursor to previous/next line when the cursor is on the first/last character
set browsedir=current                           " which directory to use for the file browser
set complete+=k                                 " scan the files given with the 'dictionary' option
set printoptions=left:8pc,right:3pc             " print options or export to html
let g:html_use_css=1
let g:use_xhtml=1000
set display=lastline                           " show last line even it does not fit, we don't want uhex
"set colorcolumn=+1
set showbreak=+\                                " show wraped lines as
set modeline                                    " search for additional vim commands in n-th first lines(see modelines)
set ttyfast                                     " always use a fast terminal
set splitbelow                                  " command :sp put a new window below the active
set splitright                                  " command :vs put a new windows on right side of active
set equalalways                                 " Resize windows on split or close
set infercase                                   " Adjust case in insert completion mode
set tildeop                                     " Tylde(~) behaves like operator
set iskeyword+=-                                " which char make a word
set iskeyword-=$
" open file under cursor with env variable
set isfname+={,}                                " where the file name starts and ends
" open file under cursor for entry: VARIABLE=path
set isfname-==
" [Bash-it](https://github.com/Bash-it/) settings
if !empty($BASH_IT)
    set path+=$BASH_IT
endif
set diffopt+=iwhite     " ignore white spaces
set diffopt+=context:3  " context for diff
if version > 810
    set diffopt+=closeoff
    set diffopt+=internal,indent-heuristic,algorithm:histogram
endif
" }}}

" Folding rules {{{
if has('folding')
    set foldenable                              " enable folding
    set foldcolumn=0                            " add a fold column
    set foldmethod=marker                       " detect triple-{ style fold markers
    set foldmarker={{{,}}}
   set foldlevelstart=1                      " start out with everything unfolded
    set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo " which commands trigger auto-unfold
endif
" }}}

" Editor layout {{{
set lazyredraw                  " don't update the display while executing macros
set cmdheight=2                 " use a status bar that is 2 rows high
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" bomb (BOM)
" UTF-8: EF BB BF
" UTF-16be: FE FF
" UTF-16le: FF FE
" 'termencoding' sets the character for keyboard and for screen (only for console Vim)
" 'printencoding' sets the character for print only for +printer and +postscript compile options
" The conversion proceeds as follows. If setf of character differ from each other and method of conversion is known:
"    * 'fileencoding' to 'encoding' while reading from a disc
"    * 'termencoding' to 'encoding' while typing
"    * (only in console Vim): 'encoding' to 'termencoding' while displaying
"    * 'encoding' to 'printencoding' while printing via PostScript
"    * 'encoding' to 'fileencoding' while writting to a disc
" Usage of ':w ++enc=XXX' does not change default behaviour of write
" Usage of 'fileencoding' (better to change by ':setlocal' then ':set') change writing behaviour
" }}}

" Vim behaviour {{{
"set spell spelllang=pl,en
"set spellsuggest=best

" if hidden is not set, TextEdit might fail.
set hidden
" hide buffers instead of closing them this
" means that the current buffer can be put
" to background without being written; and
" that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set undolevels=1000                             " use many muchos levels of undo
if has('persistent_undo')
    set undofile                                " keep a persistent backup file
    set undoreload=10000                        " maximum number lines to save for undo on a buffer reload
    let &undodir=vimrc_dir . '.undodir'
endif

" Some servers have issues with backup files, see
" [#649](https://github.com/neoclide/coc.nvim/issues/649)
set nobackup                    " do not keep backup files, it's 70's style cluttering
let &backupdir=vimrc_dir . '.backupdir,~/tmp,/tmp'
set nowritebackup
set noswapfile                  " do not write annoying intermediate swap files,
set autochdir                   " automatically switch the working directory to that of the file being edited
set directory=.,~/tmp           " store swap files in one of these directories (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                " than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:longest,list:full  " show a list when pressing tab and complete
set wildignore=*.o,*.e,*~,*.swp,*.class,*.so,*.pyo,*.zip,*.obj,*.git/*,*.rbc,*.pyc,__pycache__,*/.svn/*,*/.DS_Store,*/tmp/*
set completefunc=emoji#complete
set completeopt=longest,menu
set title                       " change the terminal's title
set titleold="Terminal"
set titlestring=%F
set noerrorbells                " don't beep
set novisualbell
set t_vb=
set t_ti= t_te=                 " put terminal in 'termcap' mode
" }}}

" Colors/theme {{{
let g:gruvbox_italic=0
let g:gruvbox_contrast_dark='hard'
" silent! colorscheme gruvbox

let g:gruvbox_material_palette='material'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_enable_italic = 0
let g:gruvbox_material_disable_italic_comment = 1
silent! colorscheme gruvbox-material
set background=dark



"}}}
" Python
if g:MACOS
    let g:python2_host_prog = '/usr/local/bin/python2'
    let g:python3_host_prog = '/usr/local/bin/python3'
endif
