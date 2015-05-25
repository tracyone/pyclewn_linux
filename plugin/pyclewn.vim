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
command -nargs=* -complete=file Pyclewn call pyclewn#StartClewn(<f-args>)

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
    exec "silent! !killall gnome-terminal"
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
silent!	nnoremap <leader>pw :silent! Cdbgvar <C-R><C-W><CR>
silent! nnoremap <leader>pf :silent! exe "Cfoldvar " . line(".")<CR>
nnoremap <leader>ps :silent! Pyclewn<cr>:silent! call Pyclewnmap()<cr>
nnoremap <leader>pp :call LoadProj()<cr>
nnoremap <leader>pd :call Pyclewnunmap()<cr>:Cquit<cr>:nbclose<cr>
nnoremap <leader>pc :Cproject .proj<cr>
"}}}
amenu ToolBar.-Sep- :
if s:is_linux==0
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/dbgrun.bmp ToolBar.Run :silent! Pyclewn<cr>:silent! call Pyclewnmap()<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/run.bmp ToolBar.Start :Cstart<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/stop.bmp ToolBar.Quit :call Pyclewnunmap()<cr>:Cquit<cr>:nbclose<cr>:call Pyclewnunmap()<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/dbgnext.bmp ToolBar.Next :Cnext<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/dbgstep.bmp ToolBar.Step :Cstep<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/dbgstepi.bmp ToolBar.Stepi :Cstepi<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/dbgrunto.bmp ToolBar.Runto :Ccontinue<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/dbgstepout.bmp ToolBar.Finish :Cfinish<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/dbgwindow.bmp ToolBar.Watch :call OpenClosedbgvar()<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/project.bmp ToolBar.Project :silent! Pyclewn<cr>:call Pyclewnmap()<cr>:Csource .proj<cr>:Cstart<cr>
    amenu icon=$VIMFILES/bundle/pyclewn/debug_icons/filesaveas.bmp ToolBar.SaveProject :Cproject .proj<cr>
else
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/dbgrun.png ToolBar.Run :silent! Pyclewn<cr>:silent! call Pyclewnmap()<cr>:Cinferiortty<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/run.png ToolBar.Start :Cstart<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/dbgstop.png ToolBar.Quit :call Pyclewnunmap()<cr>:Cquit<cr>:nbclose<cr>:call Pyclewnunmap()<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/dbgnext.png ToolBar.Next :Cnext<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/dbgstep.png ToolBar.Step :Cstep<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/dbgstepi.png ToolBar.Stepi :Cstepi<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/dbgrunto.png ToolBar.Runto :Ccontinue<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/dbgstepout.png ToolBar.Finish :Cfinish<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/dbgwindow.png ToolBar.Watch :call OpenClosedbgvar()<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/project.png ToolBar.Project :silent! Pyclewn<cr>:call Pyclewnmap()<cr>:Cinferiortty<cr>:Csource .proj<cr>:Cstart<cr>
    amenu icon=$VIMFILES/bundle/pyclewn_linux/debug_icons/filesaveas.png ToolBar.SaveProject :Cproject .proj<cr>
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
