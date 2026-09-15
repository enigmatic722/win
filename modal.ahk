#SingleInstance force

SendMode Input

if not A_IsAdmin
{
   ; Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
   ExitApp
}

Suspend on
;MsgBox, modal.ahk Reloaded

;;;;;;  GUI indicator
Gui, -Caption +ToolWindow +Border +AlwaysOnTop
Gui, Font, s11
Gui, Add, Text, vttext Center, Script
;Gui, Show, % "NoActivate x" A_ScreenWidth - 400 " y" A_ScreenHeight - 1080

Status:
;GuiControl,, ttext, % A_IsSuspended ? "Insert" : "VIM"
;Gui, Color, % A_IsSuspended ? "FFDDDC" : "C1FFC1"
;SoundBeep, 1000 + 500 * A_IsSuspended
If(A_IsSuspended) 
{
	Gui, Hide
} 
Else
{
	Gui, Show, % "NoActivate x" A_ScreenWidth - 400 " y" A_ScreenHeight - 1080
	GuiControl,, ttext, % "VI"
	Gui, Color, %  "C1FFC1"
	;Gui, Color, %  "008080"
}
Return


RCtrl::
	Suspend Off
	Gosub, Status
	Gui, Color, %  "EEAA99"
	mode := 3
	M_WIDTH := 2300
Return

$CapsLock::LCtrl

RAlt::
	Suspend Off
	Gosub, Status
	mode := 1
    Gui, Color, %  "C1FFC1"
Return

mode := 1 ; inormal == 1, visual == 2, mouse == 3

;$^F2::
$^F3::
	Reload
return

i::
	If(mode = 2) {
		Send {Left}
	}
	
	mode := 1
	Suspend on
	Gosub, Status
return

$a::
	Send {Right}
	Suspend on
	Gosub, Status
	mode := 1
return

; pdf tool
$\::
	if(isU) {
		Send {v}
		isU := false
	} else {
		Send {u}
		isU := true
	}
return

$Esc::
	If(mode = 1)
		Send {Esc}
	Else {
		;Send {Left}
		mode := 1
		Gui, Color, %  "C1FFC1"
	} 
return

