" Intialize vim-plug, if missing, download it. Based on vim-bootstrap.com {{{
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
"}}}

" vim-plug plugins and their configuration {{{
call plug#begin(bundle_dir)
" manage vim-plug by itself
Plug 'https://github.com/junegunn/vim-plug'     " 🌺 Minimalist Vim Plugin Manager

" Basic plugins
Plug 'https://github.com/tpope/vim-sensible'    " Defaults everyone can agree on

" Generally for Vim itself {{{2
Plug 'https://github.com/dstein64/vim-startuptime' " A Vim plugin for profiling Vim's startup time
Plug 'https://github.com/tpope/vim-scriptease'  " A Vim plugin for Vim plugins
Plug 'https://github.com/mhinz/vim-startify'    " The fancy start screen
Plug 'https://github.com/tpope/vim-commentary'  " comment stuff out
Plug 'https://github.com/scrooloose/nerdtree'   " A tree explorer plugin for vim
Plug 'https://github.com/scrooloose/nerdcommenter' " Vim plugin for intensely orgasmic commenting
Plug 'https://github.com/tpope/vim-abolish' " Work with several variants of a word at once
if !g:MACOS
    Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight'
endif
Plug 'https://github.com/PhilRunninger/nerdtree-buffer-ops' " A plugin for highlighting and closing open buffers while in the NERDTree

if !g:MSWIN
    Plug 'https://github.com/editorconfig/editorconfig-vim' " EditorConfig plugin
endif

" Plug 'https://github.com/arielrossanigo/dir-configs-override.vim' " Override vim configs with custom configs files in each dir
Plug 'https://github.com/vimwiki/vimwiki', { 'branch': 'dev' }                      " Personal Wiki for Vim
" Plug 'https://github.com/michal-h21/vim-zettel' " VimWiki addon for managing notes according to Zettelkasten method
"Plug 'https://github.com/ConradIrwin/vim-bracketed-paste'         " Handles bracketed-paste-mode
"Plug 'https://github.com/christoomey/vim-system-copy'             " Vim plugin for copying to the system clipboard with text-objects and motions
Plug 'https://github.com/vim-scripts/let-modeline.vim'            " Extends the modeline feature to the assignment of variables, broken!
if executable('fzf')
    Plug 'https://github.com/junegunn/fzf'
    Plug 'https://github.com/junegunn/fzf.vim' " fzf ❤️ vim
endif
if g:UNIX
    Plug 'https://github.com/dracorp/vim-pkgbuild' " easy work with ArchLinux PKGBUILD
endif
"Plug 'https://github.com/ctrlpvim/ctrlp.vim'    " Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder. http://ctrlpvim.github.com/ctrlp.vim
"Plug 'https://github.com/tacahiroy/ctrlp-funky' " A super simple function navigator for ctrlp.vim
Plug 'https://github.com/lilydjwg/colorizer'    " A Vim plugin to colorize all text in the form #rrggbb or #rg
" Plug 'https://github.com/chrisbra/Colorizer' "  color hex codes and color names
Plug 'https://github.com/godlygeek/tabular'     " Vim script for text filtering and alignment
Plug 'https://github.com/xolox/vim-misc'               " Miscellaneous auto-load Vim scripts
if executable('ctags')
    Plug 'https://github.com/xolox/vim-easytags'    " Automated tag file generation and syntax highlighting of tags
endif
"Plug 'https://github.com/LucHermitte/lh-vim-lib' " Library of Vim functions
"Plug 'https://github.com/LucHermitte/lh-tags'    " ctags base updating, and browsing from vim
" if g:UNICODE
    " Plug 'https://github.com/liuchengxu/eleline.vim' " A tiny elegant statusline for vim
" else
    Plug 'https://github.com/itchyny/lightline.vim'  " A light and configurable statusline/tabline plugin for Vim
" endif
Plug 'https://github.com/AndrewRadev/splitjoin.vim'    " A vim plugin that simplifies the transition between multiline and single-line code
Plug 'https://github.com/rstacruz/vim-closer'          " Closes brackets
Plug 'https://github.com/haya14busa/incsearch.vim'     " Improved incremental searching
" Plug 'https://github.com/easymotion/vim-easymotion'    " Vim motions on speed!
"Plug 'https://github.com/haya14busa/vim-asterisk'      " asterisk.vim provides improved * motions
Plug 'https://github.com/powerman/vim-plugin-AnsiEsc'  " ansi escape sequences concealed, but highlighted as specified (conceal)
Plug 'https://github.com/vim-scripts/DrawIt'           " Ascii drawing plugin: lines, ellipses, arrows, fills, and more!
Plug 'https://github.com/vim-scripts/LargeFile'        " Edit large files quickly (keywords: large huge speed)
if !g:MACOS
    Plug 'https://github.com/vim-scripts/SudoEdit.vim'     " Edit Files using sudo or su or any other tool
else
    Plug 'https://github.com/lambdalisue/suda.vim' " 🥪 An alternative sudo.vim for Vim and Neovim, limited support sudo in Windows
endif
"Plug 'https://github.com/vim-scripts/restore_view.vim' " A plugin for automatically restoring file's cursor position and folding
Plug 'https://github.com/pbrisbin/vim-restore-cursor' " Restore your cursor position when you (re)open vim
"Plug 'https://github.com/xolox/vim-reload'             " Automatic reloading of Vim scripts
Plug 'https://github.com/matze/vim-move' "Plugin to move lines and selections up and down
Plug 'https://github.com/kshenoy/vim-signature' " Plugin to toggle, display and navigate marks
Plug 'https://github.com/dbeniamine/cheat.sh-vim' " A vim plugin to access cheat.sh sheets
if has('python3')
    Plug 'https://github.com/puremourning/vimspector' " A multi-language debugging system for Vim
endif
" Syntastic check
if version > 700
    " Plug 'https://github.com/scrooloose/syntastic'  " Syntax checking hacks for vim
    " Plug 'https://github.com/dallarosa/syntastic-more'  " More checkers for Vim Syntastic plugin
    " Plug 'https://github.com/myint/syntastic-extras' " Additional Syntastic syntax checkers and features (for Vim)
    "Plug 'https://github.com/nxadm/syntastic-perl6'        " Perl 6 support for vim-syntastic
endif
Plug 'https://github.com/dense-analysis/ale' " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
if ( version >= 800 && has('timers') && has('job') && has('channel') ) || has('nvim')
    " ALE requires NeoVim >= 0.2.0 or Vim 8 with +timers +job +channel
    let g:ale_disable_lsp = 1
    Plug 'https://github.com/dense-analysis/ale' " Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
