#SingleInstance force

Gui, +LastFound +AlwaysOnTop +owner -Caption   
Gui, Color, black,black
WinSet, Transparent, 120
Gui,Font,s20 cYellow bold,Calibri
Gui, Add, Text, vText1, Unknown

!Space::
GuiControl, , Text1, 
GuiControl, Move, Text1, x30 w120
Gui, Show, AutoSize Center
Input,thekey,L1 T3
if (ErrorLevel="max")
{
    if (thekey="T")
    {
        GuiControl, , Text1, Terminal
        GuiControl, Move, Text1, x30 w120
        Gui, Show, AutoSize Center
        ifwinexist, -bash
            WinActivate
        else
            Run, c:\cygwin\bin\mintty.exe -
    }
    else if (thekey="F")
    {
        GuiControl, Move, Text1, x44 w106
        GuiControl, , Text1, Firefox
        Gui, Show, AutoSize Center
        ifwinexist, ahk_class MozillaWindowClass
      	    WinActivate
        else
      	    Run, "c:\Program Files\Mozilla Firefox\firefox.exe", c:\Program Files\Mozilla Firefox
    }
    else
    {
        GuiControl, Move, Text1, x70 w80
        GuiControl, , Text1, %thekey%
        Gui, Show, AutoSize Center
    }
}
SetTimer, Alert1, 400
return

Alert1:
SetTimer, Alert1, Off
Gui,Cancel
return
