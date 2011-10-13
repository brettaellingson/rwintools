SetDefaultMouseSpeed, 6
SetTitleMatchMode, 2

#include common.ahi
#include console.ahk
#include move-window.ahk
#include hardware.ahk
#include password.ahk
#include devs.ahk
#include display-property.ahk
#include timer.ahk

#IFWinActive,
;================temporary test ======================================
#+?::
	WinGet, pid, PID, A
	MsgBox %pid%
	return

MButton::	MouseClick, left, , ,2

#Esc::	Run, C:\Utils\procexp.exe

^PgDn::
	loop 4 {
		Send, {PgDn}
		Sleep, 300
	}
	Send, {PgDn}
	return
^PgUp::
	loop 4 {
		Send, {PgUp}
		Sleep, 300
	}
	Send, {PgUp}
	return
	
; start firefox
#w::
	Run, "%ProgramFiles%\Mozilla Firefox\firefox.exe"
	WaitAndActivate("Mozilla Firefox")
	return
	
#+W::
	Run, "C:\Program Files\Internet Explorer\iexplore.exe", "%HOMEDRIVE%%HOMEPATH%"
	return

#n::	Run, "%windir%\notepad.exe"
#+N::	Run, C:\Utils\pn20101010\pn.exe
#^n::	Run, C:\utils\npp\unicode\notepad++.exe

#p::	Send, {ALTDOWN}{PRINTSCREEN}{ALTUP}
#^p::	Run, "mspaint"
#!p::
	Send, {ALTDOWN}{PRINTSCREEN}{ALTUP}
	Run, "mspaint"
	return
#+P::	Run, "%ProgramFiles%\Paint.NET\PaintDotNet.exe"

#f6::	RUn, C:\Utils\MyIntelliSense\MyIntelliSense.exe, , Min
#f7::	Run, calc
#+f7::	Run, C:\WINDOWS\system32\PowerCalc.exe
#f11::	Run "C:\Utils\AutoHotkey\AutoHotkey.chm"
#+f11::	Run explorer "%A_ScriptDir%"
#f12::	Run "C:\Utils\AutoHotkey\AutoScriptWriter\AutoScriptWriter.exe"
#+f12::	Run "C:\Utils\AutoHotkey\AU3_Spy.exe"

#o::	Run, "outlook"
#+O::	Run, "onenote"
#+E::	Run, "excel"
#v::	Run, "C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE\devenv.exe"
#x::	Run, "C:\utils\lingoes_portable_2.7.1\Lingoes.exe"

; delete crossmark links
#^f1::
	FileDelete, C:\Documents and Settings\rui.luo\Desktop\CROSSMARK IT Portal.url
	Run, net use r: /delete , , Hide
	return

	
#IfWinActive, Open Document
^o::
	ControlGetPos, x, y, w, h, Button1, A,
	if not x=""
		MouseClick, left,  x + 40,  y + 10
	return

#IfWinActive, - Microsoft Word
f11::	Send, {ALTDOWN}w{ALTUP}f

#IfWinActive, - Foxit Reader
!1::	Send, {ALTDOWN}v{ALTUP}ps
!2::	Send, {CTRLDOWN}2{CTRLUP}{ALTDOWN}v{ALTUP}pf

#IfWinActive, ProFITS v3.1
^u::	run, C:\utils\pn20101010\pn.exe C:\BESTCROSSLuo\BESTCROSSMARK\timesheet-helper.js

^l::
	Send, {F12}
	
	WinWait, ProFITS v3.1 - Developer Tools, 
	IfWinNotActive, ProFITS v3.1 - Developer Tools, , WinActivate, ProFITS v3.1 - Developer Tools, 
	WinWaitActive, ProFITS v3.1 - Developer Tools, 
	
	MouseClick, left,  118,  65
	Sleep, 500
	MouseClick, left,  709,  733
	Sleep, 500
	
	run, notepad C:\BESTCROSSLuo\BESTCROSSMARK\timesheet-helper.js
	
	WinWait, timesheet-helper.js - Notepad, 
	IfWinNotActive, timesheet-helper.js - Notepad, , WinActivate, timesheet-helper.js - Notepad, 
	WinWaitActive, timesheet-helper.js - Notepad, 
	
	;MouseClick, left,  491,  215
	Sleep, 100
	Send, {CTRLDOWN}a{CTRLUP}{CTRLDOWN}c{CTRLUP}{ALTDOWN}{F4}{ALTUP}

	WinWaitActive, ProFITS v3.1 - Developer Tools, 
	Send, {CTRLDOWN}v{CTRLUP}{CTRLDOWN}{ENTER}{CTRLUP}{ALTDOWN}{F4}{ALTUP}


#IfWinActive, ahk_class #32770

;f7::
;	WinGet, dialog_id, ID, A
;	SetTitleMatchMode, RegEx
;	WinGet, ids, list, ahk_class ExploreWClass|CabinetWClass
;	loop %ids% {
;		this_id := % ids%A_Index%
;		ControlGetText, path, Edit1, ahk_id %this_id%
;		if instr(path, ":\") = 0
;			continue
;		Menu, mymenu, Add, %path%, p1
;		if (last_selected_path = path) {
;			Menu, mymenu, Default, %path%
;		}
;	}
;	ControlGetPos, x, y, w, h, Edit1, A
;	MouseMove, x, y+h, 4
;	Menu, mymenu, show
;	return

p1:
	last_selected_path := A_ThisMenuItem
	ControlSetText, Edit1, %A_ThisMenuItem%, ahk_id %dialog_id%
	return
