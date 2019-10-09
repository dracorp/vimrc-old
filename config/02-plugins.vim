" Plugins managed by vim-plug {{{

" Intialize vim-plug, if missing, download it. Based on vim-bootstrap.com {{{2
let vim_plug_path=expand(vimrc_dir . '/autoload/plug.vim')

let vim_plug_just_installed = 0
if !filereadable(vim_plug_path)
    if !executable("curl")
        echoerr "You have to install curl or first install vim-plug yourself!"
        execute "q!"
    endif
    echo "Installing Vim-Plug..."
    echo ""
    silent exec "!\curl -fLo " . vim_plug_path . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    let vim_plug_just_installed = 1
    autocmd VimEnter * PlugInstall
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif
" Obscure hacks done, you can now modify the rest of the .vimrc as you wish :) }}}

" Required: this needs to be here, so vim-plug knows we are declaring the plugins we want to use
call plug#begin(bundle_dir)
" manage vim-plug by itself
Plug 'https://github.com/junegunn/vim-plug'     " Minimalist Vim Plugin Manager

" Rest of the plugins {{{2
Plug 'https://github.com/tpope/vim-sensible'                       " Defaults everyone can agree on
Plug 'https://github.com/scrooloose/nerdtree'   " A tree explorer plugin for vim
Plug 'https://github.com/scrooloose/nerdcommenter' " Vim plugin for intensely orgasmic commenting
Plug 'https://github.com/tyok/nerdtree-ack'                        " NERDtree + ack.vim
Plug 'https://github.com/jistr/vim-nerdtree-tabs'
if g:UNICODE
    Plug 'https://github.com/scrooloose/nerdtree-git-plugin'       " A plugin of NERDTree showing git status
endif
if !g:MSWIN
    Plug 'https://github.com/editorconfig/editorconfig-vim' " EditorConfig plugin
endif
Plug 'https://github.com/arielrossanigo/dir-configs-override.vim' "Override vim configs with custom configs files in each dir
Plug 'https://github.com/vim-scripts/vimwiki' " Personal Wiki for Vim
Plug 'https://github.com/ConradIrwin/vim-bracketed-paste'          " Handles bracketed-paste-mode
Plug 'https://github.com/christoomey/vim-system-copy'              " Vim plugin for copying to the system clipboard with text-objects and motions
"Plug 'https://github.com/chrisbra/Recover.vim'                     " A Plugin to show a diff, whenever recovering a buffer
Plug 'https://github.com/vim-scripts/let-modeline.vim'             " Extends the modeline feature to the assignment of variables
if g:MACOS
    Plug '/usr/local/opt/fzf'
    Plug 'https://github.com/junegunn/fzf.vim'
elseif g:UNIX
    if executable('fzf')
        Plug 'https://github.com/junegunn/fzf.vim'
    else
        Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
        Plug 'https://github.com/junegunn/fzf.vim'
    endif
endif

Plug 'https://github.com/mhinz/vim-startify'    " The fancy start screen
Plug 'https://github.com/lilydjwg/colorizer'    " A Vim plugin to colorize all text in the form #rrggbb or #rgb
Plug 'https://github.com/Yggdroot/indentLine'   " A vim plugin to display the indention levels with thin vertical lines

if g:UNICODE
    Plug 'https://github.com/liuchengxu/eleline.vim'      " A tiny elegant statusline for vim
else
    Plug 'https://github.com/itchyny/lightline.vim'       " A light and configurable statusline/tabline plugin for Vim
endif
Plug 'https://github.com/AndrewRadev/splitjoin.vim'       " A vim plugin that simplifies the transition between multiline and single-line code
Plug 'https://github.com/rstacruz/vim-closer'             " Closes brackets
"Plug 'https://github.com/terryma/vim-smooth-scroll'       " Make scrolling in Vim more pleasant
"Plug 'https://github.com/Shougo/context_filetype.vim' " Context filetype library
"Plug 'https://github.com/chxuan/vim-edit'       " A text edit plugin for vim
Plug 'https://github.com/haya14busa/incsearch.vim' " Improved incremental searching
"Plug 'https://github.com/chxuan/vim-buffer'     " A buffer operate plugin

" Programming Languages {{{2
" A Vim plugin for Prettier
" By default it will auto format javascript, typescript, less, scss, css, json, graphql and markdown files if they have/support the "@format" pragma annotation in the header of the file.
Plug 'https://github.com/prettier/vim-prettier', { 'do': 'npm install' }
Plug 'https://github.com/hashivim/vim-terraform' " basic vim/terraform integration http://hashivim.github.io/vim-terraform

