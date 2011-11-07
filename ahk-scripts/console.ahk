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
	Run, %ComSpec%, %path%
	if StrLen(path) > 3
	{
		Run, scd_.exe -a "%path%", , Hide
	}
	return

; console2
#+C::
	path := GetWorkingFolder()
	Run, ..\console2\console.exe, %path%
	return

#^c::
	Run, %ComSpec%, %temp%
	return
	
#!c::
	path := GetWorkingFolder()
	Run, %comspec% /k "%VS90COMNTOOLS%vsvars32.bat", %path%
	return
	
; irb
#!b::
	path := GetWorkingFolder()
	Run, c:\cygwin\bin\ruby /usr/bin/irb, %path%
	return

; bash
#b::
	path := GetWorkingFolder()
	Run, bash --login, %path%
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
