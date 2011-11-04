@echo off
doskey l=dir $*
doskey cd=%~dp0\scd.bat $*
doskey less=less -i $*
doskey pn=c:\utils\pn20101010\pn.exe $*
doskey vsvar="%VS90COMNTOOLS%vsvars32.bat"
doskey ahkw=start /wait %~dp0\ahk-scriptwriter\ahkwriter.exe --console --windowless $*
doskey ahki=%~dp0\ahk-scriptwriter\ahkimagetool.exe $*
doskey ahk=start /wait c:\utils\autohotkey\autohotkey.exe $*
doskey alias=doskey /macros
doskey cropborder=java -jar %~dp0\cropborder\cropborder.jar
doskey bc2="C:\Program Files\Beyond Compare 2\bc2.exe" $*
set CYGWIN=nodosfilewarning
set PROMPT=$P$_$G

set PATH=%PATH%;c:\utils\rapi-tools;C:\Program Files\7-Zip

if exist C:\BESTCROSSLuo\Common\autoexec.bat call C:\BESTCROSSLuo\Common\autoexec.bat
