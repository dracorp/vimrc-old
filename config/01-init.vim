" Disable vim distribution plugins
" https://github.com/mhinz/vim-galore
"| Plugin     | Disable it using..                  | Help |
"|------------|-------------------------------------|------|
"| 2html      | `let g:loaded_2html_plugin = 1`     | `:h 2html` |
"| getscript  | `let g:loaded_getscriptPlugin = 1`  | `:h pi_getscript` |
"| gzip       | `let g:loaded_gzip = 1`             | `:h pi_gzip` |
"| logipat    | `let g:loaded_logipat = 1`          | `:h pi_logipat` |
"| matchparen | `let g:loaded_matchparen = 1`       | `:h pi_paren` |
"| netrw      | `let g:loaded_netrwPlugin = 1`      | `:h pi_netrw` |
"| rrhelper   | `let g:loaded_rrhelper = 1`         | `:e $VIMRUNTIME/plugin/rrhelper.vim` |
"| spellfile  | `let g:loaded_spellfile_plugin = 1` | `:h spellfile.vim` |
"| tar        | `let g:loaded_tarPlugin = 1`        | `:h pi_tar` |
"| vimball    | `let g:loaded_vimballPlugin = 1`    | `:h pi_vimball` |
"| zip        | `let g:loaded_zipPlugin = 1`        | `:h pi_zip` |
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
"let g:loaded_gzip = 1                          " some vim installation comes with compressed help files
let g:loaded_logiPat = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:netrw_nogx = 1                            " disable netrw's gx mapping.
let g:loaded_rrhelper = 1  " ?
let g:loaded_shada_plugin = 1  " ?
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_tutor_mode_plugin = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1

filetype plugin indent on

let g:MSWIN   = has('win16')  || has('win32')   || has('win64')     || has('win95')
let g:MSWIN64 = has('win64')
let g:UNIX    = has('unix')   || has('macunix') || has('win32unix')
let g:MACOS   = has('mac')
let g:PYTHON3 = has('python3')
let g:PYTHON  = has('python') || has('python3')
" Note: for proper work with pythonX on MacOs with nvim install:
" brew install python
" brew install python3
" pip2 install neovim --upgrade
" pip3 install neovim --upgrade
let g:OS      = substitute(system('uname'), "\n", "", "")

" multi_byte/unicode/utf {{{
if has('multi_byte')
    let g:UNICODE = 0
    if &termencoding == ''
        let &termencoding = &encoding
    endif
    if $LC_ALL =~? '\vutf-?8' || $LANG =~? '\vutf-?8'
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
    if has('nvim')
        " nvim uses ~/.config/nvim/init.vim instead of ~/.vim/vimrc or ~/.vimrc
        let vimrc_dir = $HOME . '/.config/nvim/'
    else
        let vimrc_dir = $HOME . '/.vim/'
    endif
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

" Plugins base configuration {{{2
" Define bundle directory for plugins and also default directory to check if
" a plugin exists for function plugin#isEnabled.
" Use g:bundle_dir or if you want overwrite default directory to check for
" plugin use g:pluginIsEnabledDirectory
let bundle_dir = vimrc_dir . 'bundle'
"let g:pluginIsEnabledDirectory = expand("$HOME/.vim/bundle")
"let g:pluginIsEnabledVerbose = 1
" Remove existing autocommands to avoid duplicates
autocmd!
" }}}

runtime! ftplugin/man.vim
let g:ft_man_folding_enable = 1
let g:ft_man_open_mode = 'vert'
let g:ft_man_no_sect_fallback = 1
