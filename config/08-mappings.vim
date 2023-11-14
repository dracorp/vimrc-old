" Key mappings

"| Recursive | Non-recursive | Unmap    | Modes                            |
"|-----------|--------------------------|----------------------------------|
"| :map      | :noremap      | :unmap   | normal, visual, operator-pending |
"| :nmap     | :nnoremap     | :nunmap  | normal                           |
"| :xmap     | :xnoremap     | :xunmap  | visual                           |
"| :cmap     | :cnoremap     | :cunmap  | command-line                     |
"| :omap     | :onoremap     | :ounmap  | operator-pending                 |
"| :imap     | :inoremap     | :iunmap  | insert                           |

" !         make a switch from a key
" <CR>      Enter key
" <C-o>     allows in 'insert' mode insert a command
" <silent>  a mapping will not be echoed on the command line
" %         actual file, :he expand
" <leader>  default \

" add additional mapleader instead of setting of mapleader option
nmap , \

if has('folding')
    " Mappings to easily toggle fold levels
    nnoremap z0 :set foldlevel=0<cr>
    nnoremap z1 :set foldlevel=1<cr>
    nnoremap z2 :set foldlevel=2<cr>
    nnoremap z3 :set foldlevel=3<cr>
    nnoremap z4 :set foldlevel=4<cr>
    nnoremap z5 :set foldlevel=5<cr>
endif

" Leader {{{

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>
" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" highlight line under cursor, horizontal cursor
nnoremap <Leader>l :setlocal cursorline!<CR>
nnoremap <Leader>L :setlocal cursorcolumn!<CR>

nnoremap <leader>; ;

" Quickly close the current window
" nnoremap <leader>q :qa<CR>

" Sort paragraphs
vnoremap <leader>s !sort -f<CR>gv
nnoremap <leader>s vip!sort -f<CR><Esc>

nnoremap <Leader>H :set hlsearch!<CR>

" Quote words under cursor
nnoremap <leader>" viW<esc>a"<esc>gvo<esc>i"<esc>gvo<esc>3l
nnoremap <leader>' viW<esc>a'<esc>gvo<esc>i'<esc>gvo<esc>3l
" }}}

" change search mapping and don't jump
" nnoremap * g#``
" nnoremap # g*``
" nnoremap g* #``
" nnoremap g# *``

nnoremap * g*``
nnoremap # g#``
nnoremap g* *``
nnoremap g# #``

" Turn off hlsearch
"nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
" nnoremap n nzzzv
" nnoremap N Nzzzv

" Function keys
" refresh syntax highlight
 noremap <silent> <F10> <Esc>:syntax sync fromstart<CR>
inoremap <silent> <F10> <C-o>:syntax sync fromstart<CR>

" Permanent 'very magic' mode, see :he pattern
" search, broken history search!
" nnoremap / /\v
" vnoremap / /\v
" substitute
cnoremap %s/ %smagic/
cnoremap %s# %smagic#
" substitute in visual mode
cnoremap \>s/ \>smagic/
cnoremap \>s# \>smagic#
" global
nnoremap :g/ :g/\v
nnoremap :g// :g//

" paste mode, where you can paste mass data
" that won't be autoindented
set pastetoggle=<S-F6>                         " deprecated: replaced by vim-bracketed-paste plugin

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

" Use Q for formatting the current paragraph (or visual selection)
vnoremap Q gq
nnoremap Q gqap

map zp :setlocal spell!<CR>
imap zP <ESC>:setlocal spell!<CR>i<right>

if g:MACOS
    " Coping
    vnoremap <C-Help> "+y
    " Pasting
    inoremap <S-Help> "+gP
    " Cutting
    vnoremap <C-S-Help> "+x
endif

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

" for normal and visual mode treat Space as PageDown
nnoremap <space> <pagedown>
vnoremap <space> <pagedown>

map <ESC>[H <Home>
map <ESC>[F <End>
imap <ESC>[H <C-O><Home>
imap <ESC>[F <C-O><End>
cmap <ESC>[H <Home>
cmap <ESC>[F <End>
