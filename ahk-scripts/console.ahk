; get working folder
GetWorkingFolder() {
	if WinActive("ahk_class ExploreWClass") or WinActive("ahk_class CabinetWClass") {
		ControlGetText, path, Edit1
		return %path%
	} else if WinActive("FreeCommander") {
		Send, {CTRLDOWN}{ALTDOWN}{INS}{ALTUP}{CTRLUP}
		Sleep, 100
		return clipboard
	} else {
		return "C:\"
	}
}

#IfWinActive,

#c::
	path := GetWorkingFolder()
	Run, %ComSpec% /k "%RWIN_HOME%\autoexec.bat", %path%
	if StrLen(path) > 3
	{
		Run, "%RWIN_HOME%\scd_.exe" -a "%path%", , Hide
	}
	return

#^c::
	Run, %ComSpec% /k "%RWIN_HOME%\autoexec.bat", %temp%
	return
	
; irb
#!b::
	path := GetWorkingFolder()
	Run, "%CYGWIN_HOME%\bin\ruby" /usr/bin/irb, %path%
	return

; bash
#b::
	path := GetWorkingFolder()
	Run, "%CYGWIN_HOME%\bin\bash" --login, %path%
	return

; paste in consle
+INS::
	if WinActive("ahk_class ConsoleWindowClass") {
		WinGetPos, x, y, w, h, A
		MouseGetPos, mx, my
		;MsgBox x=%x% y=%y% w=%w% h=%h% mx=%mx% my=%my%
		if (mx < 10)
			mx = 10
		else if (mx > w - 30)
			mx := w - 30
		
		if (my < 40)
			my = 40
		else if (my > h)
			my := h - 10

		MouseClick, right, mx, my
	}
	return
