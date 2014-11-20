" drcstubs.vim: Dr Chip's C Stubs  (a plugin)
"   isk is set to include # so as not to break #if
"
"  Author:  Charles E. Campbell
"  Date:    Jun 19, 2010
"  Version: 4a
"
" ---------------------------------------------------------------------
"  Usage:  (requires 6.0 or later) {{{1
"
"   These maps all work during insert mode while editing a C
"   or C++ program.  Use either the shorthand or longhand maps
"   below, and the associated construct will be expanded to
"   include parentheses, curly braces, and the cursor will be
"   moved to a convenient location, still in insert mode, for
"   further editing.
"
"   Shorthand  Longhand
"   Map        Map
"   ---------  --------
"   i`         if`
"   e`         els[e]`
"   ei`        eli[f]`
"   er`
"   f`         for`
"   w`         wh[ile]`
"   s`         sw[itch]`
"   c`         ca[se]`
"   d`         defa[ult]`
"              do`
"              in[clude]` yields #include
"              de[fine]`  yields #define
"   E`         Ed[bg]`    (see http://mysite.verizon.net/astronaut/dbg)
"   R`         Rd[bg]`    (see http://mysite.verizon.net/astronaut/dbg)
"   D`         Dp[rintf]` (see http://mysite.verizon.net/astronaut/dbg)
"   #`                    #ifdef ... #endif
"   ?`         ? "" : "null "
"
"   Caveat: these maps will not work if "set paste" is on
"
" ---------------------------------------------------------------------
" Installation: {{{2
"
" This copy of DrC's C-Stubs is filetype plugin for vim 6.0: put it in
"  ${HOME}/.vim/ftplugin/c/    -and-   ${HOME}/.vim/ftplugin/cpp/
" (or make suitable links) and put "filetype plugin on" in your <.vimrc>.
"
" "For I am convinced that neither death nor life, neither angels nor demons,
"  neither the present nor the future, nor any powers, nor height nor depth,
"  nor anything else in all creation, will be able to separate us from the
"  love of God that is in Christ Jesus our Lord."  Rom 8:38
" =======================================================================
" Load Once: {{{1
if exists("b:loaded_drcstubs")
  finish
endif
let b:loaded_drcstubs= "v4a"
let b:undo_ftplugin  ="let &isk=@,48-57,_"

" ---------------------------------------------------------------------
" Special Syntax: {{{1
syn keyword cTodo COMBAK
syn match cTodo "^[- ]*COMBAK[- ]*$" 
setlocal isk+=#
setlocal isk-=:
"DechoTabOn

" =====================================================================
" Public Interface: {{{1

" backquote calls DrChipCStubs function
if !hasmapto('<Plug>UseDrCStubs')
 imap <buffer> <unique> ` <Plug>UseDrCStubs
endif
inoremap <Plug>UseDrCStubs <Esc>:call <SID>DrChipCStubs()<CR>a

" provide help for drcstubs
com! Drcstubs call s:CMapHlp()

if has("gui") && has("gui_running") && !exists("s:did_drcstubs_menu")
 let s:did_drcstubs_menu= 1
 menu DrChip.DrCStubs.Help	:Drcstubs<cr>
 imenu DrChip.DrCStubs.if	if`
 imenu DrChip.DrCStubs.else	e`
 imenu DrChip.DrCStubs.elseif	ei`
 imenu DrChip.DrCStubs.for	f`
 imenu DrChip.DrCStubs.while	w`
 imenu DrChip.DrCStubs.switch	s`
 imenu DrChip.DrCStubs.case	c`
 imenu DrChip.DrCStubs.default	d`
 imenu DrChip.DrCStubs.do	do`
 imenu DrChip.DrCStubs.include	in`
 imenu DrChip.DrCStubs.define	de`
 imenu DrChip.DrCStubs.Edbg	E`
 imenu DrChip.DrCStubs.Rdbg	R`
 imenu DrChip.DrCStubs.Dprintf	D`
 imenu DrChip.DrCStubs.ifdef	#`
 imenu DrChip.DrCStubs.?\.\.	?`
endif

" =====================================================================
" Functions: {{{1

" ---------------------------------------------------------------------
" DrChipCStubs: this function changes the backquote into {{{2
"               text based on what the preceding word was
fun! s:DrChipCStubs()
"  call Dfunc("DrChipCStubs()")
  let vekeep= &ve
  set ve=
 
  let wrd= expand("<cWORD>")
  if wrd != '^#$'
   let wrd= expand("<cword>")
  endif
  let chr= substitute(getline("."),'^.*\%'.col('.').'c\(.\).*$','\1','')
  if strlen(chr) > 1
   let chr   = substitute(wrd,'^.*\(.\)$','\1','')
  endif
  let inline= (virtcol("$") - virtcol(".")) > 1
"  call Decho("wrd<".wrd."> chr<".chr."> inline=".inline)

  if chr =~ '^\\'
   norm! r`

  elseif chr =~ '?'
