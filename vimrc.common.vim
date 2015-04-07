"===================================================================================
"         FILE:  .vimrc
"  DESCRIPTION:  Suggestion for a personal configuration file ~/.vimrc
"===================================================================================
"
" To start vim without using this .vimrc file, use:
"   vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
"   vim -u NONE
"
" To test timing startup
"   vim --startuptime start.log

" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

" Remove ALL autocommands for the current group.
autocmd!

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
filetype off                                    " force reloading *after* pathogen loaded

" pathogen
"call pathogen#infect()
"call pathogen#helptags()                        " slow start and generate tags
" vundle
"set the runtime path to include Vundle and initialize
if g:UNIX
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
elseif g:MSWIN
    " vim's directory
    let &rtp .= ',' . vimrc_dir . 'bundle\Vundle.vim'
    let path=vimrc_dir . 'bundle'
    call vundle#begin(path)
endif
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" base
Plugin 'xolox/vim-misc'
Plugin 'Shougo/vimproc.vim'

" Charles Campbell
Plugin 'AnsiEsc.vim'
Plugin 'DrawIt'
Plugin 'emezeske/manpageview'
Plugin 'vim-scripts/Decho'
Plugin 'vim-scripts/gdbmgr'
Plugin 'HiColors'
Plugin 'highlight.vim'
Plugin 'LargeFile'
"Plugin 'StlShowFunc'
Plugin 'SudoEdit.vim'
Plugin 'vis'
"Plugin 'Astronaut'

" Python
if has('python')
    Plugin 'davidhalter/jedi-vim'
endif
Plugin 'klen/python-mode'

" Fritz Mehner
Plugin 'awk-support.vim'
Plugin 'bash-support.vim'
Plugin 'perl-support.vim'
Plugin 'Vim-support'
Plugin 'c.vim'
Plugin 'latex-support.vim'

" git
Plugin 'int3/vim-extradite'
Plugin 'tpope/vim-fugitive'
Plugin 'WolfgangMehner/git-support'
Plugin 'idanarye/vim-merginal'
Plugin 'airblade/vim-gitgutter'

" colorschemes
Plugin 'blueshirts/darcula'
Plugin 'altercation/vim-colors-solarized'
Plugin 'xolox/vim-colorscheme-switcher'

" Others
Plugin 'rking/ag.vim'
Plugin 'closetag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'chrisbra/vim-diff-enhanced'
Plugin 'jQuery'
Plugin 'Shutnik/jshint2.vim'
Plugin 'scrooloose/nerdtree.git'
Plugin 'tyru/open-browser.vim'
Plugin 'perl_h2xs'
Plugin 'jlemetay/permut.git'
Plugin 'edkolev/promptline.vim'
Plugin 'restore_view.vim'
Plugin 'tpope/vim-sensible'
Plugin 'SuperTab'
Plugin 'AndrewRadev/switch.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Tabmerge'
Plugin 'godlygeek/tabular'
Plugin 'majutsushi/tagbar'
Plugin 'taglist.vim'
Plugin 'sjl/splice.vim'
Plugin 'Toggle'
Plugin 'TWiki-Syntax'
"Plugin 'SirVer/ultisnips'
Plugin 'mbbill/undotree'
Plugin 'Shougo/unite.vim'
Plugin 'bling/vim-airline'
Plugin 'powerline/powerline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'nvie/vim-flake8'
Plugin 'vitalk/vim-lesscss.git'
Plugin 'plasticboy/vim-markdown'
Plugin 'kurkale6ka/vim-pairs'
Plugin 'vim-perl/vim-perl'
Plugin 'tpope/vim-repeat.git'
Plugin 'tpope/vim-scriptease'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround.git'
Plugin 'tpope/vim-unimpaired'
Plugin 'vimwiki'
Plugin 'vim-scripts/whitespace-syntax-highlight'
Plugin 'xml.vim'
Plugin 'xmledit'
Plugin 'xslt'
Plugin 'yowish'
Plugin 'MRU'

" My vim plugin for PKGBUILD
if g:UNIX
    Plugin 'dracorp/vim-pkgbuild'
endif
" local filesystem
" https://sites.google.com/site/abudden/contents/Vim-Scripts/file-templates
Plugin 'file_templates', {'pinned': 1}

" Windows
if g:MSWIN
    Plugin 'maximize.dll'
