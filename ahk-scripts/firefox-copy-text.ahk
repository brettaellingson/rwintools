SetTitleMatchMode, 2
SetKeyDelay, 100, 30,

supercopy() {
	Send, {CTRLDOWN}a{CTRLUP}{CTRLDOWN}c{CTRLUP}
	Sleep, 50
	WinActivate, - Microsoft Word
	WinWaitActive, - Microsoft Word
	Send, {CTRLDOWN}{SHIFTDOWN}v{SHIFTUP}{CTRLUP}
	WinActivate, - Mozilla Firefox
	WinWaitActive, - Mozilla Firefox
	Send, {CTRLDOWN}w{CTRLUP}
	return
}

#IfWinActive, - Mozilla Firefox

^+C::	supercopy()

^+!C::
	loop 4 {
		supercopy()
	}
	return