"   call Decho('chr=~?')
   if inline
    exe 'norm! xi? "" : "null ",'
   else
    exe 'norm! xa? "" : "null ",'
   endif

  elseif     wrd =~ '\<if\>'
"   call Decho('\<if')
   exe "norm! bdWaif() {\<CR>}\<Esc>k$F("
   ino <esc> <esc>f{:iun <c-v><esc><cr>o
  elseif wrd =~ '\<i\>'
"   call Decho('\<i')
   exe "norm! xaif() {\<CR>}\<Esc>k$F("
   ino <esc> <esc>f{:iun <c-v><esc><cr>o
 
  elseif wrd =~ '\<els\%[e]\>'
   exe "norm! bdWaelse {\<CR>}\<Esc>O \<c-h>\<Esc>"
"   call Decho('\<els')
  elseif wrd =~ '\<e\>'
   exe "norm! xaelse {\<CR>}\<Esc>O \<c-h>\<Esc>"
"   call Decho('\<e')
 
  elseif wrd =~ 'eli\%[f]\>'
   exe "norm! bdWaelse if() {\<CR>}\<Esc>k$F("
   ino <esc> <esc>f{:iun <c-v><esc><cr>o
"   call Decho('\<eli')
  elseif wrd =~ '\<ei\>'
   exe "norm! bdWaelse if() {\<CR>}\<Esc>k$F("
   ino <esc> <esc>f{:iun <c-v><esc><cr>o
"   call Decho('\<ei')
 
  elseif wrd =~ 'fo\%[r]\>'
   call drcstubs#DrCStubMulti("sil! norm! bdWafor(;;) {\<cr>}\<esc>",
	  \ 'k$F(l',
	  \ 'f;l',
	  \ 'f;l',
	  \ "jYP$D")
"   call Decho('\<for')
  elseif wrd =~ '\<f\>'
   call drcstubs#DrCStubMulti("sil! norm! bdWafor(;;) {\<cr>}\<esc>",
	  \ 'k$F(l',
	  \ 'f;l',
	  \ 'f;l',
	  \ "jYP$D")
"   call Decho('\<f\>')
 
  elseif wrd =~ 'wh\%[ile]\>'
   call drcstubs#DrCStubMulti("sil! norm! bdWawhile() {\<cr>",
	  \ 'k$F(',
	  \ "jYP$D")
"   call Decho('\<wh')
  elseif wrd =~ '\<w\>'
   call drcstubs#DrCStubMulti("sil! norm! bdWawhile() {\<cr>",
	  \ 'k$F(',
	  \ "jYP$D")
