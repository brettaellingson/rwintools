@echo off

REM set other paths no set in ahk script
if exist "%UTILS_HOME%\rapi-tools" set PATH=%PATH%;%UTILS_HOME%\rapi-tools
if exist "C:\Program Files\Graphviz2.26.3\bin" set PATH=%PATH%;C:\Program Files\Graphviz2.26.3\bin

REM alias
doskey l=dir $*
doskey cd=%~dp0\scd.bat $*
doskey pn=%UTILS_HOME%\pn20101010\pn.exe $*
doskey vsvar="%VS90COMNTOOLS%vsvars32.bat"
doskey ahkw=start /wait %~dp0\ahk-scriptwriter\ahkwriter.exe --console --windowless $*
doskey ahki=%~dp0\ahk-scriptwriter\ahkimagetool.exe $*
doskey ahk=start /wait %UTILS_HOME%\autohotkey\autohotkey.exe $*
doskey alias=doskey /macros
doskey cropborder=java -jar %UTILS_HOME%\cropborder\cropborder.jar
doskey bc2="C:\Program Files\Beyond Compare 2\bc2.exe" $*
doskey paths=path ^| sed -e 's/PATH=//' -e 's/;/\n/g'
doskey patha=set path=%path%;%cd%

if exist "C:\Program Files\7-Zip" (
	doskey 7z="C:\Program Files\7-Zip\7z.exe" $*
)
doskey vi="%CYGWIN_HOME%\bin\vim-nox.exe" $*
doskey emacs="%CYGWIN_HOME%\bin\emacs-nox.exe" $*

set LESS=-i
set CYGWIN=nodosfilewarning
set PROMPT=$P$_$G

REM process local initalization
if exist C:\BESTCROSSLuo\Common\autoexec.bat call C:\BESTCROSSLuo\Common\autoexec.bat
