---
layout: post
title:  "Windows下批量重命名文件名为小写，以及更多"
date:   2019-05-05 09:58:18 +0800
categories: technical
---

# Windows下批量重命名文件名为小写，以及更多
The answer is copied from [here](https://superuser.com/questions/65302/is-there-a-way-to-batch-rename-files-to-lowercase) and [here](https://stackoverflow.com/questions/3632272/rename-all-files-to-lowercase-replace-spaces)  
Go to the directory and run the following command:

`for /f "Tokens=*" %f in ('dir /l/b/a-d') do (rename "%f" "%f")`  
Here is the break-down in case someone wants to modify/improve :

`for /f` - For every line  
`"Tokens=*"` - Process each item in every line.  
`%f in (...)` - %f is your variable name for every item.  
`dir` - lists every file and subdirectory in a directory.  
`/l` - (parameter for dir) Uses lowercase.  
`/b` - (parameter for dir) Uses bare format, only the file/directory names, no size, no headers.  
`/a-d` - (parameter for dir) Do not list directories. (a stands for attribute, - stands for not and d stands for directory).  
`rename "%f" "!%f: =-!"`- rename the file with its own name, which is actually lowercased by the dir command and /l combination.  
---
改进版，可以替换空格为短横线。甚至做更多，只需要在newname里面下点功夫。注意这个改进版必须得放到.bat文件中执行了，没办法像上面版本那样，直接在cmd窗口运行.
```cmd
@echo off
setlocal enabledelayedexpansion
for /f "Tokens=*" %%f in ('dir /l/b/a-d') do (
set name="%%f"
set newname=!name: =-!
rename "%%f" !newname!
)
```