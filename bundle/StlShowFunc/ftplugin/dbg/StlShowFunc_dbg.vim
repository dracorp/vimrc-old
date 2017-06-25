" StlShowFunc_dbg.vim :	a ftplugin for DrChip's internal debugger files
" Author:	Charles E. Campbell
" Date:		Feb 04, 2016
" Version:  2h	ASTRO-ONLY
" ---------------------------------------------------------------------
"  Load Once: {{{1
if exists("b:loaded_StlShowFunc_dbg") || !exists("g:loaded_StlShowFunc")
 finish
endif
let b:loaded_StlShowFunc_dbg= "v2h"

" ---------------------------------------------------------------------
" StlShowFunc_dbg: show function name associated with line under cursor {{{1
fun! StlShowFunc_dbg()
"  call Dfunc("StlShowFunc_dbg() mode=".mode())
  if mode() != 'n'
"   call Dret("StlShowFunc_dbg")
   return
  endif

  " initialization:
  if !exists("b:dbgshowfunc_funcline")
   let b:dbgshowfunc_funcline= -2
   let s:funcname            = ""
  endif

  " determine searchpairpos for {}
  let stopline= line(".") - 500
  if stopline <= 0 | let stopline= 1 | endif
  sil! keepj let [funcline,funccol] = searchpairpos('{$','','}\%(\~\d\+\)\=$','Wbn','',stopline)
"  call Decho("funcline=".funcline." funccol=".funccol." b:dbgshowfunc_funcline=".b:dbgshowfunc_funcline." stopline=".stopline." curline=".line("."))

  if funcline == 0 || funccol == 0
   " occurs when searchpairpos() fails
   let b:dbgshowfunc_funcline= -2
   call StlSetFunc("")
"   call Dret("StlShowFunc_dbg : b:dbgshowfunc_funcline=".b:dbgshowfunc_funcline)
   return
  endif

  if funcline != b:dbgshowfunc_funcline
   let b:dbgshowfunc_funcline= funcline
   let funcname              = substitute(getline(funcline),'^\d*|*\(\h\w*\)(.*$','\1','e')
"   call Decho("funcname<".funcname."> s:funcname<".s:funcname.">")
   if !exists("s:funcname") || funcname != s:funcname
	let s:funcname= funcname
	call StlSetFunc(funcname."()")
   endif
  else
   let s:funcname= ""
  endif
"  call Dret("StlShowFunc_dbg : b:dbgshowfunc_funcline=".b:dbgshowfunc_funcline)
endfun

" ---------------------------------------------------------------------
"  Enable FtPlugin: {{{1
StlShowFunc dbg
augroup STLSHOWFUNC
 au CursorMoved tmp* call StlShowFunc_dbg()
augroup END

" ---------------------------------------------------------------------
"  Modelines: {{{1
" vim: fdm=marker