" c++, c {{{3
"Plug 'https://github.com/jiangxincode/mpi.vim'        " A Vim Plugin for MPI Syntax highlight, matching rules and mappings
"Plug 'https://github.com/vim-scripts/OmniCppComplete' " C/C++ omni-completion with ctags database
"Plug 'https://github.com/vim-scripts/cpp_cppcheck.vim' " Run Cppcheck on the current window
"Plug 'https://github.com/octol/vim-cpp-enhanced-highlight'                 " Additional Vim syntax highlighting for C++ (including C++11/14)
"Plug 'https://github.com/JohnKaul/cpp-devel-vim' " Vim C++ development; This vim script (adopted from kde-devel-vim) is used for C++ development in Vim and offers a few very helpful functions.

" CSS/LESS {{{3
Plug 'https://github.com/ap/vim-css-color' " Preview colours in source code while editing
"Plug 'https://github.com/groenewege/vim-less' " vim syntax for LESS (dynamic CSS)
"Plug 'https://github.com/vitalk/vim-lesscss' " Update corresponding css files on the fly while edit less files
"Plug 'https://github.com/tpope/vim-haml' " Vim runtime files for Haml, Sass, and SCSS

" Go {{{3
if version > 704 || (version == 704 && has('patch330'))
    Plug 'https://github.com/fatih/vim-go' " Go development plugin for Vim https://www.patreon.com/bhcleek
endif
Plug 'https://github.com/nsf/gocode' " An autocompletion daemon for the Go programming language

" HTML {{{3
Plug 'https://github.com/gregsexton/MatchTag' " Vim's MatchParen for HTML tags
Plug 'https://github.com/mattn/emmet-vim' " provides support for expanding abbreviations similar to emmet
Plug 'https://github.com/othree/html5.vim' " HTML5 omnicomplete and syntax
Plug 'https://github.com/alvan/vim-closetag' " Auto close (X)HTML tags

" Java {{{3
"Plug 'https://github.com/vim-scripts/vim-javacomplete2' " Refreshed javacomplete plugin for vim
"Plug 'https://github.com/vim-scripts/VimClojure' " A filetype, syntax and indent plugin for Clojure

" JavaScript {{{3
"Plug 'https://github.com/pangloss/vim-javascript' " Vastly improved Javascript indentation and syntax support in Vim
"Plug 'https://github.com/maksimr/vim-jsbeautify' " vim plugin which formated javascript files by js-beautify
"Plug 'https://github.com/wizicer/vim-jison' " vim syntax highlighting for jison
"Plug 'https://github.com/mxw/vim-jsx' " React JSX syntax highlighting and indenting for vim
"Plug 'https://github.com/Shutnik/jshint2.vim' " Lightweight, customizable and functional Vim plugin for JSHint integration

" Perl {{{3
" Support for Perl 5 and Perl 6 in Vim
Plug 'https://github.com/vim-perl/vim-perl' " Support for Perl 5 and Perl 6 in Vim http://groups.google.com/group/vim-perl
Plug 'https://github.com/vim-scripts/perl_h2xs' " Automate creating perl modules via h2xs
Plug 'https://github.com/nxadm/syntastic-perl6' " Perl 6 support for vim-syntastic
Plug 'https://github.com/vim-scripts/Perldoc.vim' " perldoc command from vim
"Plug 'https://github.com/vim-scripts/perlhelp.vim' " Interface to perldoc | conflict vim perl-support <LocalLeader>pm

" PHP {{{3
Plug 'https://github.com/shawncplus/phpcomplete.vim' " Improved PHP omnicompletion
Plug 'https://github.com/rayburgemeestre/phpfolding.vim'           " Automatic folding of PHP functions, classes,.. (also folds related PhpDoc)

" Python {{{3
if g:PYTHON
    Plug 'https://github.com/davidhalter/jedi-vim'                 " Using the jedi autocompletion library for VIM
    "Plug 'https://github.com/joonty/vdebug'         " Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.
    Plug 'https://github.com/klen/python-mode' " Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box
    Plug 'https://github.com/vim-scripts/python_fold'          " Folding expression for python
    "Plug 'https://github.com/nvie/vim-flake8'       " Flake8 plugin for Vim
    Plug 'https://github.com/jmcantrell/vim-virtualenv'            " Vim plugin for working with python virtualenvs
endif


