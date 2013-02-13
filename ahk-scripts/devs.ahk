SetTitleMatchMode, 2
SetKeyDelay, 1, 1,

#IfWinActive, - Microsoft Visual Studio
^!f::
	Send, {CTRLDOWN}c{CTRLUP}
	RunWait, %RWIN_HOME%\fmtcmt.bat, , Hide UseErrorLevel
	if !ErrorLevel
		Send, {CTRLDOWN}v{CTRLUP}
	return

^f::
	WinGetPos, , , width, height, A
	ImageSearch, x, y, 2*width/3, 60, width, 140, images\vs2008-solution-explorer-highlighted.png
	if ErrorLevel {
		Send, ^f
	} else {
		Send, {ALTDOWN}f{ALTUP}rc{ENTER}
	}
	return

; disabled because conflict with VirtuaWin hotkeys
;^!LEFT::
;	WinGetPos, , , width, height, A
;	ImageSearch, x, y, 150, 70, width-150, 100, *30 images\vs2008-active-tab-left.png
;	if ErrorLevel {
;		MsgBox, Cannot find active document tab left edge
;	} else {
;		MouseClick, ,x-50, y+10, , 2
;	}
;	return
	
;^!RIGHT::
;	WinGetPos, , , width, height, A
;	ImageSearch, x, y, 150, 70, width-150, 100, *30 images\vs2008-active-tab-right.png
;	if ErrorLevel {
;		MsgBox, Cannot find active document tab right edge
;	} else {
;		MouseClick, ,x+50, y+10, , 2
;	}
;	return

#IfWinActive, SQL Server Management Studio
; format sql in text
^+V::
	RunWait, "%RWIN_HOME%\sqlhelper.exe" -i_ -o_ , , Hide
	Send, {CTRLDOWN}{v}{CTRLUP}
	return	

^g::	Send, 00000000-0000-0000-0000-000000000000

#IfWinActive, Check In - Source Files - Workspace
^f::	MouseClick, left,  190,  48