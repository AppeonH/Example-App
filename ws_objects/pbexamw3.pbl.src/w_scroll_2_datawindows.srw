$PBExportHeader$w_scroll_2_datawindows.srw
$PBExportComments$Simultaneous scrolling of 2 DWs
forward
global type w_scroll_2_datawindows from w_center
end type
type cb_close from commandbutton within w_scroll_2_datawindows
end type
type dw_data from datawindow within w_scroll_2_datawindows
end type
type dw_names from datawindow within w_scroll_2_datawindows
end type
type st_2 from statictext within w_scroll_2_datawindows
end type
type st_1 from statictext within w_scroll_2_datawindows
end type
end forward

global type w_scroll_2_datawindows from w_center
int X=8
int Y=276
int Width=2948
int Height=1405
boolean TitleBar=true
string Title="Synchronized Vertical Scrolling of Two DataWindows"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
boolean ToolBarVisible=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_postopen pbm_custom01
cb_close cb_close
dw_data dw_data
dw_names dw_names
st_2 st_2
st_1 st_1
end type
global w_scroll_2_datawindows w_scroll_2_datawindows

event ue_postopen;////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_postopen script for w_scroll_2_datawindow
////////////////////////////////////////////////////////////////////////////////////////////////////////

//retrieve data into the 2 datawindows
SetTransObject (dw_names, sqlca)
SetTransObject (dw_data, sqlca)

Retrieve (dw_names)
Retrieve (dw_data)
end event

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////////////////////
// Open script for w_scroll_2_datawindow
////////////////////////////////////////////////////////////////////////////////////////////////////////

this.postevent("ue_postopen")
end event

on w_scroll_2_datawindows.create
this.cb_close=create cb_close
this.dw_data=create dw_data
this.dw_names=create dw_names
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={ this.cb_close,&
this.dw_data,&
this.dw_names,&
this.st_2,&
this.st_1}
end on

on w_scroll_2_datawindows.destroy
destroy(this.cb_close)
destroy(this.dw_data)
destroy(this.dw_names)
destroy(this.st_2)
destroy(this.st_1)
end on

event close;////////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_scroll_2_datawindow
////////////////////////////////////////////////////////////////////////////////////////////////////////

Hide (this)
Show (w_main)
end event

type cb_close from commandbutton within w_scroll_2_datawindows
int X=1355
int Y=1124
int Width=281
int Height=97
int TabOrder=10
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_close
////////////////////////////////////////////////////////////////////////////////////////////////////////

Close (Parent)
end event

type dw_data from datawindow within w_scroll_2_datawindows
int X=626
int Y=247
int Width=2166
int Height=817
int TabOrder=30
string DataObject="d_employee_data_list"
boolean HScrollBar=true
boolean VScrollBar=true
end type

event scrollvertical;////////////////////////////////////////////////////////////////////////////////////////////////////////
// scrollvertical script for dw_data
////////////////////////////////////////////////////////////////////////////////////////////////////////

//Syncronize the names datawindow to match the scroll position from this datawindow.
dw_names.Object.datawindow.verticalscrollposition = scrollpos


end event

type dw_names from datawindow within w_scroll_2_datawindows
int X=75
int Y=247
int Width=548
int Height=817
int TabOrder=20
string DataObject="d_employee_name_list"
boolean HScrollBar=true
end type

type st_2 from statictext within w_scroll_2_datawindows
int X=36
int Y=68
int Width=2233
int Height=71
boolean Enabled=false
string Text="Use Vertical Scroll Bar to view different employees."
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_scroll_2_datawindows
int X=36
int Y=7
int Width=2233
int Height=71
boolean Enabled=false
string Text="Use Horizontal Scroll Bar to view more data for the employees displayed."
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

