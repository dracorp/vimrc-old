" drcstubs.vim: Dr Chip's Vim Stubs  (a plugin)
"
"  Author:  Charles E. Campbell, Jr. (PhD)
"  Date:    Jun 29, 2009
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
"   i`         if`
"   e`         els[e]`
"   ei`        elsei[f]`
"   w`         wh[ile]`
"   fu`        fu[nction]`
"   F`         Dfunc`
"   R`         Dret`
"   D`         Decho`
"
"   Caveat: these maps will not work if "set paste" is on
"
" Installation:
"
" This copy of DrC's Vim-Stubs is filetype plugin for vim 6.0: put it in
"  ${HOME}/.vim/ftplugin/vim/
" (or make suitable links) and put "filetype plugin on" in your <.vimrc>.
"
" "Grace, mercy, and peace from God the Father and the Lord Jesus Christ
" our Savior" Titus 1:4b
" =======================================================================

" Load Once: {{{1
if exists("b:loaded_drcstubs")
  finish
endif
let b:loaded_drcstubs= "v3"

" ---------------------------------------------------------------------
" Special Syntax: {{{1
syn keyword vimTodo COMBAK
syn match vimTodo "^[- ]*COMBAK[- ]*$" 

" ---------------------------------------------------------------------
" Public Interface: {{{1

" backquote calls DrChipVimStubs function
if !hasmapto('<Plug>UseDrCStubs')
 imap <buffer> <unique> ` <Plug>UseDrCVimStubs
endif
inoremap <Plug>UseDrCVimStubs <Esc>:call <SID>DrCVimStubs()<CR>a

" provide help for drcstubs
com! Drcstubs call s:Vimhlp()

" ---------------------------------------------------------------------

" DrCVimStubs: this function changes the backquote into {{{1
"              text based on what the preceding word was
fun! <SID>DrCVimStubs()
 let vekeep= &ve
 set ve=

 let wrd=expand("<cWORD>")

 if     wrd =~ '\<if\>'
  exe "norm! bdWaif \<CR>endif\<Esc>k$"
 elseif wrd =~ '\<i\>'
  exe "norm! xaif \<CR>endif\<Esc>k$"

 elseif wrd =~ '\<els\%[e]\>'
  exe "norm! bdWaelse\<CR>\<Esc>O \<c-h>\<Esc>"
 elseif wrd =~ '\<e\>'
  exe "norm! xaelse \<CR>\<Esc>O \<c-h>\<Esc>"

 elseif wrd =~ '\<el\%[seif]\>'
  exe "norm! bdWaelseif \<CR>\<Esc>k$"
 elseif wrd =~ '\<ei\>'
  exe "norm! bdWaelseif \<CR>\<Esc>k$"

 elseif wrd =~ '\<fu\%[nction]\>'
  exe "norm! bdW"
  r $STUB/stubfunc.vim
  let fname= input("Enter function name: ")
  exe '/Function:/,/endfun/s/Function/'.fname.'/'
  call search('^\s*fun!','bW')
  ino <esc> <esc>:iun <c-v><esc><cr>/)$<cr>jo
  norm! f(a

 elseif wrd =~ '\<wh\%[ile]\>'
  exe "norm! bdWawhile \<CR>endwhile\<Esc>k$"
 elseif wrd =~ '\<w\>'
  exe "norm! xawhile \<CR>endwhile\<Esc>k$"

 elseif wrd =~ '\<Df\%[unc]\>'
  exe "norm! bdWacall Dfunc(\"()\")\<Esc>4hma?^\\s*fu\\%[nction]?\\>\<cr>WdwP`apla"
  ino <esc> <esc>:iun <c-v><esc><cr>/)$<cr>o
 elseif wrd =~ '\<F\>'
  exe "norm! xacall Dfunc(\"()\")\<Esc>4hma?^\\s*fu\\%[nction]?\\>\<cr>WdwP`apla"
  ino <esc> <esc>:iun <c-v><esc><cr>/)$<cr>o

 elseif wrd =~ '\<Dr\%[et]\>'
  exe "norm! bdWacall Dret(\"return \")\<Esc>2hma?^\\s*fu\\%[nction]?\\>\<cr>WdwP`apa"
  ino <esc> <esc>:iun <c-v><esc><cr>/)$<cr>
 elseif wrd =~ '\<R\>'
  exe "norm! xacall Dret(\"return \")\<Esc>2hma?^\\s*fu\\%[nction]?\\>\<cr>WdwP`apa"
  ino <esc> <esc>:iun <c-v><esc><cr>/)$<cr>

 elseif wrd =~ '\<De\%[cho]\>'
  exe "norm! bdWacall Decho(\"\")\<Esc>2hma"
  ino <esc> <esc>:iun <c-v><esc><cr>/)$<cr>o
 elseif wrd =~ '\<D\>'
  exe "norm! xacall Decho(\"\")\<Esc>2hma"
  ino <esc> <esc>:iun <c-v><esc><cr>/)$<cr>o

 else
  exe "norm! a`\<Esc>"
 endif

 let &ve= vekeep
