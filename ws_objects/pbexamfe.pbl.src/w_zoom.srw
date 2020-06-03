$PBExportHeader$w_zoom.srw
$PBExportComments$Print Zoom Dialog
forward
global type w_zoom from w_center
end type
type cb_cancel from commandbutton within w_zoom
end type
type cb_ok from commandbutton within w_zoom
end type
type st_1 from statictext within w_zoom
end type
type sle_custom from singlelineedit within w_zoom
end type
type rb_custom from radiobutton within w_zoom
end type
type rb_30 from radiobutton within w_zoom
end type
type rb_65 from radiobutton within w_zoom
end type
type rb_100 from radiobutton within w_zoom
end type
type rb_200 from radiobutton within w_zoom
end type
type gb_1 from groupbox within w_zoom
end type
end forward

global type w_zoom from w_center
int X=836
int Y=385
int Width=993
int Height=733
boolean TitleBar=true
string Title="Zoom"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
sle_custom sle_custom
rb_custom rb_custom
rb_30 rb_30
rb_65 rb_65
rb_100 rb_100
rb_200 rb_200
gb_1 gb_1
end type
global w_zoom w_zoom

on w_zoom.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.sle_custom=create sle_custom
this.rb_custom=create rb_custom
this.rb_30=create rb_30
this.rb_65=create rb_65
this.rb_100=create rb_100
this.rb_200=create rb_200
this.gb_1=create gb_1
this.Control[]={ this.cb_cancel,&
this.cb_ok,&
this.st_1,&
this.sle_custom,&
this.rb_custom,&
this.rb_30,&
this.rb_65,&
this.rb_100,&
this.rb_200,&
this.gb_1}
end on

on w_zoom.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.sle_custom)
destroy(this.rb_custom)
destroy(this.rb_30)
destroy(this.rb_65)
destroy(this.rb_100)
destroy(this.rb_200)
destroy(this.gb_1)
end on

event open;call super::open;Integer	li_Zoom

li_Zoom = Message.DoubleParm

Choose Case li_Zoom
	Case 200
		rb_200.Checked = True
	Case 100
		rb_100.Checked = True
	Case 65
		rb_65.Checked = True
	Case 30
		rb_30.Checked = True
	Case Else
		rb_custom.Checked = True
		sle_custom.Text = String(li_Zoom)
End Choose
end event

type cb_cancel from commandbutton within w_zoom
int X=626
int Y=202
int Width=310
int Height=93
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, -1)
end event

type cb_ok from commandbutton within w_zoom
int X=626
int Y=61
int Width=310
int Height=93
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer	li_Zoom

If rb_200.Checked Then
	li_Zoom = 200
ElseIf rb_100.Checked Then
	li_Zoom = 100
ElseIf rb_65.Checked Then
	li_Zoom = 65
ElseIf rb_30.Checked Then
	li_Zoom = 30
Else
	If IsNumber(sle_custom.Text) Then
		li_Zoom = Integer(sle_custom.Text)
	Else
		MessageBox("Invalid Zoom Pct.", "Please enter a valid number for zoom percentage.", Exclamation!, OK!)
		Return
	End If
End If

CloseWithReturn(Parent, li_Zoom)
end event

type st_1 from statictext within w_zoom
int X=466
int Y=490
int Width=50
int Height=58
boolean Enabled=false
string Text="%"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_custom from singlelineedit within w_zoom
int X=342
int Y=484
int Width=121
int Height=74
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="100"
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"

FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_custom from radiobutton within w_zoom
int X=89
int Y=487
int Width=235
int Height=65
string Text="Custom"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_30 from radiobutton within w_zoom
int X=89
int Y=391
int Width=193
int Height=65
string Text="30%"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_65 from radiobutton within w_zoom
int X=89
int Y=295
int Width=193
int Height=65
string Text="65%"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_100 from radiobutton within w_zoom
int X=89
int Y=199
int Width=193
int Height=65
string Text="100%"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_200 from radiobutton within w_zoom
int X=89
int Y=103
int Width=193
int Height=65
string Text="200%"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_zoom
int X=43
int Y=36
int Width=527
int Height=573
int TabOrder=10
string Text="Magnification"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

