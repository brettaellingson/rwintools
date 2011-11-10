@echo off

if "%RWIN_HOME%"=="" set RWIN_HOME=%~dp0
if "%UTILS_HOME%"=="" set UTILS_HOME=%RWIN_HOME%\..\utils

REM high priority paths
if exist "C:\Program Files\Mercurial" set PATH=C:\Program Files\Mercurial;%PATH%
if exist c:\cygwin set PATH=C:\cygwin\bin;C:\cygwin\usr\local\bin;%PATH%
if exist "%UTILS_HOME%" set PATH=%UTILS_HOME%;%PATH%
set PATH=%RWIN_HOME%;%PATH%

REM low priority paths
if exist "C:\Program Files\7-Zip" set PATH=%PATH%;C:\Program Files\7-Zip
if exist "%UTILS_HOME%\rapi-tools" set PATH=%PATH%;%UTILS_HOME%\rapi-tools
if exist "C:\Program Files\Graphviz2.26.3\bin" set PATH=%PATH%;C:\Program Files\Graphviz2.26.3\bin

REM alias
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
doskey paths=path ^| sed -e 's/PATH=//' -e 's/;/\n/g'

set CYGWIN=nodosfilewarning
set PROMPT=$P$_$G

REM process local initalization
if exist C:\BESTCROSSLuo\Common\autoexec.bat call C:\BESTCROSSLuo\Common\autoexec.bat
