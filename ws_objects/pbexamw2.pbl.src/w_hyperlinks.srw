$PBExportHeader$w_hyperlinks.srw
$PBExportComments$PB7 HyperLink Controls
forward
global type w_hyperlinks from w_center
end type
type shl_phl_linksybase from statichyperlink within w_hyperlinks
end type
type phl_linksybase from picturehyperlink within w_hyperlinks
end type
type st_instruct from statictext within w_hyperlinks
end type
type cb_close from commandbutton within w_hyperlinks
end type
end forward

global type w_hyperlinks from w_center
integer width = 2587
integer height = 1908
string title = "HyperLink Controls"
shl_phl_linksybase shl_phl_linksybase
phl_linksybase phl_linksybase
st_instruct st_instruct
cb_close cb_close
end type
global w_hyperlinks w_hyperlinks

on w_hyperlinks.create
int iCurrent
call super::create
this.shl_phl_linksybase=create shl_phl_linksybase
this.phl_linksybase=create phl_linksybase
this.st_instruct=create st_instruct
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.shl_phl_linksybase
this.Control[iCurrent+2]=this.phl_linksybase
this.Control[iCurrent+3]=this.st_instruct
this.Control[iCurrent+4]=this.cb_close
end on

on w_hyperlinks.destroy
call super::destroy
destroy(this.shl_phl_linksybase)
destroy(this.phl_linksybase)
destroy(this.st_instruct)
destroy(this.cb_close)
end on

event close;call super::close;Show ( w_main )
end event

type shl_phl_linksybase from statichyperlink within w_hyperlinks
integer x = 247
integer y = 284
integer width = 475
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 16711680
long backcolor = 67108864
string text = "www.appeon.com"
boolean focusrectangle = false
string url = "www.appeon.com"
end type

type phl_linksybase from picturehyperlink within w_hyperlinks
integer x = 206
integer y = 388
integer width = 2203
integer height = 1212
string pointer = "HyperLink!"
string picturename = "example.bmp"
boolean focusrectangle = false
string url = "www.appeon.com"
end type

type st_instruct from statictext within w_hyperlinks
integer x = 128
integer y = 48
integer width = 713
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Click on the text or picture to link"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_hyperlinks
integer x = 1042
integer y = 1660
integer width = 334
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;Close ( Parent )
end event

