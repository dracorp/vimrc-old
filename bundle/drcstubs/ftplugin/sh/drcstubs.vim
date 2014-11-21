" drcstubs.vim: Dr Chip's Sh Stubs  (a plugin)
"
"  Author:  Charles E. Campbell, Jr. (PhD)
"  Date:    Nov 04, 2009
"  Version: 3
"
"  Usage:  (requires 6.0 or later)
"
"   These maps all work during insert mode while editing vim
"   scripts.  Use either the shorthand or longhand maps
"   below, and the associated construct will be expanded to
"   include parentheses, curly braces, and the cursor will be
"   moved to a convenient location, still in insert mode, for
"   further editing.
"
"   Shorthand  Longhand
"   Map        Map
"   ---------  --------
"   c`         c[ase]`
"   i`         if`
"   e`         els[e]`
"   ei`        eli[f]`
"   fo`        for`
"   fu`        fu[nction]`
"   w`         wh[ile]`
"
"   Caveat: these maps will not work if "set paste" is on
"
"   After a line with [[...]], a line matching "^\s*($"
"   (ie. enter a "(" on an otherwise blank line)
"   will toggle between "[[..]]" and "((...))" on the line above.
"   Furthermore, a \( on such a line will become simply a "(",
"   so one can still enter a line beginning with an open parenthesis.
"
" Installation:
"
" This copy of DrC's Sh-Stubs is a ftplugin for vim 6.0: put it in
"  ${HOME}/.vim/ftplugin/sh/
" (or make suitable links) and have "filetype plugin on" in your <.vimrc>.
"
" "Blessed is the man who endures temptation, for when he has
"  been approved, he will receive the crown of life, which the Lord
"  promised to those who love him." James 1:12
"
" =======================================================================

" Load Once: {{{1
if exists("b:loaded_drcstubs")
  finish
endif
let b:loaded_drcstubs= "v3"

" ---------------------------------------------------------------------
" Special Syntax: {{{1
syn keyword	vimTodo COMBAK
syn match	vimTodo "^[- ]*COMBAK[- ]*$" 

" ---------------------------------------------------------------------
" Public Interface: {{{1

" backquote calls DrChipShStubs function
if !hasmapto('<Plug>UseDrCStubs')
 imap <buffer> <unique> ` <Plug>UseDrCShStubs
endif
inoremap <Plug>UseDrCShStubs <Esc>:call <SID>DrCShStubs()<CR>a
inoremap <buffer> <silent> (	(<c-o>:call <sid>DrCShParenChk()<cr>

" provide help for drcstubs
com! Drcstubs call s:ShMapHlp()

" ---------------------------------------------------------------------
" DrCShStubs: this function changes the backquote into {{{1
"             text based on what the preceding word was
fun! <SID>DrCShStubs()
 let vekeep= &ve
 set ve=

 let wrd=expand("<cWORD>")

 if     wrd =~ '\<ca\%[se]'
  exe "norm! bdWacase X in\<CR>esac\<Esc>k$FXxh"
  ino <esc> <esc>:iun <c-v><esc><cr>o
 elseif wrd =~ '\<c\>'
  exe "norm! xacase X in\<CR>esac\<Esc>k$FXxh"
  ino <esc> <esc>:iun <c-v><esc><cr>o

 elseif wrd =~ '\<fo\%[r]\>'
  exe "norm! bdWafor X in  ; do\<cr>done\<esc>k$FXxh"
"  ino <esc> <esc>:iun <c-v><esc><cr>0f;hha
  ino <silent> <esc> <esc>:call <sid>DrCShFor()<cr>0f;hha
 elseif wrd =~ '\<f\>'
  exe "norm! xafor X in  ; do\<cr>done\<esc>k$FXxh"
  ino <esc> <esc>:call <sid>DrCShFor()<cr>0f;hha

 elseif wrd =~ '\<if\>'
  exe "norm! bdWaif [[ X ]]; then\<CR>fi\<Esc>k$FXxh"
  ino <esc> <esc>:iun <c-v><esc><cr>o
 elseif wrd =~ '\<i\>'
  exe "norm! xaif [[ X ]]; then\<CR>fi\<Esc>k$FXxh"
  ino <esc> <esc>:iun <c-v><esc><cr>o

 elseif wrd =~ '\<els\%[e]\>'
  exe "norm! bdWaelse\<cr>	\<esc>hx"
 elseif wrd =~ '\<e\>'
  exe "norm! xaelse\<cr>	\<esc>hx"

 elseif wrd =~ '\<eli\%[f]\>'
  exe "norm! bdWaelif [[ X ]]; then\<Esc>$FXxh"
  ino <esc> <esc>:iun <c-v><esc><cr>o
 elseif wrd =~ '\<ei\>'
  exe "norm! bdWaelif [[ X ]]; then\<Esc>$FXxh"
  ino <esc> <esc>:iun <c-v><esc><cr>o

 elseif wrd =~ '\<fu\%[nction]\>'
  exe "norm! bdWafunction X\<cr>{\<cr>}\<esc>kk0fXxa"
  ino <esc> <esc>0j:iun <c-v><esc><cr>o

 elseif wrd =~ '\<wh\%[ile]\>'
  exe "norm! bdWawhile [[ X ]]; do\<CR>done\<Esc>k$FXxh"
  ino <esc> <esc>0:iun <c-v><esc><cr>o
 elseif wrd =~ '\<w\>'
  exe "norm! xawhile [[ X ]]; do\<CR>done\<Esc>k$FXxh"
  ino <esc> <esc>0:iun <c-v><esc><cr>o

 else
  exe "norm! a`\<Esc>"
 endif

 let &ve= vekeep
endfun

" ---------------------------------------------------------------------
"  DrCShParenChk:
fun! s:DrCShParenChk()
  let curline= line(".")
  let prvline= curline - 1
  if getline(curline) =~ '^\s*($' && getline(prvline) =~ '\[\[.\{-}]]'
   exe prvline.'s/\[\[/((/e'
   exe prvline.'s/]]/))/e'
   norm! j$xa
  elseif getline(curline) =~ '^\s*($' && getline(prvline) =~ '((.\{-}))'
   exe prvline.'s/((/[[/e'
   exe prvline.'s/))/]]/e'
   norm! j$xa
  elseif getline(curline) =~ '^\s*\\($'
   norm! hhxl
  endif
endfun

" ---------------------------------------------------------------------
" DrCShFor: {{{2
fun! s:DrCShFor()
  ino <esc> <esc>:iun <c-v><esc><cr>o
endfun

" ---------------------------------------------------------------------
" ShMapHlp: sets up a special window holding a list of my Sh-related {{{1
" maps, imaps, etc
fun! s:ShMapHlp()
"  call Dfunc("ShMapHlp()")

  " create DrC's Sh Stubs window
  if !exists("s:sh_helpbuf") || !bufexists(s:sh_helpbuf)
   let isfkeep= &isfname
   set isfname-=[
   set isfname-=]
   exe "bo sp ".escape("[DrC's Sh Stubs]"," '[]")
   set buftype=nofile
   set bufhidden=wipe
   set noswapfile
   set noro
   let &isfname     = isfkeep
   let s:sh_helpbuf = bufnr("%")
  endif

  put ='_               Imaps_'
  put ='_Longhand     Shorthand 	Expands To_'
  put =' --------     --------- 	----------'
  put ='  ca[se]`      c`       	 case X in\|Y\|esac'
  put ='  fo[r]`       f`       	 for X in Y ; do\|Z\|done'
  put ='  if`          i`       	 if [[ X ]]; then\|Y\|fi'
  put ='  eli[f]`      ei`      	 elif [[ X ]]; then\|Y'
  put ='  els[e]`      e`       	 else\|X'
  put ='  fu[nction]`           	 function X\|{\|Y\|}'
  put ='  wh[ile]`     w`       	 while [[ X ]]; do\|Y\|done'
  put =' '
  put ='	 \|=carriage return  X,Y,Z=successive cursor placements'

  " syntax highlighting
  syn match SHmapBar		'---\+'
  syn match SHmapInfo	'([^)]\+)'	contains=SHmapParen
  syn match SHmapTitle	'^.*{{{\d$'	contains=SHmapIgnore
  syn match SHmapTitle	'_.\{-}_'	contains=SHmapIgnore
  syn match SHmapIgnore	'{{{\d'		contained
  syn match SHmapIgnore	'_'			contained
  syn match SHmapParen	'[()]'		contained
  syn match SHmapExpansion '\t .*$'	contains=SHmapKeys,SHmapParen,SHmapCursor,SHmapNewline
  syn match SHmapCursor	'\<[XYZ]\>'	contained
  syn match SHmapNewline '|'		contained
  syn case match
  syn keyword SHmapKeys	contained case esac do done for if in then else elif function fi while

  if !exists("b:did_drcstubs_help")
   command -nargs=+ HiLink hi def link <args>
   HiLink SHmapBar 		Delimiter
   HiLink SHmapIgnore	Ignore
   HiLink SHmapInfo		String
   HiLink SHmapNewline	Delimiter
   HiLink SHmapParen	Delimiter
   HiLink SHmapTitle	Statement
   HiLink SHmapKeys		Statement
   HiLink SHmapCursor	Special
   let b:did_drcstubs_help= 1
   delc HiLink
  endif

  norm! 1Gdd
  setlocal ro
  setlocal fdm=marker
  norm! zM
"  call Dret("ShMapHlp")
endfun

" ---------------------------------------------------------------------
"  s:ShMenuToggle: toggle display of menu
augroup DrcShStubsEvents
 au!
 au BufEnter	*	call s:ShMenuToggle(1)
 au BufLeave	*	call s:ShMenuToggle(0)
augroup END
fun! s:ShMenuToggle(menustate)
  if &ft == "sh" && has("gui") && has("gui_running") && has("menu")
"   call Dfunc("s:ShMenuToggle(menustate=".a:menustate.") ft<".&ft.">")
   if a:menustate
    imenu DrChip.ShStubs.Case<tab>ca`	ca`
    imenu DrChip.ShStubs.For<tab>fo`	fo`
    imenu DrChip.ShStubs.If<tab>if`	if`
    imenu DrChip.ShStubs.Else<tab>els`	els`
    imenu DrChip.ShStubs.ElseIf<tab>eli`	eli`
    imenu DrChip.ShStubs.Function<tab>fun`	fun`
    imenu DrChip.ShStubs.While<tab>wh`	wh`
   else
    silent! iunmenu DrChip.ShStubs.Case
    silent! iunmenu DrChip.ShStubs.For
    silent! iunmenu DrChip.ShStubs.If
    silent! iunmenu DrChip.ShStubs.Else
    silent! iunmenu DrChip.ShStubs.ElseIf
    silent! iunmenu DrChip.ShStubs.Function
    silent! iunmenu DrChip.ShStubs.While
   endif
"   call Dret("s:ShMenuToggle")
  endif
endfun

" ---------------------------------------------------------------------
"  vim: fdm=marker
