SetTitleMatchMode, 2
SetKeyDelay, 100, 30,

#IfWinActive, - Mozilla Firefox

^+C::
	Send, {CTRLDOWN}a{CTRLUP}{CTRLDOWN}c{CTRLUP}
	Sleep, 100
	WinActivate, - Microsoft Word
	WinWaitActive, - Microsoft Word
	Send, {CTRLDOWN}{SHIFTDOWN}v{SHIFTUP}{CTRLUP}
	WinActivate, - Mozilla Firefox
	WinWaitActive, - Mozilla Firefox
	Send, {CTRLDOWN}w{CTRLUP}
	return
