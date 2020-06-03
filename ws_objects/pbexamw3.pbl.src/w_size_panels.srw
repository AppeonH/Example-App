$PBExportHeader$w_size_panels.srw
$PBExportComments$Example of sizing mulitple panels on a window
forward
global type w_size_panels from w_center
end type
type st_1 from statictext within w_size_panels
end type
type dw_topleft from datawindow within w_size_panels
end type
type st_both from statictext within w_size_panels
end type
type st_horizontal from statictext within w_size_panels
end type
type dw_bottom from datawindow within w_size_panels
end type
type dw_topright from datawindow within w_size_panels
end type
type st_vertical from statictext within w_size_panels
end type
end forward

global type w_size_panels from w_center
int X=41
int Y=20
int Width=2258
int Height=1836
boolean TitleBar=true
string Title="Resize Example"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_1 st_1
dw_topleft dw_topleft
st_both st_both
st_horizontal st_horizontal
dw_bottom dw_bottom
dw_topright dw_topright
st_vertical st_vertical
end type
global w_size_panels w_size_panels

type variables
Dragobject	idrg_TopLeft	//Reference to the Top Left control
Dragobject	idrg_TopRight	//Reference to the Top Right control
Dragobject	idrg_Bottom	//Reference to the Bottom  control
Boolean		ib_Debug=False	//Debug mode
Long		il_HiddenColor=0	//Bar hidden color to match the window background
Constant Integer	cii_BarThickness=20	//Bar Thickness
Constant Integer	cii_WindowBorder=15//Window border to be used on all sides
Constant Integer	cii_WindowTop = 81	//The virtual top of the window

end variables

forward prototypes
public subroutine of_refreshbars ()
public subroutine of_resizepanels ()
public subroutine of_resizebars ()
end prototypes

public subroutine of_refreshbars ();// Refresh the size bars

// Force appropriate order
st_vertical.SetPosition(ToTop!)
st_horizontal.SetPosition(ToTop!)
st_both.SetPosition(ToTop!)

// Make sure the Width is not lost
st_vertical.Width = cii_BarThickness
st_horizontal.Height = cii_BarThickness
st_both.Resize (cii_BarThickness, cii_BarThickness)

end subroutine

public subroutine of_resizepanels ();// Resize the panels according to the Vertical Line, Horizontal Line,
// BarThickness, and WindowBorder.

Long		ll_Width, ll_Height

// Validate the controls.
If Not IsValid(idrg_TopRight) or Not IsValid(idrg_TopRight) or &
	Not IsValid(idrg_Bottom) Then
	Return 
End If

ll_Width = This.WorkSpaceWidth()
ll_Height = This.WorkspaceHeight()

// Enforce a minimum window size
If ll_Width < idrg_TopRight.X + 150 Then
	ll_Width = idrg_TopRight.X + 150
End If

If ll_Height < idrg_Bottom.Y + 150 Then
	ll_Height = idrg_Bottom.Y + 150
End If

// TopLeft processing
idrg_TopLeft.Move(cii_WindowBorder, cii_WindowBorder + cii_WindowTop)
idrg_TopLeft.Resize(st_vertical.X - idrg_TopLeft.X, st_horizontal.Y - idrg_TopLeft.Y)

// TopRight Processing
idrg_TopRight.Move(st_vertical.X + cii_BarThickness, cii_WindowBorder + cii_WindowTop)
idrg_TopRight.Resize(ll_Width - (st_vertical.X + cii_BarThickness) - cii_WindowBorder, &
								st_horizontal.Y - idrg_TopRight.Y)
							
// Bottom Procesing
idrg_Bottom.Move(cii_WindowBorder, st_horizontal.Y + cii_BarThickness)
idrg_Bottom.Resize(ll_Width - (cii_WindowBorder * 2), &
							ll_Height - idrg_Bottom.Y - cii_WindowBorder)

end subroutine

public subroutine of_resizebars ();//Resize Bars according to Bars themselves, WindowBorder, and BarThickness.

st_vertical.Move (st_vertical.X, cii_WindowBorder + cii_WindowTop)
st_vertical.Resize (cii_Barthickness, 5 + st_horizontal.Y - (cii_WindowBorder + cii_WindowTop))

st_horizontal.Move (cii_WindowBorder, st_horizontal.Y)
st_horizontal.Resize (This.WorkSpaceWidth() - st_horizontal.X - cii_WindowBorder, cii_BarThickness)

st_both.Move(st_vertical.X, st_horizontal.Y)
st_both.Resize(cii_BarThickness, cii_BarThickness)

of_RefreshBars()

end subroutine

on w_size_panels.create
this.st_1=create st_1
this.dw_topleft=create dw_topleft
this.st_both=create st_both
this.st_horizontal=create st_horizontal
this.dw_bottom=create dw_bottom
this.dw_topright=create dw_topright
this.st_vertical=create st_vertical
this.Control[]={this.st_1,&
this.dw_topleft,&
this.st_both,&
this.st_horizontal,&
this.dw_bottom,&
this.dw_topright,&
this.st_vertical}
end on

