$PBExportHeader$w_trackbars.srw
$PBExportComments$PB 7 Track Bar Controls
forward
global type w_trackbars from w_center
end type
type em_linesize from editmask within w_trackbars
end type
type em_start from editmask within w_trackbars
end type
type em_min from editmask within w_trackbars
end type
type em_max from editmask within w_trackbars
end type
type cbx_slider from checkbox within w_trackbars
end type
type st_linesize from statictext within w_trackbars
end type
type st_start from statictext within w_trackbars
end type
type st_min from statictext within w_trackbars
end type
type st_max from statictext within w_trackbars
end type
type cb_close from commandbutton within w_trackbars
end type
type htb_1 from htrackbar within w_trackbars
end type
type vtb_1 from vtrackbar within w_trackbars
end type
type st_slidersize from statictext within w_trackbars
end type
type em_slidersize from editmask within w_trackbars
end type
type st_tickfreq from statictext within w_trackbars
end type
type em_tickfreq from editmask within w_trackbars
end type
type st_pagesize from statictext within w_trackbars
end type
type em_pagesize from editmask within w_trackbars
end type
type rb_top from radiobutton within w_trackbars
end type
type rb_hboth from radiobutton within w_trackbars
end type
type rb_bottom from radiobutton within w_trackbars
end type
type rb_hneither from radiobutton within w_trackbars
end type
type rb_vboth from radiobutton within w_trackbars
end type
type rb_left from radiobutton within w_trackbars
end type
type rb_right from radiobutton within w_trackbars
end type
type rb_vneither from radiobutton within w_trackbars
end type
type gb_htick from groupbox within w_trackbars
end type
type gb_vtick from groupbox within w_trackbars
end type
type gb_options from groupbox within w_trackbars
end type
type dw_1 from datawindow within w_trackbars
end type
type st_1 from statictext within w_trackbars
end type
end forward

global type w_trackbars from w_center
integer width = 3749
integer height = 1784
string title = "Progress Bar Controls"
em_linesize em_linesize
em_start em_start
em_min em_min
em_max em_max
cbx_slider cbx_slider
st_linesize st_linesize
st_start st_start
st_min st_min
st_max st_max
cb_close cb_close
htb_1 htb_1
vtb_1 vtb_1
st_slidersize st_slidersize
em_slidersize em_slidersize
st_tickfreq st_tickfreq
em_tickfreq em_tickfreq
st_pagesize st_pagesize
em_pagesize em_pagesize
rb_top rb_top
rb_hboth rb_hboth
rb_bottom rb_bottom
rb_hneither rb_hneither
rb_vboth rb_vboth
rb_left rb_left
rb_right rb_right
rb_vneither rb_vneither
gb_htick gb_htick
gb_vtick gb_vtick
gb_options gb_options
dw_1 dw_1
st_1 st_1
end type
global w_trackbars w_trackbars

type variables
boolean ib_stop
end variables

on w_trackbars.create
int iCurrent
call super::create
this.em_linesize=create em_linesize
this.em_start=create em_start
this.em_min=create em_min
this.em_max=create em_max
this.cbx_slider=create cbx_slider
this.st_linesize=create st_linesize
this.st_start=create st_start
this.st_min=create st_min
this.st_max=create st_max
this.cb_close=create cb_close
this.htb_1=create htb_1
this.vtb_1=create vtb_1
this.st_slidersize=create st_slidersize
this.em_slidersize=create em_slidersize
this.st_tickfreq=create st_tickfreq
this.em_tickfreq=create em_tickfreq
this.st_pagesize=create st_pagesize
this.em_pagesize=create em_pagesize
this.rb_top=create rb_top
this.rb_hboth=create rb_hboth
this.rb_bottom=create rb_bottom
this.rb_hneither=create rb_hneither
this.rb_vboth=create rb_vboth
this.rb_left=create rb_left
this.rb_right=create rb_right
this.rb_vneither=create rb_vneither
this.gb_htick=create gb_htick
this.gb_vtick=create gb_vtick
this.gb_options=create gb_options
this.dw_1=create dw_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_linesize
this.Control[iCurrent+2]=this.em_start
this.Control[iCurrent+3]=this.em_min
this.Control[iCurrent+4]=this.em_max
this.Control[iCurrent+5]=this.cbx_slider
this.Control[iCurrent+6]=this.st_linesize
this.Control[iCurrent+7]=this.st_start
this.Control[iCurrent+8]=this.st_min
this.Control[iCurrent+9]=this.st_max
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.htb_1
this.Control[iCurrent+12]=this.vtb_1
this.Control[iCurrent+13]=this.st_slidersize
this.Control[iCurrent+14]=this.em_slidersize
this.Control[iCurrent+15]=this.st_tickfreq
this.Control[iCurrent+16]=this.em_tickfreq
this.Control[iCurrent+17]=this.st_pagesize
this.Control[iCurrent+18]=this.em_pagesize
this.Control[iCurrent+19]=this.rb_top
this.Control[iCurrent+20]=this.rb_hboth
this.Control[iCurrent+21]=this.rb_bottom
this.Control[iCurrent+22]=this.rb_hneither
this.Control[iCurrent+23]=this.rb_vboth
this.Control[iCurrent+24]=this.rb_left
this.Control[iCurrent+25]=this.rb_right
this.Control[iCurrent+26]=this.rb_vneither
this.Control[iCurrent+27]=this.gb_htick
this.Control[iCurrent+28]=this.gb_vtick
this.Control[iCurrent+29]=this.gb_options
this.Control[iCurrent+30]=this.dw_1
this.Control[iCurrent+31]=this.st_1
end on

