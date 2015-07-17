#SingleInstance force

text=(F)irefox`n(G)oogle`n(C)hrome`n(T)erminal`n(N)ew terminal`n(E)xplorer`n(V)im`n( `; )Cancel`n(Q)uit app

Gui, +LastFound +AlwaysOnTop +owner -Caption
Gui, Color, black,black
WinSet, Transparent, 120
Gui,Font,s20 cYellow bold,Calibri
Gui, Add, Text, vText1, %text%

^;::
!Space::
GuiControl, , Text1, %text%
;GuiControl, Move, Text1, x30 w120
Gui, Show, NoActivate  ;, AutoSize Center
Input,thekey,L1 T3 M
if (ErrorLevel="max")
{
    if (thekey="t" OR theKey=chr(20))
    {
		Gui,Cancel
        ifwinexist, -bash
            WinActivate
        else
            Run, c:\cygwin\bin\mintty.exe -
    }
    else if (thekey="n" OR theKey=chr(14))
    {
		Gui,Cancel
        Run, c:\cygwin\bin\mintty.exe -
    }
    else if (thekey="c" OR theKey=chr(3))
    {
		Gui,Cancel
        ifwinexist, ahk_class Chrome_WidgetWin_1
            WinActivate
        else
            Run, "C:\Users\dstam\AppData\Local\Google\Chrome\Application\chrome.exe", C:\Users\dstam.CORP\AppData\Local\Google\Chrome\Application
    }
    else if (thekey="f" OR theKey=chr(6))
    {
		Gui,Cancel
        ifwinexist, ahk_class MozillaWindowClass
            WinActivate
        else
            Run, "c:\Program Files (x86)\Mozilla Firefox\firefox.exe", c:\Program Files\Mozilla Firefox
    }
    else if (thekey="g" OR theKey=chr(7))
    {
		Gui,Cancel
        Run, "c:\Program Files (x86)\Mozilla Firefox\firefox.exe", c:\Program Files\Mozilla Firefox
    }
    else if (thekey="e" OR theKey=chr(5))
    {
		Gui,Cancel
        ifwinexist, ahk_class CabinetWClass
            WinActivate
        else
      	    Send #e
    }
    else if (thekey="v" OR theKey=chr(22))
    {
	    Gui,Cancel
        ifwinexist, ahk_class Vim
      	    WinActivate
        else
            Run, "c:\Program Files (x86)\Vim\vim74\gvim.exe" _nofile_, C:\doc
    }
    else if (thekey="q")
    {
	    Gui,Cancel
      	Send !{F4}
    }
    else if (thekey=";")
    {
	    Gui,Cancel
    }
    else
    {
        GuiControl, , Text1, ?? (%thekey%) ??
        Gui, Show, NoActivate ;, AutoSize Center
        SetTimer, Alert1, 900
    }
}
else
{
    GuiControl, , Text1, <timeout>
    Gui, Show, NoActivate ;, AutoSize Center
    SetTimer, Alert1, 300
}
return

Alert1:
SetTimer, Alert1, Off
Gui,Cancel
return
