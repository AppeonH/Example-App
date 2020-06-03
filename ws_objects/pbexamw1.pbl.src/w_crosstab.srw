$PBExportHeader$w_crosstab.srw
$PBExportComments$Enhanced crosstab tab window.
forward
global type w_crosstab from w_center
end type
type st_2 from statictext within w_crosstab
end type
type st_status from statictext within w_crosstab
end type
type cb_change from commandbutton within w_crosstab
end type
type cb_help from commandbutton within w_crosstab
end type
type cb_print from commandbutton within w_crosstab
end type
type cb_close from commandbutton within w_crosstab
end type
type dw_1 from datawindow within w_crosstab
end type
end forward

global type w_crosstab from w_center
int X=86
int Y=39
int Width=2788
int Height=1873
boolean TitleBar=true
string Title="Enhanced Crosstab Reports"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
event ue_postopen pbm_custom01
st_2 st_2
st_status st_status
cb_change cb_change
cb_help cb_help
cb_print cb_print
cb_close cb_close
dw_1 dw_1
end type
global w_crosstab w_crosstab

forward prototypes
public subroutine wf_change_xtab (ref datawindow adw_datawindow)
end prototypes

event ue_postopen;///////////////////////////////////////////////////////////////////////////////////////////////////
//Ue_postopen for w_crosstab
///////////////////////////////////////////////////////////////////////////////////////////////////

//set the transaction object
dw_1.settransobject(sqlca)

//retrieve the data
dw_1.setredraw(false)
dw_1.retrieve()
st_status.text = " Ready"
dw_1.setredraw(true)
end event

public subroutine wf_change_xtab (ref datawindow adw_datawindow);// This function will dynamically change a crosstab to have a 
// more formatted appearance.

int li_column_count
int li_counter
int li_cur, li_next
string	ls_split
string 	ls_rc, ls_object, ls_return, ls_modstring
string 	ls_temp
string	ls_colname

//returns a list of all of the objects on the datawindow
ls_rc = adw_datawindow.Object.datawindow.objects

li_cur = 1
li_next = pos(ls_rc,'~t')

do until li_next = 0
	ls_object = mid(ls_rc,li_cur, li_next - li_cur)

//center text in the heading	
	If Lower(Left(adw_datawindow.describe(ls_object + ".Band"),6)) = "header"  Then
		ls_modstring = ls_modstring + ls_object + ".Alignment=2 " + &
			ls_object + ".Font.Weight=700 "
	End If

//format detail and total columns differently
	If adw_datawindow.describe(ls_object + ".Type") = "compute"  Then
		ls_temp = adw_datawindow.describe(ls_object + ".Expression")
		If pos(ls_temp,"sum") > 0 Then
			ls_modstring = ls_modstring + ls_object + ".Format='$#,##0' " 
		ElseIf pos(ls_temp,"count") > 0 Then 
			ls_modstring = ls_modstring + ls_object + ".Format='#,##0' " 
		End If
	ElseIf adw_datawindow.describe(ls_object + ".Type") = "column"  Then
		ls_temp = adw_datawindow.describe(ls_object + ".Coltype")
		If pos(ls_temp,"dec") > 0 Then
			ls_modstring = ls_modstring + ls_object + ".Format='$#,##0.00' " 
		ElseIf pos(ls_temp,"num") > 0 Then 
			ls_modstring = ls_modstring + ls_object + ".Format='#,##0.00' " 
		End If
	End If


//loop throgh all the objects on the datawindow
	li_cur = li_next + 1
	li_next = pos(ls_rc,'~t',li_cur)
loop
int li_min, li_x, li_rightside

////find where the crosstab 1st columns stops add a horizontal split bar
//	ls_temp = adw_datawindow.describe("datawindow.crosstab.rows")
//	li_cur = 1
//	li_next = pos(ls_temp,",")
//	li_min = -999
//	//go down through the columns, find the one with the right most ending.
//	do while li_next > 0
//		ls_colname = mid(ls_temp,li_cur,li_next - li_cur)
//		li_x = Integer(adw_datawindow.describe(ls_colname + ".X"))
//		li_rightside = li_x + Integer(adw_datawindow.describe(ls_colname + ".Width"))
//		If li_min < li_rightside Then 
//			ls_split = string (li_rightside)
//			li_min = li_rightside
//
//messagebox(" in loop max is",ls_split)
//		End If
//		li_cur = li_next + 1
//		li_next = pos(ls_temp,",",li_cur)
//	loop
//	
//	
//messagebox("out loop max is ",ls_split)
//
//	ls_modstring = ls_modstring + " Datawindow.HorizontalScrollSplit=" + ls_split
//	ls_modstring = ls_modstring + " Datawindow.HorizontalScrollPosition2=" + ls_split

	ls_return = adw_datawindow.Modify(ls_modstring)
	If ls_return <> "" Then messagebox("Display Change Err" + ls_return, ls_modstring)
	



