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
MaxWidth := 12

;========================= TAB 1 ======================= (Command List)
tab1x := []
tab1x.insertAt( 0, 5015, 5015, 5015,     ,     ,     ,     ,     ,     ,     , 5021 ,5021)      
tab1x.insertAt(12,     ,     ,     ,  716,     ,  854,     ,  992,     , 1130)
tab1x.InsertAt(36,     ,  524,  613,  702,  791,  880,  969, 1058, 1147, 1236, 1325, 1414)   
tab1x.InsertAt(48, 5037,     , 5063,     , 5065,     , 5067,     , 5069)
tab1x.InsertAt(60,  400,  521,     ,  703,     ,  867,     , 1047,     , 1213, 1385, 1520)

tab1y := []
tab1y.insertAt(12,     ,     ,     ,   70,     ,   70,     ,   70,     , 70)
tab1y.InsertAt(36,     ,  378,  332,  286,  332,  378,  332,  286,  332,  378,  332, 286) 
tab1y.InsertAt(60,  818,  818,     ,  818,     ,  818,     ,  818,     ,  818,  818, 818)

;========================= TAB 2 ======================= (Items)
tab2x := []
tab2x.insertAt( 0,     , 5084, 5015, 5086,    ,      , 5019, 5089,     , 5091)
tab2x.insertAt(12,     ,     ,     ,  716,    ,   854,     ,  992,     , 1130)
tab2x.insertAt(24,  392,  503,  620,  738,    ,   851,  968)
tab2x.insertAt(36,  460,     ,  675,     ,    ,   891)
tab2x.insertAt(48,  460,     ,  675,     ,    ,   891,     ,     , 1380)
tab2x.insertAt(60,     ,     ,     ,     ,    ,      ,     , 5030,    0)
tab2x.insertAt(72,     ,     ,     ,     ,    ,      ,     , 5021,    0)
tab2x.insertAt(84,  460,     ,  675,     ,    ,   891,     , 1199, 1380)
tab2x.insertAt(96,     , 5036,     , 5038,    ,      , 5041, 5021, 5021)
									 
tab2y := []                          
tab2y.insertAt(12,      ,     ,    ,   70,    ,    70,     ,   70,     ,  70)
tab2y.insertAt(24,   216,  216, 216,  216,    ,   216,  216)
tab2y.insertAt(36,   396,     , 396,     ,    ,   396)
tab2y.insertAt(48,   616,     , 616,     ,    ,   616,     ,     ,  754)
tab2y.insertAt(84,   826,     , 826,     ,    ,   826,     ,  826,  930)


;========================= TAB 3 ======================= (Key Items) 

tab3x := []
tab3x.insertAt( 0,    ,,,     ,  ,   ,  ,   , ,5078)
tab3x.insertAt(12,    ,,,  716,  ,854,  ,992, ,1130)
tab3x.insertAt(24,    ,,,  615,  ,956)  ,     ,
tab3x.insertAt(36,    ,,,     ,  ,   ,  ,5029 , 5033)
tab3x.insertAt(48,    ,,,  572,  ,782,  ,990) ,
tab3x.insertAt(60,    ,,,  572,  ,782,  ,990) ,
tab3x.insertAt(72,    ,,,  572,  ,782,  ,990) ,
								           
tab3y := []                                 
tab3y.insertAt(12,    ,,,   70,  , 70,  , 70, ,  70)
tab3y.insertAt(24,    ,,,  233,  ,233)  ,     ,
tab3y.insertAt(48,    ,,,  476,  ,476,  ,476) ,
tab3y.insertAt(60,    ,,,  686,  ,686,  ,686)
tab3y.insertAt(72,    ,,,  890,  ,890,  ,890)

;========================= TAB 4 ======================= (Favorite Foods)

tab4x := []
tab4x.insertAt(12,     ,     ,     ,       716,  ,854,  ,992, ,1130)

tab4y := []
tab4y.insertAt(12,     ,     ,     ,        70,   ,70,   ,70,   ,70)

;========================= TAB 5 ======================= (Settings)

;========================= ALL TABS =====================

AllTabX := [tab1x, tab2x, tab3x, tab4x]
AllTabY := [tab1y, tab2y, tab3y, tab4y]

;Set start position and starting tab
ChangeTab(1)
CurPos := 16


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
	If MenuOpen <> 1 
		return
	
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
	
Swipe(startx, starty, endx, endy)
{
	MouseMove, startx, starty, 3
	SendEvent {Blind}{LButton down}
	MouseMove, endx, endy, 3
	SendEvent {Blind}{LBUtton up}
}	
	
	
AButton(key)
{
	global	
		
		;Left Click / Change Menu
	
	If !MenuOpen
		{
		MouseMove, 1630, 796
		SendEvent {Blind}{LButton down}
		KeyWait %key%
		SendEvent {Blind}{LBUtton up}
		}
		
	; Prevent Key Repeat on same tab if held
	if (CurTab# == (Curpos-13)//2)
		return
	
	;Change Tab, if cursor is on a tab
	if AllTabX[(Curpos-13)//2]
		{
		;Click to Guarantee tab change no wait
		SendEvent {Blind}{LButton down}
		SendEvent {Blind}{LBUtton up}
		ChangeTab((Curpos-13)//2)
		}
	else 
		{
		;Hold Left Click to allow for item movement when not changing tabs
		SendEvent {Blind}{LButton down}
		KeyWait %key%
		SendEvent {Blind}{LBUtton up}
		}
	return
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

Joy2::
c::
Click, 1824, 970
return

Space::AButton("Space")

Joy1::AButton("Joy1")

Joy7::
q::
Swipe(1700, 360, 1800, 360)
return

Joy8::
e::
Swipe(1800, 360, 1700, 360)
return



Joy4::
f::
;Item Auto-pickup
ImageSearch, FoundX, FoundY, 0, 0, 1920, 1080, hand.png
if (ErrorLevel = 0)
	{
    FoundX += 4, FoundY += 4
    Click, %FoundX% %FoundY%
	}
return

Joy11::
Enter::
;Toggle Menu and 'MenuOpen' status

;MsgBox % CheckMemories
PixelSearch, MemStarX, MemStarY, 1580, 825, 1590, 835, 0x23D7F9, 3, Fast
;PixelGetColor, OutputVar1, 1585, 830
;MouseMove, 1820, 845
;MsgBox % OutputVar1
If (ErrorLevel = 0)
    {
	;Open Menu > Gameplay
	;Msgbox Pause Menu is currently Closed
	Mouseclick, left, 1565, 110
	MenuOpen = 0
	NoCursor()

	}
else
	{
	CrystalCursor()
	;Gameplay > Open Menu
	PixelSearch, MX, MooglePomY, 1820, 845, 1825, 850, 0x3658DF, 3, Fast
	If (ErrorLevel = 0) 
		{
		Mouseclick, left, 1565, 110
		MouseMove, CurTabX[CurPos], CurTabY[CurPos], 2
		MenuOpen = 1
		sleep 100 
		}
	
	}
return

Esc::ExitApp

; Switch WADS from default movement to menu movement this has to be at the end of the script as it affects everything below it
#If MenuOpen = 1
w::Gosub Up
s::Gosub Down
a::Gosub Left
d::Gosub Right
