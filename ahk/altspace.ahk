#SingleInstance force

text=(F)irefox`n(T)erminal`n(E)xplorer`n(Q)uit

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
Input,thekey,L1 T3
if (ErrorLevel="max")
{
    if (thekey="t")
    {
	Gui,Cancel
        ifwinexist, -bash
            WinActivate
        else
            Run, c:\cygwin\bin\mintty.exe -
    }
    else if (thekey="f")
    {
	Gui,Cancel
        ifwinexist, ahk_class MozillaWindowClass
      	    WinActivate
        else
      	    Run, "c:\Program Files\Mozilla Firefox\firefox.exe", c:\Program Files\Mozilla Firefox
    }
    else if (thekey="e")
    {
	Gui,Cancel
        ifwinexist, ahk_class CabinetWClass
      	    WinActivate
        else
      	    Send #e
    }
    else if (thekey="q")
    {
	Gui,Cancel
      	Send !{F4}
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