endif
"Plug 'https://github.com/maralla/validator.vim'                    " Check syntax on the fly asynchronously
" Plug 'https://github.com/osyo-manga/vim-over'   "  :substitute preview
Plug 'https://github.com/bagrat/vim-buffet'     " IDE-like Vim tabline
"Plug 'https://github.com/camspiers/animate.vim' " A Vim Window Animation Library
if has('python3') && has('timers')
"    Plug 'https://github.com/AlphaMycelium/pathfinder.vim' " Vim plugin which gives suggestions to improve your movements
endif
" Plug 'https://github.com/pearofducks/ansible-vim' " A vim plugin for syntax highlighting Ansible's common filetypes
Plug 'https://github.com/phenomenes/ansible-snippets' " Ansible Vim snippets
Plug 'https://github.com/SirVer/ultisnips' " The ultimate snippet solution for Vim
" Plug 'https://github.com/MicahElliott/Rocannon' " Vim for Ansible playbooks: omni-completion, abbreviations, syntax, folding, K-docs, and colorscheme
if version >= 802
    Plug 'https://github.com/skywind3000/vim-quickui' " The missing UI extensions for Vim 8.2 (and NeoVim 0.4) !! 😎
endif
if has('python3') || has('python2')
    Plug 'https://github.com/Chiel92/vim-autoformat' " Provide easy code formatting in Vim by integrating existing code formatters.
endif
" Plug 'https://github.com/Raimondi/delimitMate' " Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
Plug 'https://github.com/chrisbra/unicode.vim' " A Vim plugin that provides a completion function for Unicode glyphs
Plug 'https://github.com/vim-scripts/viewdoc' " Flexible viewer for any documentation (help/man/perldoc/etc.)
" plug 'https://github.com/vim-scripts/sessionman.vim' " Vim session manager
Plug 'https://github.com/xolox/vim-session' " Extended session management for Vim (:mksession on steroids)
Plug 'https://github.com/yegappan/mru' " Most Recently Used (MRU) Vim Plugin
Plug 'https://github.com/vim-scripts/FavMenu.vim' " A new menu, like IE's Favourites, or Netscape's Bookmark
Plug 'https://github.com/vim-scripts/FavEx' " Favorite file and directory explorer
Plug 'https://github.com/coot/EnchantedVim' " Persistent Very Magic Patterns in Vim Commands
Plug 'https://github.com/coot/System' " Vim plugin which gives a nice interface with the os programs
Plug 'https://github.com/coot/CRDispatcher' " A utility Vim plugin used by some of my Vim plugins

" Syntax and programing languages {{{2

if version >= 800
    " vim-polyglot: g:polyglot_disabled should be defined before loading vim-polyglot
    let g:polyglot_disabled = ['csv', 'jenkins', 'yaml']
    Plug 'https://github.com/sheerun/vim-polyglot'                    " A solid language pack for Vim
" vim-polyglot supported language pack {{{ 3
" * acpiasl (syntax)
" * ansible (syntax, indent, ftplugin)
" * apiblueprint (syntax)
" * applescript (syntax, indent)
" * arduino (syntax, indent)
" * asciidoc (syntax)
" * autohotkey (indent)
" * blade (syntax, indent, ftplugin)
" * c++11 (syntax)
" * c/c++ (syntax)
" * caddyfile (syntax, indent, ftplugin)
" * carp (syntax)
" * cjsx (syntax, ftplugin)
" * clojure (syntax, indent, autoload, ftplugin)
" * cmake (syntax, indent)
" * coffee-script (syntax, compiler, indent, autoload, ftplugin)
" * cql (syntax)
" * cryptol (syntax, compiler, ftplugin)
" * crystal (syntax, indent, autoload, ftplugin)
" * csv (syntax, autoload, ftplugin)
" * cucumber (syntax, indent, compiler, ftplugin)
" * cue (syntax)
" * dart (syntax, indent, autoload, ftplugin)
" * dhall (syntax, ftplugin)
" * dlang (syntax, indent)
" * dockerfile (syntax, indent, ftplugin)
" * elixir (syntax, indent, compiler, autoload, ftplugin)
" * elm (syntax, indent, autoload, ftplugin)
" * emberscript (syntax, indent, ftplugin)
" * emblem (syntax, indent, ftplugin)
" * erlang (syntax, indent)
" * ferm (syntax)
" * fish (syntax, indent, compiler, autoload, ftplugin)
" * flatbuffers (syntax)
" * fsharp (syntax, indent)
" * git (syntax, indent, ftplugin)
" * glsl (syntax, indent)
" * gmpl (syntax)
" * gnuplot (syntax)
" * go (syntax, compiler, indent)
" * gradle (compiler)
" * graphql (syntax, indent, autoload, ftplugin, after)
" * groovy-indent (indent)
" * groovy (syntax)
" * haml (syntax, indent, compiler, ftplugin)
" * handlebars (syntax, indent, ftplugin)
" * haproxy (syntax)
" * haskell (syntax, indent, ftplugin)
" * haxe (syntax)
" * hcl (syntax, indent, ftplugin)
" * helm (syntax)
" * hive (syntax, ftplugin)
" * html5 (syntax, indent, autoload, ftplugin)
" * i3 (syntax, ftplugin)
" * idris (syntax, indent, ftplugin)
" * ion (syntax, ftplugin)
" * jasmine (syntax)
" * javascript (syntax, indent, compiler, ftplugin, extras)
" * jenkins (syntax, indent)
" * jinja (syntax, indent)
" * json5 (syntax)
" * json (syntax, indent, ftplugin)
" * jst (syntax, indent)
" * jsx (autoload, after)
" * julia (syntax, indent, autoload, ftplugin)
" * kotlin (syntax, indent, ftplugin)
" * latex (syntax, indent, ftplugin)
" * less (syntax, indent, ftplugin)
" * lilypond (syntax, indent, compiler, ftplugin)
" * livescript (syntax, indent, compiler, ftplugin)
" * llvm (syntax, indent, ftplugin)
" * log (syntax)
" * lua (syntax, indent)
" * mako (syntax, indent, ftplugin)
" * markdown (syntax, indent, ftplugin)
" * mathematica (syntax, ftplugin)
" * mdx (syntax)
" * meson (syntax, indent, ftplugin)
" * moonscript (syntax, indent, ftplugin)
" * nginx (syntax, indent, ftplugin)
" * nim (syntax, compiler, indent)
" * nix (syntax, indent, compiler, ftplugin)
" * objc (ftplugin, syntax, indent)
" * ocaml (syntax, indent, compiler, ftplugin)
" * octave (syntax, indent)
" * opencl (syntax, indent, ftplugin)
" * perl (syntax, indent, ftplugin)
" * pgsql (syntax, indent)
" * php (syntax)
" * plantuml (syntax, indent, ftplugin)
" * pony (syntax, indent, autoload, ftplugin)
" * powershell (syntax, indent, ftplugin)
" * protobuf (syntax, indent)
" * pug (syntax, indent, ftplugin)
" * puppet (syntax, indent, autoload, ftplugin)
" * purescript (syntax, indent, ftplugin)
" * python-compiler (compiler, autoload)
" * python-indent (indent)
" * python (syntax)
" * qmake (syntax)
" * qml (syntax, indent, ftplugin)
" * r-lang (syntax)
" * racket (syntax, indent, ftplugin)
" * ragel (syntax)
" * raml (syntax, ftplugin)
" * reason (syntax, indent)
" * rspec (syntax)
" * rst (syntax, indent, autoload, ftplugin)
" * ruby (syntax, indent, compiler, autoload, ftplugin)
" * rust (syntax, indent, compiler, autoload, ftplugin)
" * sbt (syntax)
" * scala (syntax, indent, compiler, ftplugin)
" * scss (syntax, indent, ftplugin)
" * slim (syntax, indent, ftplugin)
" * slime (syntax, indent)
" * smt2 (syntax, autoload, ftplugin)
" * solidity (syntax, indent, ftplugin)
" * stylus (syntax, indent, ftplugin)
" * svelte (syntax, indent)
" * svg-indent (indent)
" * svg (syntax)
" * swift (syntax, indent, ftplugin)
" * sxhkd (syntax)
" * systemd (syntax, ftplugin)
" * terraform (syntax, indent, autoload, ftplugin)
" * textile (syntax, ftplugin)
" * thrift (syntax)
" * tmux (syntax, ftplugin)
" * tomdoc (syntax)
" * toml (syntax, ftplugin)
" * tptp (syntax)
" * twig (syntax, indent, ftplugin)
" * typescript (syntax, indent, compiler, ftplugin)
" * v (syntax, indent, ftplugin)
" * vala (syntax, indent, ftplugin)
" * vbnet (syntax)
" * vcl (syntax)
" * vifm (syntax, autoload, ftplugin)
" * vm (syntax, indent)
" * vue (syntax, indent, ftplugin)
" * xdc (syntax)
" * xls (syntax)
" * xml (syntax)
" * yaml (syntax, ftplugin)
" * yard (syntax)
" * zephir (syntax)
" * zig (syntax, autoload, ftplugin)
"}}}
endif
Plug 'https://github.com/martinda/Jenkinsfile-vim-syntax' " Jenkinsfile DSL vim syntax

