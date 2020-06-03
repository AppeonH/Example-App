$PBExportHeader$w_computed_reference.srw
$PBExportComments$Contains a DataWindow with computed fields that reference other computed fields.
forward
global type w_computed_reference from w_center
end type
type st_2 from statictext within w_computed_reference
end type
type st_1 from statictext within w_computed_reference
end type
type mle_help from multilineedit within w_computed_reference
end type
type cb_print_setup from commandbutton within w_computed_reference
end type
type cb_close from commandbutton within w_computed_reference
end type
type cb_print from commandbutton within w_computed_reference
end type
type dw_1 from datawindow within w_computed_reference
end type
end forward

global type w_computed_reference from w_center
int X=68
int Y=33
int Width=2792
int Height=1866
boolean TitleBar=true
string Title="Referencing Computed Fields in Other Computed Fields"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_postopen pbm_custom01
st_2 st_2
st_1 st_1
mle_help mle_help
cb_print_setup cb_print_setup
cb_close cb_close
cb_print cb_print
dw_1 dw_1
end type
global w_computed_reference w_computed_reference

on ue_postopen;dw_1.SetTransObject (sqlca)
dw_1.Retrieve()
end on

on close;w_main.Show()
end on

on open;this.postevent("ue_postopen")
end on

on w_computed_reference.create
this.st_2=create st_2
this.st_1=create st_1
this.mle_help=create mle_help
this.cb_print_setup=create cb_print_setup
this.cb_close=create cb_close
this.cb_print=create cb_print
this.dw_1=create dw_1
this.Control[]={ this.st_2,&
this.st_1,&
this.mle_help,&
this.cb_print_setup,&
this.cb_close,&
this.cb_print,&
this.dw_1}
end on

on w_computed_reference.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.mle_help)
destroy(this.cb_print_setup)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.dw_1)
end on

type st_2 from statictext within w_computed_reference
int X=1960
int Y=23
int Width=139
int Height=71
boolean Enabled=false
string Text="label."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_computed_reference
int X=1839
int Y=23
int Width=118
int Height=71
boolean Enabled=false
string Text="blue"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=74481808
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_help from multilineedit within w_computed_reference
int X=33
int Y=23
int Width=1807
int Height=68
boolean Border=false
boolean DisplayOnly=true
string Text="Computed fields that reference other computed fields are indicated with a"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_print_setup from commandbutton within w_computed_reference
int X=1113
int Y=1604
int Width=409
int Height=109
int TabOrder=40
string Text="Printer &Setup"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;if PrintSetup() = -1 then
	MessageBox ("Printer Setup Error", "An error has occured for Printer Setup", exclamation!)
end if
end on

type cb_close from commandbutton within w_computed_reference
int X=1558
int Y=1604
int Width=225
int Height=109
int TabOrder=30
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close (parent)
end on

type cb_print from commandbutton within w_computed_reference
int X=857
int Y=1604
int Width=225
int Height=109
int TabOrder=20
string Text="&Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.Print()
end on

type dw_1 from datawindow within w_computed_reference
int X=25
int Y=148
int Width=2713
int Height=1380
int TabOrder=10
string DataObject="d_dept_emp_stats"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

