	@echo off
	setlocal

	cd %windir%\system32\drivers\etc
	
	if errorlevel 1 exit/b 1
	
	grep -v mydell hosts > hosts.tmp
	
	curl -s http://ruismessages.appspot.com/ | ruby -e 'puts readline()[/\d+\.\d+\.\d+\.\d+/]+"\tmydell"' >> hosts.tmp
	
	if errorlevel 1 exit/b 1
	
	move /y hosts.tmp hosts
	