endif
call vundle#end()
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on                       " enable detection, plugins and indenting in one step

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch                                " highlight search
endif

" Set behavior for mouse and selection, affect on selectmode mousemodel keymodel selection
" if g:MSWIN
"     behave mswin
" else
    behave xterm
" endif

" set mousemodel=extend           "fast search by mouse

" Key mapping {{{
if filereadable(vimrc_dir . "vimrc.keys.vim")
    execute ":source" vimrc_dir . "vimrc.keys.vim"
endif
" }}}
" Some functions {{{
if filereadable(vimrc_dir . "vimrc.functions.vim")
    execute ":source" vimrc_dir . "vimrc.functions.vim"
endif
" }}}
" Common abbreviations / misspellings {{{
if filereadable(vimrc_dir . "autocorrect.vim")
    execute ":source" vimrc_dir . "autocorrect.vim"
endif
" }}}
" Editing behaviour {{{
set showmode                                    " always show what mode we're currently editing in
set wrap                                        " wrap lines
set tabstop=4                                   " a tab is four spaces
set softtabstop=4                               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                                " number of spaces to use for autoindenting
set shiftround                                  " use multiple of shiftwidth when indenting with '<' and '>'
set backspace=indent,eol,start                  " allow backspacing over everything in insert mode
set autoindent                                  " always set autoindenting on
set copyindent                                  " copy the previous indentation on autoindenting
set number                                      " show line numbers
set showmatch                                   " set show matching parenthesis
set ignorecase                                  " ignore case when searching
set smartcase                                   " ignore case if search pattern is all lowercase,
                                                " case-sensitive otherwise
set smarttab                                    " insert tabs on the start of a line according to
                                                " shiftwidth, not tabstop
set scrolloff=4                                 " keep 4 lines off the edges of the screen when scrolling
" set virtualedit=all                             " allow the cursor to go in to 'invalid' places
set incsearch                                   " show search matches as you type
" set gdefault                                     " search/replace 'globally' (on a line) by default

" display end of lines, TAB, spaces on the end of line, before and after wrap row
" eol, tab, trail, extends, precedes, strings to use in 'list' mode
set listchars=tab:>-,eol:$,trail:-,nbsp:%

set nolist                                      " don't show invisible characters by default,
                                                " but it is enabled for some file types (see later)
set pastetoggle=<F6>                            " when in insert mode, press <F2> to go to
                                                " paste mode, where you can paste mass data
                                                " that won't be autoindented
set mouse=a                                     " enable using the mouse if terminal emulator
                                                "    supports it (xterm does)

" automatyczne formatowanie, gq je wywołuje, domyślne wartości: formatoptions=croql :help fo-table
set formatoptions+=1            " 1 przenosi ostatni, pojedynczy znak, taki jak i a z w, do następnej linii.
set formatoptions+=t            " t automatyczne zwijanie do textwidth
set formatoptions-=c            " c automatyczne zwijanie do textwidth komentarzy

set nrformats=                  " make <C-a> and <C-x> play well with
                                "    zero-padded numbers (i.e. don't consider
                                "    them octal or hex)

set shortmess+=I                " hide the launch screen
set clipboard=unnamed           " normal OS clipboard interaction
" }}}
" Various settings {{{
set linebreak
set smartindent                 " smart autoindenting when starting a new line
set wrapscan 					" przy wyszukiwaniu będzie zaczynał od początku pliku, przy no tylko do końca
" set autoread                   " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
" definiuje które klawisze przenoszą kursor do nowej linii gdy jest na końcu/początku lini
" backspace, space, <left>, <right> w Normal, i w Insert
set whichwrap=b,s,<,>,[,],h,l
set browsedir=current           " which directory to use for the file browser
set complete+=k                 " scan the files given with the 'dictionary' option
set mousehide                   " Hide the mouse when typing text
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set display+=lastline           " Pokazuje na dole ostatnią linię?
set so=3                        " przy przewijaniu trzymaj się n lini od końca/początku ekranu
set textwidth=0                 " domyślna wartość: czasem wato ustawić szerokość ekranu na 78 kolumn
set showbreak=+\               " załamanie/wrap lini oznacza przez

