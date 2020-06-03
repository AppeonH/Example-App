$PBExportHeader$w_newspaper_slide_columns.srw
$PBExportComments$Newspaper / Sliding columns examples
forward
global type w_newspaper_slide_columns from w_center
end type
type cb_help from commandbutton within w_newspaper_slide_columns
end type
type cb_print from commandbutton within w_newspaper_slide_columns
end type
type cb_close from commandbutton within w_newspaper_slide_columns
end type
type dw_1 from datawindow within w_newspaper_slide_columns
end type
end forward

global type w_newspaper_slide_columns from w_center
int X=82
int Y=132
int Width=2774
int Height=1668
boolean TitleBar=true
string Title="Snake and Sliding Columns"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_postopen pbm_custom01
cb_help cb_help
cb_print cb_print
cb_close cb_close
dw_1 dw_1
end type
global w_newspaper_slide_columns w_newspaper_slide_columns

event ue_postopen;////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_postopen script for w_newspaper_slide_columns
////////////////////////////////////////////////////////////////////////////////////////////////////////

// Set Print Preview on and at 70%
dw_1.Object.Datawindow.Print.Preview = 'yes' 
dw_1.Object.Datawindow.Print.Preview.Zoom= '70'

//Retrive data
dw_1.settransobject(sqlca)
dw_1.retrieve()


end event

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_newspaper_slide_columns
////////////////////////////////////////////////////////////////////////////////////////////////////////

this.postevent("ue_postopen")
end event

event close;////////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_newspaper_slide_columns
////////////////////////////////////////////////////////////////////////////////////////////////////////

// Show the Front End Window
w_main.Show( )

end event

on w_newspaper_slide_columns.create
this.cb_help=create cb_help
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={ this.cb_help,&
this.cb_print,&
this.cb_close,&
this.dw_1}
end on

on w_newspaper_slide_columns.destroy
destroy(this.cb_help)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type cb_help from commandbutton within w_newspaper_slide_columns
int X=1533
int Y=1399
int Width=278
int Height=100
int TabOrder=40
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_help
////////////////////////////////////////////////////////////////////////////////////////////////////////

//Call the help window
f_open_help(parent.ClassName( ))
end event

type cb_print from commandbutton within w_newspaper_slide_columns
int X=811
int Y=1399
int Width=278
int Height=100
int TabOrder=30
string Text="&Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_print
////////////////////////////////////////////////////////////////////////////////////////////////////////

//print the datawindow
dw_1.print() 
end event

type cb_close from commandbutton within w_newspaper_slide_columns
int X=1174
int Y=1399
int Width=278
int Height=100
int TabOrder=20
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

//Close the window
Close(parent)
end event

type dw_1 from datawindow within w_newspaper_slide_columns
int X=11
int Y=13
int Width=2696
int Height=1341
int TabOrder=10
string DataObject="d_snake_slide_columns"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

