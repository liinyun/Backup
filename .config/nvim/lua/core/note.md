我一定要说一下 nvim 的这个功能

visual 模式下面进入命令模式 :
然后直接跟 :s/old_word/new_word/g
就可以实现选中部分的 old_word 替换为 new_word 了
后面的 g 可以改成 c 自己判断要不要替换。这个就和 vsc 一样了

还可以通过 . 来复现上一次插入模式进行的所有行动



 ===========================  window  =========================== 
wincmd         这个是在命令行中使用的
wincmd H       可以将当前窗口弄到左边。就算当前的窗口排列是上下的，使用这个命令后窗口排列就会变成左右的
wincmd K       这个就是和上面的很像，是将当前窗口弄到上面
但是上面两个功能，我都有快捷键实现了 <C-w>H   <C-w>K   就是 <C-w> 接大写的 hjkl 可以将当前窗口上下左右移动
因为小写的是在这些窗口中跳转
              

 ===========================  jump   =========================== 
w              jump to next word
b              jump to former word
e              jump to next none empty symble
^              jump to first alphabet of first word in this line
I              jump to start of this line line and switch to insert mode
A              jump to end of this line and switch to insert mode
gf             if it is a location, it will jump directly to the location
ctrl+o         jump frome commandline to coc getchar() list then I can use ctrl+w shortcut

)              jump to the end of a function
}              jump to the next block start



 =========================== select  ===========================
y+k                 copy current line and upper line
y + $number +k      copy current line and number lines above
y+w   y+e   y+a+w   I'm not fully understand



=======================  command  =========================== 
bd              close current buffer
bdelete         the full command of bd    
Trouble diagnostic  diagnostic in quicklike pattern


------ persisted -------

- `:SessionToggle` - Determines whether to load, start or stop a session
- `:SessionStart` - Start recording a session. Useful if `autostart = false`
- `:SessionStop` - Stop recording a session
- `:SessionSave` - Save the current session
- `:SessionSelect` - Load a session from the list (useful if you don’t wish to use the Telescope extension)
- `:SessionLoad` - Load the session for the current directory and current branch (if `git_use_branch = true`)
- `:SessionLoadLast` - Load the most recent session
- `:SessionLoadFromFile` - Load a session from a given path
- `:SessionDelete` - Delete the current session





------- surround -------
dst     delete tag
surround  with tag :  select and press St then input tag
# When your cursor is on a tag
cst - Change surrounding tag
dst - Delete surrounding tag
yst - Add surrounding tag



