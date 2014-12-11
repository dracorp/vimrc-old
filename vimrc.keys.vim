"===================================================================================
"         FILE:  vimrc.keys.vim
"  DESCRIPTION:  Plik z mapowaniem klawiszy
"===================================================================================
"
" !         make a switch from a key
" <CR>      it's enter
" <c-o>     allows in 'insert' mode insert a command
" <silent>  a mapping will not be echoed on the command line
" %         actual file, :he expand
" <leader>  default \
"-------------------------------------------------------------------------------
"     F1  -  pomoc, man.vim file.ext | file | filetype
"     F2  -  write file without confirmation
"     F3  -  call file explorer Ex
"     F4  -  show tag under curser in the preview window (tagfile must exist!)
"     F6  -  list all errors
"     F7  -  display previous error
"     F8  -  display next error
"     F9  -  display number of line
"     F12 -  list buffers and edit n-th buffer
"-------------------------------------------------------------------------------
if has("unix")
    "noremap    <silent>    <F1>    :help usr_toc.txt@pl<CR>
    noremap     <silent>    <F1>    :call DisplayManpage()<CR>
endif

" open file under cursors in a new window (a vertical split)
map <c-w>F :vertical wincmd f<CR>

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" Toggle line numbers
nnoremap <leader>N :setlocal number!<cr>

" podświetlaj linię pod kursorem
nnoremap <Leader>c :set cursorline!<CR>

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

noremap     <silent>    <F8>    :cnext<CR>
"noremap  <silent> <F8>         :call ChangeFileencoding()<CR>
noremap     <silent>    <F9>    :set nonumber!<CR>
noremap                 <F12>   :ls<CR>:edit #
"noremap <silent> <F12> :cal VimCommanderToggle()<CR>
"
inoremap    <silent>    <F1>    <C-C>:call DisplayManpage()<CR>
"inoremap  <silent> <F2>    <C-C>:write<CR>
inoremap    <silent>    <F3>    <C-C>:Explore<CR>
inoremap    <silent>    <F4>    <C-C>:execute ":ptag ".expand("<cword>")<CR>
inoremap    <silent>    <F5>    <C-C>:copen<CR>
"inoremap    <silent>    <F6>    <C-C>:cclose<CR>
inoremap    <silent>    <F7>    <C-C>:cprevious<CR>
inoremap    <silent>    <F8>    <C-C>:cnext<CR>
inoremap    <silent>    <F9>    <C-O>:set nonumber!<CR>
inoremap                <F12>   <C-C>:ls<CR>:edit #
"
" wklejanie
vnoremap <C-Insert> "+y
"
" search for visually highlighted text
"vmap // y/<C-R>"<CR>
"with spec chars
vmap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"
"przelaczanie podswietlania wynikow szukania ctrl+n
noremap <silent> <C-n> <Esc>:call ToggleHLSearch()<CR>
"
"-------------------------------------------------------------------------------
" comma always followed by a space
"-------------------------------------------------------------------------------
"inoremap  ,  ,<Space>
"
"-------------------------------------------------------------------------------
" autocomplete parenthesis, (brackets) and braces
"-------------------------------------------------------------------------------
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
"
"-------------------------------------------------------------------------------
" autocomplete quotes (visual and select mode)
"-------------------------------------------------------------------------------
"xnoremap  '  s''<Esc>P<Right>
"xnoremap  "  s""<Esc>P<Right>
"xnoremap  `  s``<Esc>P<Right>
"
"inoremap	'  '<Esc>:call QuoteInsertionWrapper("'")<CR>a
"inoremap	"  "<Esc>:call QuoteInsertionWrapper('"')<CR>a
"inoremap	`  `<Esc>:call QuoteInsertionWrapper('`')<CR>a
"
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
"
"backspace in VisualMode deletes selection
"vnoremap <BS> d
"
"-------------------------------------------------------------------------------
"Nawigowanie po złamaniej lini jak po zwykłej
"-------------------------------------------------------------------------------
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
"
"Edycja wielu plików: vim -o ....
"map <F2> <C-W><C-W>
"imap <F2> <C-O><C-W><C-W>
"Edycja wielu plików: vim plik1 plik2 plik3
"map <F3> :np!<CR>
"imap <F3> <ESC>:np!<CR>
"
"map :W :w
"obsługa zakładek w vimie, CTRL-I robi to co TAB, domyślnie CTRL-I skacze do przodu
"nnoremap <TAB> :tabnext<CR>
"nnoremap <S-TAB> :tabp<CR>
"nnoremap <C-]> :call <SID>Tag()<CR>\|:echo ""<CR>
"inoremap <Tab> <C-R>=InsertTabWrapper("backward")<cr>
"inoremap <S-Tab> <C-R>=InsertTabWrapper("forward")<cr>
nnoremap <c-tab> :tabnext<cr>
nnoremap <c-s-tab> :tabprev<cr>

"highlight search
"nnoremap <s-3> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>

"vim-toggle
imap <C-T>:call Toggle()<CR>
nmap <C-T>:call Toggle()<CR>
vmap <C-T> <ESC>:call Toggle()<CR>

" Quote words under cursor
nnoremap <leader>" viW<esc>a"<esc>gvo<esc>i"<esc>gvo<esc>3l
nnoremap <leader>' viW<esc>a'<esc>gvo<esc>i'<esc>gvo<esc>3l

" Quote current selection
" TODO: This only works for selections that are created "forwardly"
vnoremap <leader>" <esc>a"<esc>gvo<esc>i"<esc>gvo<esc>ll
vnoremap <leader>' <esc>a'<esc>gvo<esc>i'<esc>gvo<esc>ll

" Use shift-H and shift-L for move to beginning/end
nnoremap H 0
nnoremap L $

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
"nnoremap n n:call PulseCursorLine()<cr>
"nnoremap N N:call PulseCursorLine()<cr>

nnoremap <Leader>h :set hlsearch!<CR>
