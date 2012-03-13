; Bookmark for Media Player Classic
;
; Feel free to use and modify this script.


SetTitleMatchMode, 2

g_mpc_title := "- Media Player Classic"

GetVideoFilename(ByRef filename)
{
	global g_mpc_title
	
	IfWinActive %g_mpc_title%
	{
		WinGetTitle title
		
		StringLeft, filename, title, StrLen(title) - StrLen(g_mpc_title) - 1
		
		RunWait, handle.exe "%filename%" > c:\mpcbookmark.tmp, Min
	}
	
}

WaitForTheGotoWindow()
{
	WinWait, Go To..., 
	IfWinNotActive, Go To..., , WinActivate, Go To..., 
	WinWaitActive, Go To...
}

GetCurrentPosition(ByRef pos)
{
	global g_mpc_title
	
	IfWinActive %g_mpc_title%
	{
		Send, {CTRLDOWN}g{CTRLUP}

		WaitForTheGotoWindow()
		
		ControlGetText, pos, Edit1
		
		Send, {ESC}
	}
}	

SetCurrentPosition(pos)
{
	global g_mpc_title
	
	IfWinActive %g_mpc_title%
	{
		If StrLen(pos) > 0
		{
			Send, {CTRLDOWN}g{CTRLUP}

			WaitForTheGotoWindow()
			
			ControlSetText, Edit1, %pos%
			
			; My machine gave me some "error time format" if the ENTER key is
			; sent immediately after setting the text. So I put a catnap here
			; as a work around. Please let me know if you have
			
			Sleep, 50
			
			Send, {Enter}
		}
	}
}

^1::

GetCurrentPosition(bookmark1)

return

1::

SetCurrentPosition(bookmark1)

return

^2::

GetCurrentPosition(bookmark2)

return

2::

SetCurrentPosition(bookmark2)

return

^3::

GetCurrentPosition(bookmark3)

return

3::

SetCurrentPosition(bookmark3)

return

^4::

GetCurrentPosition(bookmark4)

return

4::

SetCurrentPosition(bookmark4)

return

^5::

GetCurrentPosition(bookmark5)

return

5::

SetCurrentPosition(bookmark5)

return

^6::

GetCurrentPosition(bookmark6)

return

6::

SetCurrentPosition(bookmark6)

return

^7::

GetCurrentPosition(bookmark7)

return

7::

SetCurrentPosition(bookmark7)

return

^8::

GetCurrentPosition(bookmark8)

return

8::

SetCurrentPosition(bookmark8)

return

^9::

GetCurrentPosition(bookmark9)

return

9::

SetCurrentPosition(bookmark9)

return

0::
GetCurrentPosition(pos)
WinWait, tmp.lst - Notepad, 
IfWinNotActive, tmp.lst - Notepad, , WinActivate, tmp.lst - Notepad, 
WinWaitActive, tmp.lst - Notepad, 
Sleep, 100
SendPlay, {CTRLDOWN}{END}{CTRLUP},%pos%
Sleep, 100

return