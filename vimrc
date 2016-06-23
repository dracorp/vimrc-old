"===============================================================================
" To start vim without using this .vimrc file, use:
"   vim -u NORC
"
" To start vim without loading any .vimrc or plugins, use:
"   vim -u NONE
"
" To test timing startup
"   vim --startuptime start.log
"===============================================================================

" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
set nocompatible

" Some globale settings for further using {{{
let g:MSWIN  = has("win16") || has("win32")   || has("win64")    || has("win95")
let g:UNIX   = has("unix")  || has("macunix") || has("win32unix")
let g:PYTHON = has('python') || has('python3')
"}}}
" OS Settings {{{
" Check OS and where are vim's config files
" $HOME - user's home directory
" $VIM  - vim's installation direcotry
if g:UNIX
    let  vimrc_dir = $HOME . '/.vim/'
elseif g:MSWIN
    " change '\' to '/' to avoid interpretation as escape character
    if match( substitute( expand("<sfile>"), '\', '/', 'g' ),
        \   substitute( expand("$HOME"),   '\', '/', 'g' ) ) == 0
        " configuration held in user's home directory
        let vimrc_dir = $HOME . '\vimfiles\'
    else
        " configuration held in vim's installation directory
        let vimrc_dir = $VIM . '\vimfiles\'
        set runtimepath-=~/vimfiles
    endif
endif
" }}}
" Remove ALL autocommands for the current group.
autocmd!

" Plugin manager(s)
let s:bundle_dir    = vimrc_dir . 'bundle'
" Manage plugins by vim-plug {{{
call plug#begin(s:bundle_dir)
" manage vim-plug by itself
Plug 'junegunn/vim-plug'
" common
"Plug 'Valloric/YouCompleteMe'                   " [A code-completion engine](https://github.com/Valloric/YouCompleteMe)
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " [A tree explorer plugin for vim](https://github.com/scrooloose/nerdtree)
Plug 'scrooloose/nerdtree-git-plugin', {'on': 'NERDTreeToggle'} " [A plugin of NERDTree showing git status](https://github.com/scrooloose/nerdtree-git-plugin)
Plug 'scrooloose/nerdcommenter'                 " [Vim plugin for intensely orgasmic commenting](https://github.com/scrooloose/nerdcommenter)
Plug 'airblade/vim-gitgutter'                   " [shows a git diff in the 'gutter' (sign column)](https://github.com/airblade/vim-gitgutter)
Plug 'ctrlpvim/ctrlp.vim'                       " [Fuzzy file, buffer, mru, tag, etc finder](https://github.com/kien/ctrlp.vim)
Plug 'easymotion/vim-easymotion'                " [Vim motions on speed!](https://github.com/easymotion/vim-easymotion)
Plug 'editorconfig/editorconfig-vim'            " [EditorConfig plugin](https://github.com/editorconfig/editorconfig-vim)
"Plug 'jiangmiao/auto-pairs'                     " [insert or delete brackets, parens, quotes in pair](https://github.com/jiangmiao/auto-pairs)
Plug 'vimwiki'                                  " [Personal Wiki for Vim](https://github.com/vim-scripts/vimwiki)
Plug 'gmarik/Vundle.vim'                        " [the plug-in manager](https://github.com/VundleVim/Vundle.vim)

"HTML
Plug 'gregsexton/MatchTag', { 'for': 'html'}
Plug 'mattn/emmet-vim', { 'for': 'html' }       " [provides support for expanding abbreviations similar to emmet](https://github.com/mattn/emmet-vim)
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'tpope/vim-haml', { 'for': 'haml'}

"CSS/LESS
Plug 'ap/vim-css-color', { 'for': ['css', 'scss', 'sass', 'less'] }
Plug 'cakebaker/scss-syntax.vim', { 'for': ['scss', 'sass'] }
Plug 'groenewege/vim-less', { 'for': 'less' }
Plug 'hail2u/vim-css3-syntax', { 'for': ['css', 'scss'] }
Plug 'vitalk/vim-lesscss', { 'for': 'less' }    " [Update corresponding css files on the fly while edit less files](https://github.com/vitalk/vim-lesscss)

"JavaScript
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'maksimr/vim-jsbeautify', { 'for': 'javascript' }
Plug 'wizicer/vim-jison', { 'for': 'jison' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'Shutnik/jshint2.vim'                    " [Lightweight, customizable and functional Vim plugin for JSHint integration](https://github.com/Shutnik/jshint2.vim)

"Perl
Plug 'vim-perl/vim-perl', { 'for': 'perl' }                     " [Support for Perl 5 and Perl 6 in Vim](https://github.com/vim-perl/vim-perl)
Plug 'perl_h2xs', { 'for': 'perl' }                             " [Automate creating perl modules via h2xs](https://github.com/vim-scripts/perl_h2xs)

" Vim
Plug 'tpope/vim-flagship'                       " [Configurable and extensible tab line and status line](https://github.com/tpope/vim-flagship)
Plug  'mhinz/vim-startify'

" Themes and syntax
Plug 'altercation/vim-colors-solarized'       " [precision colorscheme for the vim text editor](https://github.com/altercation/vim-colors-solarized)
Plug 'nginx.vim'                              " [highlights configuration files for nginx, the high-performance web server](https://github.com/vim-scripts/nginx.vim)
Plug 'primary.vim'                            " [Inspired by Google's official colors](https://github.com/vim-scripts/primary.vim)
Plug 'jiangxincode/mpi.vim'                   " [A Vim Plugin for MPI Syntax highlight, matching rules and mappings](https://github.com/jiangxincode/mpi.vim)
Plug 'putty'                                  " [A color scheme that resembles one of Putty](https://github.com/vim-scripts/putty)
Plug 'httplog'                                " [Highlight access log of Apache, nginx, etc](https://github.com/vim-scripts/httplog)
Plug 'LogViewer'                              " [Comfortable examination of multiple parallel logfiles](https://github.com/vim-scripts/LogViewer)
Plug 'jQuery'                                 " [Syntax file for jQuery](https://github.com/vim-scripts/jQuery)
Plug 'TWiki-Syntax'                           " [Syntaxfile for TWiki-Syntax](https://github.com/vim-scripts/TWiki-Syntax)
Plug 'whitespace-syntax-highlight'            " [whitespace syntax highlight](https://github.com/vim-scripts/whitespace-syntax-highlight/)
Plug 'yowish'                                 " [A yellowish dark color scheme](https://github.com/vim-scripts/yowish)
Plug 'flazz/vim-colorschemes'                   " [this is harvested from vim.org. only colorschemes downloaded in a single .vim](https://github.com/flazz/vim-colorschemes)
Plug 'morhetz/gruvbox'                          " [Retro groove color scheme for Vim](https://github.com/morhetz/gruvbox)
Plug 'ryanoasis/vim-devicons'                   " [adds font icons (glyphs ★♨☢)(https://github.com/ryanoasis/vim-devicons)

" Markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }                " [Markdown Vim Mode](https://github.com/plasticboy/vim-markdown/)
"Plug 'markdown-preview.vim', { 'for': 'markdown' }                  " [Markdown Preview - brokes vim](https://github.com/vim-scripts/markdown-preview.vim)

"Go lang
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'nsf/gocode',  { 'for': 'go' }

Plug 'Shougo/vimproc.vim'                     " [great asynchronous execution library](https://github.com/Shougo/vimproc.vim)

" Charles Campbell
Plug 'AnsiEsc.vim'                            " [ansi escape sequences concealed, but highlighted as specified (conceal)](https://github.com/vim-scripts/AnsiEsc.vim)
Plug 'powerman/vim-plugin-AnsiEsc'            " [ansi escape sequences concealed, but highlighted as specified (conceal)](https://github.com/powerman/vim-plugin-AnsiEsc)
Plug 'DrawIt'                                 " [Ascii drawing plugin: lines, ellipses, arrows, fills, and more!](https://github.com/vim-scripts/DrawIt)
Plug 'emezeske/manpageview'                   " [man page view for vim](https://github.com/emezeske/manpageview)
Plug 'Decho'                                  " [internal debugger](https://github.com/vim-scripts/decho)
Plug 'gdbmgr'                                 " [interface to gdb](https://github.com/vim-scripts/gdbmgr)
Plug 'HiColors'                               " [Colorscheme display and editor](https://github.com/vim-scripts/hicolors)
Plug 'highlight.vim'                          " [Highlight lines or patterns of interest in different colors](https://github.com/vim-scripts/highlight.vim)
Plug 'LargeFile'                              " [Edit large files quickly (keywords: large huge speed)](https://github.com/vim-scripts/largefile)
Plug 'SudoEdit.vim'                           " [Edit Files using sudo or su or any other tool](https://github.com/vim-scripts/SudoEdit.vim)
Plug 'vis'                                    " [Extended Visual Mode Commands, Substitutes, and Searches](https://github.com/vim-scripts/vis)
Plug 'cecutil'                                " [save/restore window position, mark position, selected user mapssave/restore window position, mark position, selected user maps](https://github.com/vim-scripts/cecutil)

" xolox
"Plug 'xolox/vim-notes'                        " [Easy note taking in Vim](https://github.com/xolox/vim-notes)
Plug 'xolox/vim-shell'                        " [Improved integration between Vim and its environment](https://github.com/xolox/vim-shell)
Plug 'xolox/vim-misc'                         " [Miscellaneous auto-load Vim scripts](https://github.com/xolox/vim-misc)
Plug 'xolox/vim-reload'                       " [Automatic reloading of Vim scripts](https://github.com/xolox/vim-reload)
Plug 'xolox/vim-session'                      " [Extended session management for Vim](https://github.com/xolox/vim-session)
Plug 'xolox/vim-colorscheme-switcher'         " [Color scheme switcher for Vim](https://github.com/xolox/vim-colorschemes-switch)
"if g:PYTHON
"    Plug 'xolox/vim-tools'                      " [Python scripts to publish Vim plug-ins](https://github.com/xolox/vim-tools)
"endif
if g:MSWIN
    Plug 'xolox/vim-easytags'
        \| Plug 'xolox/vim-shell'
elseif g:UNIX
    Plug 'xolox/vim-easytags'                   " [Automated tag generation and syntax highlighting in Vim](https://github.com/xolox/vim-easytags)
endif

" Python
if g:PYTHON
    Plug 'davidhalter/jedi-vim'               " [Using the jedi autocompletion library for VIM](https://github.com/davidhalter/jedi-vim)
    Plug 'betterga'                           " [betterga can get more information than ga (:ascii)](https://github.com/vim-scripts/betterga)
endif
Plug 'klen/python-mode', { 'for': 'python' }    " [Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box](https://github.com/klen/python-mode)
Plug 'python_fold', { 'for': 'python' }         " [Folding expression for python](https://github.com/vim-scripts/Python_fold)

" Fritz Mehner
Plug 'Vim-support', { 'for': 'vim' }                            " [Vim Script IDE for Vim/gVim](https://github.com/vim-scripts/Vim-Support)
Plug 'awk-support.vim', { 'for': 'awk' }                        " [AWK-IDE for Vim/gVim](https://github.com/vim-scripts/awk-support.vim)
Plug 'bash-support.vim', { 'for': 'sh' }                       " [BASH IDE -- Write and run BASH-scripts using menus and hotkeys](https://github.com/vim-scripts/bash-support.vim)
Plug 'perl-support.vim', { 'for': 'perl' }                       " [Write and run Perl-scripts using menus and hotkeys](https://github.com/vim-scripts/perl-support.vim)
Plug 'c.vim', { 'for': 'c' }                                  " [C/C++ IDE -- Write and run programs. Insert statements, idioms, comments etc](https://github.com/vim-scripts/c.vim)
Plug 'latex-support.vim', { 'for': 'latex' }                     " [LaTeX-IDE for Vim/gVim](https://github.com/vim-scripts/latex-support.vim)
Plug 'doxygen-support.vim', { 'for': 'doxygen' }                   " [Generate Doxygen comments from user defined templates](https://github.com/vim-scripts/doxygen-support.vim)

" git and other vcs
Plug 'int3/vim-extradite'
Plug 'tpope/vim-fugitive'                     " [Git wrapper of all time](https://github.com/tpope/vim-fugitive)
Plug 'WolfgangMehner/git-support'             " [Git for Vim/gVim](https://github.com/WolfgangMehner/git-support)
"Plug 'mhinz/vim-signify'                      " [show differences with style](https://github.com/mhinz/vim-signify)
Plug 'sjl/splice.vim'                         " [managing three-way merges](https://github.com/sjl/splice.vim)
"Plug 'vcscommand.vim'                        " [CVS/SVN/SVK/git/hg/bzr integration plugin - mapping conflict](https://github.com/vim-scripts/vcscommand.vim)
Plug 'git-flow-format'                        " [formats a Git Flow branch name in order to shorten the prefixes, some errors due saving a file](https://github.com/vim-scripts/git-flow-format)
Plug 'gitv'                                   " [gitk for Vim](https://github.com/vim-scripts/gitv)
Plug 'idanarye/vim-merginal'                  " [Fugitive extension to manage and merge Git branches](https://github.com/idanarye/vim-merginal)
Plug 'vim-gitignore'                          " [Another gitignore plugin for Vim](https://github.com/vim-scripts/vim-gitignore)

" for dev
Plug 'OmniCppComplete', { 'for': 'cpp' }        " [C/C++ omni-completion with ctags database](https://github.com/vim-scripts/OmniCppComplete)
Plug 'jiangxincode/TagCollection'               " [Some tags used by the OmniCppComplete which can auto complete your code](https://github.com/jiangxincode/TagCollection)
"Plug 'AutoFold.vim'                            " [A script to automate folding based on markers and syntax](https://github.com/vim-scripts/AutoFold.vim)
Plug 'vim-javacomplete2', { 'for': 'java' }     " [Refreshed javacomplete plugin for vim](https://github.com/vim-scripts/vim-javacomplete2)
Plug 'Vim-R-plugin', { 'for': 'R' }             " [Plugin to work with R](https://github.com/vim-scripts/Vim-R-plugin)
Plug 'nathanaelkane/vim-indent-guides'          " [displaying indent levels in code](https://github.com/nathanaelkane/vim-indent-guides)
Plug 'supersearch'                              " [plugin is a source code browser plugin](https://github.com/vim-scripts/supersearch)
Plug 'Dokumentary'                              " [Improve what K does](https://github.com/vim-scripts/Dokumentary)
Plug 'cpp_cppcheck.vim', { 'for': 'cpp' }       " [Run Cppcheck on the current window](https://github.com/vim-scripts/cpp_cppcheck.vim)
Plug 'joonty/vdebug'                            " [Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)(https://github.com/joonty/vdebug)
Plug 'terryma/vim-expand-region'                " [Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination](https://github.com/terryma/vim-expand-region)
"Plug 'Yggdroot/hiPairs'                        " [Highlights the pair surrounding the current cursor position - slows gvim for complex files](https://github.com/Yggdroot/hiPairs)
Plug 'nvie/vim-flake8', { 'for': 'python' }     " [Flake8 plugin for Vim](https://github.com/nvie/vim-flake8)
Plug 'xml.vim', { 'for': 'xml' }                " [helps editing xml (and [x]html, sgml, xslt) files](https://github.com/vim-scripts/xml.vim)
Plug 'xmledit', { 'for': 'xml' }                " [A filetype plugin to help edit XML, HTML, and SGML documents](https://github.com/vim-scripts/xmledit)
Plug 'xslt', { 'for': 'xslt' }                  " [XSLT ftplugin](https://github.com/vim-scripts/xslt)
"Plug 'openroad.vim'                             " [Goodies for OpenROAD users](https://github.com/vim-scripts/openroad.vim)

" Others
Plug 'mru.vim'                                " [manage Most Recently Used (MRU) files](https://github.com/vim-scripts/mru.vim)
Plug 'ggreer/the_silver_searcher'             " [A code-searching tool similar to ack, but faster](https://github.com/ggreer/the_silver_searcher)
Plug 'ctrlsf.vim'                             " [an ack/ag powered global code search and view tool](https://github.com/vim-scripts/ctrlsf.vim)
Plug 'matchit.zip'                            " [extended % matching for HTML, LaTeX, and many other languages](https://github.com/vim-scripts/matchit.zip)
Plug 'EnhancedDiff'                           " [A Vim plugin for creating better diffs](https://github.com/vim-scripts/EnhancedDiff)
Plug 'rking/ag.vim'                           " [Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'](https://github.com/rking/ag.vim)
Plug 'closetag.vim'                           " [Functions and mappings to close open HTML/XML tags](https://github.com/vim-scripts/closetag.vim)
Plug 'netrw.vim'                              " [Network oriented reading, writing, and browsing (keywords: netrw ftp scp)(https://github.com/vim-scripts/netrw.vim)
Plug 'tyru/open-browser.vim'                  " [Open URI with your favorite browser from your most favorite editor](https://github.com/tyru/open-browser.vim)
Plug 'jlemetay/permut'                        " [swap columns of text separated by arbitrary characters](https://github.com/jlemetay/permut)
Plug 'junegunn/vim-easy-align'                " [A Vim alignment plugin](https://github.com/junegunn/vim-easy-align)
Plug 'godlygeek/tabular'                      " [Vim script for text filtering and alignment](https://github.com/godlygeek/tabular)
Plug 'edkolev/promptline.vim'                 " [Generate a fast shell prompt with powerline symbols and airline colors](https://github.com/edkolev/promptline.vim)
Plug 'restore_view.vim'                       " [automatically restoring file's cursor position and folding](https://github.com/vim-scripts/restore_view.vim)
Plug 'SuperTab'                               " [Do all your insert-mode completion with Tab!](https://github.com/vim-scripts/supertab)
Plug 'AndrewRadev/switch.vim'                 " [switch segments of text with predefined replacements](https://github.com/AndrewRadev/switch.vim/)
Plug 'scrooloose/syntastic'                   " [Syntax checking hacks for vim](https://github.com/scrooloose/syntastic)
Plug 'majutsushi/tagbar'                      " [Vim plugin that displays tags in a window, ordered by scope](https://github.com/majutsushi/tagbar)
Plug 'Tabmerge'                               " [Merge a tab's windows with the current tab](https://github.com/vim-scripts/Tabmerge)
Plug 'taglist.vim'                            " [Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)](https://github.com/vim-scripts/taglist.vim)
Plug 'Toggle'                                 " [allows you to toggle bool (true/false) and other words with a shortcut](https://github.com/vim-scripts/Toggle)
"Plug 'SirVer/ultisnips'                       " [The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!](https://github.com/SirVer/ultisnips)
"Plug 'honza/vim-snippets'                     " [snippets files for various programming languages](https://github.com/honza/vim-snippets)
Plug 'mbbill/undotree'                        " [The ultimate undo history visualizer for VIM](https://github.com/mbbill/undotree)
Plug 'Shougo/unite.vim'                       " [Unite and create user interfaces](https://github.com/Shougo/unite.vim)
Plug 'vim-airline/vim-airline-themes' | Plug 'vim-airline/vim-airline'
" [Lean & mean status/tabline for vim that's light as air](https://github.com/vim-airline/vim-airline)
" [the official theme repository](https://github.com/vim-airline/vim-airline-themes)
Plug 'vim-nfo'                                " [ftplugin for .nfo files](https://github.com/vim-scripts/vim-nfo)
Plug 'kurkale6ka/vim-pairs'                   " [Punctuation text objects: ci/ da; vi@ yiq da<space> ...](https://github.com/kurkale6ka/vim-pairs)
Plug 'tpope/vim-repeat'                       " [repeat.vim: enable repeating supported plugin maps with "."](https://github.com/tpope/vim-repeat)
Plug 'tpope/vim-scriptease'                   " [A Vim plugin for Vim plugins](https://github.com/tpope/vim-scriptease)
Plug 'tpope/vim-speeddating'                  " [use CTRL-A/CTRL-X to increment dates, times, and more](https://github.com/tpope/vim-speeddating)
Plug 'tpope/vim-surround'                       " [quoting/parenthesizing made simple](https://github.com/tpope/vim-surround)
Plug 'tpope/vim-unimpaired'                   " [pairs of handy bracket mappings](https://github.com/tpope/vim-unimpaired)
"Plug 'MRU'                                   " [Most recently used files in your file menu](https://github.com/vim-scripts/mru)
"Plug 'airblade/vim-rooter'                   " [Changes Vim working directory to project root (identified by presence of known directory or file)](https://github.com/airblade/vim-rooter) conflict with map
Plug 'togglenumber'                             " [easy toggle between different numbering modes](https://github.com/vim-scripts/togglenumber)
Plug 'ap/vim-buftabline'                        " [Forget Vim tabs – now you can have buffer tabs](https://github.com/ap/vim-buftabline)
Plug 'tskeleton' | Plug 'tlib'                  " [File Templates and Code Skeletons/Snippets](http://vim.sourceforge.net/scripts/script.php?script_id=1160)
                                                " [Some utility functions](http://vim.sourceforge.net/scripts/script.php?script_id=1863)

if g:UNIX | Plug 'dracorp/vim-pkgbuild' | endif
" Windows
if g:MSWIN
    Plug 'maximize.dll'
    Plug 'poshcomplete-vim'                       " [Omni Completion for PowerShell](https://github.com/vim-scripts/poshcomplete-vim)
    Plug 'Windows-PowerShell-Syntax-Plugin'       " [Default syntax coloring for Windows PowerShell](https://github.com/vim-scripts/Windows-PowerShell-Syntax-File)
    Plug 'Windows-PowerShell-Indent-File'         " [Simple indenting rules for Windows PowerShell](https://github.com/vim-scripts/Windows-PowerShell-Indent-File
"    Plug 'mattn/webapi-vim'                      " [vim interface to Web API](https://github.com/mattn/webapi-vim)
endif

" The last
Plug 'ryanoasis/vim-devicons'                   " [adds font icons](https://github.com/ryanoasis/vim-devicons)

call plug#end()
delc PlugUpgrade
"}}}

" Settings for Vundle/bundle {{{
filetype off                                    " required
let s:vundle_home   = vimrc_dir . 'bundle/Vundle.vim'
" set the runtime path to include Vundle and initialize
let &rtp .= ',' . s:vundle_home
call vundle#begin(s:bundle_dir)
" installed manualy or by script bin/add-vba-bundle.sh
" }}}

" Manage plugin by Vundle {{{
Plugin 'file_templates', {'pinned': 1}          "[A file templates](https://sites.google.com/site/abudden/contents/Vim-Scripts/file-templates)
Plugin 'astronaut', {'pinned': 1}               " [This colorscheme is a dark-background style](http://www.drchip.org/astronaut/vim/index.html#ASTRONAUT)
Plugin 'StlShowFunc', {'pinned': 1}             " [shows current function name in status line](http://www.drchip.org/astronaut/vim/index.html#STLSHOWFUNC)
Plugin 'Ingres-vim-syntax', {'pinned':1}        " [Ingres syntax](http://community.actian.com/wiki/Vim_syntax)
call vundle#end()
filetype plugin indent on                       " required
"}}}

" Common abbreviations/misspellings, spell {{{
if filereadable(vimrc_dir . "autocorrect.vim")
    execute ":source" vimrc_dir . "autocorrect.vim"
endif
set spelllang=pl,en
" }}}

" Editing behaviour {{{
behave xterm                                    " Set behavior for mouse and selection, affect on selectmode mousemodel keymodel selection
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
set nonumber                                    " show line numbers
set showmatch                                   " set show matching parenthesis
set ignorecase                                  " ignore case when searching
set smartcase                                   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab                                    " insert tabs on the start of a line according to shiftwidth, not tabstop
set scrolloff=4                                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=                                " allow the cursor to go in to 'invalid' places
set incsearch                                   " show search matches as you type
"set gdefault                                    " search/replace 'globally' (on a line) by default

" display end of lines, TAB, spaces on the end of line, before and after wrap row
" eol, tab, trail, extends, precedes, strings to use in 'list' mode
set listchars=tab:>-,eol:$,trail:-,nbsp:%
set nolist                                      " don't show invisible characters by default, but it is enabled for some file types (see later)

" autoformat: call using gq, see also |fo-table|
set formatoptions+=1                            " long lines are not broken in insert mode
set formatoptions+=t                            " autowrap text using textwidth
set formatoptions-=c                            " autowrap comments using textwidth

set nrformats=                                  " make <C-a> and <C-x> play well with zero-padded numbers (i.e. don't consider them octal or hex)
set shortmess+=I                                " hide the launch screen
set clipboard=unnamed                           " normal OS clipboard interaction
set mouse=a                                     " enable using the mouse if terminal emulator supports it (xterm does)
" }}}

" Various settings {{{
set linebreak
set smartindent                                 " smart autoindenting when starting a new line
set wrapscan                                    " searches wrap around the end of file
set autoread                                    " read open files again when changed outside Vim
set autowrite                                   " write a modified buffer on each :next , ...
" backspace, space, <left>, <right>
set whichwrap=b,s,<,>,[,],h,l                   " which keys move the cursor to previous/next line when the cursor is on the first/last character
set browsedir=current                           " which directory to use for the file browser
set complete+=k                                 " scan the files given with the 'dictionary' option
set mousehide                                   " Hide the mouse when typing text

" export: print or to html
set printoptions=left:8pc,right:3pc             " print options
let g:html_use_css = "1"
let g:use_xhtml = 1000

set ruler                                       " show the cursor position all the time
set display+=lastline                           " show last line even it does not fit
set scrolloff=3                                 " keep distance when scroll a file
set textwidth=0                                 " maximum width of text that is being inserted
set showbreak=+\                                " show wraped lines as

set modeline                                    " search for additional vim commands in n-th first lines(see modelines)
"set ttyfast                                     " always use a fast terminal
"set nocursorline                                " underline the current line, for quick orientation

set splitbelow                                  " command :sp put a new window below the active
set splitright                                  " command :vs put a new windows on right side of active
set infercase
set tildeop                                     " Tylde(~) behaves like operator
"set iskeyword+=-,,                              " which char make a word
" }}}

" Folding rules {{{
set foldenable                  " enable folding
set foldcolumn=0                " add a fold column
set foldmethod=marker           " detect triple-{ style fold markers
set foldmarker={{{,}}}
set foldlevelstart=99           " start out with everything unfolded
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo
                                " which commands trigger auto-unfold
" Mappings to easily toggle fold levels
nnoremap z0 :set foldlevel=0<cr>
nnoremap z1 :set foldlevel=1<cr>
nnoremap z2 :set foldlevel=2<cr>
nnoremap z3 :set foldlevel=3<cr>
nnoremap z4 :set foldlevel=4<cr>
nnoremap z5 :set foldlevel=5<cr>
" }}}

" Editor layout {{{
" default file format for all OS
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats

scriptencoding utf-8
set fileencoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set encoding=utf-8

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
" 'termencoding' jest zestawem znakow dla klawiatury, oraz (tylko w konsolowym Vimie) dla ekranu.
" 'printencoding' jest zestawem znakow dla drukarki, jesli oba +printer i +postscript sa wkompilowane.
" Konwersja przebiega nastepujaco, jesli zestawy znakow roznia sie a metoda konwersji jest znana:
"    * 'fileencoding' na 'encoding' podczas czytania z dysku
"    * 'termencoding' na 'encoding' podczas wpisywania z klawiatury
"    * (tylko w konsolowym Vimie): 'encoding' na 'termencoding' podczas wyswietlania
"    * 'encoding' na 'printencoding' podczas drukowania przez PostScript
"    * 'encoding' na 'fileencoding' podczas zapisu na dysk
" Uzycie ":w ++enc=XXX" nie zmienia zachowania domyslnego (ang. ulterior?) zapisu.
" Uzycie 'fileencoding' (ktore lepiej zmieniac przez ":setlocal" niz ":set") zmienia zachowanie zapisu.
" fileencodings rozni sie od fileencoding tym, ze ustawia domyslny zapis dla wszystkich plikow.
" }}}

" Vim behaviour {{{
set hidden                                      " hide buffers instead of closing them this
                                " means that the current buffer can be put
                                " to background without being written; and
                                " that marks and undo history are preserved
set switchbuf=useopen                           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set history=1000                                " remember more commands and search history

set undolevels=1000                             " use many muchos levels of undo
if has('persistent_undo')
    set undoreload=10000                        " maximum number lines to save for undo on a buffer reload
    set undofile                                " keep a persistent backup file
    let &undodir=vimrc_dir . '.undodir'
endif
let &backupdir=vimrc_dir . '.backupdir,~/tmp,/tmp'

set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
set directory=.,~/tmp
                                " store swap files in one of these directories
                                "    (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                " than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=longest,list       " show a list when pressing tab and complete
set wildignore=*.bak,*.o,*.e,*~,*.swp,*.bak,*.pyc,*.class
set title                       " change the terminal's title
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                " this also shows visual selection info
" }}}

" Highlight, Colorscheme, syntax{{{
"highlight ExtraWhitespace ctermbg=red guibg=red
"autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
"match ExtraWhitespace /\s\+\%#\@<!$/

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

let c_comment_strings=1                         " highlight strings inside C comments

" Black, Dark, desert, grb256, moria, ron, solarized, torte
"if has('gui_running')
"    colorscheme solarized
"else
"    colorscheme redstring
"endif
set background=dark
colorscheme gruvbox

if &diff
    colorscheme xterm16
"    set diffopt+=iwhite
endif

" Large file when syntax on
syntax sync minlines=30
syntax sync maxlines=40
set synmaxcol=500
" }}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")
    augroup change_dir "{{{
        au!
        " Automatyczna zmiana katalogu do tego, w ktorym jest aktualnie edytowany plik.
        " Przydatne gdy chcemy otworzyc inny z tego samego katalogu
        " http://vim.sourceforge.net/tip_view.php?tip_id=101
        " mozna tez uzyc set acd, ale ta opcja nie dziala z pewnymi wtyczkami, zobacz :he acd
"        autocmd BufEnter * :cd %:p:h

        " The current directory is the directory of the file in the current window.
        autocmd BufEnter * :lchdir %:p:h
    augroup end "}}}

    augroup jump_last_position "{{{
        au!
        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    augroup end "}}}

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
"            setlocal foldmethod=syntax
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

" {{{ gui/gvim
if has("gui_running")
    set mousehide                                   " Hide the mouse when typing text
    set mouse=a                                     " normal(n) + visual(v) + insert(i) + comman line(c)
                                                    " help(h) - all previous when editing help files
                                                    " a - all previous

    set guioptions+=mgt
    set guioptions-=T
    " m - menu
    " T - toolbar
    " t - tear menu
    " e - tabs
    " g - grey inactive menu's items

    "set noguipty                                   " Make external commands work through a pipe instead of a pseudo-tty
    "set columns=80 lines=30                        " don't inherit geometry from parent term
    "set mousemodel=popup                           " right mouse button pops up a menu in the GUI

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

" {{{ Functions
" exclamation mark(!) means that function replace previous
let g:quickfix_is_open = 0
function! s:QuickfixToggle() "{{{
    " Toggle the quickfix window
    " From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
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
let g:last_fold_column_width = 4  " Pick a sane default for the foldcolumn
function! FoldColumnToggle() "{{{
    " Toggle the foldcolumn
    " From Steve Losh, http://learnvimscriptthehardway.stevelosh.com/chapters/38.html
    if &foldcolumn
        let g:last_fold_column_width = &foldcolumn
        setlocal foldcolumn=0
    else
        let &l:foldcolumn = g:last_fold_column_width
    endif
endfunction
" }}}
function! QuoteInsertionWrapper (quote) "{{{
" Add a second quote only if the left and the right character are not keyword
" characters.
    let col = col('.')
    if getline('.')[col-2] !~ '\k' && getline('.')[col] !~ '\k'
        normal ax
        exe "normal r".a:quote."h"
    end
endfunction " }}}
function! s:Tag() "{{{
" Tworzenie pliku znacznikow
   try
      exe "norm! \<c-]>"
   catch /^Vim([^)]\+):E433/
      call inputsave()
      let l:kat = input("Katalog glowny projektu:   ", ".")
      let l:opt = input("Opcje dla ctags:   ", "-R --fields=+S")
      call inputrestore()
      exe "!cd " . l:kat . " ; ctags " . l:opt . " ."
      exe "norm! \<c-]>"
   endtry
endfun "}}}
function! ToggleHLSearch() "{{{
" On/Off highlight search
      if &hls
           set nohls
      else
           set hls
      endif
endfunction
"}}}
function! CheckReadonly() "{{{
" Nie pozwalaj na zadne modyfikacje plikow tylko do odczytu.
    if version >= 600
        if &readonly
            setlocal nomodifiable
        endif
    endif
endfunction
"}}}
function! ChangeFileencoding() "{{{
    let encodings = ['cp1250', 'utf-8', 'iso8859-2', 'iso8859-1', 'iso8859-15']
    let prompt_encs = []
    let index = 0
    while index < len(encodings)
       call add(prompt_encs, index.'. '.encodings[index])
       let index = index + 1
    endwhile
    let choice = inputlist(prompt_encs)
    if choice >= 0 && choice < len(encodings)
        execute 'e ++enc='.encodings[choice].' %:p'
    endif
endf
"}}}
function! DisplayManpage() "{{{
" Display man page for the file
    let filename = expand("%")
    let short_filename = expand("%:r")
    let filetype = &filetype
    call manpageview#ManPageView(0,0,filename)
    if v:errmsg == "no manpage exists"
        call manpageview#ManPageView(0,0,short_filename)
        if v:errmsg == "no manpage exists"
            call manpageview#ManPageView(0,0,filetype)
        endif
    endif
endf
"}}}
function! CopyAll() "{{{
    " zaznacz wszystko
    exec 'normal ggVG'
    " kopiuj wszystko
    exec 'normal "+y'
endf
"}}}
function! PulseCursorLine() "{{{
    let current_window = winnr()

    windo set nocursorline
    execute current_window . 'wincmd w'

    setlocal cursorline

    redir => old_hi
        silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 20m

    hi CursorLine guibg=#4a4a4a
    redraw
    sleep 30m

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 30m

    hi CursorLine guibg=#2a2a2a
    redraw
    sleep 20m

    execute 'hi ' . old_hi

    windo set cursorline
    execute current_window . 'wincmd w'
endfunction
" }}}
function! MyFoldText_wikia() "{{{
  let line = getline(v:foldstart)
  if match( line, '^[ \t]*\(\/\*\|\/\/\)[*/\\]*[ \t]*$' ) == 0
    let initial = substitute( line, '^\([ \t]\)*\(\/\*\|\/\/\)\(.*\)', '\1\2', '' )
    let linenum = v:foldstart + 1
    while linenum < v:foldend
      let line = getline( linenum )
      let comment_content = substitute( line, '^\([ \t\/\*]*\)\(.*\)$', '\2', 'g' )
      if comment_content != ''
        break
      endif
      let linenum = linenum + 1
    endwhile
    let sub = initial . ' ' . comment_content
  else
    let sub = line
    let startbrace = substitute( line, '^.*{[ \t]*$', '{', 'g')
    if startbrace == '{'
      let line = getline(v:foldend)
      let endbrace = substitute( line, '^[ \t]*}\(.*\)$', '}', 'g')
      if endbrace == '}'
        let sub = sub.substitute( line, '^[ \t]*}\(.*\)$', '...}\1', 'g')
      endif
    endif
  endif
  let n = v:foldend - v:foldstart + 1
  let info = " " . n . " lines"
  let sub = sub . "                                                                                                                  "
  let num_w = getwinvar( 0, '&number' ) * getwinvar( 0, '&numberwidth' )
  let fold_w = getwinvar( 0, '&foldcolumn' )
  let sub = strpart( sub, 0, winwidth(0) - strlen( info ) - num_w - fold_w - 1 )
  return sub . info
endfunction
set foldtext=MyFoldText_wikia()
"}}}
if filereadable(vimrc_dir . "functions.vim")
    execute ":source" vimrc_dir . "functions.vim"
endif
" }}}

" {{{ Commands for functions
" }}}

" {{{ Mapping for functions
nnoremap <leader>f :call FoldColumnToggle()<cr>
nnoremap <C-q> :call <SID>QuickfixToggle()<cr>
"inoremap   '  '<Esc>:call QuoteInsertionWrapper("'")<CR>a
"inoremap   "  "<Esc>:call QuoteInsertionWrapper('"')<CR>a
"inoremap   `  `<Esc>:call QuoteInsertionWrapper('`')<CR>a
"nnoremap <C-]> :call <SID>Tag()<CR>\|:echo ""<CR>
"przelaczanie podswietlania wynikow szukania ctrl+n
"noremap <silent> <C-n> <Esc>:call ToggleHLSearch()<CR>
"noremap  <silent> <F8>         :call ChangeFileencoding()<CR>
noremap     <silent>    <F1>    :call DisplayManpage()<CR>

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
"nnoremap n n:call PulseCursorLine()<cr>
"nnoremap N N:call PulseCursorLine()<cr>
" }}}

" {{{ Commands
command! -nargs=0 Trim :%s/\s\+$//
" }}}

" {{{ Mappings
" !         make a switch from a key
" <CR>      it's enter
" <c-o>     allows in 'insert' mode insert a command
" <silent>  a mapping will not be echoed on the command line
" %         actual file, :he expand
" <leader>  default \
"-------------------------------------------------------------------------------
" change search mapping and don't jump
nnoremap * g#``
nnoremap # g*``
nnoremap g* #``
nnoremap g# *``
" refresh syntax highlight
noremap <F10> <Esc>:syntax sync fromstart<CR>
inoremap <F10> <C-o>:syntax sync fromstart<CR>
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
" paste mode, where you can paste mass data
" that won't be autoindented
set pastetoggle=<S-F6>
" open file under cursors in a new window (a vertical split)
map <c-w>F :vertical wincmd f<CR>

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" highlight line under cursor, horizontal cursor
nnoremap <Leader>l :setlocal cursorline!<CR>

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" C-U in insert/normal mode, to uppercase the word under cursor
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe

" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, as I don't have to press the Shift key to form chords to
" enter ex mode.
nnoremap ; :
nnoremap <leader>; ;

" Avoid accidental hits of <F1> while aiming for <Esc>
noremap! <F1> <Esc>

" Quickly close the current window
nnoremap <leader>q :q<CR>

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

" Sort paragraphs
vnoremap <leader>s !sort -f<CR>gv
nnoremap <leader>s vip!sort -f<CR><Esc>

map zp :setlocal spell!<CR>
imap zP <ESC>:setlocal spell!<CR>i<right>

"noremap     <silent>    <F8>    :cnext<CR>
noremap     <silent>    <F9>    :set nonumber!<CR>
"noremap                 <F12>   :ls<CR>:edit #
"noremap <silent> <F12> :cal VimCommanderToggle()<CR>
"
"inoremap  <silent> <F2>    <C-C>:write<CR>
"inoremap    <silent>    <F3>    <C-C>:Explore<CR>
inoremap    <silent>    <F4>    <C-C>:execute ":ptag ".expand("<cword>")<CR>
"inoremap    <silent>    <F5>    <C-C>:copen<CR>
"inoremap    <silent>    <F6>    <C-C>:cclose<CR>
"inoremap    <silent>    <F7>    <C-C>:cprevious<CR>
"inoremap    <silent>    <F8>    <C-C>:cnext<CR>
inoremap    <silent>    <F9>    <C-O>:set nonumber!<CR>
"inoremap                <F12>   <C-C>:ls<CR>:edit #

" wklejanie
vnoremap <C-Insert> "+y

" search for visually highlighted text
"vmap // y/<C-R>"<CR>
"with spec chars
vmap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>

" autocomplete parenthesis, (brackets) and braces
"inoremap  (  ()<Left>
"inoremap  [  []<Left>
"inoremap  {  {}<Left>
"
"vnoremap  (  s()<Esc>P<Right>%
"vnoremap  [  s[]<Esc>P<Right>%
"vnoremap  {  s{}<Esc>P<Right>%
"
" surround content with additional spaces
"
"vnoremap  )  s(  )<Esc><Left>P<Right><Right>%
"vnoremap  ]  s[  ]<Esc><Left>P<Right><Right>%
"vnoremap  }  s{  }<Esc><Left>P<Right><Right>%

" autocomplete quotes (visual and select mode)
"xnoremap  '  s''<Esc>P<Right>
"xnoremap  "  s""<Esc>P<Right>
"xnoremap  `  s``<Esc>P<Right>

"-------------------------------------------------------------------------------
" Moving cursor to other windows:
" shift down   : change window focus to lower one (cyclic)
" shift up     : change window focus to upper one (cyclic)
" shift left   : change window focus to one on left
" shift right  : change window focus to one on right
"-------------------------------------------------------------------------------
nnoremap <s-down>   <c-w>w
nnoremap <s-up>     <c-w>W
nnoremap <s-left>   <c-w>h
nnoremap <s-right>  <c-w>l

"backspace in VisualMode deletes selection
"vnoremap <BS> d

" Navigate on a wrapped line as the normal
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Up> <C-o>gk
inoremap <Up> <C-o>gk

"obsluga zakladek w vimie, CTRL-I robi to co TAB, domyslnie CTRL-I skacze do przodu
nnoremap <c-TAB> :tabnext<cr>
nnoremap <c-s-TAB> :tabprev<cr>

" Quote words under cursor
nnoremap <leader>" viW<esc>a"<esc>gvo<esc>i"<esc>gvo<esc>3l
nnoremap <leader>' viW<esc>a'<esc>gvo<esc>i'<esc>gvo<esc>3l

" Quote current selection use plugin ... instead it
" TODO: This only works for selections that are created "forwardly"
"vnoremap <leader>" <esc>a"<esc>gvo<esc>i"<esc>gvo<esc>ll
"vnoremap <leader>' <esc>a'<esc>gvo<esc>i'<esc>gvo<esc>ll

" Use shift-H and shift-L for move to beginning/end
nnoremap H 0
nnoremap L $

nnoremap <Leader>h :set hlsearch!<CR>
"}}}

" {{{ plugins configuration
" vim-toggle {{{
imap <C-T>:call Toggle()<CR>
nmap <C-T>:call Toggle()<CR>
vmap <C-T> <ESC>:call Toggle()<CR>
"}}}
" vim-airline {{{
let g:airline_powerline_fonts = 1
" vim-airline's extensions
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#branch#format = 'Git_flow_branch_format'
"}}}
" ctrlp {{{
set wildignore+=*.7z
" }}}
" syntastic {{{
" disable perlcritic
"let g:loaded_syntastic_perl_perlcritic_checker = 1
let g:syntastic_enable_perl_checker = 1
"let g:syntastic_perl_checkers ??
let g:syntastic_perl_perlcritic_thres = 1 "default 5
"let g:syntastic_perl_perlcritic_thres = string "default empty
"}}}
" perl-support {{{
" let g:Perl_TemplateOverwrittenMsg= 'no'
let g:Perl_PerlcriticSeverity = 1
let g:Perl_PerlcriticVerbosity = 9
" sprawdzanie skladni pod
let g:Perl_PodcheckerWarnings = 'yes'
let g:Perl_LocalTemplateFile = vimrc_dir . 'perl-support/templates/Templates'
" }}}
" bash-support {{{
" let g:BASH_TemplateOverwrittenMsg = 'no'
let g:Bash_LocalTemplateFile = vimrc_dir . 'bash-support/templates/Templates'
" }}}
" vim-support {{{
let g:Vim_CreateMapsForHelp = 'yes'
"}}}
" c-support {{{
" let g:C_TemplateOverwrittenMsg= 'no'
let g:C_LocalTemplateFile = vimrc_dir . 'c-support/templates/Templates'
" }}}
" jshint {{{
"let jshint2_command = '/home/piecia/opt/npm/jshint' " moved to user.vim
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
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabDefaultCompletionType = "<c-p>"
let g:SuperTabMappingForward  = '<tab>'
"let g:SuperTabMappingBackward = '<s-tab>'
" }}}
" file_templates {{{
let g:file_template_default = "def/PKGBUILD"
let g:VIMFILESDIR = vimrc_dir
" }}}
" vbookmark {{{
let g:vbookmark_bookmarkSaveFile = $HOME . '/.vimbookmark'
" }}}
" vim-session {{{
let g:session_autosave = 'yes'
let g:session_autoload = 'no'
let g:session_directory = vimrc_dir . 'sessions'
let g:session_autosave_periodic = '5'
" }}}
" TagList {{{
 noremap <silent> <F11>       :TlistToggle<CR>
inoremap <silent> <F11>  <C-C>:TlistToggle<CR>

let tlist_perl_settings  = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD;k:comments'

let Tlist_Enable_Fold_Column=0
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
let Tlist_Display_Tag_Scope=1

" show TagList window on the left
let Tlist_Use_Left_Window=1
" }}}
" Tagbar {{{
 noremap <silent> <F12>       :TagbarToggle<CR>
inoremap <silent> <F12>  <C-C>:TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_sort = 0
let g:tagbar_show_linenumbers = 0
"let g:tagbar_width = 30
"let g:tagbar_vertical = 30
let g:tagbar_autofocus = 1
" }}}
" xml_completion {{{
let g:xmlSubelements = "yes"
" }}}
" switch {{{
nnoremap <c-t> :Switch<cr>
let g:switch_custom_definitions =
    \ [
    \   ['Y', 'N'],
    \   ['y', 'n'],
    \   ['yes', 'no'],
    \   ['1', '0'],
    \   ['on', 'off'],
    \   ['ON', 'OFF'],
    \   ['enable', 'disable'],
    \   ['ENABLE', 'DISABLE'],
    \   ['true', 'false'],
    \   ['TRUE', 'FALSE']
    \ ]
" }}}
" restore_view, @see also save/restore for au {{{
set viewoptions=cursor,folds,slash,unix
let g:skipview_files = ['*\.vim']
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
" promptline {{{
let g:promptline_preset = {
    \'y' : [ promptline#slices#vcs_branch({'svn': 1}) ]}
" }}}
" gitgutter {{{
let g:gitgutter_sign_removed_first_line = "^_"
let g:gitgutter_max_signs = 2000
" }}}
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
set timeoutlen=1000
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
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
" Solarized Colorscheme Config {{{
let g:solarized_termcolors=256
let g:solarized_underline=0    "default value is 1
let g:solarized_italic=0    "default value is 1
let g:solarized_termcolors=256    "default value is 16
"let g:solarized_termtrans=0
"let g:solarized_degrade=0
"let g:solarized_bold=1
"let g:solarized_diffmode="normal"
"let g:solarized_hitrail=0
" }}}
" easytags {{{
let g:easytags_cmd = '/usr/bin/ctags'
let g:easytags_async = 1
let g:easytags_dynamic_files = 1
let g:easytags_auto_highlight = 1
let g:easytags_autorecurse = 0
let g:easytags_python_enabled = 1
let g:easytags_always_enabled = 0
let g:easytags_on_cursorhold = 1
set tags=./tags;
"set vbs=1 | call xolox#easytags#why_so_slow()
" }}}
" vim-javacomplete2 {{{
autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType java nnoremap <F4> call javacomplete#AddImport()<cr>
" }}}
" togglenumber {{{
"nnoremap <F6> :ToggleNumber<CR>
" }}}
" vim-buftabline {{{
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprev<CR>
" }}}
" vim-shell {{{
let g:shell_mappings_enabled=0
" }}}
" Ultisnips {{{
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}
" open-browser.vim {{{
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" }}}
" vim-easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}
"{{{ Emmet settings
let g:user__install_global = 0
autocmd FileType html,css EmmetInstall
"}}}
"Beautify js, html, css with ctrl-f
map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>
autocmd FileType scss noremap <buffer> <c-f> :call CSSBeautify()<cr>

"react settings
let g:jsx_ext_required = 0

" }}}

" Extra user or machine specific settings
if filereadable(vimrc_dir . "user.vim")
    execute ":source " . vimrc_dir . "user.vim"
endif