"   call Decho('\<w\>')
 
  elseif wrd =~ 'sw\%[itch]\>'
   exe "norm! bdWaswitch() {\<CR>}\<Esc>k$F("
   ino <esc> <esc>f{:iun <c-v><esc><cr>o
"   call Decho('\<sw')
  elseif wrd =~ '\<s\>'
   exe "norm! xaswitch() {\<CR>}\<Esc>k$F("
   ino <esc> <esc>f{:iun <c-v><esc><cr>o
"   call Decho('\<s')
 
  elseif wrd =~ 'ca\%[se]\>'
   exe "norm! bdWacase 1:\<CR>break;\<Esc>khf:hxh"
   ino <esc> <esc>$a/* %%% */<esc>:s/case \zs\(.*:\)\s*\/\* %%%/\1 \/* \1/<cr>:iun <c-v><esc><cr>o
"   call Decho('\<ca')
  elseif wrd =~ '\<c\>'
   exe "norm! xacase 1:\<CR>break;\<Esc>khf:hxh"
   ino <esc> <esc>$a/* %%% */<esc>:s/case \zs\(.*:\)\s*\/\* %%%/\1 \/* \1/<cr>:iun <c-v><esc><cr>o
"   call Decho('\<c')
 
  elseif wrd =~ 'de\%[fault]\>'
   exe "norm! bdWadefault:\<CR>break;\<Esc>O \<c-h>\<Esc>"
"   call Decho('\<de')
  elseif wrd =~ '\<d\>'
   exe "norm! xadefault:\<CR>break;\<Esc>O \<c-h>\<Esc>"
"   call Decho('\<d\>')
 
  elseif wrd =~ '\<do\>'
   call drcstubs#DrCStubMulti("norm! bdWado {\<CR>} while();\<Esc>O \<Esc>$",
	  \ "?while(\<cr>0f(l",
	  \ "?do {\<cr>j$")
"   call Decho('\<do')

  elseif wrd =~ 'er\%[r]\|xm\%[err]'
   exe 'norm! bdWaif(xmerror)(*xmerror)(XTDIO_WARNING,"(X)\n");'."\<esc>FXcw"
   ino <esc> <esc>:iun <c-v><esc><cr>f)a 
 
  elseif wrd =~ 'Ed\%[bg]\>'
   exe "norm! bdWaEdbg((\"\<Esc>ma[[?)\<CR>%BdwP`apa()\"));\<Esc>F("
   ino <esc> <esc>:iun <c-v><esc><cr>/"));$<cr>li
"   call Decho('\<Ed')
  elseif wrd =~ '\<E\>'
   exe "norm! xaEdbg((\"\<Esc>ma[[?)\<CR>%BdwP`apa()\"));\<Esc>F("
   ino <esc> <esc>:iun <c-v><esc><cr>/"));$<cr>li
"   call Decho('\<E')
 
  elseif wrd =~ 'Rd\%[bg]\>'
   exe "norm! bdWaRdbg((\"\<Esc>ma[[?)\<CR>%BdwP`apa\"));\<Esc>F\"h"
   ino <esc> <esc>:iun <c-v><esc><cr>/"));$<cr>l
"   call Decho('\<Rd')
  elseif wrd =~ '\<R\>'
   exe "norm! xaRdbg((\"\<Esc>ma[[?)\<CR>%BdwP`apa\"));\<Esc>F\"h"
   ino <esc> <esc>:iun <c-v><esc><cr>/"));$<cr>l
"   call Decho('\<R')
 
  elseif wrd =~ 'Dp\%[rintf]\>'
   exe "norm! bdWaDprintf((1,\"\"));\<Esc>4h"
   ino <esc> <esc>:iun <c-v><esc><cr>/"));$<cr>l
"   call Decho('\<Dp')
  elseif wrd =~ '\<D\>'
   exe "norm! xaDprintf((1,\"\"));\<Esc>4h"
   ino <esc> <esc>:iun <c-v><esc><cr>/"));$<cr>l
"   call Decho('\<D')
  
  elseif wrd =~ 'in\%[clude]\>'
   exe "norm! bdW0i#include \<Esc>"
"   call Decho('\<in')

  elseif wrd =~ 'de\%[fine]\>'
   exe "norm! bdW0i#define \<Esc>"
"   call Decho('\<de')
 
  elseif wrd =~ '#'
   exe "norm! 0Di#ifdef \<cr>#endif\<esc>kA"
"   call Decho('#')
 
  else
   exe "norm! a`\<Esc>"
  endif
 
  let &ve= vekeep

"  call Dret("DrChipCStubs")
endfun

" ---------------------------------------------------------------------
" CMapHlp: sets up a special window holding a list of my C-related {{{2
" maps, imaps, etc
fun! s:CMapHlp()
"  call Dfunc("CMapHlp()")

  " create DrC's C Stubs window
  if !exists("s:c_helpbuf") || !bufexists(s:c_helpbuf)
   let isfkeep= &isfname
   set isfname-=[
   set isfname-=]
   exe "bo sp ".escape("[DrC's C Stubs]"," '[]")
   set buftype=nofile
   set bufhidden=wipe
   set noswapfile
   set noro
   let &isfname   = isfkeep
   let s:c_helpbuf = bufnr("%")
  endif

  put ='_               Imaps_'
  put ='_Longhand     Shorthand 	Expands To_'
  put =' --------     --------- 	----------'
  put ='  if           i        	 if(X) {\|Y\|}'
  put ='  els[e]       e        	 else {\|X\|}'
  put ='  eli[f]       ei       	 else if(X) {\|Y\|}'
  put ='  fo[r]        f        	 for(X;Y;Z) {\|W\|}'
  put ='  wh[ile]      w        	 while(X) {\|Y\|}'
  put ='  sw[itch]     s        	 switch(X) {\|Y\|}'
  put ='  ca[se]       c        	 case X:\|Y\|break;'
  put ='  defa[ult]    d        	 default:\|Y\|break;'
  put ='  do                    	 do {\|X\|} while(Y);'
  put ='  Ed[bg]       E        	 Edbg((\"func(X)\",Y));'
  put ='  Rd[bg]       R        	 Rdbg((\"func X\",Y));'
  put ='  Dp[rintf]    D        	 Dprintf((1,\"X\",Y));'
  put ='  in[clude]             	 #include X'
  put ='  de[fine]              	 #define X'
  put ='  #                     	 #ifdef X ... #endif'
  put =' '
  put ='	 \|=carriage return  X,Y,Z,W=successive cursor placements'

  " syntax highlighting
  syn match CmapBar		'---\+'
  syn match CmapInfo	'([^)]\+)'		contains=CmapParen
  syn match CmapTitle	'^.*{{{\d$'		contains=CmapIgnore
  syn match CmapTitle	'_.\{-}_'		contains=CmapIgnore
  syn match CmapIgnore	'{{{\d'			contained
  syn match CmapIgnore	'_'				contained
  syn match CmapParen	'[{}()]'		contained
  syn match CmapExpansion '\t .*$'		contains=CmapKeys,CmapParen,CmapCursor,CmapNewline
  syn match CmapCursor	'\<[XYZW]\>'	contained
  syn match CmapNewline '|'				contained
  syn case match
  syn keyword CmapKeys	contained if else for while switch case default do Edbg Rdbg Dprintf #include #define #ifdef #endif DDmatout DDvecout DCmatout DCvecout

  if !exists("b:did_drcstubs_help")
   command -nargs=+ HiLink hi def link <args>
   HiLink CmapBar 		Delimiter
   HiLink CmapIgnore	Ignore
   HiLink CmapInfo		String
   HiLink CmapNewline	Delimiter
   HiLink CmapParen		Delimiter
   HiLink CmapTitle		Statement
   HiLink CmapKeys		Statement
   HiLink CmapCursor	Special
   let b:did_drcstubs_help= 1
   delc HiLink
  endif

  norm! 1Gdd
  setlocal ro
  setlocal fdm=marker
  norm! zM
"  call Dret("CMapHlp")
endfun

" =====================================================================
" Modelines: {{{1
"  vim: fdm=marker
