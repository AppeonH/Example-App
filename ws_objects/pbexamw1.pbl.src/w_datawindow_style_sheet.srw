$PBExportHeader$w_datawindow_style_sheet.srw
$PBExportComments$Frame sheet for DataWindow Style examples
forward
global type w_datawindow_style_sheet from w_center
end type
type dw_1 from datawindow within w_datawindow_style_sheet
end type
end forward

global type w_datawindow_style_sheet from w_center
int X=676
int Y=269
int Width=2393
int Height=1210
boolean TitleBar=true
string Title="Sheet"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
dw_1 dw_1
end type
global w_datawindow_style_sheet w_datawindow_style_sheet

type variables
boolean ib_share
w_datawindow_style_sheet iw_temp
end variables

on open;string ls_datawindow
int li_index


//check make sure a string was passed
//the string should contain the name of the datawindow object to be displayed
//in this window
If len(message.stringparm) <= 0 Then Return

ls_datawindow = message.stringparm

//set the datawindow object to the string that was passed
dw_1.dataobject=ls_datawindow

//parse out the last name in the datawindow object name
//ex: ?_?_window name
li_index = 1
li_index = pos(ls_datawindow,"_",li_index)
li_index = pos(ls_datawindow,"_",li_index+1)

this.title = upper(Mid(ls_datawindow,li_index+1))



end on

on resize;dw_1.width = workspacewidth() - 14
dw_1.height = workspaceheight() - 14
end on

on w_datawindow_style_sheet.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_datawindow_style_sheet.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_datawindow_style_sheet
int X=11
int Y=13
int Width=2312
int Height=1057
int TabOrder=1
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