on w_trackbars.destroy
call super::destroy
destroy(this.em_linesize)
destroy(this.em_start)
destroy(this.em_min)
destroy(this.em_max)
destroy(this.cbx_slider)
destroy(this.st_linesize)
destroy(this.st_start)
destroy(this.st_min)
destroy(this.st_max)
destroy(this.cb_close)
destroy(this.htb_1)
destroy(this.vtb_1)
destroy(this.st_slidersize)
destroy(this.em_slidersize)
destroy(this.st_tickfreq)
destroy(this.em_tickfreq)
destroy(this.st_pagesize)
destroy(this.em_pagesize)
destroy(this.rb_top)
destroy(this.rb_hboth)
destroy(this.rb_bottom)
destroy(this.rb_hneither)
destroy(this.rb_vboth)
destroy(this.rb_left)
destroy(this.rb_right)
destroy(this.rb_vneither)
destroy(this.gb_htick)
destroy(this.gb_vtick)
destroy(this.gb_options)
destroy(this.dw_1)
destroy(this.st_1)
end on

event close;call super::close;Show ( w_main )
end event

event open;call super::open;//  TrackBar Properties
	//	  boolean bringtotop 
	//	  boolean dragauto 
	//	  boolean slider 
	//	  boolean visible 
	//	  htickmarks tickmarks 
	//	  integer height 
	//	  integer linesize 
	//	  integer maxposition 
	//	  integer minposition 
	//	  integer pagesize 
	//	  integer position 
	//	  integer slidersize 
	//	  integer taborder 
	//	  integer tickfrequency 
	//	  integer width 
	//	  integer x 
	//	  integer y 
	//	  powerobject classdefinition 
	//	  string dragicon 
	//	  string pointer 
	//	  string tag 
	vtb_1.Position = 100
	htb_1.Position = 100
	




end event

type em_linesize from editmask within w_trackbars
integer x = 2400
integer y = 144
integer width = 343
integer height = 92
integer taborder = 10
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
string mask = "####0"
boolean spin = true
string minmax = "0~~100"
end type

event constructor;decimal ll_value

