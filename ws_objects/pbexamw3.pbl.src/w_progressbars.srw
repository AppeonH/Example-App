$PBExportHeader$w_progressbars.srw
$PBExportComments$PB 7 Progress Bar Controls
forward
global type w_progressbars from w_center
end type
type hpb_1 from hprogressbar within w_progressbars
end type
type vpb_1 from vprogressbar within w_progressbars
end type
type st_htext from statictext within w_progressbars
end type
type st_vtext from statictext within w_progressbars
end type
type em_step from editmask within w_progressbars
end type
type em_start from editmask within w_progressbars
end type
type em_min from editmask within w_progressbars
end type
type em_max from editmask within w_progressbars
end type
type cbx_smooth from checkbox within w_progressbars
end type
type st_step from statictext within w_progressbars
end type
type st_start from statictext within w_progressbars
end type
type st_min from statictext within w_progressbars
end type
type st_max from statictext within w_progressbars
end type
type cb_stop from commandbutton within w_progressbars
end type
type cb_close from commandbutton within w_progressbars
end type
type cb_start from commandbutton within w_progressbars
end type
type gb_options from groupbox within w_progressbars
end type
end forward

global type w_progressbars from w_center
integer width = 2309
integer height = 1640
string title = "Progress Bar Controls"
hpb_1 hpb_1
vpb_1 vpb_1
st_htext st_htext
st_vtext st_vtext
em_step em_step
em_start em_start
em_min em_min
em_max em_max
cbx_smooth cbx_smooth
st_step st_step
st_start st_start
st_min st_min
st_max st_max
cb_stop cb_stop
cb_close cb_close
cb_start cb_start
gb_options gb_options
end type
global w_progressbars w_progressbars

type variables
boolean ib_stop
end variables

on w_progressbars.create
int iCurrent
call super::create
this.hpb_1=create hpb_1
this.vpb_1=create vpb_1
this.st_htext=create st_htext
this.st_vtext=create st_vtext
this.em_step=create em_step
this.em_start=create em_start
this.em_min=create em_min
this.em_max=create em_max
this.cbx_smooth=create cbx_smooth
this.st_step=create st_step
this.st_start=create st_start
this.st_min=create st_min
this.st_max=create st_max
this.cb_stop=create cb_stop
this.cb_close=create cb_close
this.cb_start=create cb_start
this.gb_options=create gb_options
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.hpb_1
this.Control[iCurrent+2]=this.vpb_1
this.Control[iCurrent+3]=this.st_htext
this.Control[iCurrent+4]=this.st_vtext
this.Control[iCurrent+5]=this.em_step
this.Control[iCurrent+6]=this.em_start
this.Control[iCurrent+7]=this.em_min
this.Control[iCurrent+8]=this.em_max
this.Control[iCurrent+9]=this.cbx_smooth
this.Control[iCurrent+10]=this.st_step
this.Control[iCurrent+11]=this.st_start
this.Control[iCurrent+12]=this.st_min
this.Control[iCurrent+13]=this.st_max
this.Control[iCurrent+14]=this.cb_stop
this.Control[iCurrent+15]=this.cb_close
this.Control[iCurrent+16]=this.cb_start
this.Control[iCurrent+17]=this.gb_options
end on

on w_progressbars.destroy
call super::destroy
destroy(this.hpb_1)
destroy(this.vpb_1)
destroy(this.st_htext)
destroy(this.st_vtext)
destroy(this.em_step)
destroy(this.em_start)
destroy(this.em_min)
destroy(this.em_max)
destroy(this.cbx_smooth)
destroy(this.st_step)
destroy(this.st_start)
destroy(this.st_min)
destroy(this.st_max)
destroy(this.cb_stop)
destroy(this.cb_close)
destroy(this.cb_start)
destroy(this.gb_options)
end on

event close;call super::close;Show ( w_main )
end event

event open;call super::open;//  ProgressBar Properties
	//	  boolean bringtotop 
	//	  boolean dragauto 
	//	  boolean smoothscroll 
	//	  boolean visible 
	//	  integer height 
	//	  integer setstep 
	//	  integer taborder 
	//	  integer width 
	//	  integer x 
	//	  integer y 
	//	  powerobject classdefinition 
	//	  string dragicon 
	//	  string pointer 
	//	  string tag 
	//	  unsignedinteger maxposition 
	//	  unsignedinteger minposition 
	//	  unsignedinteger position 



end event

type hpb_1 from hprogressbar within w_progressbars
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
integer x = 178
integer y = 104
integer width = 1897
integer height = 52
end type