" XML, XSLT {{{3
Plug 'https://github.com/vim-scripts/xml.vim' " [helps editing xml (and [x]html, sgml, xslt) files](https://github.com/vim-scripts/xml.vim)
Plug 'https://github.com/vim-scripts/xmledit' " A filetype plugin to help edit XML, HTML, and SGML documents
Plug 'https://github.com/vim-scripts/xslt' " XSLT ftplugin

" YAML {{{3
"Plug 'https://github.com/chase/vim-ansible-yaml' " Add additional support for Ansible
Plug 'https://github.com/pearofducks/ansible-vim'                  " A vim plugin for syntax highlighting Ansible's common filetypes
Plug 'https://github.com/andrewstuart/vim-kubernetes' " vim-kubernetes
Plug 'https://github.com/stephpy/vim-yaml'      " Override vim syntax for yaml files

" JSON {{{3
Plug 'https://github.com/elzr/vim-json'                            " A better JSON

" maven {{{3
"Plug 'https://github.com/mikelue/vim-maven-plugin'                 " The Maven plugin for VIM

" Rust
Plug 'https://github.com/rust-lang/rust.vim'    " Plugin that provides Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.

" Git and other VCS {{{2
if executable('git')
    Plug 'https://github.com/int3/vim-extradite'
    Plug 'https://github.com/tpope/vim-fugitive'                   " Git wrapper of all time
    Plug 'https://github.com/junegunn/gv.vim'                      " A git commit browser in Vim
    "Plug 'https://github.com/WolfgangMehner/git-support'           " Git for Vim/gVim
    Plug 'https://github.com/vim-scripts/git-flow-format'          " formats a Git Flow branch name in order to shorten the prefixes, some errors due saving a file
    Plug 'https://github.com/vim-scripts/gitv'                     " gitk for Vim
    Plug 'https://github.com/idanarye/vim-merginal'                " Fugitive extension to manage and merge Git branches
    Plug 'https://github.com/vim-scripts/vim-gitignore'            " Another gitignore plugin for Vim
    Plug 'https://github.com/sjl/splice.vim'                       " managing three-way merges - conflict with vim-fugitive
    if version >= 704
        Plug 'https://github.com/airblade/vim-gitgutter'           " shows a git diff in the 'gutter' (sign column)
    endif
    Plug 'https://github.com/whiteinge/diffconflicts'              " A better Vimdiff Git mergetool
    Plug 'https://github.com/cohama/agit.vim'                      " A powerful Git log viewer
endif

" Themes {{{2
Plug 'https://github.com/xolox/vim-colorscheme-switcher'           " Color scheme switcher for Vim
Plug 'https://github.com/morhetz/gruvbox'                          " Retro groove color scheme for Vim

" Syntax {{{2
Plug 'https://github.com/vim-scripts/nginx.vim'   " highlights configuration files for nginx, the high-performance web server
Plug 'https://github.com/vim-scripts/httplog'                      " Highlight access log of Apache, nginx, etc
Plug 'https://github.com/vim-scripts/LogViewer'                    " Comfortable examination of multiple parallel logfiles
Plug 'https://github.com/vim-scripts/TWiki-Syntax'                 " Syntaxfile for TWiki-Syntax
Plug 'https://github.com/vim-scripts/whitespace-syntax-highlight'  " whitespace syntax highlight
Plug 'https://github.com/vim-scripts/logstash.vim'                 " logstash.vim highlights configuration files for logstash
Plug 'https://github.com/chrisbra/csv.vim'        " A Filetype plugin for csv files
Plug 'https://github.com/sheerun/vim-polyglot'                     " A solid language pack for Vim
Plug 'https://github.com/cakebaker/scss-syntax.vim'
Plug 'https://github.com/hail2u/vim-css3-syntax'
Plug 'https://github.com/vim-scripts/jQuery' " Syntax file for jQuery
Plug 'https://github.com/StanAngeloff/php.vim'     " Up-to-date PHP syntax file (5.3 - 7.1 support)
Plug 'https://github.com/vim-scripts/bats.vim'                     " Syntax highlighting for Bats - Bash Automated Testing System
Plug 'https://github.com/ekalinin/Dockerfile.vim'                  " Vim syntax file & snippets for Docker's Dockerfile
Plug 'https://github.com/skanehira/docker-compose.vim' "Vim plugin wrapping docker-compose
if !has('nvim')
    Plug 'https://github.com/skanehira/docker.vim'  " Manage docker containers and images in Vim
endif
Plug 'https://github.com/vim-scripts/ldif.vim'                     " syntax higlighting for LDIF (LDAP serialization)
Plug 'https://github.com/vim-scripts/ldap_schema.vim--Hahn'        " ldap schmema definition language