ll_value = Long ( htb_1.LineSize ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 

htb_1.LineSize = ll_value
vtb_1.LineSize = ll_value
end event

type em_start from editmask within w_trackbars
integer x = 2400
integer y = 336
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
integer accelerator = 111
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string minmax = "0~~1000"
end type

event constructor;decimal ll_value

ll_value = Long ( htb_1.Position ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 

htb_1.Position = ll_value
vtb_1.Position = ll_value
end event

type em_min from editmask within w_trackbars
integer x = 2400
integer y = 428
integer width = 343
integer height = 92
integer taborder = 40
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
string mask = "####0"
boolean spin = true
string minmax = "1~~10000"
end type

event constructor;decimal ll_value

ll_value = Long ( htb_1.MinPosition ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 

htb_1.MinPosition = ll_value
vtb_1.MinPosition = ll_value
end event

type em_max from editmask within w_trackbars
integer x = 2400
integer y = 528
integer width = 343
integer height = 92
integer taborder = 50
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
string mask = "####0"
boolean spin = true
string minmax = "1~~10000"
end type

event constructor;decimal ll_value

ll_value = Long ( htb_1.MaxPosition ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 

htb_1.MaxPosition = ll_value
vtb_1.MaxPosition = ll_value
end event

type cbx_slider from checkbox within w_trackbars
integer x = 2400
integer y = 840
integer width = 402
integer height = 64
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sho&w Slider"
borderstyle borderstyle = stylelowered!
end type

event constructor;//this.Checked = hpb_1.SmoothScroll
end event

event clicked;htb_1.Slider = this.Checked
vtb_1.Slider = this.Checked

end event

type st_linesize from statictext within w_trackbars
integer x = 1957
integer y = 152
integer width = 421
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Line S&ize:"
boolean focusrectangle = false
end type

type st_start from statictext within w_trackbars
integer x = 1957
integer y = 344
integer width = 421
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Start P&osition:"
boolean focusrectangle = false
end type

type st_min from statictext within w_trackbars
integer x = 1957
integer y = 436
integer width = 421
integer height = 76
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
end type

type st_max from statictext within w_trackbars
integer x = 1957
integer y = 536
integer width = 421
integer height = 76
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
end type

type cb_close from commandbutton within w_trackbars
integer x = 2510
integer y = 1100
integer width = 325
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "E&xit"
end type

event clicked;Close ( Parent )
end event

type htb_1 from htrackbar within w_trackbars
integer x = 192
integer y = 1460
integer width = 1614
integer height = 144
integer taborder = 190
integer minposition = 10
integer maxposition = 200
integer position = 100
integer tickfrequency = 5
integer pagesize = 5
integer linesize = 5
end type

event moved;dw_1.Object.DataWindow.Zoom = scrollpos
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

event lineup;dw_1.Object.DataWindow.Zoom = this.Position
end event

event linedown;dw_1.Object.DataWindow.Zoom = this.Position
end event

event pagedown;dw_1.Object.DataWindow.Zoom = this.Position
end event

event pageup;dw_1.Object.DataWindow.Zoom = this.Position
end event

event lineleft;dw_1.Object.DataWindow.Zoom = this.Position
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

event lineright;dw_1.Object.DataWindow.Zoom = this.Position
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

event pageleft;dw_1.Object.DataWindow.Zoom = this.Position
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

event pageright;dw_1.Object.DataWindow.Zoom = this.Position
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

type vtb_1 from vtrackbar within w_trackbars
integer x = 32
integer y = 60
integer width = 169
integer height = 1400
integer taborder = 180
integer minposition = 10
integer maxposition = 200
integer position = 100
integer tickfrequency = 5
integer pagesize = 5
integer linesize = 5
end type

event moved;dw_1.Object.DataWindow.Zoom = scrollpos
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

event lineup;dw_1.Object.DataWindow.Zoom = this.Position
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

event linedown;dw_1.Object.DataWindow.Zoom = this.Position
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

event pagedown;dw_1.Object.DataWindow.Zoom = this.Position
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

event pageup;dw_1.Object.DataWindow.Zoom = this.Position
dw_1.Title = "Zoom is " + String ( this.Position ) + "%"
end event

type st_slidersize from statictext within w_trackbars
integer x = 1957
integer y = 632
integer width = 421
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Sli&der Size:"
boolean focusrectangle = false
end type

type em_slidersize from editmask within w_trackbars
integer x = 2400
integer y = 624
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
integer accelerator = 100
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string minmax = "1~~10000"
end type

event constructor;decimal ll_value

ll_value = Long ( htb_1.SliderSize ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 

htb_1.SliderSize = ll_value
vtb_1.SliderSize = ll_value
end event

type st_tickfreq from statictext within w_trackbars
integer x = 1961
integer y = 728
integer width = 421
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tick &Frequency:"
boolean focusrectangle = false
end type

type em_tickfreq from editmask within w_trackbars
integer x = 2395
integer y = 720
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
integer accelerator = 102
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string minmax = "1~~10000"
end type

event constructor;decimal ll_value

ll_value = Long ( htb_1.TickFrequency ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 

htb_1.TickFrequency = ll_value
vtb_1.TickFrequency = ll_value
end event

type st_pagesize from statictext within w_trackbars
integer x = 1957
integer y = 248
integer width = 421
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "P&age Size:"
boolean focusrectangle = false
end type

type em_pagesize from editmask within w_trackbars
integer x = 2400
integer y = 240
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
integer accelerator = 97
borderstyle borderstyle = stylelowered!
string mask = "####0"
boolean spin = true
string minmax = "0~~100"
end type

event constructor;decimal ll_value

ll_value = Long ( htb_1.PageSize ) 

this.Text = String ( ll_value ) 
end event

event modified;decimal ll_value

this.GetData ( ll_value ) 

htb_1.PageSize = ll_value
vtb_1.PageSize = ll_value
end event

type rb_top from radiobutton within w_trackbars
integer x = 2875
integer y = 284
integer width = 562
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Top"
borderstyle borderstyle = stylelowered!
end type

event clicked;gb_htick.Event ue_ChangeTicks ( ) 
end event

type rb_hboth from radiobutton within w_trackbars
integer x = 2875
integer y = 216
integer width = 562
integer height = 76
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "To&p && Bottom"
borderstyle borderstyle = stylelowered!
end type

event clicked;gb_htick.Event ue_ChangeTicks ( ) 
end event

type rb_bottom from radiobutton within w_trackbars
integer x = 2875
integer y = 352
integer width = 562
integer height = 76
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Bottom"
borderstyle borderstyle = stylelowered!
end type

event clicked;gb_htick.Event ue_ChangeTicks ( ) 
end event

type rb_hneither from radiobutton within w_trackbars
integer x = 2875
integer y = 420
integer width = 562
integer height = 76
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Neither"
borderstyle borderstyle = stylelowered!
end type

event clicked;gb_htick.Event ue_ChangeTicks ( ) 
end event

type rb_vboth from radiobutton within w_trackbars
integer x = 2875
integer y = 656
integer width = 562
integer height = 76
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Left && Ri&ght"
borderstyle borderstyle = stylelowered!
end type

event clicked;gb_vtick.Event ue_ChangeTicks ( ) 
end event

type rb_left from radiobutton within w_trackbars
integer x = 2875
integer y = 728
integer width = 562
integer height = 76
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Left"
borderstyle borderstyle = stylelowered!
end type

event clicked;gb_vtick.Event ue_ChangeTicks ( ) 
end event

type rb_right from radiobutton within w_trackbars
integer x = 2875
integer y = 800
integer width = 562
integer height = 76
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "&Right"
borderstyle borderstyle = stylelowered!
end type

event clicked;gb_vtick.Event ue_ChangeTicks ( ) 
end event

type rb_vneither from radiobutton within w_trackbars
integer x = 2875
integer y = 872
integer width = 562
integer height = 76
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "N&either"
borderstyle borderstyle = stylelowered!
end type

event clicked;gb_vtick.Event ue_ChangeTicks ( ) 
end event

type gb_htick from groupbox within w_trackbars
event ue_changeticks ( )
integer x = 2821
integer y = 136
integer width = 727
integer height = 408
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Horizontal Tick Position"
borderstyle borderstyle = stylelowered!
end type

event ue_changeticks;Choose Case True
		
	Case rb_hboth.Checked
		htb_1.TickMarks = HTicksOnBoth!
		
	Case rb_hneither.Checked
		htb_1.TickMarks = HTicksOnNeither!
		
	Case rb_top.Checked
		htb_1.TickMarks = HTicksOnTop!
		
	Case rb_bottom.Checked
		htb_1.TickMarks = HTicksOnBottom!
		
End Choose
end event

event constructor;Choose Case htb_1.TickMarks
		
	Case HTicksOnBoth! 
		rb_hboth.Checked = True
		
	Case HTicksOnBottom! 
		rb_bottom.Checked = True
		
	Case HTicksOnNeither! 
		rb_hneither.Checked = True
		
	Case HTicksOnTop! 
		rb_top.Checked = True
		
End Choose

end event

type gb_vtick from groupbox within w_trackbars
event ue_changeticks ( )
integer x = 2821
integer y = 572
integer width = 727
integer height = 424
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vertical Tick Position"
borderstyle borderstyle = stylelowered!
end type

event ue_changeticks;Choose Case True
		
	Case rb_vboth.Checked
		vtb_1.TickMarks = VTicksOnBoth!
		
	Case rb_vneither.Checked
		vtb_1.TickMarks = VTicksOnNeither!
		
	Case rb_left.Checked
		vtb_1.TickMarks = VTicksOnLeft!
		
	Case rb_right.Checked
		vtb_1.TickMarks = VTicksOnRight!
		
End Choose
end event

event constructor;Choose Case vtb_1.TickMarks
		
	Case VTicksOnBoth! 
		rb_vboth.Checked = True
		
	Case VTicksOnLeft! 
		rb_left.Checked = True
		
	Case VTicksOnNeither! 
		rb_vneither.Checked = True
		
	Case VTicksOnRight! 
		rb_right.Checked = True
		
End Choose

end event

type gb_options from groupbox within w_trackbars
integer x = 1842
integer y = 60
integer width = 1815
integer height = 1012
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
end type

type dw_1 from datawindow within w_trackbars
integer x = 215
integer y = 80
integer width = 1573
integer height = 1360
boolean titlebar = true
string title = "Zoom is 100%"
string dataobject = "d_examples"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_trackbars
integer x = 215
integer y = 8
integer width = 983
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Move the Track Bar to zoom the datawindow"
boolean focusrectangle = false
end type

