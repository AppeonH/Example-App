$PBExportHeader$w_print_employee_roster_dw.srw
$PBExportComments$Prints the employee roster with control breaks by department; Uses DataWindow Production Reporting and the DataWindow Print function.
forward
global type w_print_employee_roster_dw from w_center
end type
type cb_saveas from commandbutton within w_print_employee_roster_dw
end type
type cb_close from commandbutton within w_print_employee_roster_dw
end type
type st_please_wait from statictext within w_print_employee_roster_dw
end type
type cb_pr_setup from commandbutton within w_print_employee_roster_dw
end type
type cb_print from commandbutton within w_print_employee_roster_dw
end type
type cb_retrieve from commandbutton within w_print_employee_roster_dw
end type
type dw_employee_roster from datawindow within w_print_employee_roster_dw
end type
end forward

global type w_print_employee_roster_dw from w_center
int X=196
int Y=301
int Width=2905
int Height=1975
boolean TitleBar=true
string Title="Grouping & Computed Columns Example"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
event ue_postopen pbm_custom01
cb_saveas cb_saveas
cb_close cb_close
st_please_wait st_please_wait
cb_pr_setup cb_pr_setup
cb_print cb_print
cb_retrieve cb_retrieve
dw_employee_roster dw_employee_roster
end type
global w_print_employee_roster_dw w_print_employee_roster_dw

on ue_postopen;dw_employee_roster.SetTransObject(sqlca)
cb_retrieve.triggerevent("clicked")
end on

on open;//Open script for w_print_employee_roster_dw

this.postevent("ue_postopen")
end on

on w_print_employee_roster_dw.create
this.cb_saveas=create cb_saveas
this.cb_close=create cb_close
this.st_please_wait=create st_please_wait
this.cb_pr_setup=create cb_pr_setup
this.cb_print=create cb_print
this.cb_retrieve=create cb_retrieve
this.dw_employee_roster=create dw_employee_roster
this.Control[]={ this.cb_saveas,&
this.cb_close,&
this.st_please_wait,&
this.cb_pr_setup,&
this.cb_print,&
this.cb_retrieve,&
this.dw_employee_roster}
end on

on w_print_employee_roster_dw.destroy
destroy(this.cb_saveas)
destroy(this.cb_close)
destroy(this.st_please_wait)
destroy(this.cb_pr_setup)
destroy(this.cb_print)
destroy(this.cb_retrieve)
destroy(this.dw_employee_roster)
end on

on close;//Close script for w_print_employee_roster_dw

this.Hide( )
w_main.Show( )
end on

type cb_saveas from commandbutton within w_print_employee_roster_dw
int X=1569
int Y=1652
int Width=406
int Height=100
int TabOrder=50
string Text="&Save As..."
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_employee_roster.SaveAs()
end on

type cb_close from commandbutton within w_print_employee_roster_dw
int X=2017
int Y=1652
int Width=242
int Height=100
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_close

Close(parent)
end on

type st_please_wait from statictext within w_print_employee_roster_dw
int X=2379
int Y=1652
int Width=363
int Height=113
boolean Visible=false
string Text="Printing, please wait..."
Alignment Alignment=Center!
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="Helv"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_pr_setup from commandbutton within w_print_employee_roster_dw
int X=1046
int Y=1652
int Width=481
int Height=100
int TabOrder=60
string Text="Printer &Setup..."
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_pr_setup

if PrintSetup( ) = -1 then
	MessageBox("Error!","PrintSetup Failed")
end if
end on

type cb_print from commandbutton within w_print_employee_roster_dw
int X=619
int Y=1652
int Width=406
int Height=100
int TabOrder=30
string Text="&Print Report"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_print

//notice to user
st_please_wait.Show( )

//print datawindow object contents
dw_employee_roster.Print( )

//clear notice
st_please_wait.Hide( )
end on

type cb_retrieve from commandbutton within w_print_employee_roster_dw
int X=267
int Y=1652
int Width=310
int Height=100
int TabOrder=20
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_retrieve


//load datawindow
dw_employee_roster.Retrieve( )

end on

type dw_employee_roster from datawindow within w_print_employee_roster_dw
int X=57
int Y=20
int Width=2536
int Height=1591
int TabOrder=10
string DataObject="d_print_employee_roster_dw"
boolean VScrollBar=true
end type

