"===================================================================================
"         FILE:  vimrc.functions.vim
"  DESCRIPTION:  Plik z funkcjami,  mapowanie klawiszy do funkcji odbywa się
"  przez plik vimrc.keys.vim
"       AUTHOR:  Piotr Rogoża
"===================================================================================
"
" Wkrzyknik(!) przy funkcji powoduje, że przy wczytywaniu zastąpi już
" istniejącą funkcję
"-------------------------------------------------------------------------------
" Add a second quote only if the left and the right character are not keyword
" characters.
"-------------------------------------------------------------------------------
function! QuoteInsertionWrapper (quote)
	let	col	= col('.')
	if getline('.')[col-2] !~ '\k' && getline('.')[col] !~ '\k'
		normal ax
		exe "normal r".a:quote."h"
	end
endfunction    " ----------  end of function QuoteInsertionWrapper  ----------
"-------------------------------------------------------------------------------
" Tworzenie pliku znaczników
"-------------------------------------------------------------------------------
function! s:Tag()
   try
      exe "norm! \<c-]>"
   catch /^Vim([^)]\+):E433/
      call inputsave()
      let l:kat = input("Katalog główny projektu:   ", ".")
      let l:opt = input("Opcje dla ctags:   ", "-R --fields=+S")
      call inputrestore()
      exe "!cd " . l:kat . " ; ctags " . l:opt . " ."
      exe "norm! \<c-]>"
   endtry
endfun
"-------------------------------------------------------------------------------
" Benoit Cerrina tab completion + A. addittion tip#102
" Bardzo fajna funkcja umożliwiająca uzupełnianie wyrazów przez <Tab>
" Jest wtyczka supertab realizująca to samo
"-------------------------------------------------------------------------------
function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction
"-------------------------------------------------------------------------------
" On/Off highlight search
"-------------------------------------------------------------------------------
function! ToggleHLSearch()
      if &hls
           set nohls
      else
           set hls
      endif
endfunction
"-------------------------------------------------------------------------------
" Nie pozwalaj na żadne modyfikacje plików tylko do odczytu.
"-------------------------------------------------------------------------------
function! CheckReadonly()
    if version >= 600
        if &readonly
            setlocal nomodifiable
        endif
    endif
endfunction
"-------------------------------------------------------------------------------
" funkcja wykrywająca kodowanie pliku i ustawiająca na właściwe,
" domyślnie brane jest kod
"-------------------------------------------------------------------------------
function! ChangeFileencoding()
    let encodings = ['cp1250', 'utf-8', 'iso8859-2']
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
"-------------------------------------------------------------------------------
" Wyświetla stronę man dla danego pliku
"-------------------------------------------------------------------------------
function! DisplayManpage()
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
" Otwarcie linka w przeglądarce
if exists("loaded_mozilla")
  finish
endif
let loaded_mozilla=1

function! CopyAll()
    " zaznacz wszystko
    exec 'normal ggVG'
    " kopiuj wszystko
    exec 'normal "+y'
endf

function ReloadVimrc()
    execute ":source " . vimrc_dir . "vimrc"
endf
" Pulse ------------------------------------------------------------------- {{{

function! PulseCursorLine()
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
