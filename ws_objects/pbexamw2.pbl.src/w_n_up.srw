$PBExportHeader$w_n_up.srw
$PBExportComments$Window that shows a DataWindow with 2 rows up per row displayed.
forward
global type w_n_up from w_center
end type
type cb_1 from commandbutton within w_n_up
end type
type cb_close from commandbutton within w_n_up
end type
type dw_my_n-up from datawindow within w_n_up
end type
end forward

global type w_n_up from w_center
int X=146
int Y=321
int Width=2827
int Height=1895
boolean TitleBar=true
string Title="N-Up Datawindow"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
event ue_postopen pbm_custom01
cb_1 cb_1
cb_close cb_close
dw_my_n-up dw_my_n-up
end type
global w_n_up w_n_up

on ue_postopen;dw_my_n-up.settransobject(sqlca)
dw_my_n-up.retrieve()
end on

on open;this.postevent("ue_postopen")
end on

on close;w_main.Show()
end on

on w_n_up.create
this.cb_1=create cb_1
this.cb_close=create cb_close
this.dw_my_n-up=create dw_my_n-up
this.Control[]={ this.cb_1,&
this.cb_close,&
this.dw_my_n-up}
end on

on w_n_up.destroy
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.dw_my_n-up)
end on

type cb_1 from commandbutton within w_n_up
int X=1003
int Y=1645
int Width=360
int Height=97
int TabOrder=30
string Text="&Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// use the standard datawindow print command
	dw_my_n-up.print()
end on

type cb_close from commandbutton within w_n_up
int X=1441
int Y=1645
int Width=360
int Height=97
int TabOrder=20
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
	close(parent)
end on

type dw_my_n-up from datawindow within w_n_up
int X=40
int Y=39
int Width=2678
int Height=1569
int TabOrder=10
string DataObject="d_n_up"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

