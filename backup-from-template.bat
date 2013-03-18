	@echo off
	@setlocal
	
	set SIGN_FILE=
	set RSYNC_BAKE=c:\rwin\rsync-bake.rb
	
	if not defined SIGN_FILE (
		echo This is a template batch file. Make a copy in the destination
		echo directory and modify the copy accordingly.
		exit /b 1
	)
	
	set SRC=%~1
	set SRC_NAME=%~n1
	
	if not defined SRC (
		echo Usage: backup-from.bat SOURCE
		exit /b 1
	)

	if not exist "%SRC%\%SIGN_FILE%" (
		echo Cannot find source signature at %SRC%\%SIGN_FILE%
		exit /b 1
	)
	
	set DEST=%~dp0%SRC_NAME%
	
	rem echo SRC_NAME=%SRC_NAME%
	rem echo SRC=%SRC%
	rem echo DEST=%DEST%
	
	:: locate ruby.exe
	set RUBYEXE=
	
	for %%i in (ruby.exe) do set RUBYEXE=%%~$PATH:i
	
	if not defined RUBYEXE (
		echo Cannot find ruby.exe
		exit /b 1
	)
	
	if not exist "%RSYNC_BAKE%" (
		echo Cannot find %RSYNC_BAKE%
		exit /b 1
	)

	call :backup_dir "%SRC%" "%DEST%"
	
	exit /b

:backup_dir
	"%RUBYEXE%" "%RSYNC_BAKE%" "%~1" "%~2"
	goto :eof