on w_size_panels.destroy
destroy(this.st_1)
destroy(this.dw_topleft)
destroy(this.st_both)
destroy(this.st_horizontal)
destroy(this.dw_bottom)
destroy(this.dw_topright)
destroy(this.st_vertical)
end on

event open;call super::open;// Set the TopLeft, TopRight, and Bottom Controls
idrg_TopLeft = dw_topleft
idrg_TopRight = dw_topright
idrg_Bottom = dw_bottom

//Change the back color so they cannot be seen.
If Not ib_debug Then 
	st_vertical.BackColor = This.BackColor
	st_both.backcolor = This.BackColor
	st_horizontal.BackColor = This.BackColor
	il_HiddenColor = This.BackColor
End If

// Call the resize functions
of_ResizeBars()
of_ResizePanels()

end event

event resize;// Call the resize functions
of_ResizeBars()
of_ResizePanels()

end event

event close;Show(w_main)

end event

type st_1 from statictext within w_size_panels
int X=9
int Y=12
int Width=1687
int Height=64
boolean Enabled=false
string Text="Drag the borders or change the window size to resize the panels."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_topleft from datawindow within w_size_panels
int X=23
int Y=188
int Width=617
int Height=804
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_both from statictext within w_size_panels
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
int X=841
int Y=1008
int Width=41
int Height=44
string DragIcon="Exclamation!"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=16711680
long BorderColor=16711680
string Pointer="SizeNESW!"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	st_horizontal.Trigger Event mousemove(flags, xpos, ypos)
	st_vertical.Trigger Event mousemove(flags, xpos, ypos)
	
	// Stretch the Vertical line
	st_vertical.Resize(cii_BarThickness, 5 + st_horizontal.Y - (cii_WindowBorder + cii_WindowTop))
End If







end event

event mouseup;st_vertical.Trigger Event mouseup(flags, xpos, ypos)
st_horizontal.Trigger Event mouseup(flags, xpos, ypos)


end event

event mousedown;This.SetPosition(ToTop!)
If Not ib_debug Then
	// Show Bar2 in Black while being moved.
	st_vertical.BackColor = 0
	st_horizontal.BackColor = 0
End If

end event

type st_horizontal from statictext within w_size_panels
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
int X=55
int Y=1084
int Width=745
int Height=32
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=16776960
string Pointer="SizeNS!"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousemove;Integer	li_prevposition

If KeyDown(keyLeftButton!) Then
	// Store the previous position.
	li_prevposition = This.Y

	// Refresh the Bar attributes.	
	This.Y = Parent.PointerY()
	
	// Perform redraws when appropriate.
	If Not IsValid(idrg_topleft) or Not IsValid(idrg_topright) Then Return
	If li_prevposition < idrg_topleft.y + idrg_topleft.height Then 
		idrg_topleft.setredraw(true)
		idrg_topright.setredraw(true)
	End If
	If Not IsValid(idrg_bottom) Then Return
	If li_prevposition > idrg_bottom.y Then idrg_bottom.setredraw(true)
End If

end event

event mouseup;// Hide the bar
If Not ib_Debug Then This.BackColor = il_HiddenColor

// Call the resize functions
of_ResizeBars()
of_ResizePanels()

end event

event mousedown;This.SetPosition(ToTop!)
If Not ib_debug Then This.BackColor = 0  // Show Bar in Black while being moved.

end event

type dw_bottom from datawindow within w_size_panels
int X=41
int Y=1188
int Width=2025
int Height=420
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_topright from datawindow within w_size_panels
int X=1074
int Y=188
int Width=983
int Height=756
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_vertical from statictext within w_size_panels
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
int X=727
int Y=188
int Width=27
int Height=540
string DragIcon="Exclamation!"
boolean FocusRectangle=false
long TextColor=255
long BackColor=255
long BorderColor=276856960
string Pointer="SizeWE!"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousemove;Integer	li_prevposition

If KeyDown(keyLeftButton!) Then
	// Store the previous position.
	li_prevposition = This.X

	// Refresh the Bar attributes.
	This.X = Parent.PointerX()
	
	// Perform redraws when appropriate.
	If Not IsValid(idrg_topright) or Not IsValid(idrg_topleft) Then Return
	If li_prevposition > idrg_topright.x Then idrg_topright.setredraw(true)
	If li_prevposition < idrg_topleft.x + idrg_topleft.width Then idrg_topleft.setredraw(true)
End If

end event

event mouseup;// Hide the bar
If Not ib_Debug Then This.BackColor = il_HiddenColor

// Call the resize functions
of_ResizeBars()
of_ResizePanels()

end event

event mousedown;This.SetPosition(ToTop!)
If Not ib_debug Then This.BackColor = 0  // Show Bar in Black while being moved.

end event

