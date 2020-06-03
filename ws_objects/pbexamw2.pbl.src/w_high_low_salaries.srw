$PBExportHeader$w_high_low_salaries.srw
$PBExportComments$Shows a bitmap indicator in DataWindow conditional on value of salary
forward
global type w_high_low_salaries from w_center
end type
type dw_employee_compensation from datawindow within w_high_low_salaries
end type
type cb_close from commandbutton within w_high_low_salaries
end type
end forward

global type w_high_low_salaries from w_center
int X=360
int Y=301
int Width=1999
int Height=1261
boolean TitleBar=true
string Title="Conditional Bitmaps"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
dw_employee_compensation dw_employee_compensation
cb_close cb_close
end type
global w_high_low_salaries w_high_low_salaries

on open;//Open script for w_high_low_salaries

dw_employee_compensation.SetTransObject(sqlca)
dw_employee_compensation.Retrieve( )
end on

on w_high_low_salaries.create
this.dw_employee_compensation=create dw_employee_compensation
this.cb_close=create cb_close
this.Control[]={ this.dw_employee_compensation,&
this.cb_close}
end on

on w_high_low_salaries.destroy
destroy(this.dw_employee_compensation)
destroy(this.cb_close)
end on

on close;//Close script for w_high_low_salaries

this.Hide( )
w_main.Show( )
end on

type dw_employee_compensation from datawindow within w_high_low_salaries
int X=72
int Y=81
int Width=1782
int Height=868
int TabOrder=10
string DataObject="d_employee_salary"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

type cb_close from commandbutton within w_high_low_salaries
int X=825
int Y=1009
int Width=274
int Height=87
int TabOrder=30
string Text="&Close"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_close

Close(parent)
end on

