$PBExportHeader$w_mode_median.srw
$PBExportComments$Sets up a datawindow that contains aggregate functions of mode and median.
forward
global type w_mode_median from w_center
end type
type cb_print from commandbutton within w_mode_median
end type
type cb_close from commandbutton within w_mode_median
end type
type dw_1 from datawindow within w_mode_median
end type
end forward

global type w_mode_median from w_center
int X=171
int Y=132
int Width=2575
int Height=1661
boolean TitleBar=true
string Title="Mode & Median Functions Example"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_print cb_print
cb_close cb_close
dw_1 dw_1
end type
global w_mode_median w_mode_median

on open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end on

on close;//Close script 


w_main.Show( )

end on

on w_mode_median.create
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={ this.cb_print,&
this.cb_close,&
this.dw_1}
end on

on w_mode_median.destroy
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type cb_print from commandbutton within w_mode_median
int X=939
int Y=1393
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

on clicked;//print datawindow
dw_1.print() 
end on

type cb_close from commandbutton within w_mode_median
int X=1298
int Y=1393
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

on clicked;Close(parent)
end on

type dw_1 from datawindow within w_mode_median
int X=4
int Width=2529
int Height=1341
int TabOrder=10
string DataObject="d_mode_median"
boolean VScrollBar=true
boolean LiveScroll=true
end type

