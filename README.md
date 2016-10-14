# make pyclewn can be installed though vbundle or pathogen

> [pyclewn](http://pyclewn.sourceforge.net/ "pyclewn offical website") is a powerful debug plugin for vim, and I think there a little trouble to install this plugin, so I make this rpos is to make pyclewn can be installed thought Vbunle or pathogen

pyclewn's version:pyclewn-1.11

# Installation

```vim
"use vim-plug install pyclewn_linux
Plug 'tracyone/pyclewn_linux,{'branch': 'pyclewn-1.11'}'
```

# new feature:

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
	* `:PyclewWatch` equal to :silent! Cdbgvar,create a gdb watched variable on current cursor
	* `<space>` When the watched variable is a structure or class instance, it can be expanded
with the|Cfoldvar|pyclewn command to display all its members and their values
as children watched variables
    * `dd`: this can delete the watch corresponding variable in current line
	* `:PyclewnLoad` load proj setting
	* `:PyclewnSave` save current project setting (such as breakpoint position..)
	* `:PyclewnExit` exit pyclewn.
	
- screenshot
	![1407051404492424](https://cloud.githubusercontent.com/assets/4246425/3483972/503dde1e-039b-11e4-9f95-2b6cb73f5b02.gif)

	![1407051404493174](https://cloud.githubusercontent.com/assets/4246425/3484051/8b54fbac-039d-11e4-8062-540a6612bbb5.gif)

