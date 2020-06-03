$PBExportHeader$w_clock_using_dw.srw
$PBExportComments$Digital Clock using datawindow computed field, now & today functions and datawindow timer.
forward
global type w_clock_using_dw from w_center
end type
type dw_1 from datawindow within w_clock_using_dw
end type
end forward

global type w_clock_using_dw from w_center
int X=996
int Y=839
int Width=929
int Height=244
boolean TitleBar=true
string Title="Digital Clock"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
dw_1 dw_1
end type
global w_clock_using_dw w_clock_using_dw

on close;// Close script for w_clock_using_dw

close (this)
w_main.Show( )
end on

on w_clock_using_dw.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_clock_using_dw.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_clock_using_dw
int X=114
int Y=23
int Width=651
int Height=97
int TabOrder=1
string DataObject="d_clock"
boolean Border=false
end type