" Markdown {{{2
Plug 'https://github.com/plasticboy/vim-markdown'                      " Markdown Vim Mode
Plug 'https://github.com/nelstrom/vim-markdown-folding'                " Fold markdown documents by section
Plug 'https://github.com/suan/vim-instant-markdown', {'do': 'npm -g install instant-markdown-d'} " Instant Markdown previews

" Charles Campbell {{{2
Plug 'https://github.com/powerman/vim-plugin-AnsiEsc'              " ansi escape sequences concealed, but highlighted as specified (conceal)
Plug 'https://github.com/vim-scripts/DrawIt'                       " Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
Plug 'https://github.com/vim-scripts/Decho'                        " internal debugger
Plug 'https://github.com/vim-scripts/gdbmgr'                       " interface to gdb
Plug 'https://github.com/vim-scripts/highlight.vim'                " Highlight lines or patterns of interest in different colors
Plug 'https://github.com/vim-scripts/LargeFile'                    " Edit large files quickly (keywords: large huge speed)
Plug 'https://github.com/vim-scripts/SudoEdit.vim'                 " Edit Files using sudo or su or any other tool
Plug 'https://github.com/vim-scripts/vis'                          " Extended Visual Mode Commands, Substitutes, and Searches
Plug 'https://github.com/vim-scripts/cecutil'                      " save/restore window position, mark position, selected user mapssave/restore window position, mark position, selected user maps

" xolox {{{2
Plug 'https://github.com/xolox/vim-shell'                          " Improved integration between Vim and its environment
Plug 'https://github.com/xolox/vim-misc'                           " Miscellaneous auto-load Vim scripts
Plug 'https://github.com/xolox/vim-reload'                         " Automatic reloading of Vim scripts
"Plug 'https://github.com/xolox/vim-session'                        " Extended session management for Vim
if g:PYTHON
    Plug 'https://github.com/xolox/vim-tools'                      " Python scripts to publish Vim plug-ins
endif
Plug 'https://github.com/xolox/vim-easytags'                       " Automated tag file generation and syntax highlighting of tags

" Fritz Mehner {{{2
Plug 'https://github.com/vim-scripts/Vim-support'                   " Vim Script IDE for Vim/gVim
Plug 'https://github.com/vim-scripts/awk-support.vim'               " AWK-IDE for Vim/gVim
Plug 'https://github.com/vim-scripts/bash-support.vim'              " BASH IDE -- Write and run BASH-scripts using menus and hotkeys
Plug 'https://github.com/vim-scripts/perl-support.vim'       " Write and run Perl-scripts using menus and hotkeys
Plug 'https://github.com/vim-scripts/c.vim'                   " C/C++ IDE -- Write and run programs. Insert statements, idioms, comments etc
"Plug 'https://github.com/vim-scripts/latex-support.vim' " LaTeX-IDE for Vim/gVim
"Plug 'https://github.com/vim-scripts/doxygen-support.vim'        " Generate Doxygen comments from user defined templates
"Plug 'https://github.com/WolfgangMehner/Vim-Mapathon'                              " My talk for Vimfest 2017 - An advanced introduction to maps

" Others {{{2
Plug 'https://github.com/vim-scripts/matchit.zip'                  " extended % matching for HTML, LaTeX, and many other languages
if version >= 704
    Plug 'https://github.com/vim-scripts/EnhancedDiff'             " A Vim plugin for creating better diffs
endif
Plug 'https://github.com/vim-scripts/closetag.vim'                 " Functions and mappings to close open HTML/XML tags
Plug 'https://github.com/tyru/open-browser.vim'                    " Open URI with your favorite browser from your most favorite editor
Plug 'https://github.com/jlemetay/permut'                          " swap columns of text separated by arbitrary characters
Plug 'https://github.com/godlygeek/tabular'                        " Vim script for text filtering and alignment
Plug 'https://github.com/AndrewRadev/switch.vim'                   " switch segments of text with predefined replacements
if version > 700
    Plug 'https://github.com/scrooloose/syntastic'                 " Syntax checking hacks for vim
    Plug 'https://github.com/roktas/syntastic-more'
    Plug 'https://github.com/myint/syntastic-extras'
