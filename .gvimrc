"===============================================================================
"          File:  .gvimrc
" 
"   Description:  suggestion for a personal configuration file ~/.gvimrc
"        Author:  Piot Rogoża
"===============================================================================
"
"===============================================================================
" GENERAL SETTINGS
"===============================================================================
set cmdheight=2                                 " Make command line two lines high
set guioptions+=mgtT                             " Uktywnia na 'twardo' elementy GUI: pasek menu i odrywanie menu
"set noguipty                                   " Make external commands work through a pipe instead of a pseudo-tty
"set columns=80 lines=30                        " don't inherit geometry from parent term
"set mousemodel=popup                           " right mouse button pops up a menu in the GUI
"-------------------------------------------------------------------------------
"  Some additional hot keys:
"    S-F3  -  call gvim file browser,  nie działa
"-------------------------------------------------------------------------------
 noremap  <silent> <s-F3>       :silent browse confirm e<CR>
inoremap  <silent> <s-F3>  <Esc>:silent browse confirm e<CR>
"
"-------------------------------------------------------------------------------
" toggle insert mode <--> 'normal mode with the <RightMouse>-key
"-------------------------------------------------------------------------------
"nnoremap  <RightMouse> <Insert>
"inoremap  <RightMouse> <ESC>
"
"-------------------------------------------------------------------------------
" use font with clearly distinguishable brackets : ()[]{}
"-------------------------------------------------------------------------------
set guifont=Bitstream\ Vera\ Sans\ Mono\ 11
set mouse=a
