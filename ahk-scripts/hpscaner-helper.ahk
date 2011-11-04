SetDefaultMouseSpeed, 6
SetTitleMatchMode, 2
SetKeyDelay, 50

#IfWinActive, hp scanning,
^f1::
	MouseClick, left,  77,  57
	Sleep, 400
	MouseMove, 0, 109, , R
	Sleep, 300
	MouseMove, 144, 0, , R
	Sleep, 100
	MouseMove, 0, 18, , R

	MouseClick, left,
	
	Sleep, 1000

	WinWait, Load Profile
	IfWinNotActive, Load Profile, , WinActivate, Load Profile, 
	WinWaitActive, Load Profile, 
	Send, {TAB}
	Sleep, 500
	Send, {DOWN}{DOWN}{DOWN}
	Sleep, 1000
	Send, {TAB}{ENTER}

	Sleep, 500
	WinWait, hp scanning, 
	IfWinNotActive, hp scanning, , WinActivate, hp scanning, 
	WinWaitActive, hp scanning, 
	MouseClick, left,  454,  497
	
	Sleep, 100
	
	return