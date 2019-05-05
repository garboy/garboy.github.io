@echo off
setlocal enabledelayedexpansion
for /f "Tokens=*" %%f in ('dir /l/b/a-d') do (
set name="%%f"
set newname=!name: =-!
rename "%%f" !newname!
)