endif
"Plug 'https://github.com/maralla/validator.vim'                    " Check syntax on the fly asynchronously
Plug 'https://github.com/majutsushi/tagbar'                        " Vim plugin that displays tags in a window, ordered by scope
Plug 'https://github.com/vim-scripts/Tabmerge'                     " Merge a tab's windows with the current tab
Plug 'https://github.com/vim-scripts/taglist.vim'                  " Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
Plug 'https://github.com/vim-scripts/Toggle'                       " allows you to toggle bool (true/false) and other words with a shortcut
if version > 703 || (version == 703 && has('patch005'))
"    Plug 'https://github.com/mbbill/undotree'                      " The ultimate undo history visualizer for VIM
endif
if version > 703 && g:PYTHON
    Plug 'https://github.com/simnalamburt/vim-mundo'                   " Vim undo tree visualizer
endif
Plug 'https://github.com/tpope/vim-repeat'                         " repeat.vim: enable repeating supported plugin maps with "."
Plug 'https://github.com/tpope/vim-scriptease'                     " A Vim plugin for Vim plugins
Plug 'https://github.com/tpope/vim-surround'                       " quoting/parenthesizing made simple
if version >= 703
    Plug 'https://github.com/ap/vim-buftabline'                    " Forget Vim tabs - now you can have buffer tabs
endif
"Plug 'https://github.com/vim-scripts/tskeleton'                    " File Templates and Code Skeletons/Snippets
if g:UNIX && g:UNICODE
"    Plug 'https://github.com/ryanoasis/vim-devicons'               " adds font icons breaks NerdTree
endif
Plug 'https://github.com/chip/vim-fat-finger'                      " Simple vim plugin for common misspellings and typos
Plug 'https://github.com/sedm0784/vim-you-autocorrect'             " Why should smartphones get all the fun?
Plug 'https://github.com/zirrostig/vim-schlepp'                    " easily moving text selections around
Plug 'https://github.com/jiangxincode/TagCollection'               " Some tags used by the OmniCppComplete which can auto complete your code
Plug 'https://github.com/nathanaelkane/vim-indent-guides'          " displaying indent levels in code
Plug 'https://github.com/terryma/vim-expand-region'                " Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination
Plug 'https://github.com/Konfekt/FastFold'                         " Speed up Vim by updating folds only when called-for
Plug 'https://github.com/will133/vim-dirdiff'                      " Vim plugin to diff two directories
" Table Mode for instant table creation
Plug 'https://github.com/dhruvasagar/vim-table-mode',{'on':'TableModeEnable'} " map conflict with bash-support
Plug 'https://github.com/brooth/far.vim'                           " Find And Replace
if has('python3')
    Plug 'https://github.com/soywod/kronos.vim'                    " A simple task and time manager for vim
endif
" 3rd party tools {{{2
if executable('python')
    Plug 'https://github.com/vim-scripts/betterga'                 " betterga can get more information than ga (:ascii)
endif
Plug 'https://github.com/ggreer/the_silver_searcher'               " A code-searching tool similar to ack, but faster
Plug 'https://github.com/vim-scripts/ctrlsf.vim'                   " an ack/ag powered global code search and view tool
Plug 'https://github.com/rking/ag.vim'                             " Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'
Plug 'https://github.com/mileszs/ack.vim'                      " Vim plugin for the Perl module / CLI script 'ack'
Plug 'https://github.com/Shougo/vimshell.vim'                      " Powerful shell implemented by vim
Plug 'https://github.com/VincentCordobes/vim-translate'            " A tiny translate-shell wrapper for Vim
Plug 'https://github.com/rizzatti/dash.vim'                        " Search Dash.app from Vim
Plug 'https://github.com/Lenovsky/nuake'                           " A Quake-style terminal panel
Plug 'https://github.com/liuchengxu/vista.vim' 					   " Viewer & Finder for LSP symbols and tags http://liuchengxu.org/vista.vim
" ctrl-a
"Plug 'https://github.com/tpope/vim-speeddating'                    " use CTRL-A/CTRL-X to increment dates, times, and more
Plug 'https://github.com/vim-scripts/visual-increment'                         " Use CTRL+A/X to create increasing sequence of numbers or letters via visual mode
"Plug 'https://github.com/vim-scripts/monday'                                   " Lets you use ctrl-a and ctrl-x on names of months and weekdays

" Completion {{{2
" Use neocomplete or neocomplcache or supertab
"if ( version > 800 )
    " Do not install via vim-plug, install it manually
    " A code-completion engine
"    execute 'Plug \"' . bundle_dir . '/YouCompleteMe\"'
"    [Dark powered asynchronous completion framework for neovim/Vim8](https://github.com/Shougo/deoplete.nvim)
"    if has('nvim')
"        Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
"    else
"        Plug 'https://github.com/Shougo/deoplete.nvim'
"        Plug 'https://github.com/roxma/nvim-yarp'
"        Plug 'https://github.com/roxma/vim-hug-neovim-rpc'
"    endif
"else
    Plug 'https://github.com/ervandew/supertab'                    " Perform all your vim insert mode completions with Tab