" General: By default it will auto format javascript, typescript, less, scss, css, json, graphql and markdown files if they have/support the "@format" pragma annotation in the header of the file.
if executable('npm')
    Plug 'https://github.com/prettier/vim-prettier',{'do':'npm install'}
endif
Plug 'https://github.com/vim-scripts/httplog'                     " Highlight access log of Apache, nginx, etc
Plug 'https://github.com/vim-scripts/better-whitespace' " A better whitespace highlighter
Plug 'https://github.com/vim-scripts/logstash.vim'                " logstash.vim highlights configuration files for logstash
"Plug 'https://github.com/vim-scripts/jQuery'                      " Syntax file for jQuery
Plug 'https://github.com/xu-cheng/brew.vim'                       " 🍺 Vim Syntax for Homebrew formulae
if !has('nvim')
    Plug 'https://github.com/rhysd/vim-healthcheck' " Polyfill of Neovim's health-check for Vim
endif
Plug 'https://github.com/vim-scripts/groovy.vim' " syntax file for the groovy programming language
" Docker {{{3
if !has('nvim') && version >= 801.1799
    Plug 'https://github.com/skanehira/docker.vim'  " Manage docker containers and images in Vim
endif
"Plug 'https://github.com/jiangmiao/auto-pairs' " Vim plugin, insert or delete brackets, parens, quotes in pair
" Plug 'https://github.com/vim-scripts/ShowPairs'
Plug 'https://github.com/junegunn/goyo.vim' " 🌷 Distraction-free writing in Vim
Plug 'https://github.com/junegunn/vim-peekaboo' " 👀 " / @ / CTRL-R
"Plug 'https://github.com/WolfgangMehner/Vim-support', {'for': 'vim'}                   " Vim Script IDE for Vim/gVim
if version >= 800
    Plug 'https://github.com/wfxr/minimap.vim'    " 📡 Blazing fast minimap for vim, powered by code-minimap written in Rust.
endif
if has('patch-8.1.2114') || has('nvim-0.4.2')
    " Plug 'https://github.com/liuchengxu/vim-clap', { 'do': ':Clap install-binary' } " clap Modern performant generic finder and dispatcher for Vim and NeoVim; hude size!