set modeline                    " modeline to komendy dla vima w komentarzach innych plików
" set ttyfast                     " always use a fast terminal
set nocursorline                  " underline the current line, for quick orientation
"żeby vim nie przycinał na dużych plikach gdy jest kolorowanie składni
syntax sync minlines=30
syntax sync maxlines=40
set synmaxcol=500
set splitbelow                  " polecenie :sp umieszcza nowe okno pod aktywnym
set splitright                  " polecenie :vs umieszcza nowe po prawej stronie aktywnego
set infercase
set tildeop                     " Tylda(~) robi za operator, można teraz używać jej np. tak: ~w ~~
" set iskeyword+=-,,              " which char make a word
" }}}
" Folding rules {{{
set foldenable                  " enable folding
set foldcolumn=0                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
" set foldmarek={{{,}}}
"set foldlevelstart=99           " start out with everything unfolded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
highlight FoldColumn  gui=bold    guifg=grey65     guibg=Grey90
highlight Folded      gui=italic  guifg=Black      guibg=Grey90
highlight LineNr      gui=NONE    guifg=grey60     guibg=Grey90

" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>
" }}}
" Editor layout {{{
scriptencoding utf-8
set fenc=utf-8
set termencoding=utf-8
set fileencoding=utf-8
"if g:MSWIN
"    Problem with function and command which operates on diacriticals!
"    set encoding=cp1250
"else
    set encoding=utf-8
"endif
set lazyredraw                  " don't update the display while executing macros
set laststatus=2                " tell VIM to always put a status line in, even
                                "    if there is only one window
set cmdheight=1                 " use a status bar that is 1 rows high
"set fileencodings=ucs-bom,utf-8,default,utf-16le,iso8859-2,cp1250,iso8859-1
set fileencodings=ucs-bom,utf-8,default,cp1250,iso8859-2,iso8859-1,ucs-bom,utf-16le
" bomb (BOM)
" UTF-8: EF BB BF
" UTF-16be: FE FF
" UTF-16le: FF FE
" 'termencoding' jest zestawem znaków dla klawiatury, oraz (tylko w konsolowym Vimie) dla ekranu.
" 'printencoding' jest zestawem znaków dla drukarki, jeśli oba +printer i +postscript są wkompilowane.
" Konwersja przebiega następująco, jeśli zestawy znaków różnią się a metoda konwersji jest znana:
"    * 'fileencoding' na 'encoding' podczas czytania z dysku
"    * 'termencoding' na 'encoding' podczas wpisywania z klawiatury
"    * (tylko w konsolowym Vimie): 'encoding' na 'termencoding' podczas wyświetlania
"    * 'encoding' na 'printencoding' podczas drukowania przez PostScript
"    * 'encoding' na 'fileencoding' podczas zapisu na dysk
" Użycie ":w ++enc=XXX" nie zmienia zachowania domyślnego (ang. ulterior?) zapisu.
" Użycie 'fileencoding' (które lepiej zmieniać przez ":setlocal" niż ":set") zmienia zachowanie zapisu.
" fileencodings różni się od fileencoding tym, że ustawia domyślny zapis dla wszystkich plików.
" }}}
" Vim behaviour {{{
" set hidden                      " hide buffers instead of closing them this
                                "    means that the current buffer can be put
                                "    to background without being written; and
                                "    that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                " remember more commands and search history

set undolevels=1000             " use many muchos levels of undo
set undoreload=10000            "maximum number lines to save for undo on a buffer reload
if has('persistent_undo')
    set undofile                " keep a persistent backup file
    let &undodir=vimrc_dir . '.undodir'
endif
let &backupdir=vimrc_dir . '.backupdir,~/tmp,/tmp'

set nobackup                    " do not keep backup files, it's 70's style cluttering
" set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
"set directory=~/tmp,/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                "    than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=longest,list       " show a list when pressing tab and complete
set wildignore=*.bak,*.o,*.e,*~,*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info

" Permanent 'very magic' mode, see :he pattern
" search
" nnoremap / /\v
" vnoremap / /\v
" substitute
cnoremap %s/ %smagic/
" substitute in visual mode
cnoremap \>s/ \>smagic/
" global
nnoremap :g/ :g/\v
nnoremap :g// :g//
" }}}
" Toggle the quickfix window {{{
" From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
nnoremap <C-q> :call <SID>QuickfixToggle()<cr>

let g:quickfix_is_open = 0

