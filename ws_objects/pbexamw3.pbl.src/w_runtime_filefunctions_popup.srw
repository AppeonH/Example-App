$PBExportHeader$w_runtime_filefunctions_popup.srw
$PBExportComments$PB 8 - New File Functions
forward
global type w_runtime_filefunctions_popup from window
end type
type cb_browse from commandbutton within w_runtime_filefunctions_popup
end type
type cb_ok from commandbutton within w_runtime_filefunctions_popup
end type
type sle_1 from singlelineedit within w_runtime_filefunctions_popup
end type
type st_1 from statictext within w_runtime_filefunctions_popup
end type
end forward

global type w_runtime_filefunctions_popup from window
integer width = 1472
integer height = 576
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_browse cb_browse
cb_ok cb_ok
sle_1 sle_1
st_1 st_1
end type
global w_runtime_filefunctions_popup w_runtime_filefunctions_popup

on w_runtime_filefunctions_popup.create
this.cb_browse=create cb_browse
this.cb_ok=create cb_ok
this.sle_1=create sle_1
this.st_1=create st_1
this.Control[]={this.cb_browse,&
this.cb_ok,&
this.sle_1,&
this.st_1}
end on

on w_runtime_filefunctions_popup.destroy
destroy(this.cb_browse)
destroy(this.cb_ok)
destroy(this.sle_1)
destroy(this.st_1)
end on

event open;string ls_parm, ls_title, ls_text, ls_browse, ls_initial
long ll_pos

ls_parm = Message.StringParm

ll_pos = Pos ( ls_parm, "~t" ) 
If ll_pos > 0 Then
	ls_title = Left ( ls_parm, ll_pos - 1 ) 
	ls_parm = Mid ( ls_parm, ll_pos + 1 ) 
End If

ll_pos = Pos ( ls_parm, "~t" ) 
If ll_pos > 0 Then
	ls_initial = Left ( ls_parm, ll_pos - 1 ) 
	ls_parm = Mid ( ls_parm, ll_pos + 1 ) 
End If

ll_pos = Pos ( ls_parm, "~t" ) 
If ll_pos > 0 Then
	ls_text = Left ( ls_parm, ll_pos - 1 ) 
	ls_browse = Mid ( ls_parm, ll_pos + 1 ) 
End If

this.Title = ls_title
st_1.Text = ls_text
sle_1.Text = ls_initial
cb_browse.Visible = ( Lower ( ls_browse ) = "yes" ) 


end event

type cb_browse from commandbutton within w_runtime_filefunctions_popup
boolean visible = false
integer x = 1339
integer y = 176
integer width = 69
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
end type

event clicked;string ls_path, ls_file
int li_rc
 
ls_path = sle_1.Text
li_rc = GetFileSaveName ( "Select File", &
		ls_path, ls_file, "TXT", &
		"All Files (*.*),*.*" )

IF li_rc = 1 Then
	sle_1.Text = ls_path 
End If
end event

type cb_ok from commandbutton within w_runtime_filefunctions_popup
integer x = 585
integer y = 340
integer width = 334
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;CloseWithReturn ( Parent, sle_1.Text )
end event

type sle_1 from singlelineedit within w_runtime_filefunctions_popup
integer x = 32
integer y = 176
integer width = 1298
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_runtime_filefunctions_popup
integer x = 32
integer y = 36
integer width = 1367
integer height = 132
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