endif
if has('lambda')
    Plug 'https://github.com/kkoomen/vim-doge', { 'do': { -> doge#install() } }
endif

" DB {{{
"Plug 'https://github.com/kristijanhusak/vim-dadbod' " Modern database interface for Vim
"Plug 'https://github.com/kristijanhusak/vim-dadbod-ui' " Simple UI for vim-dadbod
" }}}

" Ldap/ldif {{{3
Plug 'https://github.com/vim-scripts/ldif.vim'              " syntax higlighting for LDIF (LDAP serialization)
Plug 'https://github.com/vim-scripts/ldap_schema.vim--Hahn' " ldap schmema definition language

" Markdown {{{3
Plug 'https://github.com/plasticboy/vim-markdown'       " Markdown Vim Mode, @require tabular
" Plug 'https://github.com/gabrielelana/vim-markdown' " Markdown for Vim: a complete environment to create Markdown files with a syntax highlight that doesn't suck!
"Plug 'https://github.com/nelstrom/vim-markdown-folding' " Fold markdown documents by section
Plug 'https://github.com/JamshedVesuna/vim-markdown-preview' " A light Vim plugin for previewing markdown files in a browser - without leaving Vim.
if executable('npm')
"    Plug 'https://github.com/suan/vim-instant-markdown',{'do':'npm -g install instant-markdown-d'} " Instant Markdown previews
endif
Plug 'https://github.com/mzlogin/vim-markdown-toc' " A vim 7.4+ plugin to generate table of contents for Markdown files.

" terraform {{{3
Plug 'https://github.com/hashivim/vim-terraform' " basic vim/terraform integration http://hashivim.github.io/vim-terraform

" c++, c {{{3
" Plug 'https://github.com/vim-scripts/c.vim' " C/C++ IDE -- Write and run programs. Insert statements, idioms, comments etc

" CSS/LESS {{{3
"Plug 'https://github.com/ap/vim-css-color' " Preview colours in source code while editing, @conflict vim-markdown

" Go {{{3
if version > 801 || version == 801 && has('patch453')
"    Plug 'https://github.com/fatih/vim-go' " Go development plugin for Vim https://www.patreon.com/bhcleek
endif

" HTML {{{3
Plug 'https://github.com/gregsexton/MatchTag' " Vim's MatchParen for HTML tags
Plug 'https://github.com/alvan/vim-closetag'  " Auto close (X)HTML tags

" Perl {{{3
"Plug 'https://github.com/vim-perl/vim-perl'            " Support for Perl 5 and Perl 6 in Vim http://groups.google.com/group/vim-perl
"Plug 'https://github.com/vim-scripts/perl-support.vim', {'for': 'perl'} " Write and run Perl-scripts using menus and hotkeys
Plug 'https://github.com/WolfgangMehner/perl-support' " Edit Perl scripts in Vim/gVim. Insert code snippets, run, check, and profile the code and look up help.

" Python {{{3
if g:PYTHON
    Plug 'https://github.com/davidhalter/jedi-vim'                      " Using the jedi autocompletion library for VIM
    " Plug 'https://github.com/klen/python-mode', { 'branch': 'develop' } " Vim python-mode. PyLint, Rope, Pydoc, breakpoints from box
    Plug 'https://github.com/jmcantrell/vim-virtualenv'                 " Vim plugin for working with python virtualenvs
    " Plug 'https://github.com/vim-scripts/python_fold'                 " Folding expression for python
    Plug 'https://github.com/vim-scripts/SimpylFold'                    " No-BS Python code folding
    " Plug 'https://github.com/nvie/vim-flake8'                         " Flake8 plugin for Vim
    " Plug 'https://github.com/joonty/vdebug'                           " Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.
endif


" XML, XSLT {{{3
Plug 'https://github.com/vim-scripts/xml.vim' " [helps editing xml (and [x]html, sgml, xslt) files](https://github.com/vim-scripts/xml.vim)
Plug 'https://github.com/vim-scripts/xmledit' " A filetype plugin to help edit XML, HTML, and SGML documents
Plug 'https://github.com/vim-scripts/xslt'    " XSLT ftplugin

" YAML {{{3
" Plug 'https://github.com/andrewstuart/vim-kubernetes' " vim-kubernetes
Plug 'https://github.com/stephpy/vim-yaml'            " Override vim syntax for yaml files

" JSON {{{3
Plug 'https://github.com/elzr/vim-json' " A better JSON

" Rust
"Plug 'https://github.com/rust-lang/rust.vim' " Plugin that provides Rust file detection, syntax highlighting, formatting, Syntastic integration, and more.

" Git and other VCS {{{2
if g:UNICODE && executable('git')
   " Plug 'https://github.com/scrooloose/nerdtree-git-plugin'       " A plugin of NERDTree showing git status
endif
if executable('git')
    Plug 'https://github.com/tpope/vim-fugitive'          " Git wrapper of all time
    Plug 'https://github.com/int3/vim-extradite' " A git commit browser for vim. Extends fugitive.vim.
    Plug 'https://github.com/junegunn/gv.vim'             " A git commit browser in Vim
    Plug 'https://github.com/vim-scripts/git-flow-format' " formats a Git Flow branch name in order to shorten the prefixes, some errors due saving a file
"    Plug 'https://github.com/vim-scripts/gitv'            " gitk for Vim
    Plug 'https://github.com/idanarye/vim-merginal',{'branch':'develop'}       " Fugitive extension to manage and merge Git branches
    Plug 'https://github.com/vim-scripts/vim-gitignore'   " Another gitignore plugin for Vim
    Plug 'https://github.com/sjl/splice.vim'              " managing three-way merges - conflict with vim-fugitive
    if version >= 704
        " use coc-git instead of this
        Plug 'https://github.com/airblade/vim-gitgutter', {'branch':'main'}  " shows a git diff in the 'gutter' (sign column)
    endif
    Plug 'https://github.com/whiteinge/diffconflicts'     " A better Vimdiff Git mergetool
    Plug 'https://github.com/cohama/agit.vim'             " A powerful Git log viewer
"    Plug 'https://github.com/rhysd/git-messenger.vim' " plugin to reveal the hidden message from Git under the cursor quickly
    if has('nvim')
        Plug 'https://github.com/tveskag/nvim-blame-line' " A small plugin that uses neovims virtual text to print git blame info at the end of the current line
    endif
endif
Plug 'https://github.com/rhysd/conflict-marker.vim' " Weapon to fight against conflicts in Vim.

" Themes {{{2
Plug 'https://github.com/xolox/vim-colorscheme-switcher'           " Color scheme switcher for Vim, @require vim-misc
Plug 'https://github.com/sainnhe/gruvbox-material' " Gruvbox with Material Palette
Plug 'https://github.com/morhetz/gruvbox' "  Retro groove color scheme for Vim
Plug 'https://github.com/ajmwagar/vim-deus' " 🌙 A better color scheme for the late night coder

" Shells/Bash
Plug 'https://github.com/vim-scripts/bash-support.vim'              " BASH IDE -- Write and run BASH-scripts using menus and hotkeys
Plug 'https://github.com/vim-scripts/bats.vim'                     " Syntax highlighting for Bats - Bash Automated Testing System

" Awk
Plug 'https://github.com/vim-scripts/awk-support.vim'               " AWK-IDE for Vim/gVim

" Others {{{2
" Plug 'https://github.com/vim-scripts/matchit.zip'                  " extended % matching for HTML, LaTeX, and many other languages
Plug 'https://github.com/andymass/vim-matchup' " vim match-up: even better % 👊 navigate and highlight matching words 👊 modern matchit and matchparen replacement
if version >= 704
"    Plug 'https://github.com/vim-scripts/EnhancedDiff'             " A Vim plugin for creating better diffs
endif
Plug 'https://github.com/chrisbra/vim-diff-enhanced' " Better Diff options for Vim
Plug 'https://github.com/tyru/open-browser.vim'                    " Open URI with your favorite browser from your most favorite editor
Plug 'https://github.com/jlemetay/permut'                          " swap columns of text separated by arbitrary characters
Plug 'https://github.com/AndrewRadev/switch.vim'                   " switch segments of text with predefined replacements
Plug 'https://github.com/majutsushi/tagbar'                        " Vim plugin that displays tags in a window, ordered by scope
if executable('ctags')
    Plug 'https://github.com/vim-scripts/taglist.vim'                  " Source code browser (supports C/C++, java, perl, python, tcl, sql, php, etc)
endif
" Plug 'https://github.com/vim-scripts/Toggle'                       " allows you to toggle bool (true/false) and other words with a shortcut
Plug 'https://github.com/tpope/vim-repeat'             " enable repeating supported plugin maps with                                      " . "
Plug 'https://github.com/tpope/vim-speeddating'        " use CTRL-A/CTRL-X to increment dates, times, and more
Plug 'https://github.com/vim-scripts/visual-increment' " Use CTRL+A/X to create increasing sequence of numbers or letters via visual mode
Plug 'https://github.com/tpope/vim-surround'           " quoting/parenthesizing made simple
if version > 703 && g:PYTHON
    Plug 'https://github.com/simnalamburt/vim-mundo'                   " Vim undo tree visualizer
elseif version > 703 || (version == 703 && has('patch005'))
    Plug 'https://github.com/mbbill/undotree'                      " The ultimate undo history visualizer for VIM
endif
if version >= 703
    " Plug 'https://github.com/ap/vim-buftabline'                    " Forget Vim tabs - now you can have buffer tabs
endif
"Plug 'https://github.com/vim-scripts/tskeleton'                    " File Templates and Code Skeletons/Snippets
Plug 'http://github.com/tomtom/tskeleton_vim' " File Templates and Code Skeletons/Snippets for VIM
Plug 'https://github.com/tomtom/tlib_vim' " Some utility functions for VIM
Plug 'https://github.com/chip/vim-fat-finger'                      " Simple vim plugin for common misspellings and typos
Plug 'https://github.com/sedm0784/vim-you-autocorrect'             " Why should smartphones get all the fun?
Plug 'https://github.com/zirrostig/vim-schlepp'                    " easily moving text selections around
Plug 'https://github.com/jiangxincode/TagCollection'               " Some tags used by the OmniCppComplete which can auto complete your code
" Plug 'https://github.com/nathanaelkane/vim-indent-guides'          " displaying indent levels in code
let g:indentLine_enabled = 0
Plug 'https://github.com/Yggdroot/indentLine'   " A vim plugin to display the indention levels with thin vertical lines
Plug 'https://github.com/terryma/vim-expand-region'                " Vim plugin that allows you to visually select increasingly larger regions of text using the same key combination
"Plug 'https://github.com/Konfekt/FastFold'                         " Speed up Vim by updating folds only when called-for
Plug 'https://github.com/will133/vim-dirdiff'                      " Vim plugin to diff two directories
" Table Mode for instant table creation
Plug 'https://github.com/dhruvasagar/vim-table-mode',{'on':'TableModeEnable'} " map conflict with bash-support
Plug 'https://github.com/brooth/far.vim'                           " Find And Replace
"Plug 'https://github.com/liuchengxu/vim-which-key' " tulip Vim plugin that shows keybindings in popup
Plug 'https://bitbucket.org/sw-samuraj/vim-gradle'

if version > 704 || version == 704 && has('patch1154')
    Plug 'https://github.com/liuchengxu/vista.vim'                     " Viewer & Finder for LSP symbols and tags http://liuchengxu.org/vista.vim
endif
if version >= 801
    " Plug 'https://github.com/neoclide/coc.nvim',{'branch': 'release'} " Intellisense engine for vim8 & neovim, full language server protocol support as VSCode https://salt.bountysource.com/teams/coc-nvim
    " Snippets are separated from the engine. Add this if you want them:
    Plug 'https://github.com/honza/vim-snippets' " vim-snipmate default snippets (Previously snipmate-snippets)
endif
Plug 'https://github.com/ervandew/supertab'
if has('nvim') || version >= 802
"    Plug 'https://github.com/pechorin/any-jump.nvim' " Jump to any definition and usages eye IDE madness without overhead (alpha)
endif

" 3rd party tools {{{2
if executable('python')
    Plug 'https://github.com/vim-scripts/betterga'                 " betterga can get more information than ga (:ascii)
endif
if executable('ack')
    Plug 'https://github.com/tyok/nerdtree-ack'          " NERDtree + ack.vim
    Plug 'https://github.com/ggreer/the_silver_searcher' " A code-searching tool similar to ack, but faster
    Plug 'https://github.com/mileszs/ack.vim'            " Vim plugin for the Perl module / CLI script 'ack'
endif
"Plug 'https://github.com/dyng/ctrlsf.vim'       " An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2

" Language & Grammar {{{2
" Plug 'https://github.com/rhysd/vim-grammarous'                     " A powerful grammar checker for Vim using LanguageTool; huge size!

" MS Windows only {{{2
if g:MSWIN
    Plug 'https://github.com/vim-scripts/poshcomplete-vim'                       " Omni Completion for PowerShell
    Plug 'https://github.com/vim-scripts/Windows-PowerShell-Syntax-Plugin'       " Default syntax coloring for Windows PowerShell
    Plug 'https://github.com/vim-scripts/Windows-PowerShell-Indent-File'         " [Simple indenting rules for Windows PowerShell](https://github.com/vim-scripts/Windows-PowerShell-Indent-File
endif
if g:MSWIN && !g:MSWIN64
    Plug 'https://github.com/vim-scripts/maximize.dll'
endif

" Some offline plugins {{{2
" [A file templates](https://sites.google.com/site/abudden/contents/Vim-Scripts/file-templates)
" execute 'Plug \"' . bundle_dir . '/file_templates\"'
Plug 'https://github.com/drbeco/vimtemplates' " The VI Improved templates
" Always load the vim-devicons as the very last one. Use a nerd font
" Plug 'https://github.com/ryanoasis/vim-devicons'         " Adds file type icons to Vim plugins such as: NERDTree, vim-airline, CtrlP, unite, Denite, lightline, vim-startify and many more
" end of vim-plug's plugins management
call plug#end()
delc PlugUpgrade
"}}}
"}}}
" Plugins configuration {{{
" ale {{{2
if plugin#isEnabled('ale')
    " use the quickfix list instead of the loclist
    let g:ale_set_loclist = 0
    let g:ale_set_quickfix = 1
    " let g:ale_open_list = 1
    let g:ale_set_highlights = 0
endif
" }}}
" animate {{{2
if plugin#isEnabled('animate.vim')
    nnoremap <silent> <C-S-Up>    :call animate#window_delta_height(10)<CR>
    nnoremap <silent> <C-S-Down>  :call animate#window_delta_height(-10)<CR>
    nnoremap <silent> <C-S-Left>  :call animate#window_delta_width(10)<CR>
    nnoremap <silent> <C-S-Right> :call animate#window_delta_width(-10)<CR>
endif
" }}}
" bash-support {{{2
if plugin#isEnabled('bash-support.vim')
    " let g:BASH_TemplateOverwrittenMsg = 'no'
    if g:UNIX
        " see ~/.config/vim/local.vim
        " let g:BASH_LocalTemplateFile    = vimrc_dir . 'templates/bash-support/templates/Templates'
        " let g:BASH_GuiSnippetBrowser = 'commandline'
        if g:MACOS
            let g:BASH_Executable       = '/usr/local/bin/bash'
        else
            let g:BASH_Executable       = '/usr/bin/bash'
        endif
    endif
endif
" }}}
" ctrlp {{{2
if plugin#isEnabled('ctrlp.vim')
    if executable('ag')
        " Use Ag over Grep
        set grepprg=ag\ --nogroup\ --nocolor
        " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    endif
    set wildignore+=*.7z
endif
" ctrlp-funky {{{2
if plugin#isEnabled('ctrlp-funky')
    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
    let g:ctrlp_funky_syntax_highlight = 1
    " If you want to have this highlight feature
    let g:ctrlp_funky_matchtype = 'path'
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
" coc.nvim {{{2
if plugin#isEnabled('coc.nvim')
"    let $NVIM_COC_LOG_LEVEL = 'info'
    let $NODE_TLS_REJECT_UNAUTHORIZED=0
    let g:coc_global_extensions = [
    \ 'coc-calc',
    \ 'coc-css',
    \ 'coc-emmet',
    \ 'coc-emoji',
    \ 'coc-git',
    \ 'coc-highlight',
    \ 'coc-html',
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-prettier',
    \ 'coc-pyright',
    \ 'coc-python',
    \ 'coc-ultisnips',
    \ 'coc-snippets',
    \ 'coc-xml',
    \ 'coc-yaml',
    \ 'coc-yank',
    \ 'coc-markdownlint',
    \ ]
    " \ 'coc-sh',
    " \ 'coc-go',
    " \ 'coc-tsserver',
    " \ 'coc-pairs',
    " \ 'coc-explorer',
    " \ 'coc-template',
    " \ 'coc-imselect',

    " Use tab for trigger completion with characters ahead and navigate.
    " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.

    if has('vim')
        set pumwidth=50
    endif
    inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    let g:coc_snippet_next = '<tab>'

    " Use <c-space> to trigger completion.
    inoremap <silent><expr> <c-space> coc#refresh()

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
    " Coc only does snippet and additional edit on confirm.
"    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    " Or use `complete_info` if your vim support it, like:
"    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

    command! -nargs=0 Prettier :CocCommand prettier.formatFile

    " Use `[g` and `]g` to navigate diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " Remap keys for gotos
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        B
        call CocAction('doHover')
    endif
    endfunction

    " Highlight symbol under cursor on CursorHold
"    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Remap for rename current word
    nmap <F2> <Plug>(coc-rename)

    " Remap for format selected region
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap for do codeAction of current line
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Fix autofix problem of current line
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Create mappings for function text object, requires document symbols feature of languageserver.
    xmap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap if <Plug>(coc-funcobj-i)
    omap af <Plug>(coc-funcobj-a)

    " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"    nmap <silent> <C-d> <Plug>(coc-range-select)
"    xmap <silent> <C-d> <Plug>(coc-range-select)

    " Use `:Format` to format current buffer
    command! -nargs=0 Format :call CocAction('format')

    " Use `:Fold` to fold current buffer
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " use `:OR` for organize import of current buffer
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add status line support, for integration with other plugin, checkout `:h coc-status`
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Using CocList
    " Show all diagnostics
    nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions
    nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
    " Show commands
    nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document
    nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols
    nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list
    nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

    " Extensions
    vmap <leader>a <Plug>(coc-codeaction-selected)
    nmap <leader>a <Plug>(coc-codeaction-selected)

    " coc-calc
    " append result on current expression
    nmap <Leader>ca <Plug>(coc-calc-result-append)
    " replace result on current expression
    nmap <Leader>cr <Plug>(coc-calc-result-replace)

    " coc-snippets
    " Use <C-l> for trigger snippet expand.
    imap <C-l> <Plug>(coc-snippets-expand)

    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)

    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'

    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'
    let g:coc_snippet_prev = '<S-TAB>'
    let g:coc_status_error_sign = '•'
    let g:coc_status_warning_sign = '•'

    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)
    " ~/.vim/coc-extension/repl.js
    xmap <silent> <TAB> <Plug>(coc-repl-sendtext)
