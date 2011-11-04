SetTitleMatchMode, 2

append_text(text)
{
	THETXT = tmp.txt - Notepad
	IfWinNotExist, %THETXT%
	{
		msgbox, cannot find dropping box
		return 0
	}
	IfWinNotActive, %THETEXT%, , WinActivate, %THETEXT%, 
	WinWaitActive, %THETEXT%, 
	Sleep, 100
	SendPlay, {CTRLDOWN}{END}{CTRLUP}
	SendPlay, %text%
	Sleep, 500
	return 1
}

#IfWinActive, - Media Player Classic

WaitForTheGotoWindow()
{
	WinWait, Go To..., 
	IfWinNotActive, Go To..., , WinActivate, Go To..., 
	WinWaitActive, Go To...
}

SetCurrentPosition(pos)
{
	if not pos
		return
	Send, {CTRLDOWN}g{CTRLUP}
	WaitForTheGotoWindow()
	ControlSetText, Edit1, %pos%
	
	; My machine gave me some "error time format" if the ENTER key is
	; sent immediately after setting the text. So I put a catnap here
	; as a work around. Please let me know if you have a clue.
	
	Sleep, 50
	Send, {Enter}
}

GetCurrentPosition(ByRef pos)
{
	Send, {CTRLDOWN}g{CTRLUP}
	WaitForTheGotoWindow()
	ControlGetText, pos, Edit1
	Send, {ESC}
}	

; hot keys

^1::  GetCurrentPosition(bookmark1)
^2::  GetCurrentPosition(bookmark2)
^3::  GetCurrentPosition(bookmark3)
^4::  GetCurrentPosition(bookmark4)
^5::  GetCurrentPosition(bookmark5)
^6::  GetCurrentPosition(bookmark6)
^7::  GetCurrentPosition(bookmark7)
^8::  GetCurrentPosition(bookmark8)
^9::  GetCurrentPosition(bookmark9)
^[::  GetCurrentPosition(bookmark_section_begin)
^]::  GetCurrentPosition(bookmark_section_end)
1::  SetCurrentPosition(bookmark1)
2::  SetCurrentPosition(bookmark2)
3::  SetCurrentPosition(bookmark3)
4::  SetCurrentPosition(bookmark4)
5::  SetCurrentPosition(bookmark5)
6::  SetCurrentPosition(bookmark6)
7::  SetCurrentPosition(bookmark7)
8::  SetCurrentPosition(bookmark8)
9::  SetCurrentPosition(bookmark9)
[::	 SetCurrentPosition(bookmark_section_begin)
]::	 SetCurrentPosition(bookmark_section_end)

0::
	WinGet, id, ID, A
	GetCurrentPosition(pos)
	append_text(pos)
	WinActivate, ahk_id %id%
	return
\::
	if !bookmark_section_begin
	{
		msgbox, section begin is not set
		return
	}
	
	if !bookmark_section_end
	{
		msgbox, section begin is not set
		return
	}
	
	WinGet, id, ID, A
	append_text("{Enter}" . bookmark_section_begin . "`t" . bookmark_section_end)
	WinActivate, ahk_id %id%
	return
