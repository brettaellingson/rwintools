	@echo off
	setlocal
	
	if not defined WINRUBY19EXE set WINRUBY19EXE=C:\Ruby192\bin\ruby.exe

:loop
	"%WINRUBY19EXE%" "%~dp0html2txt.rb" %*