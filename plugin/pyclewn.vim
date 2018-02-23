" pyclewn run time file
" Maintainer:   <xdegaye at users dot sourceforge dot net>
"
" Configure VIM to be used with pyclewn and netbeans
"

" pyclewn version
let s:is_linux=1
if (has("win32")) || has("win64")
let s:is_linux=0
endif
let g:pyclewn_version = "pyclewn-1.11.py2"
let s:plugin_path = escape(expand('<sfile>:p:h'), '\')
let g:pyclewn_home = s:plugin_path."/../"
" enable balloon_eval
if has("balloon_eval")
    set ballooneval
    set balloondelay=100
endif

" The 'Pyclewn' command starts pyclewn and vim netbeans interface.
command! -nargs=* -complete=file Pyclewn call pyclewn#StartClewn(<f-args>)
command! -nargs=0 PyclewWatch exec "silent! Cdbgvar " . expand("<cword>")
command! -nargs=0 PyclewnStart  exec "silent! Pyclewn" | call Pyclewnmap()
command! -nargs=0 PyclewnLoad call LoadProj()
command! -nargs=0 PyclewnExit call Pyclewnunmap() | Cquit | nbclose | call Pyclewnunmap()
command! -nargs=0 PyclewnSave Cproject .proj

"autocmd group for pyclewn
augroup PyclewnGroup
    au!
augroup END

"{{{pyclewn
function! Pyclewnmap()
    silent! nmap <tab> :C
    exec "Cmapkeys"
    silent! :execute "Cdbgvar"
    :execute "only"
    :rightbelow 35vsplit (clewn)_console
    :set syntax=cpp
    :wincmd h
    " watch
    :rightbelow 5split (clewn)_dbgvar
    :set syntax=cpp
    :wincmd k
endfunction
function! Pyclewnunmap()
    nmap <TAB> za
    exec "silent! Cunmapkeys"
    silent!	bwipeout (clewn)_console
    silent!	bdelete (clewn)_console
    silent! bwipeout (clewn)_dbgvar
    silent! ccl
    exec "silent! !killall inferior_tty.py"
endfunction
func! OpenClosedbgvar()
    if bufexists("(clewn)_dbgvar")
        silent! bwipeout (clewn)_dbgvar
    else
        :rightbelow 5split (clewn)_dbgvar
        :set syntax=cpp
    endif
endfunc
let g:openmenu_flag=0
func! LoadProj()
    if filereadable(".proj")
        :silent! Pyclewn
        :call Pyclewnmap()
        :Csource .proj
        :Cstart
    else
        echohl WarningMsg | echo "No .proj file!!You must create it first( use <leader>pc )\n" | echohl None
        echohl WarningMsg | echo "wait for a second...starting Pyclewn.." | echohl None
        :5sleep
        :silent! Pyclewn
        :call Pyclewnmap()
    endif
endfunc
if s:is_linux==1
    let g:pyclewn_args = "--args=-q --gdb=async --terminal=gnome-terminal,-x"
else
    let g:pyclewn_args = "--args=-q --gdb=async"
endif
au PyclewnGroup BufWinEnter (clewn)_dbgvar nnoremap <buffer> <space> :silent! exe "Cfoldvar " . line(".")<CR>
au PyclewnGroup BufWinEnter (clewn)_dbgvar nnoremap <buffer> <c-d> 25<down>
au PyclewnGroup BufWinEnter (clewn)_dbgvar nnoremap <buffer> <c-b> 25<up>
au PyclewnGroup BufWinEnter (clewn)_dbgvar nnoremap <buffer> dd 0f]w:exec "Cdelvar " . expand('<cword>')<cr>

let $icon_directory=fnamemodify(expand('<sfile>'), ":p:h").'/../debug_icons'
"}}}
amenu ToolBar.-Sep- :
if s:is_linux==0
    amenu icon=$icon_directory/dbgrun.bmp ToolBar.Run :silent! Pyclewn<cr>:silent! call Pyclewnmap()<cr>
    amenu icon=$icon_directory/run.bmp ToolBar.Start :Cstart<cr>
    amenu icon=$icon_directory/stop.bmp ToolBar.Quit :call Pyclewnunmap()<cr>:Cquit<cr>:nbclose<cr>:call Pyclewnunmap()<cr>
    amenu icon=$icon_directory/dbgnext.bmp ToolBar.Next :Cnext<cr>
    amenu icon=$icon_directory/dbgstep.bmp ToolBar.Step :Cstep<cr>
    amenu icon=$icon_directory/dbgstepi.bmp ToolBar.Stepi :Cstepi<cr>
    amenu icon=$icon_directory/dbgrunto.bmp ToolBar.Runto :Ccontinue<cr>
    amenu icon=$icon_directory/dbgstepout.bmp ToolBar.Finish :Cfinish<cr>
    amenu icon=$icon_directory/dbgwindow.bmp ToolBar.Watch :call OpenClosedbgvar()<cr>
    amenu icon=$icon_directory/project.bmp ToolBar.Project :silent! Pyclewn<cr>:call Pyclewnmap()<cr>:Csource .proj<cr>:Cstart<cr>
    amenu icon=$icon_directory/filesaveas.bmp ToolBar.SaveProject :Cproject .proj<cr>
else
    amenu icon=$icon_directory/dbgrun.png ToolBar.Run :silent! Pyclewn<cr>:silent! call Pyclewnmap()<cr>:Cinferiortty<cr>
    amenu icon=$icon_directory/run.png ToolBar.Start :Cstart<cr>
    amenu icon=$icon_directory/dbgstop.png ToolBar.Quit :call Pyclewnunmap()<cr>:Cquit<cr>:nbclose<cr>:call Pyclewnunmap()<cr>
    amenu icon=$icon_directory/dbgnext.png ToolBar.Next :Cnext<cr>
    amenu icon=$icon_directory/dbgstep.png ToolBar.Step :Cstep<cr>
    amenu icon=$icon_directory/dbgstepi.png ToolBar.Stepi :Cstepi<cr>
    amenu icon=$icon_directory/dbgrunto.png ToolBar.Runto :Ccontinue<cr>
    amenu icon=$icon_directory/dbgstepout.png ToolBar.Finish :Cfinish<cr>
    amenu icon=$icon_directory/dbgwindow.png ToolBar.Watch :call OpenClosedbgvar()<cr>
    amenu icon=$icon_directory/project.png ToolBar.Project :silent! Pyclewn<cr>:call Pyclewnmap()<cr>:Cinferiortty<cr>:Csource .proj<cr>:Cstart<cr>
    amenu icon=$icon_directory/filesaveas.png ToolBar.SaveProject :Cproject .proj<cr>
endif
tmenu ToolBar.Run Connect pyclewn-->Map keys-->Cfile <user input>
tmenu ToolBar.Start	Start debug(Cstart)
tmenu ToolBar.Quit Stop debug
tmenu ToolBar.Next	Next(Cnext)
tmenu ToolBar.Step	Step(Cstep)
tmenu ToolBar.Stepi	Stepi(Cstepi)
tmenu ToolBar.Finish Stepout(Cfinish)
tmenu ToolBar.Watch Open or close watch windows 
tmenu ToolBar.Runto	Continue(Cconinue)
tmenu ToolBar.Project Load project and start debug
tmenu ToolBar.SaveProject Save Project setting(save as .proj)
