SetDefaultMouseSpeed, 6
SetTitleMatchMode, 2
SetKeyDelay, 10, 10

click_property_tab_then_filename()
{
	Sleep, 50
	MouseClick, left,  102,  35
	Sleep, 300
	
	MouseClick, left,  269,  100
	Sleep, 200
}

click_meta_tab()
{
	Sleep, 50
	MouseClick, left,  53,  35
	Sleep, 300
}

#IfWinActive, Properties -
; auto fill track title and track number by the file name
; the file name is assumed to have pattern like nn-title.wav
; tested in windows 7 64, foobar 2000 v1.2.1
^r::
	click_property_tab_then_filename()
	Send, {CTRLDOWN}c{CTRLUP}

	click_meta_tab()
	
	MouseClick, left,  160,  91
	Sleep, 300
	Send, {CTRLDOWN}v{CTRLUP}
	Send, {BACKSPACE}{BACKSPACE}{BACKSPACE}{BACKSPACE}{HOME}{DEL}{DEL}{DEL}{TAB}

	MouseClick, left,  146,  210
	Sleep, 300
	
	Send, {CTRLDOWN}v{CTRLUP}
	Send, {HOME}{RIGHT}{RIGHT}{SHIFTDOWN}{END}{SHIFTUP}{DEL}{TAB}
	
	Send, {ALTDOWN}o{ALTUP}
	return
