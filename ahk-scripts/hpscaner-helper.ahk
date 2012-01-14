SetDefaultMouseSpeed, 6
SetTitleMatchMode, 2
SetKeyDelay, 50

; open the load profile dialog and set focus to the drop down

open_load_profile() {
	MouseClick, left,  77,  57
	Sleep, 300
	MouseMove, 0, 109, , R
	Sleep, 200
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
}

close_load_profile() {
	Send, {TAB}{ENTER}
	Sleep, 500
}


;	WinWait, hp scanning, 
;	IfWinNotActive, hp scanning, , WinActivate, hp scanning, 
;	WinWaitActive, hp scanning, 

#IfWinActive, hp scanning,
^2::
	open_load_profile()
	Send, {DOWN}
	Sleep, 1000
	close_load_profile()
	return

^3::
	open_load_profile()
	Send, {DOWN}
	Sleep, 500
	Send, {DOWN}
	Sleep, 1000
	close_load_profile()
	return