"endif
if !g:MSWIN
    " add to the env variable PATH ~/.vim/bin
    Plug 'https://github.com/c9s/perlomni.vim',{'do':'make install'} " perl omnicompletion for vim (including base class function compleltions .. etc)
endif
" }}}
" Snippets {{{2
if g:PYTHON
    " TAB conflict with other completion tools
"    Plug 'https://github.com/SirVer/ultisnips'                 " The ultimate snippet solution for Vim
endif
" Snippets for neocomplcache, neocomplete
Plug 'https://github.com/Shougo/neosnippet.vim'                    " Shougo/neosnippet
Plug 'https://github.com/Shougo/neosnippet-snippets'               " The standard snippets repository for neosnippet
Plug 'https://github.com/honza/vim-snippets'                       " snippets files for various programming languages
"Plug 'https://github.com/garbas/vim-snipmate'                      " snipMate.vim aims to be a concise vim script that implements some of TextMate's snippets features
"    Plug 'https://github.com/vim-scripts/tlib'                     " Some utility functions
"    Plug 'https://github.com/marcweber/vim-addon-mw-utils'         " interpret a file by function and cache file automatically
" }}}
" UNIX only {{{2
if g:UNIX
    Plug 'https://github.com/dracorp/vim-pkgbuild'
endif

" MS Windows only {{{2
if g:MSWIN
    Plug 'https://github.com/vim-scripts/poshcomplete-vim'                       " Omni Completion for PowerShell
    Plug 'https://github.com/vim-scripts/Windows-PowerShell-Syntax-Plugin'       " Default syntax coloring for Windows PowerShell
    Plug 'https://github.com/vim-scripts/Windows-PowerShell-Indent-File'         " [Simple indenting rules for Windows PowerShell](https://github.com/vim-scripts/Windows-PowerShell-Indent-File
"    Plug 'https://github.com/mattn/webapi-vim'                       " vim interface to Web API
endif
if g:MSWIN && !g:MSWIN64
    Plug 'https://github.com/vim-scripts/maximize.dll'
endif

" Some offline plugins {{{2
" [A file templates](https://sites.google.com/site/abudden/contents/Vim-Scripts/file-templates)
execute 'Plug \"' . bundle_dir . '/file_templates\"'
" [shows current function name in status line](http://www.drchip.org/astronaut/vim/index.html#STLSHOWFUNC)
execute 'Plug \"' . bundle_dir . '/StlShowFunc\"'
execute 'Plug \"' . bundle_dir . '/manpageview\"'
" [A code-completion engine](https://github.com/Valloric/YouCompleteMe)
execute 'Plug \"' . bundle_dir . 'YouCompleteMe\"'
" Language & Grammar {{{2
Plug 'https://github.com/rhysd/vim-grammarous'                     " A powerful grammar checker for Vim using LanguageTool
"}}}
" end of vim-plug's plugins management
call plug#end()
delc PlugUpgrade
"}}}
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
    if g:UNIX
        let g:C_LocalTemplateFile = vimrc_dir . 'templates/c-support/templates/Templates'
    endif
endif
" }}}
" delimitMate {{{2
if plugin#isEnabled('delimitMate')
    let delimitMate_expand_cr = 1
endif
" }}}
" deoplete {{{2
if plugin#isEnabled('deoplete.nvim')
	" Use deoplete.
    let g:deoplete#enable_at_startup = 1
	" Use smartcase.
	call deoplete#custom#option('smart_case', v:true)
    call deoplete#custom#option({
        \ 'auto_complete_delay': 200,
        \ 'smart_case': v:true,
        \ })
    inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
endif
"
" doxygen-support {{{2
if plugin#isEnabled('doxygen-support.vim')
    let g:Doxy_LocalTemplateFile = vimrc_dir . 'templates/doxygen-support/templates/doxygen.templates'
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
    let g:easytags_suppress_ctags_warning = 1
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
" fzf {{{2
if plugin#isEnabled('fzf.vim')
    nnoremap <silent> <leader>e :FZF -m<CR>
    "Recovery commands from history through FZF
    nmap <leader>y :History:<CR>
