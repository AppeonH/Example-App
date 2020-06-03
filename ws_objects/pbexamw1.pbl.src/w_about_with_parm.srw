$PBExportHeader$w_about_with_parm.srw
$PBExportComments$A Generic About window that is opened using the OpenSheetWithParm feature. This window then takes a string passed to it and formats it for the about window.
forward
global type w_about_with_parm from w_center
end type
type lv_1 from listview within w_about_with_parm
end type
type st_sys_resources from statictext within w_about_with_parm
end type
type st_mode from statictext within w_about_with_parm
end type
type cb_ok from commandbutton within w_about_with_parm
end type
type st_1 from statictext within w_about_with_parm
end type
type st_app_title from statictext within w_about_with_parm
end type
type st_conv_memory from statictext within w_about_with_parm
end type
type mle_about from multilineedit within w_about_with_parm
end type
type ln_1 from line within w_about_with_parm
end type
end forward

global type w_about_with_parm from w_center
integer x = 663
integer y = 268
integer width = 1577
integer height = 1060
string title = "About:"
windowtype windowtype = response!
long backcolor = 78682240
string icon = "None!"
toolbaralignment toolbaralignment = alignatleft!
lv_1 lv_1
st_sys_resources st_sys_resources
st_mode st_mode
cb_ok cb_ok
st_1 st_1
st_app_title st_app_title
st_conv_memory st_conv_memory
mle_about mle_about
ln_1 ln_1
end type
global w_about_with_parm w_about_with_parm

type prototypes

end prototypes

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Purpose:
//	This window expects to receive a string parameter that will contain
//	an @ sign to use as a delimiter to provide a window title and a message
//	to place in the window MLE control.
//
//	This script uses the 
//		Message Object String Parm to pass the title and contents of the 
//			About Window
//		POS function to find the Position of the @ sign 
//		MID Funciton to disect the string into 
//			THe window title = everything infront of the @ sign
//			The about Message = Everything after the @ sign
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string			 	ls_message, ls_windowtitle
int 				li_position, li_index
ulong			lul_memcount
uint				lui_resource_avail
ListViewItem	llvi_1

st_1.Text = "PowerBuilder " + sVersion + " Code Examples"
//************************************************************************
//		Display the logo icon in the ListView
//************************************************************************
llvi_1.PictureIndex = 1
lv_1.AddItem(llvi_1)
llvi_1.ItemX = -75
llvi_1.ItemY = 5
lv_1.SetItem(1, llvi_1)

//************************************************************************
//		First find the postion of the @ sign  
//************************************************************************
li_position = pos(message.stringparm, "@")

//************************************************************************
//		If There is an @ sign (lPosition > 0) then take the title and 
//		message out of the Message object StringParm
//		If there is no @ sign Assume that there is no title and use the 
//		String as the message
//************************************************************************

If li_position > 0 then 
	ls_windowtitle = mid(Message.StringParm, 1, li_position - 1)
	ls_message = mid (Message.StringParm, li_position + 1, Len(Message.StringParm))
else
	ls_windowtitle = Message.StringParm
	ls_message = ""
End if


//************************************************************************
//		Set up the window
//************************************************************************

//Move Title to appropriate spots
this.title = "About: " + ls_windowtitle
st_app_title.text = ls_windowtitle

//Display message if any 
//If no message is available, remove comment box
if ls_message = "" then
	mle_about.visible = false
else
	mle_about.text = ls_message
End if

//Get Conventional memory from Global ExternalSDK call
// It returns the number of bytes available. Convert Bytes
// returned to K by dividing by 1024.
lul_memcount = gu_ext_func.uf_GetFreeMemory()
st_conv_memory.text = "Memory:             " + &
	String(lul_memcount / 1024,"#,##0") + " KB Free"


//Get System Resources from Global External SDK call
// It returns the % free System Resources 
lui_resource_avail = gu_ext_func.uf_GetFreeSystemResources( 0 )
If lui_resource_avail <> 0 Then
	st_sys_resources.text = "System Resources:  " + String (lui_resource_avail) + " %  Free"
End If


// Returns a double word of binary  encoded values.
// If the 6th bit is turned on , then the system is 386 enhanced mode
// If the 5th bit is turned on, then the system is standard mode
// other wise its in Real Mode
st_mode.text = gu_ext_func.uf_GetOS_mode ( )

end event

on w_about_with_parm.create
int iCurrent
call super::create
this.lv_1=create lv_1
this.st_sys_resources=create st_sys_resources
this.st_mode=create st_mode
this.cb_ok=create cb_ok
this.st_1=create st_1
this.st_app_title=create st_app_title
this.st_conv_memory=create st_conv_memory
this.mle_about=create mle_about
this.ln_1=create ln_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_1
this.Control[iCurrent+2]=this.st_sys_resources
this.Control[iCurrent+3]=this.st_mode
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_app_title
this.Control[iCurrent+7]=this.st_conv_memory
this.Control[iCurrent+8]=this.mle_about
this.Control[iCurrent+9]=this.ln_1
end on

on w_about_with_parm.destroy
call super::destroy
destroy(this.lv_1)
destroy(this.st_sys_resources)
destroy(this.st_mode)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.st_app_title)
destroy(this.st_conv_memory)
destroy(this.mle_about)
destroy(this.ln_1)
end on

type lv_1 from listview within w_about_with_parm
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 74481808
boolean enabled = false
boolean border = false
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean scrolling = false
string largepicturename[] = {"exampl.bmp"}
long largepicturemaskcolor = 12632256
integer smallpicturewidth = 16
integer smallpictureheight = 16
long smallpicturemaskcolor = 553648127
long statepicturemaskcolor = 553648127
integer x = 37
integer y = 20
integer width = 210
integer height = 172
integer taborder = 20
end type

type st_sys_resources from statictext within w_about_with_parm
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
boolean focusrectangle = false
integer x = 265
integer y = 864
integer width = 1225
integer height = 68
end type

type st_mode from statictext within w_about_with_parm
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Windows Mode"
boolean focusrectangle = false
integer x = 265
integer y = 736
integer width = 1225
integer height = 68
end type

type cb_ok from commandbutton within w_about_with_parm
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
integer x = 1175
integer y = 16
integer width = 329
integer height = 100
integer taborder = 10
end type

on clicked;close(parent)
end on

type st_1 from statictext within w_about_with_parm
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "PowerBuilder 5.0 Code Examples "
boolean focusrectangle = false
integer x = 265
integer y = 112
integer width = 887
integer height = 76
end type

type st_app_title from statictext within w_about_with_parm
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "App Title Here"
boolean focusrectangle = false
integer x = 265
integer y = 36
integer width = 914
integer height = 76
end type

type st_conv_memory from statictext within w_about_with_parm
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean enabled = false
string text = "Conventional Memory"
boolean focusrectangle = false
integer x = 265
integer y = 800
integer width = 1225
integer height = 68
end type

type mle_about from multilineedit within w_about_with_parm
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
integer x = 41
integer y = 240
integer width = 1463
integer height = 448
end type

type ln_1 from line within w_about_with_parm
integer beginx = 265
integer beginy = 724
integer endx = 1513
integer endy = 724
long linecolor = 33554432
integer linethickness = 4
end type

