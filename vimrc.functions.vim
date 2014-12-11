"===================================================================================
"         FILE:  vimrc.functions.vim
"  DESCRIPTION:  User vim functions without mappings, see vimrc.keys
"===================================================================================
" exclamation mark(!) means that function replace previous

function! QuoteInsertionWrapper (quote) "{{{
" Add a second quote only if the left and the right character are not keyword
" characters.
	let	col	= col('.')
	if getline('.')[col-2] !~ '\k' && getline('.')[col] !~ '\k'
		normal ax
		exe "normal r".a:quote."h"
	end
endfunction    " QuoteInsertionWrapper }}}
function! s:Tag() "{{{
" Tworzenie pliku znaczników
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
endfun "}}}
function! InsertTabWrapper(direction) "{{{
" Benoit Cerrina tab completion + A. addittion tip#102
" Bardzo fajna funkcja umożliwiająca uzupełnianie wyrazów przez <Tab>
" Jest wtyczka supertab realizująca to samo
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    elseif "backward" == a:direction
        return "\<c-p>"
    else
        return "\<c-n>"
    endif
endfunction
"}}}
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
" Nie pozwalaj na żadne modyfikacje plików tylko do odczytu.
    if version >= 600
        if &readonly
            setlocal nomodifiable
        endif
    endif
endfunction
"}}}
function! ChangeFileencoding() "{{{
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
command! -nargs=0 Trim :%s/\s\+$//