function! s:QuickfixToggle()
    if g:quickfix_is_open
        cclose
        let g:quickfix_is_open = 0
        execute g:quickfix_return_to_window . "wincmd w"
    else
        let g:quickfix_return_to_window = winnr()
        copen
        let g:quickfix_is_open = 1
    endif
endfunction
" }}}
" Toggle the foldcolumn {{{
nnoremap <leader>f :call FoldColumnToggle()<cr>

let g:last_fold_column_width = 4  " Pick a sane default for the foldcolumn

function! FoldColumnToggle()
    if &foldcolumn
        let g:last_fold_column_width = &foldcolumn
        setlocal foldcolumn=0
    else
        let &l:foldcolumn = g:last_fold_column_width
    endif
endfunction
" }}}
" autocommand {{{
if has("autocmd")
    " *save/restore view*
    "autocmd BufWinLeave *.* mkview!
    "autocmd BufWinEnter *.* silent loadview

    " Zaczynaj nowy plik w trybie Insert
    "autocmd BufNewFile * startinsert

    " Automatyczna zmiana katalogu do tego, w ktorym jest aktualnie edytowany plik.
    " Przydatne gdy chcemy otworzyc inny z tego samego katalogu
    " http://vim.sourceforge.net/tip_view.php?tip_id=101
    " mozna tez uzyc set acd, ale ta opcja nie dziala z pewnymi wtyczkami, zobacz :he acd
    autocmd BufEnter * :cd %:p:h

    " Zablokuj pliki tylko do odczytu
    "au BufReadPost * :call CheckReadonly()

    " The current directory is the directory of the file in the current window.
    autocmd BufEnter * :lchdir %:p:h

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

 endif " has("autocmd")
" }}}
" Spell {{{
set spelllang=pl,en
" }}}
" Highlight & Colorscheme {{{