endif
" }}}
" delimitMate {{{2
if plugin#isEnabled('delimitMate')
    let delimitMate_expand_cr = 1
endif
" }}}
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
" editorconfig-vim {{{2
if plugin#isEnabled('editorconfig-vim')
    au FileType gitcommit let b:EditorConfig_disable = 1
endif
" }}}
" eleline {{{2
if plugin#isEnabled('eleline.vim')
    let g:eleline_powerline_fonts = 1
    " see https://github.com/neoclide/coc-git
endif
" }}}
" emmet-vim {{{2
if plugin#isEnabled('emmet-vim')
    let g:user__install_global = 0
    autocmd FileType html,css EmmetInstall
endif
"}}}
" EnchantedVim {{{2
if plugin#isEnabled('EnchantedVim')
    let g:VeryMagic = 0
    let g:VeryMagicSubstitute = 1  " (default is 0)
    let g:VeryMagicGlobal = 1  " (default is 0)
    let g:VeryMagicVimGrep = 1  " (default is 0)
    let g:VeryMagicSearchArg = 1  " (default is 0, :edit +/{pattern}))
    let g:VeryMagicFunction = 1  " (default is 0, :fun /{pattern})
    let g:VeryMagicHelpgrep = 1  " (default is 0)
    let g:VeryMagicRange = 1  " (default is 0, search patterns in command ranges)
    let g:VeryMagicEscapeBackslashesInSearchArg = 1  " (default is 0, :edit +/{pattern}))
    let g:SortEditArgs = 1  " (default is 0, see below)
