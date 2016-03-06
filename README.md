# **Make pyclewn can be installed though vbundle or pathogen**

> [pyclewn](http://pyclewn.sourceforge.net/ "pyclewn offical website") is a powerful debug plugin for vim, and I think there a little trouble to install this plugin, so I make this rpos is to make pyclewn can be installed thought Vbunle or pathogen

pyclewn's version:pyclewn-2.2

Current version is not stable enough，please use pyclewn-1.11

```vim
"use vim-plug install pyclewn_linux
Plug 'tracyone/pyclewn_linux,{'tag': 'pyclewn-1.11'}'
```

# New feature compare to version 1.11

version 2.2 has following new feature:

1. Three clewn buffers are updated by gdb, they list the breakpoints, the backtrace and the threads. One can jump with the <CR> key or the mouse to the corresponding source code line from the `(clewn)_breakpoints` window or switch to the corresponding frame from the `(clewn)_backtrace window`, or switch to the correponding thread with the `(clewn)_threads window`. The Ccwindow command has been removed.

2. All the Vim functions defined by pyclewn that split windows can be overriden.

3. A compound watched variable in `(clewn)_variables` can be expanded and collapsed with the <CR> key or the mouse.

4. The new `Cballooneval` command switches on/off the Vim balloon without interfering with the pyclewn key mappings that rely on the Vim w`ballooneval option to be function.

5. The first optional argument of the :Pyclewn Vim command selects the debugger and the following arguments are passed to the debugger. For example, to debug foobar args with gdb, run the Vim commmand `:Pyclewn gdb --args foobar args`.

6. The new `g:pyclewn_terminal` Vim global variable allows the pyclewn program started with `:Pyclewn` to run in a terminal instead of as a daemon, and helps trouble shooting startup problems.

7. Full gdb completion is now available on Vim command line. See `:help gdb-completion`.

8. The console and the Pyclewn buffers are loaded in windows of a dedicated tab page when the `--window` option is set to usetab. See `help pyclewn-usetab`.

9. The new command `Cexitclewn` closes the debugging session and removes the Pyclewn buffers and their windows (issue #20).

10. Two new key mappings are available in the breakpoints window. Use + to toggle the breakpoint state between enable/disable, and use `<C-K>` to delete the breakpoint.

11. The new `vim.ping()` function may be used to check whether an existing Python process may be attached to.


# New feature added by myself

- add icon in gvim toolbar

   ![toolbar](https://cloud.githubusercontent.com/assets/4246425/3483964/08cf1d4a-039b-11e4-9aab-498cb65956da.png)

   from left to right:

   * red triangle action:connect pyclewn-->Map keys ,pop up a gnome-terminal for program output,after this you can execute :Cfile to load program.
   * start debug,equal to :Cstart
   * X:stop debug close all split windows
   * :Cnext
   * :Cstep
   * :Cstepi
   * :Ccontinue
   * setpout,:Cfinish
   * Load project and start debug,in current dir ".proj" must be exist
   * when you are debugging ,press this button,it can create .proj file in current dir which save the info about breakpoint position and how to load the program(such as option and argurements)
- key map
	* after start pyclewn(red triangle button),press tab equal to :C
	* `<leader>pw` equal to :silent! Cdbgvar,create a gdb watched variable on current cursor
	* `<space>` When the watched variable is a structure or class instance, it can be expanded with the|Cfoldvar|pyclewn command to display all its members and their values as children watched variables
	* `dd`: in `(clewn)_variables` buffer,this can delete the watch corresponding variable
	* `<leader>pp` load proj setting
	* `<leader>pc` save current project setting (such as breakpoint position..)
	
# Screenshot

**version 1.11**

![version1.11](https://cloud.githubusercontent.com/assets/4246425/3484051/8b54fbac-039d-11e4-8062-540a6612bbb5.gif)

**version 2.2**

![version2.2](https://cloud.githubusercontent.com/assets/4246425/13549118/7e27f55a-e33a-11e5-9168-6385a786fdb2.png)

