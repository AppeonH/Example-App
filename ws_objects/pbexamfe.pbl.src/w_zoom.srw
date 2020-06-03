$PBExportHeader$w_zoom.srw
$PBExportComments$Print Zoom Dialog
forward
global type w_zoom from w_center
end type
type cb_1 from commandbutton within w_zoom
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
integer x = 837
integer y = 384
integer width = 992
integer height = 732
string title = "Zoom"
windowtype windowtype = response!
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
cb_1 cb_1
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
int iCurrent
call super::create
this.cb_1=create cb_1
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
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.sle_custom
this.Control[iCurrent+6]=this.rb_custom
this.Control[iCurrent+7]=this.rb_30
this.Control[iCurrent+8]=this.rb_65
this.Control[iCurrent+9]=this.rb_100
this.Control[iCurrent+10]=this.rb_200
this.Control[iCurrent+11]=this.gb_1
end on

on w_zoom.destroy
call super::destroy
destroy(this.cb_1)
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

type cb_1 from commandbutton within w_zoom
integer x = 631
integer y = 376
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "none"
end type

type cb_cancel from commandbutton within w_zoom
integer x = 626
integer y = 204
integer width = 311
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, -1)
end event

type cb_ok from commandbutton within w_zoom
integer x = 626
integer y = 60
integer width = 311
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
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
integer x = 466
integer y = 492
integer width = 50
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "%"
alignment alignment = right!
long bordercolor = 8388608
boolean focusrectangle = false
end type

type sle_custom from singlelineedit within w_zoom
integer x = 343
integer y = 484
integer width = 119
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
string text = "100"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_custom from radiobutton within w_zoom
integer x = 87
integer y = 488
integer width = 233
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Custom"
end type

type rb_30 from radiobutton within w_zoom
integer x = 87
integer y = 392
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "30%"
end type

type rb_65 from radiobutton within w_zoom
integer x = 87
integer y = 296
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "65%"
end type

type rb_100 from radiobutton within w_zoom
integer x = 87
integer y = 200
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "100%"
end type

type rb_200 from radiobutton within w_zoom
integer x = 87
integer y = 104
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "200%"
end type

type gb_1 from groupbox within w_zoom
integer x = 41
integer y = 36
integer width = 526
integer height = 572
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Magnification"
end type

