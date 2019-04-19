"
" To start vim without loading any .vimrc or plugins, use:
"   vim -u NONE
"
" To test timing startup
"   vim --startuptime start.log

" Basic settings {{{
" Use Vim settings, rather then Vi settings. This must be first, because it changes other options as a side effect.
" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif

" Some global settings for further using {{{
let g:MSWIN   = has('win16')  || has('win32')   || has('win64')     || has('win95')
let g:MSWIN64 = has('win64')
let g:UNIX    = has('unix')   || has('macunix') || has('win32unix')
let g:PYTHON  = has('python') || has('python3')
let g:PYTHON3 = has('python3')
let g:OS      = substitute(system('uname'), "\n", "", "")
"}}}

" multi_byte/unicode/utf {{{
if has('multi_byte')
    let g:UNICODE = 0
    if &termencoding == ''
        let &termencoding = &encoding
    endif
    if $LC_ALL =~? 'utf-?8' || $LANG =~? '\vutf-?8'
        let g:UNICODE = 1
        scriptencoding utf-8
        set fileencoding=utf-8
        set encoding=utf-8
    endif
endif
"}}}

" OS Settings, exports vimrc_dir {{{
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

" Remove existing autocommands to avoid duplicates
autocmd!
"}}}

" Plugins managed by vim-plug {{{
" define bundle directory for plugins and also default directory to check if
" a plugin exists for function plugin#isEnabled
" use g:bundle_dir or if you want overwrite default directory to check for
" plugin use g:pluginIsEnabledDirectory
let bundle_dir = vimrc_dir . 'bundle'
"let g:pluginIsEnabledDirectory = expand("$HOME/.vim/bundle")
"let g:pluginIsEnabledVerbose = 1

call plug#begin(bundle_dir)
" manage vim-plug by itself
Plug 'junegunn/vim-plug'

