$PBExportHeader$w_example_report_sheet.srw
$PBExportComments$Used for Example Report
forward
global type w_example_report_sheet from w_center
end type
type dw_report from datawindow within w_example_report_sheet
end type
end forward

global type w_example_report_sheet from w_center
int X=4
int Y=17
int Width=2226
int Height=1396
boolean TitleBar=true
string MenuName="m_report"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
int ToolBarX=1
int ToolBarY=1
int ToolBarWidth=1
int ToolBarHeight=1
event ue_postopen ( )
event ue_scroll ( integer ai_scroll )
event ue_print ( )
event ue_zoom ( integer ai_zoom )
dw_report dw_report
end type
global w_example_report_sheet w_example_report_sheet

type variables
u_report_structure  iuo_Parm
Integer  ii_CurrentZoom = 75
Constant Integer iZOOMINCREMENT = 5
end variables

event ue_postopen;SetPointer(hourglass!)

dw_report.Retrieve(iuo_Parm.is_Application, iuo_Parm.is_Object)
end event

event ue_scroll;If ai_Scroll = -1 Then
	dw_report.ScrollPriorPage()
ElseIf ai_Scroll = 1 Then
	dw_report.ScrollNextPage()
Else
	dw_report.ScrollToRow(ai_Scroll)
End if
end event

event ue_print;OpenWithParm(w_dw_print_options, dw_report)

If Message.DoubleParm = -1 Then Return
dw_report.Print(True)
end event

event ue_zoom;Integer	li_Zoom

li_Zoom = ai_zoom * iZOOMINCREMENT

If li_Zoom = 0 Then
	OpenWithParm(w_zoom, ii_CurrentZoom)
	If Message.DoubleParm > 0 Then
		ii_CurrentZoom = Message.DoubleParm
	End if
	
Else
	ii_CurrentZoom = ii_CurrentZoom + li_Zoom
End If

If ii_CurrentZoom < 10 Then ii_CurrentZoom = 10

dw_report.modify('datawindow.print.preview.zoom = ' + String(ii_CurrentZoom))
This.title = "Detail Report For " + Trim(iuo_Parm.is_Title) + " Example (Zoom: " + String(ii_CurrentZoom) + "%)"
end event

event open;call super::open;iuo_Parm = Message.PowerObjectParm

If Not IsValid(iuo_Parm) Then
	Beep(1)

Else
	dw_report.SetTransObject(sqlca)
	dw_report.Modify("DataWindow.Print.Preview=Yes")
	dw_report.Modify("datawindow.print.preview.zoom = " + String(ii_CurrentZoom))
	This.title = "Detail Report For " + trim(iuo_parm.is_Title) + " Example (Zoom: " + String(ii_CurrentZoom) + "%)"
	Post Event ue_postopen()
End If
end event

on w_example_report_sheet.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_report)
end on

event resize;dw_report.width = newwidth - dw_report.x
dw_report.height = newheight - dw_report.y
end event

on w_example_report_sheet.create
if this.MenuName = "m_report" then this.MenuID = create m_report
this.dw_report=create dw_report
this.Control[]={ this.dw_report}
end on

event close;Close(w_example_report_frame)
end event

type dw_report from datawindow within w_example_report_sheet
int X=4
int Y=4
int Width=2031
int Height=1162
int TabOrder=20
string DataObject="d_example_report_main"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

