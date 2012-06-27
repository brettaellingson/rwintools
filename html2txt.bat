	@echo off
	setlocal

	set RUBY=C:\Ruby192\bin\ruby.exe

	"%RUBY%" "%~dp0html2txt.rb" %*