" For Vim {{{2
Plug 'tpope/vim-sensible'                       " [Defaults everyone can agree on](https://github.com/tpope/vim-sensible)
Plug 'scrooloose/nerdcommenter'                 " [Vim plugin for intensely orgasmic commenting](https://github.com/scrooloose/nerdcommenter)
"Plug 'jbgutierrez/vim-better-comments'          " [Easily highlight human-friendly comments in your code!](https://github.com/jbgutierrez/vim-better-comments)
"Plug 'easymotion/vim-easymotion'                " [Vim motions on speed!](https://github.com/easymotion/vim-easymotion)
if !g:MSWIN
    Plug 'editorconfig/editorconfig-vim'        " [EditorConfig plugin](https://github.com/editorconfig/editorconfig-vim)
endif
Plug 'vim-scripts/vimwiki'                      " [Personal Wiki for Vim](https://github.com/vim-scripts/vimwiki)
if version >= 800 || has('nvim')
    Plug 'skywind3000/asyncrun.vim'             " [Run Async Shell Commands in Vim 8.0 / NeoVim and Output to Quickfix Window](https://github.com/skywind3000/asyncrun.vim)
endif
"Plug 'Shougo/vimproc.vim'                       " [great asynchronous execution library](https://github.com/Shougo/vimproc.vim)
"Plug 'vim-scripts/YankRing.vim'                 " [Maintains a history of previous yanks, changes and deletes](https://github.com/vim-scripts/YankRing.vim)
Plug 'junegunn/vim-peekaboo'                    " [extends \" and @ in normal mode and <CTRL-R>](https://github.com/junegunn/vim-peekaboo)
Plug 'ConradIrwin/vim-bracketed-paste'          " [Handles bracketed-paste-mode](https://github.com/ConradIrwin/vim-bracketed-paste)
if has('patch-8.0.1364') || has('nvim')
    Plug 'andymass/vim-tradewinds'              " [the missing window movement](https://github.com/andymass/vim-tradewinds)
endif
Plug 'chrisbra/Recover.vim'                     " [A Plugin to show a diff, whenever recovering a buffer](https://github.com/chrisbra/Recover.vim)
if has('patch-7.4.1154')
    Plug 'embear/vim-localvimrc'                    " [Search local vimrc files ('.lvimrc') in the tree (root dir up to current dir) and load them.](https://github.com/embear/vim-localvimrc)
endif

" UI {{{2
Plug 'scrooloose/nerdtree'                      " [A tree explorer plugin for vim](https://github.com/scrooloose/nerdtree)
Plug 'tyok/nerdtree-ack'                        " [NERDtree + ack.vim](https://github.com/tyok/nerdtree-ack)
if g:UNICODE
    Plug 'scrooloose/nerdtree-git-plugin'       " [A plugin of NERDTree showing git status](https://github.com/scrooloose/nerdtree-git-plugin)
endif
Plug 'tpope/vim-flagship'                       " [Configurable and extensible tab line and status line](https://github.com/tpope/vim-flagship)
Plug 'mhinz/vim-startify'                       " [The fancy start screen](https://github.com/mhinz/vim-startify)
"Plug 'vim-scripts/mru.vim'                      " [manage Most Recently Used (MRU) files](https://github.com/vim-scripts/mru.vim)
Plug 'lilydjwg/colorizer'                       " [A Vim plugin to colorize all text in the form #rrggbb or #rgb](https://github.com/lilydjwg/colorizer)
Plug 'gu-fan/colorv.vim',{'on': 'ColorV'}       " [edit color easy](https://github.com/gu-fan/colorv.vim)
Plug 'mattn/webapi-vim'                         " [vim interface to Web API](https://github.com/mattn/webapi-vim)

" UI::statusline {{{2
if g:UNICODE
    Plug 'liuchengxu/eleline.vim'                   " [A tiny elegant statusline for vim](https://github.com/liuchengxu/eleline.vim)
else
"    Plug 'itchyny/lightline.vim'                    " [A light and configurable statusline/tabline plugin for Vim](https://github.com/itchyny/lightline.vim)
"    Plug 'vim-airline/vim-airline'                  " [Lean & mean status/tabline for vim that's light as air](https://github.com/vim-airline/vim-airline)
"    Plug 'vim-airline/vim-airline-themes'           " [the official theme repository](https://github.com/vim-airline/vim-airline-themes)
endif
"Plug 'edkolev/promptline.vim'                   " [Generate a fast shell prompt with powerline symbols and airline colors](https://github.com/edkolev/promptline.vim)
"Plug 'tpope/vim-sleuth'                         " [Heuristically set buffer options](https://github.com/tpope/vim-sleuth)
"Plug 'AndrewRadev/splitjoin.vim'                " [A vim plugin that simplifies the transition between multiline and single-line code](https://github.com/AndrewRadev/splitjoin.vim)

" pairs {{{2
"Plug 'tpope/vim-unimpaired'                     " [pairs of handy bracket mappings](https://github.com/tpope/vim-unimpaired)
"Plug 'kurkale6ka/vim-pairs'                     " [Punctuation text objects: ci/ da; vi@ yiq da<space> ...](https://github.com/kurkale6ka/vim-pairs)
"Plug 'jiangmiao/auto-pairs'                     " [insert or delete brackets, parens, quotes in pair](https://github.com/jiangmiao/auto-pairs)
"Plug 'Yggdroot/hiPairs'                        " [Highlights the pair surrounding the current cursor position - slows gvim for complex files](https://github.com/Yggdroot/hiPairs)

" Behavior {{{2
"Plug 'Raimondi/delimitMate'                     " [insert mode auto-completion for quotes, parens, brackets](https://github.com/Raimondi/delimitMate)
Plug 'rstacruz/vim-closer'                      " [Closes brackets](https://github.com/rstacruz/vim-closer)
"Plug 'vim-scripts/restore_view.vim'             " [automatically restoring file's cursor position and folding](https://github.com/vim-scripts/restore_view.vim)
Plug 'markonm/traces.vim'                       " [Range, pattern and substitute preview for Vim](https://github.com/markonm/traces.vim)
"Plug 'gcmt/taboo.vim'                           " [Few utilities for pretty tabs](https://github.com/gcmt/taboo.vim)
Plug 'vim-scripts/let-modeline.vim'             " [Extends the modeline feature to the assignment of variables](https://github.com/vim-scripts/let-modeline.vim)

" ctrlp {{{2
"Plug 'ctrlpvim/ctrlp.vim'                       " [Fuzzy file, buffer, mru, tag, etc finder](https://github.com/kien/ctrlp.vim)
"Plug 'tacahiroy/ctrlp-funky'                    " [A simple function navigator for ctrlp.vim](https://github.com/tacahiroy/ctrlp-funky)
"Plug 'sgur/ctrlp-extensions.vim'                " [Plugins for ctrlp.vim](https://github.com/sgur/ctrlp-extensions.vim)

" Programming Languages {{{2
" [A Vim plugin for Prettier](https://github.com/prettier/vim-prettier)
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue'] }

Plug 'ekalinin/Dockerfile.vim'                  " [Vim syntax file & snippets for Docker's Dockerfile](https://github.com/ekalinin/Dockerfile.vim)

" c++, c {{{3
Plug 'jiangxincode/mpi.vim', {'for':['c','cpp','fortran']}  " [A Vim Plugin for MPI Syntax highlight, matching rules and mappings](https://github.com/jiangxincode/mpi.vim)
Plug 'vim-scripts/OmniCppComplete',      {'for': 'cpp'}                 " [C/C++ omni-completion with ctags database](https://github.com/vim-scripts/OmniCppComplete)
Plug 'vim-scripts/cpp_cppcheck.vim',     {'for': 'cpp'}                 " [Run Cppcheck on the current window](https://github.com/vim-scripts/cpp_cppcheck.vim)
Plug 'octol/vim-cpp-enhanced-highlight'         " [Additional Vim syntax highlighting for C++ (including C++11/14)](https://github.com/octol/vim-cpp-enhanced-highlight)

" CSS/LESS {{{3
Plug 'ap/vim-css-color',            {'for': ['css','scss','sass','less']}
Plug 'groenewege/vim-less',         {'for': ['less']}
Plug 'vitalk/vim-lesscss',          {'for': ['less']}                          " [Update corresponding css files on the fly while edit less files](https://github.com/vitalk/vim-lesscss)

" Go {{{3
if version > 704 || (version == 704 && has('patch330'))
    Plug 'fatih/vim-go', {'for': 'go'}
endif
Plug 'nsf/gocode',   {'for': 'go'}

" HTML {{{3
Plug 'gregsexton/MatchTag', {'for': ['html','xml']}
Plug 'mattn/emmet-vim',     {'for': ['html','css','sass']}  " [provides support for expanding abbreviations similar to emmet](https://github.com/mattn/emmet-vim)
Plug 'othree/html5.vim',    {'for': ['html']}
Plug 'tpope/vim-haml',      {'for': ['haml','sass','scss']}
Plug 'alvan/vim-closetag',  {'for': ['html','xml']}         " [Auto close (X)HTML tags](https://github.com/alvan/vim-closetag)

" Java {{{3
Plug 'vim-scripts/vim-javacomplete2', {'for':'java'}        " [Refreshed javacomplete plugin for vim](https://github.com/vim-scripts/vim-javacomplete2)
Plug 'vim-scripts/VimClojure',        {'for':'clojure'}     " [A filetype, syntax and indent plugin for Clojure](https://github.com/vim-scripts/VimClojure)

" JavaScript {{{3
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'maksimr/vim-jsbeautify',  {'for': 'javascript'}
Plug 'wizicer/vim-jison',       {'for': ['jison','yacc']}
Plug 'mxw/vim-jsx',             {'for': ['javascript','jsx']}
Plug 'Shutnik/jshint2.vim',     {'for': 'javascript'}         " [Lightweight, customizable and functional Vim plugin for JSHint integration](https://github.com/Shutnik/jshint2.vim)

" Perl {{{3
" [Support for Perl 5 and Perl 6 in Vim](https://github.com/vim-perl/vim-perl)
Plug 'vim-perl/vim-perl',       {'for': 'perl', 'do': 'make clean carp dancer highlight-all-pragmas moose test-more try-tiny' }
Plug 'vim-scripts/perl_h2xs',   {'for': ['perl','pm','xs']} " [Automate creating perl modules via h2xs](https://github.com/vim-scripts/perl_h2xs)
Plug 'nxadm/syntastic-perl6',   {'for': ['perl','pm','xs']} " [Perl 6 support for vim-syntastic](https://github.com/nxadm/syntastic-perl6.git)
Plug 'vim-scripts/Perldoc.vim', {'for': ['perl','pm','xs']} " [perldoc command from vim](https://github.com/vim-scripts/Perldoc.vim)
"Plug 'vim-scripts/perlhelp.vim',            {'for': ['perl','pm','xs']} " [Interface to perldoc](https://github.com/vim-scripts/perlhelp.vim) " conflict vim perl-support <LocalLeader>pm

" PHP {{{3
Plug 'shawncplus/phpcomplete.vim', {'for':'php'} " [Improved PHP omnicompletion](https://github.com/shawncplus/phpcomplete.vim)
Plug 'rayburgemeestre/phpfolding.vim'           " [Automatic folding of PHP functions, classes,.. (also folds related PhpDoc)](https://github.com/rayburgemeestre/phpfolding.vim)

" Python {{{3
if g:PYTHON
    Plug 'davidhalter/jedi-vim'                 " [Using the jedi autocompletion library for VIM](https://github.com/davidhalter/jedi-vim)
    Plug 'vim-scripts/betterga'                 " [betterga can get more information than ga (:ascii)](https://github.com/vim-scripts/betterga)
    "Plug 'joonty/vdebug', {'for': 'python'}         " [Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)(https://github.com/joonty/vdebug)
    Plug 'klen/python-mode', {'for': 'python'}  " [Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box](https://github.com/klen/python-mode)
    Plug 'vim-scripts/python_fold', {'for': 'python'}           " [Folding expression for python](https://github.com/vim-scripts/Python_fold)
    "Plug 'nvie/vim-flake8', {'for': 'python'}       " [Flake8 plugin for Vim](https://github.com/nvie/vim-flake8)
    Plug 'jmcantrell/vim-virtualenv'            " [Vim plugin for working with python virtualenvs](https://github.com/jmcantrell/vim-virtualenv)
endif

" R {{{3
"Plug 'Vim-R-plugin', {'for': 'R'}               " [Plugin to work with R](https://github.com/vim-scripts/Vim-R-plugin)

" XML, XSLT {{{3
Plug 'vim-scripts/xml.vim', {'for': 'xml'}      " [helps editing xml (and [x]html, sgml, xslt) files](https://github.com/vim-scripts/xml.vim)
Plug 'vim-scripts/xmledit', {'for': 'xml'}      " [A filetype plugin to help edit XML, HTML, and SGML documents](https://github.com/vim-scripts/xmledit)
Plug 'vim-scripts/xslt',    {'for': 'xslt'}     " [XSLT ftplugin](https://github.com/vim-scripts/xslt)

" YAML {{{3
"Plug 'chase/vim-ansible-yaml', {'for':['yaml','yml']}  " [Add additional support for Ansible](https://github.com/chase/vim-ansible-yaml)
Plug 'pearofducks/ansible-vim'                  " [A vim plugin for syntax highlighting Ansible's common filetypes](https://github.com/pearofducks/ansible-vim)

" JSON {{{3
Plug 'elzr/vim-json'                            " [A better JSON](https://github.com/elzr/vim-json)

" maven {{{3
Plug 'mikelue/vim-maven-plugin'                 " [The Maven plugin for VIM](https://github.com/mikelue/vim-maven-plugin)

" Git and other VCS {{{2
if executable('git')
    Plug 'int3/vim-extradite'
    Plug 'tpope/vim-fugitive'                   " [Git wrapper of all time](https://github.com/tpope/vim-fugitive)
    Plug 'junegunn/gv.vim'                      " [A git commit browser in Vim](https://github.com/junegunn/gv.vim)
    Plug 'WolfgangMehner/git-support'           " [Git for Vim/gVim](https://github.com/WolfgangMehner/git-support)
    Plug 'vim-scripts/git-flow-format'          " [formats a Git Flow branch name in order to shorten the prefixes, some errors due saving a file](https://github.com/vim-scripts/git-flow-format)
    Plug 'vim-scripts/gitv'                     " [gitk for Vim](https://github.com/vim-scripts/gitv)
    Plug 'idanarye/vim-merginal'                " [Fugitive extension to manage and merge Git branches](https://github.com/idanarye/vim-merginal)
    Plug 'vim-scripts/vim-gitignore'            " [Another gitignore plugin for Vim](https://github.com/vim-scripts/vim-gitignore)
    Plug 'sjl/splice.vim'                       " [managing three-way merges - conflict with vim-fugitive](https://github.com/sjl/splice.vim)
"    Plug 'mhinz/vim-signify'                    " [show differences with style](https://github.com/mhinz/vim-signify) error while writting
"    Plug 'vim-scripts/vcscommand.vim'           " [CVS/SVN/SVK/git/hg/bzr integration plugin - mapping conflict](https://github.com/vim-scripts/vcscommand.vim)
    if version >= 704
        Plug 'airblade/vim-gitgutter'           " [shows a git diff in the 'gutter' (sign column)](https://github.com/airblade/vim-gitgutter)
    endif
    Plug 'whiteinge/diffconflicts'              " [A better Vimdiff Git mergetool](https://github.com/whiteinge/diffconflicts)
    Plug 'cohama/agit.vim'                      " [A powerful Git log viewer](https://github.com/cohama/agit.vim)
endif

" Themes {{{2
"Plug 'altercation/vim-colors-solarized'       " [precision colorscheme for the vim text editor](https://github.com/altercation/vim-colors-solarized)
"Plug 'vim-scripts/primary.vim'                            " [Inspired by Google's official colors](https://github.com/vim-scripts/primary.vim)
"Plug 'vim-scripts/yowish'                                   " [A yellowish dark color scheme](https://github.com/vim-scripts/yowish)
"Plug 'flazz/vim-colorschemes'                   " [this is harvested from vim.org. only colorschemes downloaded in a single .vim](https://github.com/flazz/vim-colorschemes)
Plug 'xolox/vim-colorscheme-switcher'           " [Color scheme switcher for Vim](https://github.com/xolox/vim-colorschemes-switch)
"Plug 'vim-scripts/HiColors'                     " [Colorscheme display and editor](https://github.com/vim-scripts/hicolors)
"Plug 'sonph/onehalf',{'rtp':'vim/'}             " [Clean, vibrant and pleasing color schemes for Vim, Sublime Text, iTerm, gnome-terminal and more](https://github.com/sonph/onehalf)
Plug 'morhetz/gruvbox'                          " [Retro groove color scheme for Vim](https://github.com/morhetz/gruvbox)

" Syntax {{{2
Plug 'vim-scripts/nginx.vim', {'for':'nginx'}   " [highlights configuration files for nginx, the high-performance web server](https://github.com/vim-scripts/nginx.vim)
"Plug 'putty'                                    " [A color scheme that resembles one of Putty](https://github.com/vim-scripts/putty)
Plug 'vim-scripts/httplog'                      " [Highlight access log of Apache, nginx, etc](https://github.com/vim-scripts/httplog)
Plug 'vim-scripts/LogViewer'                    " [Comfortable examination of multiple parallel logfiles](https://github.com/vim-scripts/LogViewer)
Plug 'vim-scripts/TWiki-Syntax'                 " [Syntaxfile for TWiki-Syntax](https://github.com/vim-scripts/TWiki-Syntax)
Plug 'vim-scripts/whitespace-syntax-highlight'  " [whitespace syntax highlight](https://github.com/vim-scripts/whitespace-syntax-highlight/)
"Plug 'bronson/vim-trailing-whitespace'          " [Highlights trailing whitespace in red and provides](https://github.com/bronson/vim-trailing-whitespace)
Plug 'ntpeters/vim-better-whitespace'           " [Better whitespace highlighting](https://github.com/ntpeters/vim-better-whitespace)
Plug 'vim-scripts/logstash.vim'                 " [logstash.vim highlights configuration files for logstash](https://github.com/vim-scripts/logstash.vim)
Plug 'chrisbra/csv.vim',{'for':'csv'}           " [A Filetype plugin for csv files](https://github.com/chrisbra/csv.vim)
Plug 'sheerun/vim-polyglot'                     " [A solid language pack for Vim](https://github.com/sheerun/vim-polyglot)
Plug 'cakebaker/scss-syntax.vim', {'for': ['scss','sass']}
Plug 'hail2u/vim-css3-syntax', {'for': ['css','scss']}
Plug 'vim-scripts/jQuery', {'for': 'javascript'}         " [Syntax file for jQuery](https://github.com/vim-scripts/jQuery)
Plug 'StanAngeloff/php.vim', {'for':'php'} " [Up-to-date PHP syntax file (5.3 - 7.1 support)](https://github.com/StanAngeloff/php.vim)
Plug 'vim-scripts/bats.vim'                     " [Syntax highlighting for Bats - Bash Automated Testing System](https://github.com/vim-scripts/bats.vim)

" Markdown {{{2
"Plug 'plasticboy/vim-markdown', {'for': 'markdown'}                      " [Markdown Vim Mode](https://github.com/plasticboy/vim-markdown/)
"Plug 'MikeCoder/markdown-preview.vim', {'for': 'markdown'}               " [Markdown Preview - brokes vim](https://github.com/vim-scripts/markdown-preview.vim) does not work
Plug 'nelstrom/vim-markdown-folding', {'for': 'markdown'}                " [Fold markdown documents by section](https://github.com/nelstrom/vim-markdown-folding)
"Plug 'suan/vim-instant-markdown', {'for':'markdown'}                     " [Instant Markdown previews](https://github.com/suan/vim-instant-markdown)
"Plug 'JamshedVesuna/vim-markdown-preview'       " [A light Vim plugin for previewing markdown files in a browser](https://github.com/JamshedVesuna/vim-markdown-preview)

" Charles Campbell {{{2
Plug 'vim-scripts/AnsiEsc.vim'                  " [ansi escape sequences concealed, but highlighted as specified (conceal)](https://github.com/vim-scripts/AnsiEsc.vim)
Plug 'powerman/vim-plugin-AnsiEsc'              " [ansi escape sequences concealed, but highlighted as specified (conceal)](https://github.com/powerman/vim-plugin-AnsiEsc)
Plug 'vim-scripts/DrawIt'                       " [Ascii drawing plugin: lines, ellipses, arrows, fills, and more!](https://github.com/vim-scripts/DrawIt)
"Plug 'emezeske/manpageview'                     " [man page view for vim](https://github.com/emezeske/manpageview)
Plug 'vim-scripts/Decho'                        " [internal debugger](https://github.com/vim-scripts/decho)
Plug 'vim-scripts/gdbmgr'                       " [interface to gdb](https://github.com/vim-scripts/gdbmgr)
Plug 'vim-scripts/highlight.vim'                " [Highlight lines or patterns of interest in different colors](https://github.com/vim-scripts/highlight.vim)
Plug 'vim-scripts/LargeFile'                    " [Edit large files quickly (keywords: large huge speed)](https://github.com/vim-scripts/largefile)
Plug 'vim-scripts/SudoEdit.vim'                 " [Edit Files using sudo or su or any other tool](https://github.com/vim-scripts/SudoEdit.vim)
Plug 'vim-scripts/vis'                          " [Extended Visual Mode Commands, Substitutes, and Searches](https://github.com/vim-scripts/vis)
Plug 'vim-scripts/cecutil'                      " [save/restore window position, mark position, selected user mapssave/restore window position, mark position, selected user maps](https://github.com/vim-scripts/cecutil)

" xolox {{{2
"Plug 'xolox/vim-notes'                          " [Easy note taking in Vim](https://github.com/xolox/vim-notes)
Plug 'xolox/vim-shell'                          " [Improved integration between Vim and its environment](https://github.com/xolox/vim-shell)
Plug 'xolox/vim-misc'                           " [Miscellaneous auto-load Vim scripts](https://github.com/xolox/vim-misc)
Plug 'xolox/vim-reload'                         " [Automatic reloading of Vim scripts](https://github.com/xolox/vim-reload)
"Plug 'xolox/vim-session'                        " [Extended session management for Vim](https://github.com/xolox/vim-session)
if g:PYTHON
    Plug 'xolox/vim-tools'                      " [Python scripts to publish Vim plug-ins](https://github.com/xolox/vim-tools)
endif
Plug 'xolox/vim-easytags'                       " [Automated tag file generation and syntax highlighting of tags](https://github.com/xolox/vim-easytags)

" Fritz Mehner {{{2
Plug 'vim-scripts/Vim-support',{'for': 'vim'}              " [Vim Script IDE for Vim/gVim](https://github.com/vim-scripts/Vim-Support)
Plug 'vim-scripts/awk-support.vim',{'for': 'awk'}          " [AWK-IDE for Vim/gVim](https://github.com/vim-scripts/awk-support.vim)
Plug 'vim-scripts/bash-support.vim',{'for': 'sh'}          " [BASH IDE -- Write and run BASH-scripts using menus and hotkeys](https://github.com/vim-scripts/bash-support.vim)
Plug 'vim-scripts/perl-support.vim',{'for':['perl','xs']}                 " [Write and run Perl-scripts using menus and hotkeys](https://github.com/vim-scripts/perl-support.vim)
Plug 'vim-scripts/c.vim', {'for':['c','cpp']}                   " [C/C++ IDE -- Write and run programs. Insert statements, idioms, comments etc](https://github.com/vim-scripts/c.vim)
Plug 'vim-scripts/latex-support.vim',{'for':['tex','plaintex']} " [LaTeX-IDE for Vim/gVim](https://github.com/vim-scripts/latex-support.vim)
Plug 'vim-scripts/doxygen-support.vim',{'for':'doxygen'}        " [Generate Doxygen comments from user defined templates](https://github.com/vim-scripts/doxygen-support.vim)
Plug 'WolfgangMehner/Vim-Mapathon'                              " [My talk for Vimfest 2017 - An advanced introduction to maps](https://github.com/WolfgangMehner/vim-mapathon)

" Others {{{2
if version > 704 || (version == 704 && has('patch330'))
"    Plug 'andymass/vim-matchup'                     " [even better % fist_oncoming navigate and highlight matching words fist_oncoming modern matchit and matchparen replacement](https://github.com/andymass/vim-matchup)
endif
Plug 'vim-scripts/matchit.zip'                  " [extended % matching for HTML, LaTeX, and many other languages](https://github.com/vim-scripts/matchit.zip)
if version >= 704
    Plug 'vim-scripts/EnhancedDiff'             " [A Vim plugin for creating better diffs](https://github.com/vim-scripts/EnhancedDiff)
endif
Plug 'vim-scripts/closetag.vim'                 " [Functions and mappings to close open HTML/XML tags](https://github.com/vim-scripts/closetag.vim)
Plug 'vim-scripts/netrw.vim'                    " [Network oriented reading, writing, and browsing (keywords: netrw ftp scp)(https://github.com/vim-scripts/netrw.vim)
Plug 'tyru/open-browser.vim'                    " [Open URI with your favorite browser from your most favorite editor](https://github.com/tyru/open-browser.vim)
Plug 'jlemetay/permut'                          " [swap columns of text separated by arbitrary characters](https://github.com/jlemetay/permut)
"Plug 'junegunn/vim-easy-align'                  " [A Vim alignment plugin](https://github.com/junegunn/vim-easy-align)
Plug 'godlygeek/tabular'                        " [Vim script for text filtering and alignment](https://github.com/godlygeek/tabular)
Plug 'AndrewRadev/switch.vim'                   " [switch segments of text with predefined replacements](https://github.com/AndrewRadev/switch.vim/)
if version > 700
    Plug 'scrooloose/syntastic'                 " [Syntax checking hacks for vim](https://github.com/scrooloose/syntastic)
endif
"Plug 'maralla/validator.vim'                    " [Check syntax on the fly asynchronously](https://github.com/maralla/validator.vim)
Plug 'majutsushi/tagbar'                        " [Vim plugin that displays tags in a window, ordered by scope](https://github.com/majutsushi/tagbar)
Plug 'vim-scripts/Tabmerge'                     " [Merge a tab's windows with the current tab](https://github.com/vim-scripts/Tabmerge)
Plug 'vim-scripts/taglist.vim'                  " [Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)](https://github.com/vim-scripts/taglist.vim)
Plug 'vim-scripts/Toggle'                       " [allows you to toggle bool (true/false) and other words with a shortcut](https://github.com/vim-scripts/Toggle)
if version > 703 || (version == 703 && has('patch005'))
"    Plug 'mbbill/undotree'                      " [The ultimate undo history visualizer for VIM](https://github.com/mbbill/undotree)
endif
if version > 703 && g:PYTHON
    Plug 'simnalamburt/vim-mundo'                   " [Vim undo tree visualizer](https://github.com/simnalamburt/vim-mundo)
endif
if version > 704 || (version == 704 && has('patch330'))
    Plug 'Shougo/unite.vim'                     " [Unite and create user interfaces](https://github.com/Shougo/unite.vim)
endif
Plug 'tpope/vim-repeat'                         " [repeat.vim: enable repeating supported plugin maps with "."](https://github.com/tpope/vim-repeat)
Plug 'tpope/vim-scriptease'                     " [A Vim plugin for Vim plugins](https://github.com/tpope/vim-scriptease)
Plug 'tpope/vim-surround'                       " [quoting/parenthesizing made simple](https://github.com/tpope/vim-surround)
"Plug 'MRU'                                      " [Most recently used files in your file menu](https://github.com/vim-scripts/mru)
"Plug 'airblade/vim-rooter'                      " [Changes Vim working directory to project root (identified by presence of known directory or file)](https://github.com/airblade/vim-rooter) conflict with map
"Plug 'togglenumber'                             " [easy toggle between different numbering modes](https://github.com/vim-scripts/togglenumber)
if version >= 703
    Plug 'ap/vim-buftabline'                    " [Forget Vim tabs - now you can have buffer tabs](https://github.com/ap/vim-buftabline)
endif
"Plug 'vim-scripts/tskeleton' | Plug 'vim-scripts/tlib'                  " [File Templates and Code Skeletons/Snippets](http://vim.sourceforge.net/scripts/script.php?script_id=1160)
if g:UNIX && g:UNICODE
"    Plug 'ryanoasis/vim-devicons'               " [adds font icons](https://github.com/ryanoasis/vim-devicons) breaks NerdTree
endif
Plug 'chip/vim-fat-finger'                      " [Simple vim plugin for common misspellings and typos](https://github.com/chip/vim-fat-finger)
Plug 'sedm0784/vim-you-autocorrect'             " Why should smartphones get all the fun?](https://github.com/sedm0784/vim-you-autocorrect)
Plug 'zirrostig/vim-schlepp'                    " [easily moving text selections around](https://github.com/zirrostig/vim-schlepp)
Plug 'jiangxincode/TagCollection'               " [Some tags used by the OmniCppComplete which can auto complete your code](https://github.com/jiangxincode/TagCollection)
"Plug 'nathanaelkane/vim-indent-guides'          " [displaying indent levels in code](https://github.com/nathanaelkane/vim-indent-guides)
Plug 'vim-scripts/supersearch'                  " [plugin is a source code browser plugin](https://github.com/vim-scripts/supersearch)
Plug 'vim-scripts/Dokumentary'                  " [Improve what K does](https://github.com/vim-scripts/Dokumentary)
Plug 'terryma/vim-expand-region'                " [Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination](https://github.com/terryma/vim-expand-region)
"Plug 'AutoFold.vim'                            " [A script to automate folding based on markers and syntax](https://github.com/vim-scripts/AutoFold.vim)
"Plug 'Konfekt/FastFold'                         " [Speed up Vim by updating folds only when called-for](https://github.com/Konfekt/FastFold)
Plug 'reedes/vim-pencil'                        " [Rethinking Vim as a tool for writing](https://github.com/reedes/vim-pencil)
Plug 'will133/vim-dirdiff'                      " [Vim plugin to diff two directories](https://github.com/will133/vim-dirdiff)
Plug 'vim-scripts/cream-ascii'                  " [Insert an ASCII character from a dialog box](https://github.com/vim-scripts/cream-ascii)
" [Table Mode for instant table creation](https://github.com/dhruvasagar/vim-table-mode)
Plug 'dhruvasagar/vim-table-mode',{'on':'TableModeEnable'} " map conflict with bash-support
Plug 'brooth/far.vim'                           " [Find And Replace](https://github.com/brooth/far.vim)
Plug 'soywod/kronos.vim'                        " [A simple task and time manager for vim](https://github.com/soywod/kronos.vim)
" 3rd party tools {{{2
Plug 'ggreer/the_silver_searcher'               " [A code-searching tool similar to ack, but faster](https://github.com/ggreer/the_silver_searcher)
Plug 'rking/ag.vim'                             " [Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'](https://github.com/rking/ag.vim)
Plug 'vim-scripts/ctrlsf.vim'                   " [an ack/ag powered global code search and view tool](https://github.com/vim-scripts/ctrlsf.vim)
Plug 'mileszs/ack.vim'                          " [Vim plugin for the Perl module / CLI script 'ack'](https://github.com/mileszs/ack.vim)
if executable('rg')
    Plug 'jremmen/vim-ripgrep'                  " [Use RipGrep in Vim and display results in a quickfix list](https://github.com/jremmen/vim-ripgrep)
endif
Plug 'VincentCordobes/vim-translate'            " [A tiny translate-shell wrapper for Vim](https://github.com/VincentCordobes/vim-translate)
Plug 'rizzatti/dash.vim'                        " [Search Dash.app from Vim](https://github.com/rizzatti/dash.vim)
Plug 'Lenovsky/nuake'                           " [A Quake-style terminal panel](https://github.com/Lenovsky/nuake)

" ctrl-a
"Plug 'tpope/vim-speeddating'                    " [use CTRL-A/CTRL-X to increment dates, times, and more](https://github.com/tpope/vim-speeddating)
Plug 'vim-scripts/visual-increment'                         " [Use CTRL+A/X to create increasing sequence of numbers or letters via visual mode](https://github.com/vim-scripts/visual-increment)
"Plug 'vim-scripts/monday'                                   " [Lets you use ctrl-a and ctrl-x on names of months and weekdays](https://github.com/vim-scripts/monday)

" Completion {{{2
" Use neocomplete or neocomplcache or supertab
if (version > 703 && has('lua')) || ( version == 703 && has('patch-885') && has('lua'))
    Plug 'Shougo/neocomplete.vim'               " [Next generation completion framework after neocomplcache](https://github.com/Shougo/neocomplete.vim)
elseif (version >= 703 && !has('lua'))
    Plug 'Shougo/neocomplcache.vim'             " [Ultimate auto-completion system for Vim](https://github.com/Shougo/neocomplcache.vim)
else
    Plug 'ervandew/supertab'                    " [Perform all your vim insert mode completions with Tab](https://github.com/ervandew/supertab)
endif
Plug 'Shougo/vimshell.vim'                      " [Powerful shell implemented by vim](https://github.com/Shougo/vimshell.vim)
if !g:MSWIN
    Plug 'c9s/perlomni.vim',{'do':'make install'} " [perl omnicompletion for vim (including base class function compleltions .. etc)](https://github.com/c9s/perlomni.vim)
endif
" Snippets for neocomplcache, neocomplete
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
if g:PYTHON
    " TAB conflict with other completion tools
"    Plug 'SirVer/ultisnips'                     " [The ultimate snippet solution for Vim. Send pull requests to SirVer/ultisnips!](https://github.com/SirVer/ultisnips)
endif
Plug 'honza/vim-snippets'                       " [snippets files for various programming languages](https://github.com/honza/vim-snippets)

" UNIX only {{{2
if g:UNIX
    Plug 'dracorp/vim-pkgbuild', {'for': 'PKGBUILD'}
endif

" MS Windows only {{{2
if g:MSWIN
    Plug 'vim-scripts/poshcomplete-vim'                       " [Omni Completion for PowerShell](https://github.com/vim-scripts/poshcomplete-vim)
    Plug 'vim-scripts/Windows-PowerShell-Syntax-Plugin'       " [Default syntax coloring for Windows PowerShell](https://github.com/vim-scripts/Windows-PowerShell-Syntax-File)
    Plug 'vim-scripts/Windows-PowerShell-Indent-File'         " [Simple indenting rules for Windows PowerShell](https://github.com/vim-scripts/Windows-PowerShell-Indent-File
"    Plug 'mattn/webapi-vim'                       " [vim interface to Web API](https://github.com/mattn/webapi-vim)
endif
if g:MSWIN && !g:MSWIN64
    Plug 'vim-scripts/maximize.dll'
endif

" Some offline plugins {{{2
" [A file templates](https://sites.google.com/site/abudden/contents/Vim-Scripts/file-templates)
execute 'Plug \"' . bundle_dir . '/file_templates\"'
" [This colorscheme is a dark-background style](http://www.drchip.org/astronaut/vim/index.html#ASTRONAUT)
"execute 'Plug \"' . bundle_dir . '/astronaut\"'
" [shows current function name in status line](http://www.drchip.org/astronaut/vim/index.html#STLSHOWFUNC)
execute 'Plug \"' . bundle_dir . '/StlShowFunc\"'
execute 'Plug \"' . bundle_dir . '/manpageview\"'
" [A code-completion engine](https://github.com/Valloric/YouCompleteMe)
execute 'Plug \"' . bundle_dir . 'YouCompleteMe\"'
" end of vim-plug's plugins management
call plug#end()
delc PlugUpgrade
"}}}2
" }}}

" Plugins configuration {{{
" bash-support {{{2
if plugin#isEnabled('bash-support.vim')
    " let g:BASH_TemplateOverwrittenMsg = 'no'
    if g:UNIX
        let g:BASH_LocalTemplateFile = vimrc_dir . 'templates/bash-support/templates/Templates'
    endif
endif
" }}}
" ctrlp {{{2
if plugin#isEnabled('ctrlp')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    set wildignore+=*.7z
endif
" }}}
" c-support {{{2
if plugin#isEnabled('c.vim')
    " let g:C_TemplateOverwrittenMsg= 'no'
    if g:UNICODE
        let g:C_LocalTemplateFile = vimrc_dir . 'templates/c-support/templates/Templates'
    endif
endif
" }}}
" delimitMate {{{2
if plugin#isEnabled('delimitMate')
    let delimitMate_expand_cr = 1
endif
" }}}
" doxygen-support {{{2
if plugin#isEnabled('doxygen-support.vim')
    let g:Doxy_LocalTemplateFile = vimrc_dir . 'templates/doxygen-support/templates/Templates'
endif
" }}}
" easytags {{{2
if plugin#isEnabled('vim-easytags')
    let g:easytags_async          = 1
    let g:easytags_dynamic_files  = 1
    let g:easytags_auto_highlight = 1
    let g:easytags_autorecurse    = 0
    let g:easytags_python_enabled = 1
    let g:easytags_always_enabled = 0
    let g:easytags_on_cursorhold  = 1
    setglobal tags+=./tags;
    " uncomment to see why so slow
    "set vbs=1 | call xolox#easytags#why_so_slow()
endif
" }}}
" eleline {{{2
if plugin#isEnabled('eleline.vim')
    let g:eleline_powerline_fonts = 1
endif
" }}}
" emmet-vim {{{2
if plugin#isEnabled('emmet-vim')
    let g:user__install_global = 0
    autocmd FileType html,css EmmetInstall
endif
"}}}
" file_templates {{{2
if plugin#isEnabled('file_templates')
    let g:file_template_default = "def.PKGBUILD"
    let g:VIMFILESDIR = vimrc_dir
endif
" }}}
" gitgutter {{{2
if plugin#isEnabled('vim-gitgutter')
    let g:gitgutter_sign_removed_first_line = "^_"
    let g:gitgutter_max_signs               = 2000
endif
" }}}
" gruvbox {{{2
if plugin#isEnabled('gruvbox')
    colorscheme gruvbox
    set background=dark
    if !exists("g:lightline")
        let g:lightline = {}
    endif
    let g:lightline.colorscheme='gruvbox'
endif
" }}}
" latex-support {{{2
if plugin#isEnabled('latex-support')
    let tlist_bib_settings   = 'bib;e:BibTeX-Entries;s:BibTeX-Strings'
    let tlist_make_settings  = 'make;m:makros;t:targets'
    let tlist_tex_settings   = 'latex;s:Contents;g:Graphics;i:Listings;l:\label;r:\ref;p:\pageref;b:\bibitem'
    if g:UNIX
        let s:LATEX_pdf_viewer         = "evince"
    endif
endif
" }}}
" lightline {{{2
if plugin#isEnabled('lightline.vim')
    if !exists("g:lightline")
        g:lightline = {}
    endif
    let g:lightline.component_function = {
                \ 'filename': 'LightlineFilename',
                \ }
    let g:lightline.active = {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'readonly', 'filename' ] ],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'percent' ],
        \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ }
    function! LightlineFilename()
        let filename = &filetype ==# 'vimfiler' ? vimfiler#get_status_string() :
                \ &filetype ==# 'unite' ? unite#get_status_string() :
                \ &filetype ==# 'vimshell' ? vimshell#get_status_string() :
                \ expand('%:p') !=# '' ? expand('%:p') : '[No Name]'
        let modified = &modified ? ' +' : ''
        return filename . modified
    endfunction
endif
" }}}
" manpageview {{{2
if plugin#isEnabled('manpageview')
    let $PAGER=''
endif
"}}}
" mundotree {{{2
if plugin#isEnabled('vim-mundo')
    nnoremap <F5> :MundoToggle<cr>
endif
"}}}
" mru {{{2
if plugin#isEnabled('mru.vim')
    let MRU_File = vimrc_dir . 'vim_mru_files'
endif
" }}}
" neocomplcache {{{2
if plugin#isEnabled('neocomplcache.vim')
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplcache.
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
    " Enable heavy features.
    " Use camel case completion.
    "let g:neocomplcache_enable_camel_case_completion = 1
    " Use underbar completion.
    "let g:neocomplcache_enable_underbar_completion = 1
    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()
    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><c-space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"
    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplcache_enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplcache_enable_insert_char_pre = 1
    " AutoComplPop like behavior.
    "let g:neocomplcache_enable_auto_select = 1
    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplcache_enable_auto_select = 1
    "let g:neocomplcache_disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " Enable heavy omni completion.
    if !exists('g:neocomplcache_force_omni_patterns')
        let g:neocomplcache_force_omni_patterns = {}
    endif
    let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif
" }}}
" neocomplete {{{2
if plugin#isEnabled('neocomplete.vim')
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }
    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'
    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()
    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
    endfunction
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"
    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1
    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endif
" }}}
" nerdtree {{{2
if plugin#isEnabled('nerdtree')
    map <F2> :NERDTreeToggle<CR>
    map <Leader>n <plug>NERDTreeTabsToggle<CR>
    set timeoutlen=1000
    let g:NERDTreeDirArrows=0
    "let g:NERDTreeDirArrowExpandable='+'
    "let g:NERDTreeDirArrowCollapsible='~'
    let NERDTreeShowHidden=1
    "let NERDTreeIgnore=['\.swp$',]
    " close when last
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif
" }}}
" onehalf {{{2
if plugin#isEnabled('onehalf/vim')
    colorscheme onehalfdark
    let g:airline_theme='onehalfdark'
    if !g:lightline
        let g:lightline = {}
    endif
    let g:lightline.colorscheme='onehalfdark'
endif
" }}}
" open-browser.vim {{{2
if plugin#isEnabled('open-browser.vim')
    let g:netrw_nogx = 0 " disable netrw's gx mapping.
    nmap gx <Plug>(openbrowser-smart-search)
    vmap gx <Plug>(openbrowser-smart-search)
endif
" }}}
" perl-support {{{2
if plugin#isEnabled('perl-support.vim')
    " let g:Perl_TemplateOverwrittenMsg= 'no'
    let g:Perl_PerlcriticSeverity  = 1
    let g:Perl_PerlcriticVerbosity = 9
    " sprawdzanie skladni pod
    let g:Perl_PodcheckerWarnings  = 'yes'
    if g:UNIX
        let g:Perl_LocalTemplateFile   = vimrc_dir . 'templates/perl-support/templates/Templates'
    else
        let g:Perl_LocalTemplateFile = $HOME . "vimfiles\\perl-support\\templates\\Templates"
    endif
endif
" }}}
" promptline {{{2
if plugin#isEnabled('promptline.vim')
    let g:promptline_preset = {
        \'y' : [ promptline#slices#vcs_branch({'svn': 1}) ]}
endif
" }}}
" python-mode {{{2
if plugin#isEnabled('python-mode')
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
    let g:pymode_doc     = 1
    let g:pymode_doc_key = 'K'
    "Linting
    let g:pymode_lint = 1
    "let g:pymode_lint_checker = "pyflakes,pep8"
    " Auto check on save
    let g:pymode_lint_write = 1
    " Support virtualenv
    let g:pymode_virtualenv = 1
    " Enable breakpoints plugin
    let g:pymode_breakpoint      = 1
    let g:pymode_breakpoint_bind = '<leader>b'
    " syntax highlighting
    let g:pymode_syntax               = 1
    let g:pymode_syntax_all           = 1
    let g:pymode_syntax_indent_errors = g:pymode_syntax_all
    let g:pymode_syntax_space_errors  = g:pymode_syntax_all
    " Don't autofold code
    let g:pymode_folding = 0
endif
" }}}
" restore_view {{{2
if plugin#isEnabled('restore_view.vim')
    set viewoptions=cursor,folds,slash,unix
    let g:skipview_files = ['*\.vim']
endif
" }}}
" startify {{{2
if plugin#isEnabled('vim-startify')
    let g:startify_fortune_use_unicode = 1
endif
"}}}
" supertab {{{2
if plugin#isEnabled('supertab')
    let g:SuperTabMappingForward  = '<tab>'
endif
" }}}
" switch {{{2
if plugin#isEnabled('switch.vim')
    nnoremap <c-t> :Switch<cr>
    let g:switch_custom_definitions =
        \ [
        \   ['Y','N'],
        \   ['y','n'],
        \   ['yes','no'],
        \   ['1','0'],
        \   ['on','off'],
        \   ['ON','OFF'],
        \   ['enable','disable'],
        \   ['ENABLE','DISABLE'],
        \   ['true','false'],
        \   ['TRUE','FALSE']
        \ ]
endif
" }}}
" syntastic {{{2
if plugin#isEnabled('syntastic')
    "let g:loaded_syntastic_perl_perlcritic_checker = 1
    "let g:syntastic_perl_perlcritic_thres          = 1
    "let g:syntastic_enable_perl_checker            = 1
    " see :he syntastic_mode_map
    let g:syntastic_mode_map = {
        \ 'mode': 'passive',
        \ 'passive_filetypes': ['python'],
        \ 'active_filetypes': [],
        \}
    let g:syntastic_aggregate_errors = 1
    let g:syntastic_ignore_files     = [ 'PKGBUILD' ]
    " Recomended settings
    set statusline+="%#warningmsg#"
    set statusline+="%{SyntasticStatuslineFlag()}"
    set statusline+="%*"
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list            = 1
    let g:syntastic_check_on_open            = 1
    let g:syntastic_check_on_wq              = 0
    " syntastic on/off
    noremap <silent> <F9> <Esc>:SyntasticToggleMode<cr>
    inoremap <silent> <F9> <C-o>:SyntasticToggleMode<cr>
endif
"}}}
" taboo.vim {{{2
if plugin#isEnabled('taboo.vim')
endif
" }}}
" tagbar {{{2
if plugin#isEnabled('tagbar')
    noremap <silent> <F12>       :TagbarToggle<CR>
    inoremap <silent> <F12>  <C-C>:TagbarToggle<CR>
    let g:tagbar_left             = 1
    let g:tagbar_sort             = 0
    let g:tagbar_show_linenumbers = 0
    let g:tagbar_autofocus        = 1
    "let g:tagbar_width           = 30
    "let g:tagbar_vertical        = 30
    let g:tagbar_compact = 1
    let g:tagbar_type_ansible = {
        \ 'ctagstype' : 'ansible',
        \ 'kinds' : [
        \ 't:tasks',
        \ 'h:hosts'
        \ ],
        \ 'sort' : 0
        \ }
    let g:tagbar_type_terraform = {
        \ 'ctagstype' : 'terraform',
        \ 'kinds' : [
        \ 'r:resources',
        \ 'm:modules',
        \ 'o:outputs',
        \ 'v:variables',
        \ 'f:tfvars'
        \ ],
        \ 'sort' : 0
        \ }
    let g:tagbar_type_make = {
        \ 'kinds':[
        \ 'm:macros',
        \ 't:targets'
        \ ]
        \}
    " fix your ~/.ctags https://gist.github.com/dracorp/5d7308b894c1c9f301bc9cb8d2f262db
    let g:tagbar_type_sh = {
        \ 'kinds':[
        \ 'f:functions',
        \ 'c:constants',
        \ 'v:variables'
        \ ]
        \}
    let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
        \ ]
        \ }
endif
" }}}
" tagList {{{2
if plugin#isEnabled('taglist.vim')
    noremap <silent> <F11>       :TlistToggle<CR>
    inoremap <silent> <F11>  <C-C>:TlistToggle<CR>
    let tlist_perl_settings = 'perl;c:constants;f:formats;l:labels;p:packages;s:subroutines;d:subroutines;o:POD;k:comments'
    " fix your ~/.ctags https://gist.github.com/dracorp/5d7308b894c1c9f301bc9cb8d2f262db
    let tlist_sh_settings   = 'sh;f:functions;v:variables;c:constants'
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
    " show function/method prototypes in the list
    let Tlist_Display_Prototype=1
    " don't show scope info
    let Tlist_Display_Tag_Scope=1
    " show TagList window on the left
    let Tlist_Use_Left_Window=1
endif
" }}}
" the_silver_searcher|ag {{{2
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor
endif
" }}}
" ultisnips {{{2
if plugin#isEnabled('ultisnips')
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"    let g:UltiSnipsExpandTrigger="<tab>"
"    let g:UltiSnipsJumpForwardTrigger="<c-b>"
"    let g:UltiSnipsJumpBackwardTrigger="<c-z>"
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
endif
" }}}
" undotree {{{2
if plugin#isEnabled('undotree')
    nnoremap <F5> :UndotreeToggle<cr>
endif
"}}}
" vbookmark {{{2
if plugin#isEnabled('vbookmark')
    let g:vbookmark_bookmarkSaveFile = $HOME . '/.vimbookmark'
endif
" }}}
" vim-airline {{{2
if plugin#isEnabled('vim-airline')
    let g:airline_powerline_fonts = 1
    let g:airline_theme           = 'luna'
    let g:airline_section_c       = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
    " vim-airline's extensions
    let g:airline#extensions#tabline#enabled      = 1
    let g:airline#extensions#tabline#left_sep     = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#wordcount#enabled    = 1   "Show word count
endif
"}}}
" vim-buftabline {{{2
if plugin#isEnabled('vim-buftabline')
    nnoremap <C-N> :bnext<CR>
    nnoremap <C-P> :bprev<CR>
endif
" }}}
" vim-colors-solarized {{{2
if plugin#isEnabled('vim-colors-solarized')
    let g:solarized_termcolors = 256
    let g:solarized_underline  = 0                     "default value is 1
    let g:solarized_italic     = 0                        "default value is 1
    let g:solarized_termcolors = 256                  "default value is 16
endif
" }}}
" vim-cpp-enhanced-highlight {{{2
if plugin#isEnabled('vim-cpp-enhanced-highlight')
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    let g:cpp_experimental_simple_template_highlight = 1
    let g:cpp_experimental_template_highlight = 1
    let g:cpp_concepts_highlight = 1
    let g:cpp_no_function_highlight = 1
endif
"}}}
" vim-easy-align {{{2
if plugin#isEnabled('vim-easy-align')
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    "xmap ga <Plug>(EasyAlign)
    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    "nmap ga <Plug>(EasyAlign)
endif
" }}}
" vim-go {{{2
if plugin#isEnabled('vim-go')
    let g:go_fmt_command = "goimports"
    let g:go_autodetect_gopath = 1
    let g:go_list_type = "quickfix"
    let g:go_highlight_types = 1
    let g:go_highlight_fields = 1
    let g:go_highlight_functions = 1
    let g:go_highlight_function_calls = 1
    let g:go_highlight_extra_types = 1
    let g:go_highlight_generate_tags = 1
endif
"}}}2
" vim-javacomplete2 {{{2
if plugin#isEnabled('vim-javacomplete2')
    autocmd FileType java set omnifunc=javacomplete#Complete
    autocmd FileType java nnoremap <F4> call javacomplete#AddImport()<cr>
endif
" }}}
" vim-jsbeautify {{{2
if plugin#isEnabled('vim-jsbeautify')
    autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
    " for html
    autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
    " for css or scss
    autocmd FileType css,scss noremap <buffer> <c-f> :call CSSBeautify()<cr>
    "react settings
    let g:jsx_ext_required = 0
endif
"}}}
"vim-markdown-preview {{{2
if plugin#isEnabled('vim-markdown-preview')
    let vim_markdown_preview_browser='Firefox'
"    let vim_markdown_preview_perl=1
"    let vim_markdown_preview_pandoc=1
endif
"}}}
" vim-session {{{2
if plugin#isEnabled('vim-session')
    let g:session_autosave = 'yes'
    let g:session_autoload = 'no'
    let g:session_directory = vimrc_dir . 'sessions'
    let g:session_autosave_periodic = '5'
endif
" }}}
" vim-shell {{{2
if plugin#isEnabled('vim-shell')
    let g:shell_mappings_enabled=0
endif
" }}}
" vim-support {{{2
if plugin#isEnabled('vim-support')
    if g:UNICODE
        let g:Vim_LocalTemplateFile = vimrc_dir . 'templates/vim-support/templates/Templates'
    endif
    let g:Vim_CreateMapsForHelp = 'yes'
endif
"}}}
" vim-toggle {{{2
if plugin#isEnabled('vim-toggle')
    imap <C-T>:call Toggle()<CR>
    nmap <C-T>:call Toggle()<CR>
    vmap <C-T> <ESC>:call Toggle()<CR>
endif
"}}}
" xml_completion {{{2
if plugin#isEnabled('xml_completion')
    let g:xmlSubelements = "yes"
endif
" }}}
" yaifa {{{2
if plugin#isEnabled('yaifa')
    let yaifa_max_lines = 512
endif
"}}}
" Higher priority
"}}}

" Editing behaviour {{{
behave xterm                                    " Set behaviour for mouse and selection, affect on selectmode mousemodel keymodel selection
set mousehide                                   " Hide the mouse when typing text
set mouse=v                                     " enable using the mouse if terminal emulator supports it (xterm does)
"set ttymouse=xterm2                             " Indicate terminal type for mouse codes
set showmode                                    " always show what mode we're currently editing in
set wrap                                        " wrap lines

" indention & Tabs
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

set nonumber                                    " show line numbers
set showmatch                                   " set show matching parenthesis
set ignorecase                                  " ignore case when searching
set smartcase                                   " ignore case if search pattern is all lowercase, case-sensitive otherwise
set virtualedit=                                " allow the cursor to go in to 'invalid' places
"set gdefault                                    " search/replace 'globally' (on a line) by default
set nojoinspaces                                " do not insert 2 spaces after .?! when join lines <J>

" display end of lines, TAB, spaces on the end of line, before and after wrap row
" eol, tab, trail, extends, precedes, strings to use in 'list' mode
set nolist                                      " don't show invisible characters by default, but it is enabled for some file types (see later)

set textwidth=79                                 " maximum width of text that is being inserted
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

set shortmess+=I                                " hide the launch screen
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

" }}}

" Various settings {{{
filetype on
filetype plugin on
filetype plugin indent on

set sessionoptions+=tabpages,globals

if !plugin#isEnabled('vim-sensible')
    set autoread                                " read open files again when changed outside Vim
    set scrolloff=4                             " keep 4 lines off the edges of the screen when scrolling
    set backspace=indent,eol,start              " allow backspacing over everything in insert mode
    set incsearch                               " show search matches as you type
    set listchars=tab:>-,eol:$,trail:-,nbsp:%
    set complete-=i                             " do not scan current and included files, on slow machines
"    set nrformats=                              " make <C-a> and <C-x> play well with zero-padded numbers (i.e. don't consider them octal or hex)
    set laststatus=2                            " tell VIM to always put a status line in, even if there is only one window
    set ruler                                   " show the cursor position all the time
    set history=1000                            " remember more commands and search history
endif

set linebreak
set wrapscan                                    " searches wrap around the end of file
set autowrite                                   " write a modified buffer on each :next , ...
" backspace, space, <left>, <right>
set whichwrap=b,s,<,>,[,],h,l                   " which keys move the cursor to previous/next line when the cursor is on the first/last character
set browsedir=current                           " which directory to use for the file browser
set complete+=k                                 " scan the files given with the 'dictionary' option

" export: print or to html
set printoptions=left:8pc,right:3pc             " print options
let g:html_use_css=1
let g:use_xhtml=1000

set display+=lastline                           " show last line even it does not fit
"set colorcolumn=+1
set showbreak=+\                                " show wraped lines as

set modeline                                    " search for additional vim commands in n-th first lines(see modelines)
set ttyfast                                     " always use a fast terminal

set splitbelow                                  " command :sp put a new window below the active
set splitright                                  " command :vs put a new windows on right side of active
set infercase
set tildeop                                     " Tylde(~) behaves like operator
set iskeyword+=-                                " which char make a word
" open file under cursor with env variable
set isfname+={,}                                " where the file name starts and ends
" open file under cursor for entry: VARIABLE=path
set isfname-==
" [Bash-it](https://github.com/Bash-it/) settings
if !empty($BASH_IT)
    set path+=$BASH_IT
endif
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
au FileType sh let g:sh_fold_enabled=5
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax
" }}}

" Editor layout {{{
set fileformats=unix,dos,mac    " Prefer Unix over Windows over OS 9 formats

set lazyredraw                  " don't update the display while executing macros

set cmdheight=1                 " use a status bar that is 1 rows high
set fileencodings=ucs-bom,utf-8,default,cp1250,iso8859-2,iso8859-15,iso8859-1,ucs-bom,utf-16le
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
set spell spelllang=pl,en

set hidden                      " hide buffers instead of closing them this
                                " means that the current buffer can be put
                                " to background without being written; and
                                " that marks and undo history are preserved
set switchbuf=useopen           " reveal already opened files from the
                                " quickfix window instead of opening new
                                " buffers
set undolevels=1000                             " use many muchos levels of undo
if has('persistent_undo')
    set undoreload=10000                        " maximum number lines to save for undo on a buffer reload
    set undofile                                " keep a persistent backup file
    let &undodir=vimrc_dir . '.undodir'
endif
let &backupdir=vimrc_dir . '.backupdir,~/tmp,/tmp'

set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
set autochdir                   " automatically switch the working directory to that of the file being edited
set directory=.,~/tmp           " store swap files in one of these directories (in case swapfile is ever turned on)
set viminfo='20,\"80            " read/write a .viminfo file, don't store more
                                " than 80 lines of registers
set wildmenu                    " make tab completion for files/buffers act like bash
"set wildmode=longest,list
set wildmode=list:longest,full  " show a list when pressing tab and complete
set wildignore=*.bak,*.o,*.e,*~,*.swp,*.bak,*.pyc,*.class,*.so,*.pyo,*.zip
set title                       " change the terminal's title
set noerrorbells                " don't beep
set novisualbell
set t_vb=
set t_ti= t_te=                 " put terminal in 'termcap' mode
set showcmd                     " show (partial) command in the last line of the screen
                                " this also shows visual selection info
" }}}

" View {{{
" more colors
if &term =~ "xterm"
    if has("terminfo")
        set t_Co=256
        set t_Sf="\<Esc>[3%p1%dm"
        set t_Sb="\<Esc>[4%p1%dm"
    else
        set t_Co=256
        set t_Sf="\<Esc>[3%dm"
        set t_Sb="\<Esc>[4%dm"
    endif
endif

if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

let c_comment_strings=1                         " highlight strings inside C comments
"}}}

" Filetype specific handling {{{
" only do this part when compiled with support for autocommands
if has("autocmd")

    augroup change_dir "{{{
        au!
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

    augroup vim_files "{{{
        au!

        " Bind <F1> to show the keyword under cursor
        " general help can still be entered manually, with :h
        autocmd FileType vim noremap <buffer> <F1> <Esc>:help <C-r><C-w><CR>
        autocmd FileType vim noremap! <buffer> <F1> <Esc>:help <C-r><C-w><CR>
"        autocmd FileType vim nnoremap <buffer> <F12> :source %<CR>
    augroup end "}}}

    augroup awk_files " {{{
        au!
        autocmd FileType awk nnoremap <buffer> <F12> :!gawk -f %<CR>
    augroup end " }}}

    augroup xdefaults_files " {{{
        au!
        autocmd FileType xdefaults nnoremap <buffer> <F12> :!xrdb -load %<CR>
        augroup end " }}}

    augroup xmodmap_files " {{{
        au!
        autocmd FileType xmodmap nnoremap <buffer> <F12> :!xmodmap %<CR>
        augroup end " }}}

    augroup css_files "{{{
        au!

        autocmd FileType css,less setlocal foldmethod=marker foldmarker={,}
    augroup end "}}}

    augroup xml_files "{{{
        au!
        "!xmllint --nout --schema sci.xsd %
    augroup end "}}}

    augroup go "{{{
    autocmd!

    " Show by default 4 spaces for a tab
    autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

    " :GoBuild and :GoTestCompile
    autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

    " :GoTest
    autocmd FileType go nmap <leader>t  <Plug>(go-test)

    " :GoRun
    autocmd FileType go nmap <leader>r  <Plug>(go-run)

    " :GoDoc
    autocmd FileType go nmap <Leader>d <Plug>(go-doc)

    " :GoCoverageToggle
    autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)

    " :GoInfo
    autocmd FileType go nmap <Leader>i <Plug>(go-info)

    " :GoMetaLinter
    autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

    " :GoDef but opens in a vertical split
    autocmd FileType go nmap <Leader>v <Plug>(go-def-vertical)
    " :GoDef but opens in a horizontal split
    autocmd FileType go nmap <Leader>s <Plug>(go-def-split)

    " :GoAlternate  commands :A, :AV, :AS and :AT
    autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
    autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
    autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
    autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
    augroup end "}}}

endif
" }}}

" gui/gvim {{{
if g:MSWIN64 && has("gui_running")
    au GUIEnter * simalt ~x
endif

if has("gui_running")
    set mousehide                               " Hide the mouse when typing text
    set mouse=a                                 " normal(n) + visual(v) + insert(i) + comman line(c)
                                                " help(h) - all previous when editing help files
                                                " a - all previous
    set guioptions+=m                           " menu bar
    set guioptions+=g                           " grey menu items
    set guioptions+=t                           " include tearoff menu items
    set guioptions-=e                           " Add tab pages when indicated with 'showtabline'
    set guioptions-=T                           " exclude Toolbar
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
        set guifont=Hack\ 11
        " from https://github.com/powerline/fonts.git
    endif
endif
" }}}

" Functions {{{
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
let g:last_fold_column_width = 4                " Pick a sane default for the foldcolumn
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
function! CheckReadonly() "{{{
" Do not allow on any modifications read only files
    if version >= 600
        if &readonly
            setlocal nomodifiable
        endif
    endif
endfunction
"}}}
function! ChangeFileencoding() "{{{
    let encodings = ['cp1250','utf-8','iso8859-2','iso8859-1','iso8859-15']
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
" Display man page for the file. The functions uses manpageview plugin.
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
    " mark whole
    exec 'normal ggVG'
    " copy whole
    exec 'normal "+y'
endf
"}}}
function! MyFoldText() "{{{
    " http://vim.wikia.com/wiki/Customize_text_for_closed_folds
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
set foldtext=MyFoldText()
"}}}
function! s:set_all(option, val, ...) abort "{{{
" How to apply a setting in all open tabs and windows?
" https://vi.stackexchange.com/questions/12061/how-to-apply-a-setting-in-all-open-tabs-and-windows
  let val = eval(a:val)

  for t in range(1, tabpagenr('$'))
    for w in range(1, tabpagewinnr(t, '$'))
      if gettabwinvar(t, w, '&buftype') !=# ''
        continue
      endif
      call settabwinvar(t, w, '&'.a:option, val)
    endfor
  endfor
endfunction
command! -complete=option -nargs=+ SetAll call s:set_all(<f-args>)
"}}}
function! DoFormatXML() range "{{{
    " Save the file type
    let l:origft = &ft

    " Clean the file type
    set ft=

    " Add fake initial tag (so we can process multiple top-level elements)
    exe ":let l:beforeFirstLine=" . a:firstline . "-1"
    if l:beforeFirstLine < 0
        let l:beforeFirstLine=0
    endif
    exe a:lastline . "put ='</PrettyXML>'"
    exe l:beforeFirstLine . "put ='<PrettyXML>'"
    exe ":let l:newLastLine=" . a:lastline . "+2"
    if l:newLastLine > line('$')
        let l:newLastLine=line('$')
    endif

    " Remove XML header
    exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"

    " Recalculate last line of the edited code
    let l:newLastLine=search('</PrettyXML>')

    " Execute external formatter
    exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"

    " Recalculate first and last lines of the edited code
    let l:newFirstLine=search('<PrettyXML>')
    let l:newLastLine=search('</PrettyXML>')

    " Get inner range
    let l:innerFirstLine=l:newFirstLine+1
    let l:innerLastLine=l:newLastLine-1

    " Remove extra unnecessary indentation
    exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"

    " Remove fake tag
    exe l:newLastLine . "d"
    exe l:newFirstLine . "d"

    " Put the cursor at the first line of the edited code
    exe ":" . l:newFirstLine

    " Restore the file type
    exe "set ft=" . l:origft
endfunction
command! -range=% FormatXML <line1>,<line2>call DoFormatXML()

nmap <silent> <leader>x :%FormatXML<CR>
vmap <silent> <leader>x :FormatXML<CR>
"}}}
function! RemoveDiacritics(...) "{{{
    if a:0 == 0
        let s:locale='pl'
    else
        let s:locale=a:1
    endif
    if s:locale == 'pl'
        %s/[ąĄćĆęĘłŁńŃóÓśŚźŹżŻ]/
            \\={'ą':'a','Ą':'A','ć':'c','Ć':'C','ę':'e','Ę':'E','ł':'l','Ł':'L','ń':'n','Ń':'N','ó':'o','Ó':'O','ś':'s','Ś':'S','ź':'z','Ź':'Z','ż':'z','Ż':'Z'}
            \[submatch(0)]/g
    endif
endfunction "}}}

" build_go_files is a custom function that builds or compiles the test file.
" It calls :GoBuild if its a Go file, or :GoTestCompile if it's a test file
function! s:build_go_files()
let l:file = expand('%')
if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
endif
endfunction

if filereadable(vimrc_dir . "functions.vim")
    execute ":source" vimrc_dir . "functions.vim"
endif

" Commands for functions {{{2
command! -nargs=0 RemoveDiacritics call RemoveDiacratics()

" Mapping for functions {{{2
nnoremap <leader>q :call <SID>QuickfixToggle()<cr>
nnoremap <leader>f :call FoldColumnToggle()<cr>
"noremap  <silent> <F8>         :call ChangeFileencoding()<CR>
noremap     <silent>    <F1>    :call DisplayManpage()<CR>
" }}}2
" }}}

" Commands {{{
command! -nargs=0 Trim :%s/\s\+$//
" }}}

" Mappings {{{
" !         make a switch from a key
" <CR>      it's enter
" <c-o>     allows in 'insert' mode insert a command
" <silent>  a mapping will not be echoed on the command line
" %         actual file, :he expand
" <leader>  default \

" TAB and Shift-TAB in normal mode cycle buffers
"nmap <Tab> :bn<CR>
"nmap <S-Tab> :bp<CR>

" Leader {{{2
" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" Toggle line numbers
nnoremap <leader>n :setlocal number!<cr>

" highlight line under cursor, horizontal cursor
nnoremap <Leader>l :setlocal cursorline!<CR>
nnoremap <Leader>L :setlocal cursorcolumn!<CR>

nnoremap <leader>; ;

" Quickly close the current window
"nnoremap <leader>q :q<CR>

" Sort paragraphs
vnoremap <leader>s !sort -f<CR>gv
nnoremap <leader>s vip!sort -f<CR><Esc>

nnoremap <Leader>h :set hlsearch!<CR>

" Quote words under cursor
nnoremap <leader>" viW<esc>a"<esc>gvo<esc>i"<esc>gvo<esc>3l
nnoremap <leader>' viW<esc>a'<esc>gvo<esc>i'<esc>gvo<esc>3l
" }}}

" change search mapping and don't jump
nnoremap * g#``
nnoremap # g*``
nnoremap g* #``
nnoremap g# *``

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Function keys
" refresh syntax highlight
 noremap <silent> <F10> <Esc>:syntax sync fromstart<CR>
inoremap <silent> <F10> <C-o>:syntax sync fromstart<CR>

" Permanent 'very magic' mode, see :he pattern
" search, broken history search!
"nnoremap / /\v
"vnoremap / /\v
" substitute
cnoremap %s/ %smagic/
" substitute in visual mode
cnoremap \>s/ \>smagic/
" global
nnoremap :g/ :g/\v
nnoremap :g// :g//

" paste mode, where you can paste mass data
" that won't be autoindented
"set pastetoggle=<S-F6>                         " deprecated: replaced by vim-bracketed-paste plugin

" open file under cursors in a new window (a vertical split)
map <c-w>F :vertical wincmd f<CR>

" Speed up scrolling of the viewport slightly
nnoremap <C-e> 2<C-e>
nnoremap <C-y> 2<C-y>

" C-U in insert/normal mode, to uppercase the word under cursor
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe
" C-L in insert/normal mode, to lowercase the word under cursor
inoremap <c-l> <esc>viwuea
nnoremap <c-l> viwue

" Since I never use the ; key anyway, this is a real optimization for almost
" all Vim commands, as I don't have to press the Shift key to form chords to
" enter ex mode.
nnoremap ; :

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

map zp :setlocal spell!<CR>
imap zP <ESC>:setlocal spell!<CR>i<right>

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

"vnoremap  (  s()<Esc>P<Right>%
"vnoremap  [  s[]<Esc>P<Right>%
"vnoremap  {  s{}<Esc>P<Right>%

" autocomplete quotes (visual and select mode)
"xnoremap  '  s''<Esc>P<Right>
"xnoremap  "  s""<Esc>P<Right>
"xnoremap  `  s``<Esc>P<Right>

" Moving cursor to other windows:
" shift down   : change window focus to lower one (cyclic)
" shift up     : change window focus to upper one (cyclic)
" shift left   : change window focus to one on left
" shift right  : change window focus to one on right
nnoremap <s-down>   <c-w>w
nnoremap <s-up>     <c-w>W
nnoremap <s-left>   <c-w>h
nnoremap <s-right>  <c-w>l

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

" tab pages
nnoremap <c-TAB> :tabnext<cr>
nnoremap <c-s-TAB> :tabprev<cr>

" Use shift-H and shift-L for move to beginning/end
nnoremap H 0
nnoremap L $

"}}}

" Extra user or machine specific settings, not under version control
if filereadable(vimrc_dir . "user.vim")
    execute ":source " . vimrc_dir . "user.vim"
endif