endfun

" ---------------------------------------------------------------------
" Vimhlp: sets up a special window holding a list of my Vim-related {{{1
" maps, imaps, etc
fun! s:Vimhlp()
"  call Dfunc("Vimhlp()")

  " create VimHelp window
  if !exists("s:vimhelpbuf") || !bufexists(s:vimhelpbuf)
   let isfkeep= &isfname
   set isfname-=[
   set isfname-=]
   exe "bo sp ".escape('[Vim Map and Command Help]','')
   set buftype=nofile
   set bufhidden=wipe
   set noswapfile
   set noro
   let &isfname     = isfkeep
   let s:vimhelpbuf = bufnr("%")
  endif

  put ='Imaps'
  put ='_Longhand     Shorthand 	Expands To_'
  put =' --------     --------- 	----------'
  put ='  if           i        	 if X\|endif'
  put ='  els[e]       e        	 else\|X'
  put ='  elsei[f]     ei       	 elseif X'
  put ='  fu[nction]            	 fun! X(Y)\|endfun'
  put ='  wh[ile]      w        	 while X\|endwhile'
  put ='  Df[unc]      F        	 call Dfunc(\"func(X)\")\|Y'
  put ='  Dr[et]       R        	 call Dret(\"return func X\")'
  put ='  De[cho]      D        	 call Decho(\"X\")\|Y'

  " syntax highlighting
  syn match VmapBar		'---\+'
  syn match VmapInfo	'([^)]\+)'	contains=VmapParen
  syn match VmapTitle	'^.*{{{\d$'	contains=VmapIgnore
  syn match VmapTitle	'_.\{-}_'	contains=VmapIgnore
  syn match VmapIgnore	'{{{\d'		contained
  syn match VmapIgnore	'_'			contained
  syn match VmapParen	'[{}()]'	contained
  syn match VmapExpansion '\t .*$'	contains=VmapKeys,VmapParen,VmapCursor,VmapNewline
  syn match VmapCursor	'\<[XY]\>'	contained
  syn match VmapNewline '|'			contained
  syn case match
  syn keyword VmapKeys	contained if else elseif fun endfun endif endwhile while Dfunc Dret Decho call

  if !exists("b:did_drcstubs_help")
   command -nargs=+ HiLink hi def link <args>
   HiLink VmapBar 		Delimiter
   HiLink VmapIgnore	Ignore
   HiLink VmapInfo		String
   HiLink VmapNewline	Delimiter
   HiLink VmapParen		Delimiter
   HiLink VmapTitle		Statement
   HiLink VmapKeys		Statement
   HiLink VmapCursor	Special
   let b:did_drcstubs_help= 1
   delc HiLink
  endif

  norm! 1Gdd
  setlocal ro
  setlocal fdm=marker
  norm! zM
"  call Dret("Vimhlp")
endfun

" ---------------------------------------------------------------------
"  s:VimMenuToggle: toggle display of menu
augroup DrcVimStubsEvents
 au!
 au BufEnter	*	call s:VimMenuToggle(1)
 au BufLeave	*	call s:VimMenuToggle(0)
augroup END
fun! s:VimMenuToggle(menustate)
  if &ft == "vim" && has("gui") && has("gui_running") && has("menu")
"   call Dfunc("s:VimMenuToggle(menustate=".a:menustate.") ft<".&ft."> mode<".mode().">")
   if a:menustate
	imenu DrChip.VimStubs.Decho<tab>Decho`	De`
	imenu DrChip.VimStubs.Dfunc<tab>Dfunc`	F`
	imenu DrChip.VimStubs.Dret<tab>Dret`	R`
	imenu DrChip.VimStubs.ElseIf<tab>elseif`	elsei`
	imenu DrChip.VimStubs.Else<tab>else`	e`
	imenu DrChip.VimStubs.Function<tab>fun`	fun`
    imenu DrChip.VimStubs.If<tab>if`		i`
	imenu DrChip.VimStubs.While<tab>while`	wh`
   else
	silent! iunmenu DrChip.VimStubs.Decho
	silent! iunmenu DrChip.VimStubs.Dfunc
	silent! iunmenu DrChip.VimStubs.Dret
	silent! iunmenu DrChip.VimStubs.ElseIf
	silent! iunmenu DrChip.VimStubs.Else
	silent! iunmenu DrChip.VimStubs.Function
	silent! iunmenu DrChip.VimStubs.If
	silent! iunmenu DrChip.VimStubs.While
   endif
"   call Dret("s:VimMenuToggle")
  endif
endfun

" ---------------------------------------------------------------------
"  vim: fdm=marker