$^[::
	if(mode = 1) {
		Send {Esc}
	} else if(mode = 2) {
		;Send {Left}
		mode := 1
    Gui, Color, %  "C1FFC1"
	} else if(mode = 3) {
		Send {Esc}
		If (Toggle){
			Toggle := false
		    Click, Up
		}
	}
return

$v::
	if(mode = 1) {
		mode := 2
        Gui, Color, %  "008080"
	} else if(mode = 2) {
        mode := 1
        Gui, Color, %  "C1FFC1"
    } else {
		If (Toggle){
      ;Gui, Show, % "NoActivate x" A_ScreenWidth - 400 " y" A_ScreenHeight - 1080
      ;GuiControl,, ttext, % "VI"
      Gui, Color, %  "EEAA99"
			Toggle := false
		  Click, Up
		} else {
      Gui, Color, %  "008080"
      ;Gui, Hide
			Toggle := true
		    Click, Down
		}
	}
return

$+v::
    Gui, Color, %  "008080"
	Send {Home}+{End}
	mode := 2
return

$+i::
    Send, {Home}
	Suspend on
	Gosub, Status
return

$+a::
	Send {End}
	Suspend on
	Gosub, Status
return

; Movement
$k::
	If(mode = 1) {
		Send {UP}
	}
	else if(mode = 3) {
		;MouseMove, 0, -25, 0, R ; when you press w, mouse will move up 25 pixels
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		Y -= 25
		
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 0, -25, 0, R ; when you press w, mouse will move up 25 pixels
	}		
	else 
		Send +{UP}
return

$j::
	If(mode = 1)
		Send {DOWN}
	else if(mode = 3) {
		;MouseMove, 0, 25, 0, R ; when you press s, mouse will move down 25 pixels
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		Y += 25
		
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 0, 25, 0, R ; when you press w, mouse will move up 25 pixels
	}	
	else 
		Send +{DOWN}
return

$h::
	If(mode = 1)
		Send {LEFT}
	else if(mode = 3) {
		;MouseMove, -50, 0, 0, R ; when you press a, mouse will move left 25 pixels
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		X -= 50
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, -50, 0, 0, R ; when you press w, mouse will move up 25 pixels
	}	
	Else 
		Send +{LEFT}
return

l::
	If(mode = 1)
		Send {RIGHT}
	else if(mode = 3) {
		;MouseMove, 50, 0, 0, R ; when you press d, mouse will move right 25 pixels
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		X += 50
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 50, 0, 0, R ; when you press w, mouse will move up 25 pixels
	}
	Else 
		Send +{RIGHT}
return

$+k::
	If(mode = 1)
		Send {Up}{Up}{Up}{Up}{Up}
	Else If(mode = 2)
		Send +{UP}+{UP}+{UP}+{UP}+{UP}
	Else If(mode = 3) {
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		Y -= 150
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 0, -150, 0, R ; when you press w, mouse will move up 25 pixels
	}

return

$+j::
	If(mode = 1)
		Send {Down}{Down}{Down}{Down}{Down}
	Else If(mode = 2)
		Send +{DOWN}+{DOWN}+{DOWN}+{DOWN}+{DOWN}
	Else If(mode = 3) {
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		Y += 150
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 0, 150, 0, R ; when you press w, mouse will move up 25 pixels
	}
return

$+l::
	If(mode = 1) {
		Send +{Right}
		;Suspend on
		;Gosub, Status
	} Else If (mode = 3) {
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		X += 200
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 200, 0, 0, R ; when you press w, mouse will move up 25 pixels
		DllCall("SetCursorPos", "int", X, "int", Y)
		;Click, R
	}
return

$+h::
	If(mode = 1) {
		Send +{Left}
		;Suspend on
		;Gosub, Status
	} Else If(mode = 3) {
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		X -= 200
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, -200, 0, 0, R ; when you press w, mouse will move up 25 pixels
	    ;Click
	}
return

$^b::
    if(mode = 2) {
        Send +{PgUp}
    } else {
        Send {PgUp}
    }
return    

$^f::
    if(mode = 2) {
        Send +{PgDn}
    } else {
        Send {PgDn}
    }
return    

$^k::
	if(mode = 3) {
		;MouseMove, 0, -25, 0, R ; when you press w, mouse will move up 25 pixels
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		Y -= 8
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 0, -8, 0, R ; when you press w, mouse will move up 25 pixels
	} else {
		;Send {UP}       ; k UP          (Cursor up line)
        Send {PgUp}
	}
return

$^j::
	if(mode = 3) {
		;MouseMove, 0, 25, 0, R ; when you press s, mouse will move down 25 pixels
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		Y += 8
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 0, 8, 0, R ; when you press w, mouse will move up 25 pixels
	} else {
		;Send {DOWN}     ; j DOWN            (Cursor down line)
    Send ^{j}
	}
return

$^h::
	if(mode = 3) {
		;MouseMove, -50, 0, 0, R ; when you press a, mouse will move left 25 pixels
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		X -= 8
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, -8, 0, 0, R ; when you press w, mouse will move up 25 pixels
	} else {
		;Send {LEFT}     ; j LEFT        (Cursor left one character)
        Send ^{h}
	}
return

$^l::
	if(mode = 3) {
		;MouseMove, 50, 0, 0, R ; when you press d, mouse will move right 25 pixels
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		X += 8
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 8, 0, 0, R ; when you press w, mouse will move up 25 pixels
	} else {
		;Send {RIGHT}    ; l RIGHT       (Cursor right one character)
        Send ^{l}
	}
return

b::
	If(mode = 1)
		Send ^{LEFT}
	Else If(mode = 2)
		Send ^+{LEFT}
	Else If(mode = 3) {
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		X -= 200
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, -200, 0, 0, R ; when you press w, mouse will move up 25 pixels
	    ;Click
	}
		
return

$+b::
    Send ^+{LEFT}
return

w::
	If(mode = 1)
		Send ^{RIGHT}
	Else If (mode = 2)
		Send ^+{RIGHT}
	Else If (mode = 3) {
		CoordMode, Mouse, Screen
		MouseGetPos, X, Y
		X += 200
		if(X >= M_WIDTH)
			DllCall("SetCursorPos", "int", X, "int", Y)
		else
			MouseMove, 200, 0, 0, R ; when you press w, mouse will move up 25 pixels
		DllCall("SetCursorPos", "int", X, "int", Y)
		;Click, R
	}
return

$+w::
    Send ^+{RIGHT}
return

;$#k::
;	;MouseClick ,WheelUp,,,10,0,D,R
;	MouseClick, WheelUp ; when you press 2, mouse will scroll up
;return	
;
;$#j::
;	;MouseClick ,WheelDown,,,10,0,D,R
;	MouseClick, WheelDown ; when you press x, mouse will scroll down
;return	



$+6::
	If(mode = 1)
		Send {HOME}
	Else 
		Send +{HOME}
return

$^i::
	If(mode = 1)
		Send {HOME}
	Else If(mode = 2)
		Send +{HOME}
	Else If(mode = 3) {
		CoordMode, Mouse, Screen
		WinGetPos, X, Y, W, H, A
		MouseGetPos, CX, CY
		X += 250
		DllCall("SetCursorPos", "int", X, "int", CY)
	}
return

$^;::
	If(mode = 1)
		Send {End}
	Else If(mode = 2)
		Send +{End}
	Else If(mode = 3) {
		CoordMode, Mouse, Screen
		WinGetPos, X, Y, W, H, A
		MouseGetPos, CX, CY
		W -= 300
		DllCall("SetCursorPos", "int", W, "int", CY)
	}
return

$^Enter::
    Send {Enter}
	Send !+{0}
	state := false
    Suspend on
    Gosub, Status
return

;$^m::
;	If(mode = 3) {
;		CoordMode, Mouse, Screen
;		WinGetPos, X, Y, W, H, A
;		MouseGetPos, CX, CY
;		W /= 2
;		DllCall("SetCursorPos", "int", W, "int", CY)
;	} else {
;		Send ^{m}
;	}
;return

$+4::
	If(mode = 1)
		Send {End}
	Else 
		Send +{End}
return


;$g::
;	KeyWait, g
;	KeyWait, g, D, T1
;	If ErrorLevel = 0
;	{
;		If(mode = 1 or mode = 3)
;			Send ^{Home}
;		Else
;			Send ^+{Home}
;	}
;return

g::
	If(mode = 1 or mode = 3) {
		;Input, SingleKey, T1, c.{`,} 
		Input, SingleKey, T1, gi

		If (ErrorLevel = "Endkey:G")
		{
			Send ^{Home}
		} Else If (ErrorLevel = "Endkey:i")
		{
			Send, {U+006F}
            Sleep 5
			Send, {U+002F}
            Suspend on
            Gosub, Status
		} 
	}
    Else
        Send ^+{Home}
return


$+g::
	If(mode = 1 or mode = 3)
		Send ^{End}
	Else
		Send ^+{End}
return

;;;;;;;;;;;;; Edit
$^a::
	If(mode = 1) 
	{
		Clipboard := "" ; 
		Send +{Right} 
		Send ^c
		ClipWait, 1

		if Clipboard is digit 
		{
			Clipboard := Clipboard + 1
			Send ^v
		}

		Send {Left}
	}
return

$^x::
	If(mode = 1) 
	{
		Clipboard := "" ; 
		Send +{Right} 
		Send ^c
		ClipWait, 1

		if Clipboard is digit 
		{
			Clipboard := Clipboard - 1
			Send ^v
		}

		Send {Left}
	}
return

$~::
	If(mode = 1) 
	{
		Clipboard := "" ; 
		Send +{Right} 
		Send ^c
		ClipWait, 1

		if Clipboard is upper 
		{
			StringLower, Clipboard, Clipboard
			Send ^v
		}
		Else if Clipboard is lower 
		{
			StringUpper, Clipboard, Clipboard
			Send ^v
		} 
		Else 
		{
			Send {Right} 
		}
	}
return

u::
	If(mode = 1) 
	{
		Send ^{z}
	} 
	Else If (mode = 2)
	{
		Clipboard := "" ; 
		Send ^c
		ClipWait, 

		StringLower, Clipboard, Clipboard
		Send ^v
		mode := 1
        Gui, Color, %  "C1FFC1"
	} Else If(mode = 3) {
		MouseClick, WheelUp
	} 
return

$+u::
	If (mode = 2)
	{
		Clipboard := "" ; 
		Send ^c
		ClipWait, 

		StringUpper, Clipboard, Clipboard
		Send ^v
		mode := 1
        Gui, Color, %  "C1FFC1"
	}
return


$^r::
	;Send ^+{z}
    Send ^{y}
return

+y::
	Send, +{End}
	Send, ^{c}
	Send {Left}
return
y::
	if(mode = 1) {
		Input, SingleKey, L1 T1, , 

		If (SingleKey = "y")
		{
			Clipboard := "" 
			Send, {End}+{Home}
			Send, ^{c}
			ClipWait, 1
			Clipboard := "`r`n" Clipboard
			Send {Left}
		} 
		Else If (SingleKey = "e")
		{
			Send +^{Right}

			Clipboard := "" 
			Send ^{c}
			ClipWait, 1
			Send {Left}
		}
		;Else If (SingleKey = "e")
		;{
		;	EndOfWordSelect(mode)

		;	Clipboard := "" 
		;	Send ^{c}
		;	ClipWait, 1
		;	Send {Left}
		;}
		Else If (SingleKey = "$")
		{
			Send, +{End}
			Send, ^{c}
			Send {Left}
		}
	}
	Else If(mode = 2) {
		Send ^{c}
		mode := 1
        Gui, Color, %  "C1FFC1"
		Send {Right}
	} 
	Else If(mode = 3) {
		Send ^{c}
		Send {Right}
		if(Toggle) {
			Toggle := false
			Click, Up
			Send {Esc}
		}
		Suspend on
		Gosub, Status
	}
return

$x::
	If(mode = 1) {
		Send {Delete}
	} 
	Else If(mode = 3) {
		Send ^{x}

	}
	Else {
		Send ^{x}
		mode := 1
        Gui, Color, %  "C1FFC1"
	}
return

$+x::
	If(mode = 1) {
		Send {Backspace}
	}
return

p::
	;if(mode = 1 or mode = 2) {
		If(RegExMatch(Clipboard, "`r`n *"))
		{
			Send {End}
		}
		Send ^{v}
        mode := 1
        Gui, Color, %  "C1FFC1"
	;} else if(mode = 3) {
;		if(isCenter) {
;			MouseCorner()
;			isCenter := false
;		} else {
;			MouseCenter()
;			isCenter := true
;		}
;	}
return

$+p::
	;if(mode != 3) {
	if(True) {
		If(RegExMatch(Clipboard, "`r`n *"))
		{
			Send {Up}{End}
			Send ^{v}
		} Else {
			Send {Left}^{v}
		}
        mode := 1
        Gui, Color, %  "C1FFC1"
	} else {
		Send +{p}
	}
return

$s::
	If(mode = 1) {
		Send {Delete}
		Suspend on
	}
	Else If(mode = 2) {
		Send {Delete}
		Suspend on
	}
	Gosub, Status
return

r::
	Suspend, on
	Send, +{Right}
	Input, Char, L1 T3 V
	If (ErrorLevel = "Timeout")
	{
		Send, {Left}
	}
	Suspend, Off
return

c::
	If(mode = 1 or mode = 3) {
		;Input, SingleKey, T1, c.{`,} 
		Input, SingleKey, T1, cebwl

		If (ErrorLevel = "Endkey:C")
		{
			Send, {Home}
            Sleep 1
            Send, +{End}
			Send, {Delete}
			Suspend on
		} Else If (ErrorLevel = "Endkey:e")
		{
			EndOfWordSelect(mode)
			Send, {Delete}
			Suspend on
		} Else If (ErrorLevel = "Endkey:w")
		{
			Send, ^{Delete}
			Suspend on
		}Else If (ErrorLevel = "Endkey:b")
		{
			Send, ^+{Left}
			Send, {Delete}
			Suspend on
		} Else If (ErrorLevel = "Endkey:l")
		{
			Send, {Delete}
			Suspend on
		}
		Gosub, Status
	}
	Else If(mode = 2) {
		Send {Delete}
		Suspend on
		Gosub, Status
	} 
return

$+s::
	If(mode = 1) {
		Send, {Home}+{End}
		Send, {Delete}
		Suspend on
	}
	Gosub, Status
return

d::
	If(mode = 1) {
		;Input, SingleKey, T1, d.{`,}
		Input, SingleKey, T1, debw

		If (ErrorLevel = "Endkey:D")
		{
			Send, {End}
            Sleep 1
            Send, +{Home}+{Home}
			Send, {Delete}
			Send, {End}{Home}
		} Else If (ErrorLevel = "Endkey:E")
		{
			EndOfWordSelect(mode)
			Send, {Delete}
		} Else If (ErrorLevel = "Endkey:W")
		{
			Send, ^{Delete}
		}Else If (ErrorLevel = "Endkey:B")
		{
			Send, ^+{Left}
			Send, {Delete}
		}

	}
	Else If(mode = 2) {
		Send {Delete}
		mode := 1
        Gui, Color, %  "C1FFC1"
	}
	Else If(mode = 3) {
		MouseClick, WheelDown ; when you press x, mouse will scroll down
	}
return

$o::
	if(mode = 1) {
		Send {END}{ENTER}
	} else {
		If (Toggle){
			Toggle := false
		    Click, Up
		} else {
			Toggle := true
		    Click, Down
		}
	}
return

$+o::
	Send {HOME}{ENTER}{UP}
return
	
$+d::
	Send +{End}{Delete}
return

$+c::
	Send +{End}{Delete}
	Suspend on
	Gosub, Status
return


;$!m:: ; J in VI
;	Send {End}{Delete}
;
;	Clipboard := "" ; 
;	Send ^+{Right} 
;	Send ^c
;	ClipWait, 1
;
;	StringReplace, OutputVar, ClipBoard, %A_Space%,, All UseErrorLevel
;	Length := StrLen(Clipboard)
;
;	If(ErrorLevel = Length) {
;		Send ^{Delete}{Space}{Left}
;	}
;return

,::
    Send +{Tab}
return

.::
    Send {Tab}
return

e::
	if(mode = 1) {
		Send {Enter}
		Suspend on
		Gosub, Status
	} else if(mode = 2) {
        Send ^+{right}
    } else {
        Click
        If (Toggle){
            Toggle := false
            Gui, Color, %  "EEAA99"
        }
	}
return	

$^e::
	if(mode = 3) {
	    ;Click, M
		;Send {MButton}
		Send ^{LButton}
	} else {
	    ;Send ^{Enter}
        Send ^{e}
	}
return	

$^g::Send ^#{4}

f::
	if(mode = 1) {
	    Send {Appskey}
	} else if(mode = 2) {
        mode := 1
        Gui, Color, %  "C1FFC1"
	    Send {Appskey}
    } else {
		If (Toggle){
			Toggle := false
		    Click, Up
            Gui, Color, %  "EEAA99"
		}
		Click, R
	}
return	

$q::Send ^{w}

;;; App 
^q::Send !{f4}

[::
	Send +^{Tab}
return

]::
	Send ^{Tab}
return

$z::
    if(isCenter) {
        MouseCorner()
        isCenter := false
    } else {
        MouseCenter()
        isCenter := true
    }
	;Send ^{t}
	;Suspend on
	;Gosub, Status
return	

$'::Send !{Tab}
$^'::Send !{Tab}

$m::

return	

$-::Send, {Volume_down}
$=::Send, {Volume_up}

`;::Send !^{Tab}

;$z::
;    if(mode = 3) {
;		if(isCenter) {
;			MouseCorner()
;			isCenter := false
;		} else {
;			MouseCenter()
;			isCenter := true
;		}
;	} else {
;        Send ^#{4}
;    }
;return 

;$8::Send !{LEFT}
;$9::Send !{RIGHT}
$![::Send !{Up}

~!d::Send {Right}
~F2::Send {Left}

~!o::
	if(mode = 3) {
		Toggle := false
		Click, Up
		Send {Esc}
	}
return	

~^+n::
	Suspend, on
    Gosub, Status
	;Input, Str, V, {Enter}{Esc}, 
	;Suspend, Off
return

$#+n::
	Suspend, on
    Gosub, Status
	Send {F2}
	;Input, Str, V, {Enter}{Esc}, 
	;Suspend, Off
return	

~^+u::
	Suspend, on
	Gosub, Status
	Input, Str, V, {Enter}{Esc}, 
	If (ErrorLevel = "Endkey:Esc")
	{
		Suspend, off
	}
return

$n::
	Send {F3}
return

$+n::Send +{F3}

$/::
	if(mode = 1 or mode = 3) {
		suspend, on
		Gosub, Status
		Send ^{f}
		;Input, Str, V, {Enter}{Esc}, 
		;Suspend, Off
		;Gosub, Status
	}
return

~+;::
	Suspend, on
	;Send !{d}
	Input, Str, V, {Enter}{Esc}, 
	Suspend, Off
	Gosub, Status
return

;;; Functions
EndOfWord(mode) {
	Clipboard := "" ; 
	Send ^+{Right} 
	Send ^c
	ClipWait, 1

	;StringReplace, OutputVar, ClipBoard, %A_Space%,, All UseErrorLevel
	Length := StrLen(Clipboard)
	TrimLength := StrLen(RTrim(Clipboard))
	;MsgBox % "Spaces: " ErrorLevel "`nChars: " (Length-ErrorLevel) "`n Line: " Clipboard

	If(trimLength = 0 && Length > 0) {
		Clipboard := "" ; 

		Send {Right}
		
		Send ^+{Right} 
		Send ^c
		ClipWait, 1

		Length := StrLen(Clipboard)
		TrimLength := StrLen(RTrim(Clipboard))
		;StringReplace, OutputVar, ClipBoard, %A_Space%,, All UseErrorLevel
		;MsgBox % "Spaces: " ErrorLevel "`nChars: " (Length-ErrorLevel) "`n Line: " Clipboard
	}

	Spaces := Length - TrimLength

	If(mode = 1) {
		Send {Right}
		Loop % Spaces
		{
			Send {Left}
		}
	} 
}

EndOfWordSelect(mode) {
	oldClipboard := ClipboardAll
	Clipboard := "" ; 
	Send +{Right}
	Send ^c
	ClipWait, 1

	Length := StrLen(Clipboard)
	TrimLength := StrLen(RTrim(Clipboard))

	isTrimed := Length != TrimLength
	;isTrimed := Length > 1
	Send +{Left}

	Clipboard := "" ; 

	Send ^+{Right} 

	if(isTrimed) {
		Send ^+{Right} ; send one more time
	} 

	Send ^c
	ClipWait, 1

	;StringReplace, OutputVar, ClipBoard, %A_Space%,, All UseErrorLevel
	Length := StrLen(Clipboard)
	TrimLength := StrLen(RTrim(Clipboard))
	;MsgBox % "Spaces: " ErrorLevel "`nChars: " (Length-ErrorLevel) "`n Line: " Clipboard

	If(trimLength = 0 && Length > 0) {
		Clipboard := "" ; 

		Send ^+{Right} 
		Send ^c
		ClipWait, 1

		Length := StrLen(Clipboard)
		TrimLength := StrLen(RTrim(Clipboard))
		;StringReplace, OutputVar, ClipBoard, %A_Space%,, All UseErrorLevel
		;MsgBox % "Spaces: " ErrorLevel "`nChars: " (Length-ErrorLevel) "`n Line: " Clipboard
	}

	Spaces := Length - TrimLength

	Loop % Spaces
	{
		Send +{Left}
	}

	;;;; resume clipboard
	Clipboard := oldClipboard
}

;;;;;;;Mouse;;;;;;;;
MouseCenter() {
	CoordMode, Mouse, Screen
	WinGetPos, X, Y, W, H, A
	H /= 2 
	W /= 2 
	DllCall("SetCursorPos", "int", W, "int", H)
}

mouseCorner() {
	CoordMode, Mouse, Screen
	WinGetPos, X, Y, W, H, A
	DllCall("SetCursorPos", "int", W-50, "int", H-100)
}


;$^,::Send ^{PgUp}
;$^.::Send ^{PgDn}
;$^'::Send !{Tab}
$^space::Send #^5
$^m::Send #{UP}
$^t::Send #!{d}
t::Send #{t}
