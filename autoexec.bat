@echo off
doskey l=dir $*
doskey cd=%~dp0\scd.bat $*
doskey less=less -i $*
doskey pn=C:\utils\pn20101010\pn.exe $*
doskey vsvar="%VS90COMNTOOLS%vsvars32.bat"
doskey ahkw=start /wait C:\utils\AutoHotkey\scriptwriter\ahkwriter.exe --console --windowless $*
doskey ahki=C:\utils\AutoHotkey\scriptwriter\ahkimagetool.exe $*
doskey ahk=start /wait C:\utils\autohotkey\autohotkey.exe $*
doskey alias=doskey /macros
doskey cropborder=java -jar C:\utils\cropborder\cropborder.jar
doskey bc2="C:\Program Files\Beyond Compare 2\bc2.exe" $*
set CYGWIN=nodosfilewarning
set PROMPT=$P$_$G

set PATH=%PATH%;%~dp0\rapi-tools

if exist C:\BESTCROSSLuo\Common\autoexec.bat call C:\BESTCROSSLuo\Common\autoexec.bat
