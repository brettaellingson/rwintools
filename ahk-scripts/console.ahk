#IfWinActive,

GroupAdd, window_with_path, ahk_class ExploreWClass
GroupAdd, window_with_path, ahk_class CabinetWClass

; get working folder
GetWorkingFolder() {
	if WinActive("ahk_class ExploreWClass") or WinActive("ahk_class CabinetWClass") {

		ControlGetText, path, ToolbarWindow322
		
		if ErrorLevel {
			ControlGetText, path, Edit1
		} else {
			if InStr(path, "Address: ") {
				path := SubStr(path, 10)
			}
			
			; windows 7 control panel
			if InStr(path, ":") <> 2 {
				path := "C:\"
			}
		}
		
		return %path%
	} else {
		return "C:\"
	}
}

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

#IfWinActive, ahk_group window_with_path

^+C::	clipboard := GetWorkingFolder()