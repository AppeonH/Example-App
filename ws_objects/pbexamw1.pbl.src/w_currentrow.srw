$PBExportHeader$w_currentrow.srw
$PBExportComments$Example using the CurrentRow() function to update a customer
forward
global type w_currentrow from w_center
end type
type cb_help from commandbutton within w_currentrow
end type
type cb_cancel from commandbutton within w_currentrow
end type
type cb_update from commandbutton within w_currentrow
end type
type dw_1 from datawindow within w_currentrow
end type
end forward

global type w_currentrow from w_center
int X=4
int Y=4
int Width=2962
int Height=1863
boolean TitleBar=true
string Title="CurrentRow()"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_postopen ( )
cb_help cb_help
cb_cancel cb_cancel
cb_update cb_update
dw_1 dw_1
end type
global w_currentrow w_currentrow

event ue_postopen;dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end event

event open;call super::open;Post Event ue_postopen()

end event

on w_currentrow.create
this.cb_help=create cb_help
this.cb_cancel=create cb_cancel
this.cb_update=create cb_update
this.dw_1=create dw_1
this.Control[]={ this.cb_help,&
this.cb_cancel,&
this.cb_update,&
this.dw_1}
end on

on w_currentrow.destroy
destroy(this.cb_help)
destroy(this.cb_cancel)
destroy(this.cb_update)
destroy(this.dw_1)
end on

event close;Show(w_main)

end event

type cb_help from commandbutton within w_currentrow
int X=1753
int Y=1652
int Width=249
int Height=87
int TabOrder=40
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_currentrow")

end event

type cb_cancel from commandbutton within w_currentrow
int X=1384
int Y=1652
int Width=249
int Height=87
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_update from commandbutton within w_currentrow
int X=1014
int Y=1652
int Width=249
int Height=87
int TabOrder=10
string Text="Update"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.Update()

end event

type dw_1 from datawindow within w_currentrow
int X=4
int Y=4
int Width=2920
int Height=1604
int TabOrder=20
string DataObject="d_currentrow"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