endif
" }}}
" fugitive {{{2
if plugin#isEnabled('vim-fugitive')
  set statusline+=%{fugitive#statusline()}
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
    silent! colorscheme gruvbox
    set background=dark
    if !exists("g:lightline")
        let g:lightline = {}
    endif
    let g:lightline.colorscheme='gruvbox'
endif
" }}}
" incsearch.vim {{{2
if plugin#isEnabled('incsearch.vim')
    map /  <Plug>(incsearch-forward)
    map ?  <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
endif
" }}}
" indentLine {{{2
if plugin#isEnabled('indentLine')
  let g:indentLine_enabled = 1
  let g:indentLine_concealcursor = 0
  let g:indentLine_char = '┆'
  let g:indentLine_faster = 1
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
" neosnippet {{{2
if plugin#isEnabled('neosnippet')
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
    " Enable snipMate compatibility feature.
    let g:neosnippet#enable_snipmate_compatibility = 1

    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

    " SuperTab like snippets behavior.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <expr><TAB>
     \ pumvisible() ? "\<C-n>" :
     \ neosnippet#expandable_or_jumpable() ?
     \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

    " For conceal markers.
    if has('conceal')
        set conceallevel=2 concealcursor=niv
    endif
endif
" }}}

" nerdcommenter {{{2
if plugin#isEnabled('nerdcommenter')
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Align line-wise comment delimiters flush left instead of following code indentation
    let g:NERDDefaultAlign = 'left'
    " Set a language to use its alternate delimiters by default
    let g:NERDAltDelims_java = 1
    " Allow commenting and inverting empty lines (useful when commenting a region)
    let g:NERDCommentEmptyLines = 1
    " Enable trimming of trailing whitespace when uncommenting
    let g:NERDTrimTrailingWhitespace = 1
    " Enable NERDCommenterToggle to check all selected lines is commented or not
    let g:NERDToggleCheckAllLines = 1
endif
" }}}
" nerdtree {{{2
if plugin#isEnabled('nerdtree')
    nnoremap <silent> <F2> :NERDTreeToggle<CR>
    nnoremap <silent> <F3> :NERDTreeFind<CR>
    set timeoutlen=1000
    let g:NERDTreeChDirMode=2
    let g:NERDTreeDirArrows=0
    let NERDTreeShowHidden=1
    let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
    "let NERDTreeIgnore=['\.swp$',]
    let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
    let g:NERDTreeShowBookmarks=1
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
    let g:NERDTreeHighlightFolders = 1
    let g:NERDTreeHighlightFoldersFullName = 1
    "let g:NERDTreeDirArrowExpandable='+'
    "let g:NERDTreeDirArrowCollapsible='~'
    let g:NERDTreeDirArrowExpandable='▷'
    let g:NERDTreeDirArrowCollapsible='▼'
    " close when last
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif
" }}}
" nerdtree-git-plugin {{{2
if plugin#isEnabled('nerdtree-git-plugin')
    let g:NERDTreeIndicatorMapCustom = {
        \ "Modified"  : "✹",
        \ "Staged"    : "✚",
        \ "Untracked" : "✭",
        \ "Renamed"   : "➜",
        \ "Unmerged"  : "═",
        \ "Deleted"   : "✖",
        \ "Dirty"     : "✗",
        \ "Clean"     : "✔︎",
        \ 'Ignored'   : '☒',
        \ "Unknown"   : "?"
        \ }
endif
" }}}
" onehalf {{{2
if plugin#isEnabled('onehalf/vim')
    silent! colorscheme onehalfdark
    let g:airline_theme='onehalfdark'
    if !g:lightline
        let g:lightline = {}
    endif
    let g:lightline.colorscheme='onehalfdark'
endif
" }}}
" open-browser.vim {{{2
if plugin#isEnabled('open-browser.vim')
    let g:netrw_nogx = 1 " disable netrw's gx mapping.
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
    let g:syntastic_yaml_checkers = ['yamllint']
endif
"}}}
" taboo.vim {{{2
if plugin#isEnabled('taboo.vim')
endif
" }}}
" tagbar {{{2
if plugin#isEnabled('tagbar')
    noremap  <silent> <F12>       :TagbarToggle<CR>
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
    noremap <silent> <F10>       :TlistToggle<CR>
    inoremap <silent> <F10>  <C-C>:TlistToggle<CR>
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
    let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger="<tab>"
    let g:UltiSnipsJumpBackwardTrigger="<c-b>"
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

    autocmd BufEnter,BufRead *.html,*.htm UltiSnipsAddFiletypes html.htmldjango
    autocmd BufEnter,BufRead *.rst UltiSnipsAddFiletypes rst.rst
    autocmd BufEnter,BufRead *.py UltiSnipsAddFiletypes python.python

    au BufReadPost *.snippets set filetype=snippets
    autocmd BufEnter,BufRead *.snippets UltiSnipsAddFiletypes snippets.snippets
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
    let g:airline_powerline_fonts     = 1
    let g:airline_theme               = 'luna'
    let g:airline_section_c           = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
    let g:airline_skip_empty_sections = 1
    " vim-airline's extensions
    let g:airline#extensions#tabline#enabled      = 1
    let g:airline#extensions#branch#enabled       = 1
    let g:airline#extensions#tagbar#enabled       = 1
    let g:airline#extensions#tabline#left_sep     = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#wordcount#enabled    = 1   "Show word count
endif
"}}}
" vim-buffer {{{2
if plugin#isEnabled('vim-buffer')
    nnoremap <silent> <c-p> :PreviousBuffer<cr>
    nnoremap <silent> <c-n> :NextBuffer<cr>
    nnoremap <silent> <leader>d :CloseBuffer<cr>
    nnoremap <silent> <leader>D :BufOnly<cr>
endif
" }}}
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
" vim-edit {{{2
if plugin#isEnabled('vim-edit')
    nnoremap Y :CopyText<cr>
    nnoremap D :DeleteText<cr>
    nnoremap C :ChangeText<cr>
    nnoremap <leader>r :ReplaceTo<space>
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
" vim-indent-guides {{{2
if plugin#isEnabled('vim-indent-guides')
    let g:indent_guides_enable_on_vim_startup = 0
endif
" vim-instant-markdown {{{2
if plugin#isEnabled('vim-instant-markdown')
    let g:instant_markdown_mathjax = 1
    let g:instant_markdown_allow_unsafe_content = 1
    let g:instant_markdown_autostart = 0        " :InstantMarkdownPreview
    autocmd FileType markdown noremap <leader>m :InstantMarkdownPreview<cr>
endif
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
" vim-markdown-preview {{{2
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
    let g:session_command_aliases = 1
endif
" }}}
" vim-shell {{{2
if plugin#isEnabled('vim-shell')
    let g:shell_mappings_enabled=0
endif
" }}}
" vim-smooth-scroll {{{2
if plugin#isEnabled('vim-smooth-scroll')
    noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
    noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
    noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
    noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>
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
" vim-terraform {{{2
if plugin#isEnabled('vim-terraform')
    let g:terraform_align=1
    let g:terraform_fold_sections=1
    let g:terraform_fmt_on_save=1
endif
" }}}
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
" vista {{{2
if plugin#isEnabled('vista.vim')
    noremap  <silent> <S-F12>       :Vista!!<CR>
    inoremap <silent> <S-F12>  <C-C>:Vista!!<CR>
    function! NearestMethodOrFunction() abort
        return get(b:, 'vista_nearest_method_or_function', '')
    endfunction

    set statusline+=%{NearestMethodOrFunction()}

    " By default vista.vim never run if you don't call it explicitly.
    " If you want to show the nearest function in your statusline
    " automatically, you can add the following line to your vimrc
    autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
    " Ensure you have installed some decent font to show these pretty symbols,
    " then you can enable icon for the kind.
    let g:vista#renderer#enable_icon = 1
endif
" }}}
" yaifa {{{2
if plugin#isEnabled('yaifa')
    let yaifa_max_lines = 512
endif
"}}}
" YouCompleteMe {{{2
if plugin#isEnabled('YouCompleteMe')
    let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
    let g:ycm_use_ultisnips_completer = 1           " Default 1, just ensure
    let g:ycm_seed_identifiers_with_syntax = 1      " Completion for programming language's keyword
    let g:ycm_complete_in_comments = 1              " Completion in comments
    let g:ycm_complete_in_strings = 1               " Completion in string
    let g:snips_author = 'Piotr Rogoza'
    let g:snips_email = 'piotr.r.public@gmail.com'
    let g:snips_github = 'https://github.com/dracorp'

    let g:ycm_confirm_extra_conf = 0
    let g:ycm_error_symbol = '✗'
    let g:ycm_warning_symbol = '✹'
    let g:ycm_seed_identifiers_with_syntax = 1
    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings = 1
    let g:ycm_python_binary_path = 'python'
    nnoremap <leader>u :YcmCompleter GoToDeclaration<cr>
    nnoremap <leader>o :YcmCompleter GoToInclude<cr>
    nnoremap <leader>ff :YcmCompleter FixIt<cr>
    nmap <F5> :YcmDiags<cr>
endif
" }}}
"}}}

