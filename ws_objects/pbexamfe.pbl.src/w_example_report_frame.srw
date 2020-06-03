$PBExportHeader$w_example_report_frame.srw
$PBExportComments$Frame window for Examples Report
forward
global type w_example_report_frame from w_center
end type
type mdi_1 from mdiclient within w_example_report_frame
end type
end forward

global type w_example_report_frame from w_center
integer x = 5
integer y = 4
integer width = 2034
integer height = 1276
string title = "Examples Report"
string menuname = ""
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 273241183
integer toolbarx = 1
integer toolbary = 1
integer toolbarwidth = 1
integer toolbarheight = 1
event ue_postopen ( )
mdi_1 mdi_1
end type
global w_example_report_frame w_example_report_frame

type variables
u_report_structure  iuo_Parms
end variables

event ue_postopen;OpenSheetWithParm(w_example_report_sheet, iuo_Parms, This, 1, Layered!)
end event

on w_example_report_frame.create
int iCurrent
call super::create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.mdi_1=create mdi_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mdi_1
end on

event open;call super::open;iuo_Parms = Message.PowerObjectParm
Post Event ue_postopen()
end event

event close;Show(w_main)
end event

on w_example_report_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_example_report_frame
long BackColor=273241183
end type