"if has("terminfo")
"  let &t_Co=16
"  let &t_AB="\<Esc>[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm"
"  let &t_AF="\<Esc>[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm"
"else
"  let &t_Co=16
"  let &t_Sf="\<Esc>[3%dm"
"  let &t_Sb="\<Esc>[4%dm"
"endif

if &term =~ "xterm"
  " 256 colors
  let &t_Co = 256
  " restore screen after quitting
  let &t_ti = "\<Esc>7\<Esc>[r\<Esc>[?47h"
  let &t_te = "\<Esc>[?47l\<Esc>8"
  if has("terminfo")
    let &t_Sf = "\<Esc>[3%p1%dm"
    let &t_Sb = "\<Esc>[4%p1%dm"
  else
    let &t_Sf = "\<Esc>[3%dm"
    let &t_Sb = "\<Esc>[4%dm"
  endif
endif

let c_comment_strings=1                         " highlight strings inside C comments
colorscheme redstring
if &diff
    colorscheme xterm16
endif
" Black, c, Dark, darkzen, desert, elflord, grb, grb-light, grb2, grb256,
" grb4, moria, redstring, xterm16
" set background=dark
" highlight MatchParen ctermbg=blue guibg=lightyellow " highlight paired brackets
"-------------------------------------------------------------------------------
""highlight SpellErrors ctermfg=Red ctermbg=White guifg=Red guibg=White cterm=underline gui=underline term=reverse
" highlight Normal         ctermfg=LightGrey guibg=black guifg=#AFABAF
" highlight Search         ctermfg=Yellow ctermbg=Red cterm=bold guifg=Yellow guibg=Red
" highlight IncSearch      ctermbg=red ctermfg=black cterm=NONE guifg=red guibg=black
" highlight Visual         cterm=reverse guifg=#303030 guibg=LightGray
" highlight Cursor         ctermfg=Black ctermbg=Green cterm=bold guifg=black guibg=#61FFCF
" highlight Special        ctermfg=Brown guifg=#CF7520
" highlight Comment        ctermfg=LightGray guifg=#7A90FF guibg=black gui=NONE
" highlight StatusLine     cterm=bold gui=NONE ctermfg=green ctermbg=blue guifg=green guibg=#0000AF
" highlight StatusLineNC   ctermfg=black ctermbg=white cterm=NONE
" highlight User1          ctermfg=grey ctermbg=blue cterm=bold
" highlight VertSplit      ctermfg=gray ctermbg=blue cterm=bold
" highlight Statement      ctermfg=Yellow cterm=bold gui=none guifg=Yellow
" highlight vimCommand     ctermfg=Yellow ctermbg=black cterm=NONE guifg=#CF7520
" highlight Type           cterm=NONE gui=NONE guifg=#00AB00
" highlight Identifier     cterm=NONE ctermfg=blue
" highlight NonText        guifg=#7A90FF
" highlight Folded         term=standout cterm=bold ctermfg=6 ctermbg=0 guifg=Cyan guibg=black
" highlight PreProc        term=underline cterm=bold ctermfg=Blue guifg=#7A90FF
" highlight Todo           term=standout ctermfg=0 ctermbg=3 guifg=black guibg=#CF7520
" }}}
" use css while export to html {{{
let g:html_use_css = "1"
let g:use_xhtml = 1000
" }}}
" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")
    augroup invisible_chars "{{{
        au!

        " Show invisible characters in all of these files
        "autocmd filetype vim setlocal list
        autocmd filetype help nnoremap <S-F12> :call ReadHelp()<CR>
        function! ReadHelp()
            if !exists("b:help")
                let b:help=1
            endif
            if (b:help)
                setlocal ft=txt
                let b:help=0
            else
                setlocal ft=help
                let b:help=1
            endif
        endfun
        "autocmd filetype python,rst setlocal list
        "autocmd filetype ruby setlocal list
        "autocmd filetype javascript,css setlocal list
    augroup end "}}}

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd filetype vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd filetype vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
"        autocmd filetype vim nnoremap <buffer> <F12> :source %<CR>
    augroup end "}}}

    augroup html_files "{{{
        au!

        " This function detects, based on HTML content, whether this is a
        " Django template, or a plain HTML file, and sets filetype accordingly
        fun! s:DetectHTMLVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ '{%\s*\(extends\|load\|block\|if\|for\|include\|trans\)\>'
                    set ft=htmldjango.html
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=html
        endfun

        " Auto-tidy selection
        vnoremap <leader>x :!tidy -q -i --show-errors 0 --show-body-only 1 --wrap 0<cr><cr>

        autocmd BufNewFile,BufRead *.html,*.htm,*.j2 call s:DetectHTMLVariant()

        " Auto-closing of HTML/XML tags
        let g:closetag_default_xml=1
        let g:xml_syntax_folding=1
        autocmd filetype xml,xsd,xslt,xsl,html,htmldjango call SetHtmlOptions()
        function! SetHtmlOptions()
            let b:closetag_html_style=1
            setlocal foldmethod=syntax
            " keymap
"            let l:filename = expand("%:r")
"            exe "nnoremap <F12> :!xmllint --noout --schema " . l:filename . ".xsd %<CR>"
"            nnoremap <S-F12> :silent %!xmllint --format --recover - 2>/dev/null<CR>
        endfun
    augroup end " }}}

    augroup awk_files " {{{
        au!
        autocmd filetype awk nnoremap <buffer> <F12> :!gawk -f %<CR>
    augroup end " }}}

    augroup xdefaults_files " {{{
        au!
        autocmd filetype xdefaults nnoremap <buffer> <F12> :!xrdb -load %<CR>
        augroup end " }}}

    augroup xmodmap_files " {{{
        au!
        autocmd filetype xmodmap nnoremap <buffer> <F12> :!xmodmap %<CR>
        augroup end " }}}

    augroup python_files "{{{
        au!

        " This function detects, based on Python content, whether this is a
        " Django file, which may enabling snippet completion for it
        fun! s:DetectPythonVariant()
            let n = 1
            while n < 50 && n < line("$")
                " check for django
                if getline(n) =~ 'import\s\+\<django\>' || getline(n) =~ 'from\s\+\<django\>\s\+import'
                    set ft=python.django
                    "set syntax=python
                    return
                endif
                let n = n + 1
            endwhile
            " go with html
            set ft=python
        endfun
        autocmd BufNewFile,BufRead *.py call s:DetectPythonVariant()

        " PEP8 compliance (set 1 tab = 4 chars explicitly, even if set
        " earlier, as it is important)
        autocmd filetype python setlocal textwidth=78
        autocmd filetype python match ErrorMsg '\%>120v.\+'

        " But disable autowrapping as it is super annoying
        autocmd filetype python setlocal formatoptions-=t

        " Folding for Python (uses syntax/python.vim for fold definitions)
        "autocmd filetype python,rst setlocal nofoldenable
        "autocmd filetype python setlocal foldmethod=expr

        " Python runners
        autocmd filetype python noremap <buffer> <F5> :w<CR>:!python %<CR>
        autocmd filetype python inoremap <buffer> <F5> <Esc>:w<CR>:!python %<CR>
        autocmd filetype python noremap <buffer> <S-F5> :w<CR>:!ipython %<CR>
        autocmd filetype python inoremap <buffer> <S-F5> <Esc>:w<CR>:!ipython %<CR>

        " Toggling True/False
        autocmd filetype python nnoremap <silent> <C-t> mmviw:s/True\\|False/\={'True':'False','False':'True'}[submatch(0)]/<CR>`m:nohlsearch<CR>

        " Run a quick static syntax check every time we save a Python file
        autocmd BufWritePost *.py call Flake8()

        " Defer to isort for sorting headers (instead of using Unix sort)
        autocmd filetype python nnoremap <leader>s :Isort<cr>
    augroup end " }}}

    augroup supervisord_files "{{{
        au!

        autocmd BufNewFile,BufRead supervisord.conf set ft=dosini
    augroup end " }}}

    augroup markdown_files "{{{
        au!

        autocmd filetype markdown noremap <buffer> <leader>p :w<CR>:!open -a Marked %<CR><CR>
    augroup end " }}}

    augroup ruby_files "{{{
        au!

    augroup end " }}}

    augroup rst_files "{{{
        au!

        " Auto-wrap text around 74 chars
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
    augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd filetype css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup javascript_files "{{{
        au!

        autocmd filetype javascript setlocal expandtab
        autocmd filetype javascript setlocal listchars=trail:·,extends:#,nbsp:·
        autocmd filetype javascript setlocal foldmethod=marker foldmarker={,}

        " Toggling True/False
        autocmd filetype javascript nnoremap <silent> <C-t> mmviw:s/true\\|false/\={'true':'false','false':'true'}[submatch(0)]/<CR>`m:nohlsearch<CR>
    augroup end "}}}

    augroup jquery "{{{
        au!
        au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
        au BufRead,BufNewFile *.user.js set ft=javascript syntax=jquery
    augroup end "}}}

    augroup textile_files "{{{
        au!

        autocmd filetype textile set tw=78 wrap

        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end "}}}
endif
" }}}
" gui/gvim {{{
if has("gui_running")
    " Black, Dark, desert, grb256, moria, ron, solarized, torte
    colorscheme solarized
    set mousehide                                   " Hide the mouse when typing text
    set mouse=v                                     " normal(n) + visual(v) + insert(i) + comman line(c)
                                                    " help(h) - all previous + help files
                                                    " a - all previous

    set guioptions+=mgtT                            " Uktywnia na 'twardo' elementy GUI: pasek menu i odrywanie menu
    "set noguipty                                   " Make external commands work through a pipe instead of a pseudo-tty
    "set columns=80 lines=30                        " don't inherit geometry from parent term
    "set mousemodel=popup                           " right mouse button pops up a menu in the GUI

    "  Some additional hot keys:
    "    S-F3  -  call gvim file browser,  nie działa
    noremap  <silent> <s-F3>       :silent browse confirm e<CR>
    inoremap  <silent> <s-F3>  <Esc>:silent browse confirm e<CR>

    " toggle insert mode  'normal mode with the <RightMouse>-key
    "nnoremap  <RightMouse> <Insert>
    "inoremap  <RightMouse> <ESC>

    if g:MSWIN
        set guifont=DejaVu_Sans_Mono:h10:cANSI
    elseif g:UNIX
        set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
    endif
endif
" }}}

" Switch from block-cursor to vertical-line-cursor when going into/out of
" insert mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" bundle/* {{{

" vim-toggle {{{
imap <C-T>:call Toggle()<CR>
nmap <C-T>:call Toggle()<CR>
vmap <C-T> <ESC>:call Toggle()<CR>
"}}}
" tagbar {{{
nmap <F7> :TagbarToggle<CR>
"}}}
" vim-airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
"}}}
" ctrlp {{{
set wildignore+=*.7z
" }}}
" syntastic {{{
let g:syntastic_enable_perl_checker = 1
"}}}
" perl-support {{{
" let g:Perl_TemplateOverwrittenMsg= 'no'
let g:Perl_PerlcriticSeverity = 5
let g:Perl_PerlcriticVerbosity = 9
" sprawdzanie składni pod
let g:Perl_PodcheckerWarnings = 'yes'
" }}}
" bash-support {{{
" let g:BASH_TemplateOverwrittenMsg = 'no'
" }}}
" vim-support {{{
let g:Vim_CreateMapsForHelp = 'yes'
"}}}
" c-support {{{
" let g:C_TemplateOverwrittenMsg= 'no'
" }}}
" jshint {{{
let jshint2_command = '/home/piecia/opt/npm/jshint'
"}}}
" manpageview {{{
let $PAGER=''
"}}}
" lattex-support {{{
let tlist_bib_settings   = 'bib;e:BibTeX-Entries;s:BibTeX-Strings'
let tlist_make_settings  = 'make;m:makros;t:targets'
let tlist_tex_settings   = 'latex;s:Contents;g:Graphics;i:Listings;l:\label;r:\ref;p:\pageref;b:\bibitem'
if g:UNIX
    let s:LATEX_pdf_viewer         = "evince"
endif
" }}}
" supertab {{{
" let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabDefaultCompletionType = "<c-p>"
let g:SuperTabMappingForward  = '<tab>'
" let g:SuperTabMappingBackward = '<s-tab>'
" }}}
" file_templates {{{
let g:file_template_default = "def/PKGBUILD"
let g:VIMFILESDIR = vimrc_dir
" }}}
" vbookmark {{{
let g:vbookmark_bookmarkSaveFile = $HOME . '/.vimbookmark'
" }}}
" vim-session {{{
let g:session_autosave = 'no'
" }}}
" TagList settings {{{
 noremap <silent> <F11>       :TlistToggle<CR>
inoremap <silent> <F11>  <C-C>:TlistToggle<CR>

let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD;k:comments'
" nnoremap <leader>l :TlistClose<CR>:TlistToggle<CR>
" nnoremap <leader>L :TlistClose<CR>

" quit Vim when the TagList window is the last open window
let Tlist_Exit_OnlyWindow=1         " quit when TagList is the last open window
let Tlist_GainFocus_On_ToggleOpen=1 " put focus on the TagList window when it opens
" let Tlist_Process_File_Always=1     " process files in the background, even when the TagList window isn't open
" let Tlist_Show_One_File=1           " only show tags from the current buffer, not all open buffers
let Tlist_WinWidth=40               " set the width
let Tlist_Inc_Winwidth=1            " increase window by 1 when growing

" shorten the time it takes to highlight the current tag (default is 4 secs)
" note that this setting influences Vim's behaviour when saving swap files,
" but we have already turned off swap files (earlier)
" set updatetime=1000

" the default ctags in /usr/bin on the Mac is GNU ctags, so change it to the
" exuberant ctags version in /usr/local/bin
" let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'

" show function/method prototypes in the list
let Tlist_Display_Prototype=1

" don't show scope info
let Tlist_Display_Tag_Scope=0

" show TagList window on the right
let Tlist_Use_Right_Window=1
" }}}
" xml_completion {{{
let g:xmlSubelements = "yes"
" }}}
" switch {{{
nnoremap <c-t> :Switch<cr>
let g:switch_custom_definitions =
    \ [
    \   ['Y', 'N'],
    \   ['yes', 'no'],
    \   ['1', '0'],
    \   ['on', 'off'],
    \   ['enable', 'disable']
    \ ]
" }}}
" restore_view, @see also save/restore for au {{{
set viewoptions=cursor,folds,slash,unix
" let g:skipview_files = ['*\vim']
" }}}
" mru {{{
let MRU_File = vimrc_dir . 'vim_mru_files'
" }}}
" undotree {{{
nnoremap <F5> :UndotreeToggle<cr>
"}}}
" yaifa {{{
let yaifa_max_lines = 512
"}}}
" silver search|ag {{{
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
" }}}
" NerdTree {{{
map <F2> :NERDTreeToggle<CR>
" }}}
" python-mode {{{
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
let g:pymode_rope = 1

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0
" }}}
" Extra user or machine specific settings {{{
if filereadable(vimrc_dir . "user.vim")
    execute ":source " . vimrc_dir . "user.vim"
endif
" }}}