endif
" }}}
" file_templates {{{2
if plugin#isEnabled('file_templates')
    let g:VIMFILESDIR = vimrc_dir
    if !exists("g:file_template_default")
        let g:file_template_default = {}
    endif
    let g:file_template_default.PKGBUILD = "default"
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
" goyo {{{2
if plugin#isEnabled('goyo.vim')
    let g:goyo_width='90%'
    let g:goyo_height='90%'
    let g:goyo_linenr=1
endif
" }}}
" gruvbox {{{2
if plugin#isEnabled('gruvbox')
endif
" }}}
" incsearch.vim {{{2
if plugin#isEnabled('incsearch.vim')
"    let g:incsearch#auto_nohlsearch = 1
    nmap /  <Plug>(incsearch-forward)
    nmap ?  <Plug>(incsearch-backward)
    nmap g/ <Plug>(incsearch-stay)

"    map n  <Plug>(incsearch-nohl-n)
"    map N  <Plug>(incsearch-nohl-N)
"    map *  <Plug>(incsearch-nohl-*)
"    map #  <Plug>(incsearch-nohl-#)
"    map g* <Plug>(incsearch-nohl-g*)
"    map g# <Plug>(incsearch-nohl-g#)
endif
" }}}
" indentLine {{{2
if plugin#isEnabled('indentLine')
    let g:indentLine_setColors = 0
    " Vim
    let g:indentLine_color_term = 239

    " GVim
    let g:indentLine_color_gui = '#A4E57E'

    " none X terminal
    let g:indentLine_color_tty_light = 7 " (default: 4)
    let g:indentLine_color_dark = 1 " (default: 2)

    " Background (Vim, GVim)
    let g:indentLine_bgcolor_term = 202
    let g:indentLine_bgcolor_gui = '#FF5F00'
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
        let g:lightline = {}
    endif
    let g:lightline.colorscheme = 'gruvbox_material'
    let g:lightline.component_function = {}
    let g:lightline.component_function.filename = 'LightlineFilename'
    let g:lightline.component_function.mode = 'LightlineMode'
    let g:lightline.component_function.gitbranch = 'FugitiveHead'
    let g:lightline.component_function.bomb = 'LightlineBomb'


    let g:lightline.active = {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'gitbranch', 'readonly', 'filename' ] ],
        \   'right': [ [ 'lineinfo' ],
        \              [ 'percent' ],
        \              [ 'fileformat', 'fileencoding', 'filetype', 'bomb' ] ]
        \ }

    function! LightlineBomb()
        return &bomb ? "BOM" : ""
    endfunction

    function! LightlineMode()
        return expand('%:t') =~# '^__Tagbar__' ? 'Tagbar':
            \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
            \ &filetype ==# 'unite' ? 'Unite' :
            \ &filetype ==# 'vimfiler' ? 'VimFiler' :
            \ &filetype ==# 'vimshell' ? 'VimShell' :
            \ lightline#mode()
    endfunction

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
" nerdcommenter {{{2
if plugin#isEnabled('nerdcommenter')
    " Add spaces after comment delimiters by default
    let g:NERDSpaceDelims = 1
    " Use compact syntax for prettified multi-line comments
    let g:NERDCompactSexyComs = 1
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
    let g:NERDCustomDelimiters = {
        \ 'brewfile': { 'left': '#','right': '' }
    \ }
