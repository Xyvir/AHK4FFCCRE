#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;APPLY CUSTOM CURSOR
CrystalCursor()
OnExit("DefaultCursor")


;test Github change

;TO DO: Add veritcal scroll buttons selections & vertical scroll (mousewheel)
;		Add Menu back in and Tabs 60+





;INIT ARRAYS

CoordMode, Mouse, Screen
MaxWidth := 10

;========================= TAB 1 =======================
tab1x := []
tab1x.insertAt( 0,     ,     , 5023, 5014,     ,     ,     ,     ,     , 5028)      
tab1x.insertAt(10,     ,     ,     ,     ,  716,  854,  992, 1130)
tab1x.InsertAt(20,     ,     ,     ,  524,  702,  880, 1058, 1236, 1414)
tab1x.InsertAt(30,     ,     ,  400,  521,  703,  867, 1047, 1213, 1385, 1520)

tab1y := []
tab1y.insertAt(10,     ,     ,     ,     ,   70,   70,   70,   70)
tab1y.InsertAt(20,     ,     ,     ,  378,  286,  378,  286,  378,  286)
tab1y.InsertAt(30,     ,     ,  818,  818,  818,  818,  818,  818,  818,  818)


;========================= TAB 2 =======================
tab2x := []
tab2x.insertAt( 0,     ,     , 5051, 5014, 5053,     , 5055,     , 5017)
tab2x.insertAt(10,     ,     ,     ,     ,  716,  854,  992, 1130)
tab2x.insertAt(20,     ,  392,  503,  620,  738,  851,  968)
tab2x.insertAt(30,     ,  460,     ,  675,     ,  891)
tab2x.insertAt(40,     ,  460,     ,  675,     ,  891,     ,     , 1380)
tab2x.insertAt(50,     ,  460,     ,  675,     ,  891,     , 1199, 1380)
tab2x.insertAt(60,     ,     , 5031,     , 5033,     , 5035)

tab2y := []
tab2y.insertAt(10,     ,     ,     ,     ,   70,   70,   70,   70)
tab2y.insertAt(20,     ,  216,  216,  216,  216,  216,  216)
tab2y.insertAt(30,     ,  396,     ,  396,     ,  396)
tab2y.insertAt(40,     ,  616,     ,  616,     ,  616,    ,      ,  754)
tab2y.insertAt(50,     ,  826,     ,  826,     ,  826,    ,   826,  930)


;========================= TAB 3 =======================

tab3x := []
tab3x.insertAt( 0,     ,     ,     ,     ,     ,     ,     , 5066)
tab3x.insertAt(10,     ,     ,     ,     ,  716,  854,  992, 1130)
tab3x.insertAt(20,     ,     ,     ,     ,  615,  956)
tab3x.insertAt(30,     ,     ,     ,     ,     ,     , 5025, 5025)
tab3x.insertAt(40,     ,     ,     ,     ,  572,  782,  990)
tab3x.insertAt(50,     ,     ,     ,     ,  572,  782,  990)
tab3x.insertAt(60,     ,     ,     ,     ,  572,  782,  990)

tab3y := []
tab3y.insertAt(10,     ,     ,     ,     ,   70,   70,   70,   70)
tab3y.insertAt(20,     ,     ,     ,     ,  233,  233)
tab3y.insertAt(40,     ,     ,     ,     ,  476,  476,  476)
tab3y.insertAt(50,     ,     ,     ,     ,  686,  686,  686)
tab3y.insertAt(60,     ,     ,     ,     ,  890,  890,  890)

;========================= TAB 4 =======================

tab4x := []
tab4x.insertAt(10,     ,     ,     ,     ,  716,  854,  992, 1130)

tab4y := []
tab4y.insertAt(10,     ,     ,     ,     ,   70,   70,   70,   70)

;========================= ALL TAB =====================

AllTabX := [tab1x, tab2x, tab3x, tab4x]
AllTabY := [tab1y, tab2y, tab3y, tab4y]

;Set start position and starting tab
ChangeTab(1)
CurPos := 14


;MAIN FUNCTIONS

ChangeTab(TabNumber)
{
	global
	
	;MsgBox % "ChangeTab" . TabNumber
	
	;Set CurTab#
	CurTab# := TabNumber
	
	;Set New CurTab
	CurTabX := AllTabX[TabNumber]
	CurTabY := AllTabY[TabNumber]
		
	;Calculate New CurMaxHeight
	CurMaxHeight := CurTabx.Length() + MaxWidth - mod(CurTabx.Length(), MaxWidth)
	;MsgBox % CurMaxHeight	
	
}



