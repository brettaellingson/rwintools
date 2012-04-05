	@echo off
	setlocal
	
	for /f "usebackq" %%i in (`clip ^| grep -E "^\s*(///|//|--)" -o`) do (
		set PREFIX=%%i
	)
	
	if "%PREFIX%"=="" (
		clip | dos2unix | fmt -w 90 | unix2dos | clip -i
	) else (
		clip | dos2unix | fmt "-p%PREFIX%" -w 90 | unix2dos | clip -i
	)
	