endif
" }}}
" nerdtree {{{2
if plugin#isEnabled('nerdtree')
    nnoremap <silent> <F3> :NERDTreeToggle<CR>
"    nnoremap <silent> <F3> :NERDTreeFind<CR>
    let g:NERDTreeWinPos = "right"
    set timeoutlen=1000
    let g:NERDTreeChDirMode=2
    let g:NERDTreeDirArrows=0
    let NERDTreeShowHidden=1
    let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
    let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
    let g:NERDTreeShowBookmarks=1
    let g:NERDTreeFileExtensionHighlightFullName = 1
    let g:NERDTreeExactMatchHighlightFullName = 1
    let g:NERDTreePatternMatchHighlightFullName = 1
    let g:NERDTreeHighlightFolders = 1
    let g:NERDTreeHighlightFoldersFullName = 1
    if g:UNICODE
        let g:NERDTreeDirArrowExpandable='▷'
        let g:NERDTreeDirArrowCollapsible='▼'
    else
        let g:NERDTreeDirArrowExpandable='+'
        let g:NERDTreeDirArrowCollapsible='~'
    endif
    " How can I open NERDTree automatically when vim starts up on opening a directory?
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
    " How can I close vim if the only window left open is a NERDTree?
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
endif
    let g:NERDTreeGitStatusWithFlags = 1
    let g:NERDTreeIgnore = ['^node_modules$']
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
"    silent! colorscheme onehalfdark
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
" spaceduck {{{2
if plugin#isEnabled('spaceduck')
endif
" }}}
" startify {{{2
if plugin#isEnabled('vim-startify')
    let g:startify_fortune_use_unicode = 1
endif
"}}}
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
    " let g:syntastic_mode_map = {
    "     \ 'mode': 'passive',
    "     \ 'passive_filetypes': ['python'],
    "     \ 'active_filetypes': [],
    "     \}
    let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
    nnoremap <C-w>E :SyntasticCheck<CR>
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
    " extras
    let g:syntastic_yaml_checkers = ['yamllint']
    let g:syntastic_cfg_checkers = ['cfg']
    let g:syntastic_dosini_checkers = ['dosini']
    let g:syntastic_make_checkers = ['gnumake']
    let g:syntastic_javascript_checkers = ['json_tool']
    let g:syntastic_json_checkers = ['json_tool']
    " Like Syntastic's pyflakes checker, but treats messages about unused
    " variables/imports as warnings rather than errors.
    let g:syntastic_python_checkers = ['pyflakes_with_warnings']
    nnoremap ZZ :call syntastic_extras#quit_hook()<cr>
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
        \ 'ctagstype'	: 'markdown',
        \ 'kinds'		: [
            \ 'c:chapter:0:1',
            \ 's:section:0:1',
            \ 'S:subsection:0:1',
            \ 't:subsubsection:0:1',
            \ 'T:l4subsection:0:1',
            \ 'u:l5subsection:0:1',
        \ ],
        \ 'sro'			: '""',
        \ 'kind2scope'	: {
            \ 'c' : 'chapter',
            \ 's' : 'section',
            \ 'S' : 'subsection',
            \ 't' : 'subsubsection',
            \ 'T' : 'l4subsection',
        \ },
        \ 'scope2kind'	: {
            \ 'chapter' : 'c',
            \ 'section' : 's',
            \ 'subsection' : 'S',
            \ 'subsubsection' : 't',
            \ 'l4subsection' : 'T',
        \ },
    \ }
	let g:tagbar_type_css = {
		\ 'ctagstype' : 'Css',
			\ 'kinds'     : [
				\ 'c:classes',
				\ 's:selectors',
				\ 'i:identities'
			\ ]
		\ }
	let g:tagbar_type_go = {
		\ 'ctagstype': 'go',
		\ 'kinds' : [
			\'p:package',
			\'f:function',
			\'v:variables',
			\'t:type',
			\'c:const'
		\]
	\}
	let g:tagbar_type_groovy = {
		\ 'ctagstype' : 'groovy',
		\ 'kinds'     : [
			\ 'p:package:1',
			\ 'c:classes',
			\ 'i:interfaces',
			\ 't:traits',
			\ 'e:enums',
			\ 'm:methods',
			\ 'f:fields:1'
		\ ]
	\ }
	let g:tagbar_type_json = {
		\ 'ctagstype' : 'json',
		\ 'kinds' : [
		\ 'o:objects',
		\ 'a:arrays',
		\ 'n:numbers',
		\ 's:strings',
		\ 'b:booleans',
		\ 'z:nulls'
		\ ],
	\ 'sro' : '.',
		\ 'scope2kind': {
		\ 'object': 'o',
		\ 'array': 'a',
		\ 'number': 'n',
		\ 'string': 's',
		\ 'boolean': 'b',
		\ 'null': 'z'
		\ },
		\ 'kind2scope': {
		\ 'o': 'object',
		\ 'a': 'array',
		\ 'n': 'number',
		\ 's': 'string',
		\ 'b': 'boolean',
		\ 'z': 'null'
		\ },
		\ 'sort' : 0
	\ }
	let g:tagbar_type_perl = {
		\ 'ctagstype' : 'perl',
		\ 'kinds'     : [
			\ 'p:package:0:0',
			\ 'w:roles:0:0',
			\ 'e:extends:0:0',
			\ 'u:uses:0:0',
			\ 'r:requires:0:0',
			\ 'o:ours:0:0',
			\ 'a:properties:0:0',
			\ 'b:aliases:0:0',
			\ 'h:helpers:0:0',
			\ 's:subroutines:0:0',
			\ 'd:POD:1:0'
		\ ]
	\ }
endif
" }}}
" tagList {{{2
if plugin#isEnabled('taglist.vim')
    noremap <silent> <S-F11>       :TlistToggle<CR>
    inoremap <silent> <S-F11>  <C-C>:TlistToggle<CR>
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
" vbookmark {{{2
if plugin#isEnabled('vbookmark')
    let g:vbookmark_bookmarkSaveFile = $HOME . '/.vimbookmark'
endif
" }}}
" viewdoc {{{2
if plugin#isEnabled('viewdoc')
    " let g:no_viewdoc_maps=1
    let g:viewdoc_open='new'
    " let g:viewdoc_open="topleft new"
    let g:viewdoc_openempty=0
    let g:viewdoc_copy_to_search_reg=1
endif
"}}}
" vim-airline {{{2
if plugin#isEnabled('vim-airline')
    let g:airline_powerline_fonts     = 1
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
" vim-asterisk {{{2
if plugin#isEnabled('vim-asterisk')
    let g:asterisk#keeppos = 1
"    map *  <Plug>(asterisk-*)
"    map #  <Plug>(asterisk-#)
"    map g* <Plug>(asterisk-g*)
"    map g# <Plug>(asterisk-g#)
    map *  <Plug>(asterisk-z*)
    map #  <Plug>(asterisk-z#)
    map g* <Plug>(asterisk-gz*)
    map g# <Plug>(asterisk-gz#)