WrapCursor(direction)
{
	global
	;MsgBox % "CurPOS:" . CurPos . " " . mod(CurPos, MaxWidth) . "==" . (MaxWidth - 1) . "*" . ((1 - direction)//2)
	
	;Wrap on left or right edge
	if mod(CurPos, MaxWidth) == (MaxWidth - 1)*((1 - direction)// 2)
		{
		CurPos += -MaxWidth * direction
		;MsgBox % "RowWrap " . CurPos 
		}
	
	;Wrap on top or bottom edge
	if (CurPos < 0 OR CurPos >= CurMaxHeight)
		{
		CurPos += -(Abs(direction)//direction) * CurMaxHeight
		;MsgBox % "ColumnWrap " . CurPos
		}
}



MoveCursor(direction)
{
	global
	
	;Does nothing if the Menu isn't open
	;If MenuOpen <> 1 
	;	return
	
	;Move the Cursor Once
	CurPos += direction
	
	;Wrap if at an edge	
	WrapCursor(direction)
	
	;Skip all contiguos empty positions, wrapping if needed
	while(!CurTabx[CurPos])
	{
		CurPos += direction
		WrapCursor(direction)
		;MsgBox % A_Index . ". " . "CurPOS=" . CurPos . " X=" . CurTabX[CurPos] . " Y=" . CurTabY[CurPos]
	}			
	
	
	;Warp on Warp positions 
	if (CurTabx[CurPos] > 5000)
		{
		;Msgbox % CurPos . ":" . CurTabx[CurPos] . "Over 5000 Warp"	
		CurPos:= CurTabx[CurPos] - 5000
		}
	
	
	;Uncomment Below to troublshoot	
	;MsgBox % "CurPOS " . CurPos . " X " . CurTabX[CurPos] . " Y " . CurTabY[CurPos]
	
	;Move the Mouse 
	MouseMove, CurTabX[CurPos], CurTabY[CurPos], 2

	;Play a Sound
	;Soundplay Select.wav		
}
	
CrystalCursor()
{
	Cursor = %A_ScriptDir%\crystal.cur
	CursorHandle := DllCall( "LoadCursorFromFile", Str,Cursor )
	Cursors = 32512,32513,32514,32515,32516,32640,32641,32642,32643,32644,32645,32646,32648,32649,32650,32651
	Loop, Parse, Cursors, `,
		{
		DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_Loopfield )
		}
}
	
NoCursor()
{
	Cursor = %A_ScriptDir%\no_cursor.cur
	CursorHandle := DllCall( "LoadCursorFromFile", Str,Cursor )
	Cursors = 32512,32513,32514,32515,32516,32640,32641,32642,32643,32644,32645,32646,32648,32649,32650,32651
	Loop, Parse, Cursors, `,
		{
		DllCall( "SetSystemCursor", Uint,CursorHandle, Int,A_Loopfield )
		}
}

DefaultCursor() 
{
	SPI_SETCURSORS := 0x57
	DllCall( "SystemParametersInfo", UInt,SPI_SETCURSORS, UInt,0, UInt,0, UInt,0 ) ; Reload the system cursors
}

;KEYSTROKE ACTIONS

Up::MoveCursor(-MaxWidth)

Down::MoveCursor(MaxWidth)

Left::MoveCursor(-1)

Right::MoveCursor(1)

;Left Click / Change Menu
`::
;Change Tab, if cursor is on a tab
if AllTabX[Curpos-13] AND CurTab# <> Curpos-13
	{
	;Click to Guarantee tab change no wait
	SendEvent {Blind}{LButton down}
	SendEvent {Blind}{LBUtton up}
	ChangeTab(Curpos-13)
	}
else 
	{
	;Hold Left Click to allow for item movement
	SendEvent {Blind}{LButton down}
	KeyWait ``
	SendEvent {Blind}{LBUtton up}
	}
return

;Item Auto-pickup
$f::
ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, hand.png
if (ErrorLevel = 0){
    FoundX += 4, FoundY += 4
    Click, %FoundX% %FoundY%
}else
    Send f
return

;Open Menu and set 'MenuOpen' status
Enter::
PixelGetColor, CheckMemories, 1603, 836
NoCursor()
Mouseclick, left, 1565, 110
;MsgBox % CheckMemories
If (CheckMemories <> 0x4AF3FF)
    {
	;Msgbox Pause Menu is currently Open
	MoveCursor(0)
	MenuOpen = 1
	sleep 100
	CrystalCursor()
	}
else
	{
	;Msgbox Pause Menu is currently Closed
	MenuOpen = 0
	}
	

return



Esc::ExitApp
