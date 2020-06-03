$PBExportHeader$w_other_category.srw
$PBExportComments$Example showing how to create an "other" category on a graph
forward
global type w_other_category from w_center
end type
type cb_close from commandbutton within w_other_category
end type
type cb_help from commandbutton within w_other_category
end type
type dw_1 from datawindow within w_other_category
end type
end forward

global type w_other_category from w_center
int X=215
int Y=189
int Width=2487
int Height=1541
boolean TitleBar=true
string Title="~"Other~" Category"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_close cb_close
cb_help cb_help
dw_1 dw_1
end type
global w_other_category w_other_category

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end event

on w_other_category.create
this.cb_close=create cb_close
this.cb_help=create cb_help
this.dw_1=create dw_1
this.Control[]={ this.cb_close,&
this.cb_help,&
this.dw_1}
end on

on w_other_category.destroy
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.dw_1)
end on

event close;Show(w_main)

end event

type cb_close from commandbutton within w_other_category
int X=2167
int Y=181
int Width=247
int Height=85
int TabOrder=20
string Text="Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_help from commandbutton within w_other_category
int X=2167
int Y=37
int Width=247
int Height=85
int TabOrder=10
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_other_category")

end event

type dw_1 from datawindow within w_other_category
int X=33
int Y=37
int Width=2076
int Height=1377
string DataObject="d_other_category"
BorderStyle BorderStyle=StyleShadowBox!
boolean LiveScroll=true
end type

