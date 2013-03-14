#SingleInstance force

Gui, +LastFound +AlwaysOnTop +owner -Caption   
Gui, Color, black,black
WinSet, Transparent, 120
Gui,Font,s20 cYellow bold,Calibri
Gui, Add, Text, vText1, Unknown`n(T)erminal

!Space::
GuiControl, , Text1, (F)irefox`n(T)erminal
;GuiControl, Move, Text1, x30 w120
Gui, Show ;, AutoSize Center
Input,thekey,L1 T3
if (ErrorLevel="max")
{
    if (thekey="T")
    {
        ;GuiControl, , Text1, `n(T)erminal
        ;GuiControl, Move, Text1, x30 w120
        ;Gui, Show ;, AutoSize Center
	Gui,Cancel
        ifwinexist, -bash
            WinActivate
        else
            Run, c:\cygwin\bin\mintty.exe -
        ;SetTimer, Alert1, 1
    }
    else if (thekey="F")
    {
        ;GuiControl, Move, Text1, x44 w106
        ;GuiControl, , Text1, (F)irefox`n
        ;Gui, Show ;, AutoSize Center
	Gui,Cancel
        ifwinexist, ahk_class MozillaWindowClass
      	    WinActivate
        else
      	    Run, "c:\Program Files\Mozilla Firefox\firefox.exe", c:\Program Files\Mozilla Firefox
        ;SetTimer, Alert1, 1
    }
    else
    {
        ;GuiControl, Move, Text1, x70 w80
        GuiControl, , Text1, ?? (%thekey%) ??
        Gui, Show ;, AutoSize Center
        SetTimer, Alert1, 900
    }
}
else
{
    GuiControl, , Text1, <timeout>
    Gui, Show ;, AutoSize Center
    SetTimer, Alert1, 300
}
return

Alert1:
SetTimer, Alert1, Off
Gui,Cancel
return
