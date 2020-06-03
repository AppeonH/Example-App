$PBExportHeader$w_reg_update_value.srw
$PBExportComments$Window to update a registry value
forward
global type w_reg_update_value from w_center
end type
type cb_cancel from commandbutton within w_reg_update_value
end type
type cb_ok from commandbutton within w_reg_update_value
end type
type sle_data from singlelineedit within w_reg_update_value
end type
type sle_name from singlelineedit within w_reg_update_value
end type
type st_2 from statictext within w_reg_update_value
end type
type st_1 from statictext within w_reg_update_value
end type
end forward

global type w_reg_update_value from w_center
int X=439
int Y=457
int Width=1843
int Height=625
boolean TitleBar=true
string Title="Edit String"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_cancel cb_cancel
cb_ok cb_ok
sle_data sle_data
sle_name sle_name
st_2 st_2
st_1 st_1
end type
global w_reg_update_value w_reg_update_value

event open;call super::open;String	ls_Parm
Integer	li_Pos

ls_Parm = Message.StringParm

li_Pos = Pos(ls_Parm, "~t")

sle_name.Text = Left(ls_Parm, (li_Pos - 1))
sle_data.Text = Right(ls_Parm, (Len(ls_Parm) - li_Pos))

sle_data.SelectText(1, Len(sle_data.Text))

end event

on w_reg_update_value.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_data=create sle_data
this.sle_name=create sle_name
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={ this.cb_cancel,&
this.cb_ok,&
this.sle_data,&
this.sle_name,&
this.st_2,&
this.st_1}
end on

on w_reg_update_value.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_data)
destroy(this.sle_name)
destroy(this.st_2)
destroy(this.st_1)
end on

type cb_cancel from commandbutton within w_reg_update_value
int X=1418
int Y=389
int Width=307
int Height=85
int TabOrder=20
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Null

SetNull(ls_Null)
CloseWithReturn(Parent, ls_Null)

end event

type cb_ok from commandbutton within w_reg_update_value
int X=1079
int Y=389
int Width=307
int Height=85
int TabOrder=30
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, sle_data.Text)

end event

type sle_data from singlelineedit within w_reg_update_value
int X=33
int Y=277
int Width=1692
int Height=73
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean HideSelection=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_name from singlelineedit within w_reg_update_value
int X=33
int Y=93
int Width=1692
int Height=73
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_reg_update_value
int X=33
int Y=205
int Width=257
int Height=61
boolean Enabled=false
string Text="Value Data:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_reg_update_value
int X=33
int Y=25
int Width=289
int Height=61
boolean Enabled=false
string Text="Value Name:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

