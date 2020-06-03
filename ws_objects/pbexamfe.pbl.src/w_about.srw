$PBExportHeader$w_about.srw
$PBExportComments$About box for examples
forward
global type w_about from w_center
end type
type phl_logo from picturehyperlink within w_about
end type
type st_exver from statictext within w_about
end type
type st_os from statictext within w_about
end type
type st_pbtype from statictext within w_about
end type
type cb_ok from commandbutton within w_about
end type
type st_3 from statictext within w_about
end type
type st_version from statictext within w_about
end type
type st_1 from statictext within w_about
end type
type st_2 from statictext within w_about
end type
end forward

global type w_about from w_center
integer x = 731
integer y = 940
integer width = 1399
integer height = 932
string title = "About"
windowtype windowtype = response!
long backcolor = 79416533
toolbaralignment toolbaralignment = alignatleft!
phl_logo phl_logo
st_exver st_exver
st_os st_os
st_pbtype st_pbtype
cb_ok cb_ok
st_3 st_3
st_version st_version
st_1 st_1
st_2 st_2
end type
global w_about w_about

type variables
end variables

event open;call super::open;Long ll_Memory

st_exver.Text = "Version " + sVERSIONEX
st_version.Text = "Version " + sVERSIONNAME

st_pbtype.Text = "PowerBuilder "
If ge_Environment.PBType = desktop! Then
	st_pbtype.Text = st_pbtype.Text + "Desktop"
Else
	st_pbtype.Text = st_pbtype.Text + "Enterprise"
End If

st_os.Text = "Windows " + String(ge_Environment.OSMajorRevision) + &
	"." + String(ge_Environment.OSMinorRevision)
	
int li_year
li_year = Year ( Today() )
st_3.text = "© " + String (li_year, "####" ) + " Appeon.  All rights reserved."

end event

on w_about.create
int iCurrent
call super::create
this.phl_logo=create phl_logo
this.st_exver=create st_exver
this.st_os=create st_os
this.st_pbtype=create st_pbtype
this.cb_ok=create cb_ok
this.st_3=create st_3
this.st_version=create st_version
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.phl_logo
this.Control[iCurrent+2]=this.st_exver
this.Control[iCurrent+3]=this.st_os
this.Control[iCurrent+4]=this.st_pbtype
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_version
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
end on

on w_about.destroy
call super::destroy
destroy(this.phl_logo)
destroy(this.st_exver)
destroy(this.st_os)
destroy(this.st_pbtype)
destroy(this.cb_ok)
destroy(this.st_3)
destroy(this.st_version)
destroy(this.st_1)
destroy(this.st_2)
end on

type phl_logo from picturehyperlink within w_about
integer x = 37
integer y = 64
integer width = 192
integer height = 172
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "exampl.bmp"
boolean focusrectangle = false
boolean map3dcolors = true
string url = "https://www.appeon.com/products/appeon-powerbuilder.html"
end type

type st_exver from statictext within w_about
integer x = 256
integer y = 128
integer width = 869
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
boolean enabled = false
string text = "Version nn.n.n.nn"
alignment alignment = center!
long bordercolor = 8388608
boolean focusrectangle = false
end type

type st_os from statictext within w_about
integer x = 256
integer y = 416
integer width = 869
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
boolean enabled = false
string text = "Windows n.n"
alignment alignment = center!
long bordercolor = 8388608
boolean focusrectangle = false
end type

type st_pbtype from statictext within w_about
integer x = 256
integer y = 288
integer width = 869
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
boolean enabled = false
string text = "PowerBuilder %version%"
alignment alignment = center!
long bordercolor = 8388608
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_about
integer x = 512
integer y = 704
integer width = 320
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;Close(Parent)
end event

type st_3 from statictext within w_about
integer x = 238
integer y = 512
integer width = 1280
integer height = 160
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
boolean enabled = false
string text = "© yyyy Appeon. All rights reserved."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_version from statictext within w_about
integer x = 256
integer y = 352
integer width = 869
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
boolean enabled = false
string text = "Version nn.n.n"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_about
integer x = 256
integer y = 64
integer width = 869
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
boolean enabled = false
string text = "PowerBuilder Code Examples"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_about
integer x = 256
integer y = 192
integer width = 869
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
string text = "by Appeon"
alignment alignment = center!
boolean focusrectangle = false
end type

