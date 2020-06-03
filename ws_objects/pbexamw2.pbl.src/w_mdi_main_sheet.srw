$PBExportHeader$w_mdi_main_sheet.srw
$PBExportComments$MDI frame
forward
global type w_mdi_main_sheet from w_center
end type
type dw_1 from datawindow within w_mdi_main_sheet
end type
end forward

global type w_mdi_main_sheet from w_center
int X=676
int Y=269
int Width=1586
int Height=1066
boolean TitleBar=true
string MenuName="m_mdiframe_sheet"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
dw_1 dw_1
end type
global w_mdi_main_sheet w_mdi_main_sheet

type variables
string is_title
end variables

forward prototypes
public subroutine wf_retrieve_data (integer dept, string dept_name)
end prototypes

public subroutine wf_retrieve_data (integer dept, string dept_name);/////////////////////////////////////////////////////////////////////////////////////////
// Function: wf_retrieve_data
/////////////////////////////////////////////////////////////////////////////////////////

integer ll_ret

this.title = is_title +dept_name

ll_ret = dw_1.Retrieve(dept)
if ll_ret < 1 then
	MessageBox("Sorry!", "No employees for Department " + String(dept) + " found!", &
					 Information!, OK!)
end if



end subroutine

event open;call super::open;/////////////////////////////////////////////////////////////////////////////////////////
//Open script for w_mdi_main_sheet
/////////////////////////////////////////////////////////////////////////////////////////

// Get the structure 
mdi_main_structure parm
parm = message.powerobjectparm

// Assign the appropriate window title
is_title = parm.title

// Assign the appropriate datawindow object
dw_1.dataobject = parm.datawindow_name

// Retrive the datawindow
dw_1.settransobject(sqlca)
if parm.dept <> 0 then wf_retrieve_data(parm.dept,parm.dept_name)

end event

event resize;/////////////////////////////////////////////////////////////////////////////////////////
//Resize script for w_mdi_main_sheet
/////////////////////////////////////////////////////////////////////////////////////////

// Resize the data window to fit neatly, however the window is sized
dw_1.Resize(this.WorkSpaceWidth( ) - 25, this.WorkSpaceHeight( ) - 25)
end event

on w_mdi_main_sheet.create
if this.MenuName = "m_mdiframe_sheet" then this.MenuID = create m_mdiframe_sheet
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_mdi_main_sheet.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_mdi_main_sheet
int Y=4
int Width=996
int Height=599
int TabOrder=1
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dragdrop;/////////////////////////////////////////////////////////////////////////////////////////
// DragDrop script for dw_1
/////////////////////////////////////////////////////////////////////////////////////////

DragObject	ldo_which_control
int li_dept, li_row
string ls_dept_name
datawindow ldw

ldo_which_control = DraggedObject()
if TypeOf(ldo_which_control) = Datawindow! then // did a datawindow get dropped on me?
	ldw = ldo_which_control
//	if dw.dataobject = 'd_dept_name'  then // is it one I know how to work with?
		li_row = ldw.getrow()
		if row > 0 then // does it have rows in it?
			li_dept = ldw.object.dept_id[li_row]
			ls_dept_name = ldw.object.dept_name[li_row]
			wf_retrieve_data(li_dept,ls_dept_name)
		end if
//	end if
end if
end event

