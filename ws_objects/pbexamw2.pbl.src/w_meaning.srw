$PBExportHeader$w_meaning.srw
$PBExportComments$The meaning of life
forward
global type w_meaning from w_center
end type
type cb_move from picturebutton within w_meaning
end type
type cb_quit from commandbutton within w_meaning
end type
end forward

global type w_meaning from w_center
int X=4
int Y=4
int Width=939
int Height=1146
boolean TitleBar=true
string Title="The Meaning of Life"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
WindowType WindowType=response!
cb_move cb_move
cb_quit cb_quit
end type
global w_meaning w_meaning

type variables
integer ii_cb_width,ii_cb_height,ii_win_height,ii_win_width
end variables

on w_meaning.create
this.cb_move=create cb_move
this.cb_quit=create cb_quit
this.Control[]={ this.cb_move,&
this.cb_quit}
end on

on w_meaning.destroy
destroy(this.cb_move)
destroy(this.cb_quit)
end on

event mousemove;Integer	 	li_PX, li_PY, li_NX, li_NY, li_Top, li_Bottom, li_Left, li_Right
Boolean		lb_Vert, lb_Horiz

li_PX = This.PointerX()
li_PY = This.PointerY()

li_NX = cb_move.x
li_NY = cb_move.y
lb_Vert = (li_PY > (li_NY - 30)) And (li_PY < (li_NY + ii_cb_height + 30))
lb_Horiz = (li_PX > (li_NX - 30)) And (li_PX < (li_NX + ii_cb_width + 30))

If lb_Vert And  lb_Horiz Then	// it's inside so move it
	li_Top = li_PY - (li_NY - 30)
	li_Bottom = (li_NY + ii_cb_height + 30) - li_PY
	li_Left = li_PX - (li_NX - 30)
	li_Right =  (li_NX + ii_cb_width + 30) - li_PX
	
	// Determine which is closer
	If min(li_Top,li_Bottom) < min(li_Left,li_Right) Then
		If li_Top > li_Bottom Then
			li_NY = li_PY - (ii_cb_height  + 30)
		Else
			li_NY = li_PY + 30
		End If
	Else
		If li_Right < li_Left Then
			li_NX = li_PX - (ii_cb_width  + 30)
		Else
			li_NX = li_PX + 30
		End If
	End If
	
	// If this would move it off the window, then wrap it to the other side
	If li_NY < 0 Then 	li_NY = ii_win_height - (30+ ii_cb_height)
	If li_NX < 0 Then 	li_NX = ii_win_width - (30+ ii_cb_width)
	If li_NY+ii_cb_height >= ii_win_height Then li_NY = 30
	If li_NX+ii_cb_width >= ii_win_width Then li_NX = 30
	cb_move.Move(li_NX,li_NY)
End If

end event

event close;Show(w_main)

end event

event resize;// Remember the initial sizes of the button and window
ii_cb_height = cb_move.Height 
ii_cb_width = cb_move.Width
ii_win_height = This.WorkSpaceHeight()
ii_win_width = This.WorkSpaceWidth()

// Center the cb_move button in the window
cb_move.Move(((ii_win_width - ii_cb_width) / 2), ((ii_win_height - ii_cb_height) / 2))

// Center the cb_quit button at the bottom of the window
cb_quit.Move(((ii_win_width - cb_quit.Width) / 2), (ii_win_height - (cb_quit.Height + 20)))

end event

type cb_move from picturebutton within w_meaning
event mousemove pbm_mousemove
int X=232
int Y=305
int Width=431
int Height=199
int TabOrder=20
string Text="Click Here For The Meaning Of Life"
VTextAlign VTextAlign=MultiLine!
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousemove;parent.postevent('mousemove')
end event

event clicked;Messagebox("The meaning of life", "Don't forget about the tab key!")
Close(Parent)

end event

type cb_quit from commandbutton within w_meaning
int X=321
int Y=874
int Width=232
int Height=97
int TabOrder=10
string Text="Quit"
boolean Default=true
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

