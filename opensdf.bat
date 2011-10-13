@echo off
setlocal

if "%~1"=="" (
	echo Missing sdf file name!
	goto:eof
)

::echo %1 | sed "s/[""]//g" | putclip

set AHK=C:\Utils\AutoHotkey
"%AHK%\AutoHotkey.exe" "c:\utils\ahk-scripts\open-sdf.ahk" "%~1"
