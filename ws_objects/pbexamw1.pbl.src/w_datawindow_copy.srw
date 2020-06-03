$PBExportHeader$w_datawindow_copy.srw
$PBExportComments$Window used in the Copy DataWindow Example using ImportString()
forward
global type w_datawindow_copy from w_center
end type
type st_2 from statictext within w_datawindow_copy
end type
type st_1 from statictext within w_datawindow_copy
end type
type cb_2 from commandbutton within w_datawindow_copy
end type
type cb_1 from commandbutton within w_datawindow_copy
end type
type cb_copy from commandbutton within w_datawindow_copy
end type
type cb_undo from commandbutton within w_datawindow_copy
end type
type dw_copy from datawindow within w_datawindow_copy
end type
type dw_cust from datawindow within w_datawindow_copy
end type
end forward

global type w_datawindow_copy from w_center
int X=164
int Y=93
int Width=2607
int Height=1754
boolean TitleBar=true
string Title="DataWindows-ImportString() & RowsCopy()"
long BackColor=74481808
boolean ControlMenu=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_postopen pbm_custom01
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
cb_copy cb_copy
cb_undo cb_undo
dw_copy dw_copy
dw_cust dw_cust
end type
global w_datawindow_copy w_datawindow_copy

type variables
string is_dwcopy
end variables

event ue_postopen;
//set transaction object up for the datawindow and retrieve
dw_cust.settransobjecT(sqlca)
dw_cust.retrieve()


//This will store the data portion of the datawindow in a string called is_dwcopy
is_dwcopy = dw_cust.Object.DataWindow.data

end event

on open;//do the work in the custom post open event
this.postevent("ue_postopen")
end on

on w_datawindow_copy.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_copy=create cb_copy
this.cb_undo=create cb_undo
this.dw_copy=create dw_copy
this.dw_cust=create dw_cust
this.Control[]={ this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.cb_copy,&
this.cb_undo,&
this.dw_copy,&
this.dw_cust}
end on

on w_datawindow_copy.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_copy)
destroy(this.cb_undo)
destroy(this.dw_copy)
destroy(this.dw_cust)
end on

on close;show(w_main)
end on

type st_2 from statictext within w_datawindow_copy
int X=619
int Y=820
int Width=484
int Height=71
boolean Enabled=false
string Text="Using RowsCopy()"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_datawindow_copy
int X=619
int Y=93
int Width=534
int Height=71
boolean Enabled=false
string Text="Using ImportString()"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_datawindow_copy
int X=1401
int Y=1501
int Width=313
int Height=109
int TabOrder=50
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help(parent.classname())
end on

type cb_1 from commandbutton within w_datawindow_copy
int X=882
int Y=1501
int Width=313
int Height=109
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type cb_copy from commandbutton within w_datawindow_copy
int X=43
int Y=785
int Width=523
int Height=109
int TabOrder=30
string Text="Copy DataWindow"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_dwcopy, ls_type, ls_name
datawindowchild ldw_child
string ls_count
int li_count, li_index, li_rc

//accept text on datawindow about to be copied
dw_cust.accepttext()

//clear out the destination
dw_copy.reset()

//This section is not needed if the destination does not contain child datawindows.
ls_count = dw_copy.Object.DataWindow.column.count
li_count = integer (ls_count)

For li_index = 1 to li_count
	ls_type = dw_copy.describe("#" + string(li_index) + ".edit.style")
	If ls_type = "dddw" Then
		ls_name = dw_copy.describe("#" + string(li_index) + ".name")
         	li_rc = dw_copy.GetChild(ls_name , ldw_child)
		If li_rc = -1 Then 
			MessageBox("Error on DWC Retreive",String(li_rc))
		Else
			ldw_child.settransobject(sqlca)
			ldw_child.retrieve()
		End If
	End If
Next
//***********************************************************************************

//put the data portion of source datawindow into a string

dw_cust.RowsCopy(1,dw_cust.rowcount(),Primary!,dw_copy,1,Primary!)



end event

type cb_undo from commandbutton within w_datawindow_copy
int X=43
int Y=65
int Width=523
int Height=109
int TabOrder=20
string Text="Undo All Changes"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//This will clear of data contents of the datawindow and 
//refill the data using the importstring() function. The data is stored in the instance
//string is_dwcopy which was loaded in the postopen event of the window.
dw_cust.reset()
dw_cust.importstring(is_dwcopy)

end on

type dw_copy from datawindow within w_datawindow_copy
int X=43
int Y=913
int Width=2472
int Height=519
int TabOrder=60
string DataObject="d_cust"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_cust from datawindow within w_datawindow_copy
int X=43
int Y=193
int Width=2472
int Height=519
int TabOrder=10
string DataObject="d_cust"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

