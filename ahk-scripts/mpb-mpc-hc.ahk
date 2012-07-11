editclass = WindowsForms10.EDIT.app.0.378734a

WaitForTheGotoWindow()
{
	WinWait, Go To..., 
	IfWinNotActive, Go To..., , WinActivate, Go To..., 
	WinWaitActive, Go To...
}

GetCurrentPosition(ByRef pos)
{
	Send, {CTRLDOWN}g{CTRLUP}
	WaitForTheGotoWindow()
	ControlGetText, pos, Edit1
	Send, {ESC}
}	

; this method gets the MPC current position
; by the status bar info.
GetCurrentPosition2(byRef pos)
{
	ControlGetText, text, Static2
	if ErrorLevel
	{
		MsgBox, cannot get current position info - %text%
		return
	}
	StringGetPos, index, text, /
	if ErrorLevel
	{
		MsgBox, cannot get current position info - %text%
		return
	}
	pos := SubStr(text, 1, index-1)
}

SetCurrentPosition(pos)
{
	If StrLen(pos) > 0
	{
		Send, {CTRLDOWN}g{CTRLUP}
		WaitForTheGotoWindow()
		ControlSetText, Edit1, %pos%
		; My machine gave me some "error time format" if the ENTER key is
		; sent immediately after setting the text. So I put a catnap here
		; as a work around.
		Sleep, 50
		Send, {Enter}
	}
}

; assert: current window is MPC
UpdateMPB(pid)
{
	global editclass
	
	GetCurrentPosition2(pos)
	mpbtitle := pid . " - MPB"
	IfWinNotExist, %mpbtitle%
	{
		MsgBox, Bound MPB window is not found - %mpbtitle%
		return
	}	WinActivate, %mpbtitle%
	WinWaitActive, %mpbtitle%
	ControlSetText, %editclass%1, go %pos%
	Sleep, 10
	Send, {Enter}
	WinWaitActive, %mpbtitle%
}

; assert: current window is MPB
UpdateMPC(hwnd)
{
	global editclass
	
	ControlGetText, pos, %editclass%1
	if ErrorLevel
	{
		MsgBox, Cannot get position from MPB window
		return
	}
	WinActivate, ahk_id %hwnd%
	WinWaitActive, ahk_id %hwnd%
	SetCurrentPosition(pos)
}

#IfWinActive, ahk_class MediaPlayerClassicW

^b::
	WinGet, pid, PID, A
	WinGet, hwnd, ID, A
	
	IfWinNotExist, Enter process id
	{
		mpbtitle := pid . " - MPB"
		IfWinNotExist, %mpbtitle%
		{
			IfWinNotExist, 0 - MPB
			{
				MsgBox, cannot locate a bound MPB window
				return
			}
			WinActivate, 0 - MPB
			WinWaitActive, 0 - MPB
		}
		else
		{
			WinActivate, %mpbtitle%
			WinWaitActive, %mpbtitle%
		}
		Send, ^b
	}
	WinActivate, Enter process id
	WinWaitActive, Enter process id
	ControlSetText, %editclass%1, %pid%
	Sleep, 10
	Send, {Enter}
	
	WinActivate, ahk_id %hwnd%
	return

[::
	WinGet, pid, PID, A
	WinGet, hwnd, ID, A
	
	UpdateMPB(pid)
	
	Send, [
	Sleep, 50
	
	UpdateMPC(hwnd)
	
	WinActivate, ahk_id %hwnd%
	return

]::
	WinGet, pid, PID, A
	WinGet, hwnd, ID, A
	
	UpdateMPB(pid)
	
	Send, ]
	Sleep, 50
	
	UpdateMPC(hwnd)
	
	WinActivate, ahk_id %hwnd%
	return

INSERT::
	WinGet, pid, PID, A
	WinGet, hwnd, ID, A
	
	UpdateMPB(pid)
	
	Send, {INSERT}
	
	WinActivate, ahk_id %hwnd%
	return

^INSERT::
	WinGet, pid, PID, A
	WinGet, hwnd, ID, A
	
	UpdateMPB(pid)
	
	Send,  {CTRLDOWN}{INSERT}{CTRLUP}
	
	WinActivate, ahk_id %hwnd%
	return

#IfWinActive, 0 - MPB

^t::
	;;ControlGet, hwnd, Hwnd, , WindowsForms10.EDIT.app.0.b7ab7b1
	ControlGetText, text, WindowsForms10.EDIT.app.0.b7ab7b1
	MsgBox, %text%