end subroutine

event resize;///////////////////////////////////////////////////////////////////////////////////////////////////
//Resize script for w_crosstab
///////////////////////////////////////////////////////////////////////////////////////////////////
dw_1.width = workspacewidth() - 14


end event

event open;call super::open;///////////////////////////////////////////////////////////////////////////////////////////////////
//Open script for w_crosstab
///////////////////////////////////////////////////////////////////////////////////////////////////
this.postevent("ue_postopen")
end event

event close;///////////////////////////////////////////////////////////////////////////////////////////////////
//Close script for w_crosstab
///////////////////////////////////////////////////////////////////////////////////////////////////

w_main.Show( )

end event

on w_crosstab.create
this.st_2=create st_2
this.st_status=create st_status
this.cb_change=create cb_change
this.cb_help=create cb_help
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={ this.st_2,&
this.st_status,&
this.cb_change,&
this.cb_help,&
this.cb_print,&
this.cb_close,&
this.dw_1}
end on

on w_crosstab.destroy
destroy(this.st_2)
destroy(this.st_status)
destroy(this.cb_change)
destroy(this.cb_help)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type st_2 from statictext within w_crosstab
int X=54
int Y=17
int Width=246
int Height=71
boolean Enabled=false
string Text="Status:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_status from statictext within w_crosstab
int X=310
int Y=17
int Width=1057
int Height=68
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text=" Ready"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_change from commandbutton within w_crosstab
int X=630
int Y=1569
int Width=545
int Height=100
int TabOrder=50
string Text="Change Cross&tab"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_change
///////////////////////////////////////////////////////////////////////////////////////////////////

//bring up the standard dialog to dynamically change crosstab definition
dw_1.setredraw(false)
dw_1.crosstabdialog( )
wf_change_xtab(dw_1)
st_status.text = " Ready"
dw_1.setredraw(true)
end event

type cb_help from commandbutton within w_crosstab
int X=1988
int Y=1569
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

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_help
///////////////////////////////////////////////////////////////////////////////////////////////////

f_open_help(parent.ClassName( ))
end event

type cb_print from commandbutton within w_crosstab
int X=1266
int Y=1569
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

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_print
///////////////////////////////////////////////////////////////////////////////////////////////////

//print datawindow
dw_1.print() 
end event

type cb_close from commandbutton within w_crosstab
int X=1625
int Y=1569
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

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_close
///////////////////////////////////////////////////////////////////////////////////////////////////

Close(parent)
end event

type dw_1 from datawindow within w_crosstab
event ue_messagetext pbm_dwnmessagetext
int X=8
int Y=106
int Width=2696
int Height=1415
int TabOrder=10
string DataObject="d_crosstab"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean HSplitScroll=true
boolean LiveScroll=true
end type

event ue_messagetext;///////////////////////////////////////////////////////////////////////////////////////////////////
// ue_MessageText script for dw_1
///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
//This event occurs each time the datawindow has a message to 
//display on status
///////////////////////////////////////////////////////////////////////////////////////////////////

setpointer(hourglass!)

st_status.text = " " + text

end event

event retrievestart;///////////////////////////////////////////////////////////////////////////////////////////////////
// RetrieveStart script for dw_1
///////////////////////////////////////////////////////////////////////////////////////////////////

setpointer(hourglass!)

//Disable buttons
cb_help.enabled = false
cb_close.enabled = false
cb_print.enabled = false
cb_change.enabled = false

//Display on-window status
st_status.text = " Retrieving Data..."

end event

event retrieveend;///////////////////////////////////////////////////////////////////////////////////////////////////
// RetrieveEnd script for dw_1
///////////////////////////////////////////////////////////////////////////////////////////////////

//Enable buttons
cb_help.enabled = true
cb_close.enabled = true
cb_print.enabled = true
cb_change.enabled = true
end event