type vpb_1 from vprogressbar within w_progressbars
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
integer x = 105
integer y = 104
integer width = 59
integer height = 1368
end type

type st_htext from statictext within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Horizontal Progress Bar"
boolean focusrectangle = false
integer x = 178
integer y = 24
integer width = 512
integer height = 52
end type

type st_vtext from statictext within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vertical Progress Bar"
boolean focusrectangle = false
integer x = 187
integer y = 704
integer width = 229
integer height = 236
end type

type em_step from editmask within w_progressbars
string mask = "#####"
boolean spin = true
string minmax = "0~~100"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
integer accelerator = 105
borderstyle borderstyle = stylelowered!
integer x = 1120
integer y = 404
integer width = 343
integer height = 92
integer taborder = 10
end type

event constructor;decimal ll_value

ll_value = Long ( hpb_1.SetStep ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 


hpb_1.SetStep = ll_value
vpb_1.SetStep = ll_value

end event

type em_start from editmask within w_progressbars
string mask = "#####"
boolean spin = true
string minmax = "0~~1000"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
integer accelerator = 112
borderstyle borderstyle = stylelowered!
integer x = 1120
integer y = 500
integer width = 343
integer height = 92
integer taborder = 30
end type

event constructor;decimal ll_value

ll_value = Long ( hpb_1.Position ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 


hpb_1.Position = ll_value
vpb_1.Position = ll_value

end event

type em_min from editmask within w_progressbars
string mask = "#####"
boolean spin = true
string minmax = "1~~10000"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
integer accelerator = 109
borderstyle borderstyle = stylelowered!
integer x = 1120
integer y = 596
integer width = 343
integer height = 92
integer taborder = 40
end type

event constructor;decimal ll_value

ll_value = Long ( hpb_1.SetStep ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 


hpb_1.MinPosition = ll_value
vpb_1.MinPosition = ll_value
end event

type em_max from editmask within w_progressbars
string mask = "#####"
boolean spin = true
string minmax = "1~~10000"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
integer accelerator = 120
borderstyle borderstyle = stylelowered!
integer x = 1120
integer y = 692
integer width = 343
integer height = 92
integer taborder = 50
end type

event constructor;decimal ll_value

ll_value = Long ( hpb_1.MaxPosition ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 


hpb_1.MaxPosition = ll_value
vpb_1.MaxPosition = ll_value
end event

type cbx_smooth from checkbox within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Smooth S&crolling"
borderstyle borderstyle = stylelowered!
integer x = 1120
integer y = 812
integer width = 882
integer height = 64
integer taborder = 60
end type

event constructor;this.Checked = hpb_1.SmoothScroll
end event

event clicked;hpb_1.SmoothScroll = this.Checked
vpb_1.SmoothScroll = this.Checked
hpb_1.SetReDraw ( True )
vpb_1.SetReDraw ( True )
end event

type st_step from statictext within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Step &Increment:"
boolean focusrectangle = false
integer x = 667
integer y = 412
integer width = 379
integer height = 76
end type

type st_start from statictext within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start &Position:"
boolean focusrectangle = false
integer x = 667
integer y = 508
integer width = 352
integer height = 76
end type

type st_min from statictext within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Min Position:"
boolean focusrectangle = false
integer x = 667
integer y = 604
integer width = 352
integer height = 76
end type

type st_max from statictext within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ma&x Position:"
boolean focusrectangle = false
integer x = 667
integer y = 700
integer width = 352
integer height = 76
end type

type cb_stop from commandbutton within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "S&top"
integer x = 1134
integer y = 1016
integer width = 325
integer height = 92
integer taborder = 80
end type

event clicked;ib_stop = True
end event

type cb_close from commandbutton within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "E&xit"
integer x = 1477
integer y = 1016
integer width = 325
integer height = 92
integer taborder = 90
end type

event clicked;Close ( Parent )
end event

type cb_start from commandbutton within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Start"
integer x = 791
integer y = 1016
integer width = 325
integer height = 92
integer taborder = 70
end type

event clicked;long ll_step, ll_max

SetPointer ( HourGlass! )

ll_max = hpb_1.MaxPosition

For ll_step = 1 to ll_max
	Yield ( ) 
	If ib_stop Then
		ib_stop = False
		Return
	End If
	hpb_1.StepIt ( )
	vpb_1.StepIt ( )
Next 
end event

type gb_options from groupbox within w_progressbars
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Options"
borderstyle borderstyle = stylelowered!
integer x = 553
integer y = 280
integer width = 1518
integer height = 932
end type