endif
" }}}
" vim-buffer {{{2
if plugin#isEnabled('vim-buffer')
    nnoremap <silent> <c-p> :PreviousBuffer<cr>
    nnoremap <silent> <c-n> :NextBuffer<cr>
    nnoremap <silent> <leader>d :CloseBuffer<cr>
    nnoremap <silent> <leader>D :BufOnly<cr>
endif
" }}}
" vim-buffet {{{2
if plugin#isEnabled('vim-buffet')
    nmap <leader>1 <Plug>BuffetSwitch(1)
    nmap <leader>2 <Plug>BuffetSwitch(2)
    nmap <leader>3 <Plug>BuffetSwitch(3)
    nmap <leader>4 <Plug>BuffetSwitch(4)
    nmap <leader>5 <Plug>BuffetSwitch(5)
    nmap <leader>6 <Plug>BuffetSwitch(6)
    nmap <leader>7 <Plug>BuffetSwitch(7)
    nmap <leader>8 <Plug>BuffetSwitch(8)
    nmap <leader>9 <Plug>BuffetSwitch(9)
    nmap <leader>0 <Plug>BuffetSwitch(10)
    let g:buffet_powerline_separators = 1
    let g:buffet_tab_icon = "\uf00a"
    let g:buffet_left_trunc_icon = "\uf0a8"
    let g:buffet_right_trunc_icon = "\uf0a9"
endif
" vim-buftabline {{{2
if plugin#isEnabled('vim-buftabline')
    nnoremap <C-N> :bnext<CR>
    nnoremap <C-P> :bprev<CR>
endif
" }}}
" vim-commentary {{{2
if plugin#isEnabled('vim-commentary')
    autocmd FileType apache setlocal commentstring=#\ %s
    autocmd FileType dosini setlocal commentstring=#\ %s
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
" vim-diff-enhanced {{{2
if plugin#isEnabled('vim-diff-enhanced')
    if !has("patch-8.1.0360") && &diff
        let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
    endif
endif
" }}}
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
    let g:indent_guides_exclude_filetypes = ['help', 'nerdtree']
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
" vim-markdown{{{2
if plugin#isEnabled('vim-markdown')
    let g:vim_markdown_folding_disabled = 1
    " gabrielelana/vim-markdown
    let g:markdown_enable_folding = 0
    let g:markdown_enable_insert_mode_leader_mappings = 1
    let g:markdown_enable_conceal = 1
    let g:vim_markdown_follow_anchor = 1
endif
"}}}
" vim-markdown-preview {{{2
if plugin#isEnabled('vim-markdown-preview')
    let vim_markdown_preview_browser='Firefox'
    if executable("grip")
        let vim_markdown_preview_github=1
    endif
    " if executable("markdown")
    "     let vim_markdown_preview_perl=1
    " endif
    " if executable("pandoc")
    "    let vim_markdown_preview_pandoc=1
    " endif
endif
"}}}
" vim-markdown-toc {{{2
if plugin#isEnabled('vim-markdown-toc')
    " let g:vmt_dont_insert_fence = 1
    " let g:vmt_fence_text = 'TOC'
    " let g:vmt_fence_closing_text = '/TOC
    let g:vmt_auto_update_on_save = 1
    let g:vmt_list_item_char = '-'
    let g:vmt_include_headings_before = 1
endif
"}}}
" vim-move {{{2
if plugin#isEnabled('vim-move')
    let g:move_key_modifier = 'C'
endif
" }}}
" vim-nightfly-guicolors {{{2
if plugin#isEnabled('vim-nightfly-guicolors')
"    colorscheme nightfly
endif
" }}}
" vim-polyglot {{{2
if plugin#isEnabled('vim-polyglot')
endif
" }}}
" vim-session {{{2
if plugin#isEnabled('vim-session')
    let g:session_autosave = 'yes'
    let g:session_autoload = 'yes'
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
" vim-table-mode {{{2
if plugin#isEnabled('vim-table-mode')

    function! s:isAtStartOfLine(mapping)
      let text_before_cursor = getline('.')[0 : col('.')-1]
      let mapping_pattern = '\V' . escape(a:mapping, '\')
      let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
      return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
    endfunction

    inoreabbrev <expr> <bar><bar>
              \ <SID>isAtStartOfLine('\|\|') ?
              \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
    inoreabbrev <expr> __
              \ <SID>isAtStartOfLine('__') ?
              \ '<c-o>:silent! TableModeDisable<cr>' : '__'
endif
" }}}
" vim-terraform {{{2
if plugin#isEnabled('vim-terraform')
    let g:terraform_align=1
    let g:terraform_fold_sections=1
    let g:terraform_fmt_on_save=1
endif
" }}}
" vim-toggle {{{2
if plugin#isEnabled('Toggle')
    imap <c-t>:call Toggle()<CR>
    nmap <c-t>:call Toggle()<CR>
    vmap <c-t> <ESC>:call Toggle()<CR>
endif
"}}}
" vimtemplates {{{2

if plugin#isEnabled('vimtemplates')
    let g:vimtemplates_dir = vimrc_dir
    if !exists("g:file_template_default")
        let g:file_template_default = {}
    endif
    let g:file_template_default.PKGBUILD = "default"

    let g:author="Piotr Rogoza"
    " let g:email="nice@email.have.me"
    " let g:webpage='www.myextraordinary.example.com'
    " let g:phone="+55 (11) 1234-5678"
    let g:DoxygenToolkit_authorName=g:author
endif
" vimwiki {{{2
if plugin#isEnabled('vimwiki')
    let g:vimwiki_list = [
                \ {'path': '~/Documents/vimwiki', 'ext': '.wiki'},
                \ {'path': '~/Projects/Projects-other/shellcheck.wiki/', 'syntax': 'markdown', 'ext': '.md'},
                \ {'path': '~/Projects/Projects-other/awesome-macos-command-line/', 'syntax': 'markdown', 'ext': '.md'},
                \ {'path': '~/Projects/Projects-other/markdown-here.wiki', 'syntax': 'markdown', 'ext': '.md'}
                \]
    let g:vimwiki_global_ext=0
    nmap <Leader>wf <Plug>VimwikiFollowLink
    nmap <Leader>we <Plug>VimwikiSplitLink
    nmap <Leader>vs :vs \| :VimwikiIndex<CR>
    nnoremap <silent> <leader>uu :call vimwiki#base#linkify()<cr>
    nmap <Leader>wq <Plug>VimwikiVSplitLink

    function! VimwikiFindIncompleteTasks()
    lvimgrep /- \[ \]/ %:p
    lopen
    endfunction

    function! VimwikiFindAllIncompleteTasks()
    VimwikiSearch /- \[ \]/
    lopen
    endfunction

    nmap <Leader>wx :call VimwikiFindIncompleteTasks()<CR>
    nmap <Leader>wa :call VimwikiFindAllIncompleteTasks()<CR>
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
    " To enable fzf's preview window set g:vista_fzf_preview.
    " The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
    " For example:
    let g:vista_fzf_preview = ['right:50%']

endif
" }}}
" yaifa {{{2
if plugin#isEnabled('yaifa')
    let yaifa_max_lines = 512
endif
"}}}
"}}}

