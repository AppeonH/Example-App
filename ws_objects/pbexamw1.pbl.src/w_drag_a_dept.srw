$PBExportHeader$w_drag_a_dept.srw
$PBExportComments$MDI Sheet:  List of department names
forward
global type w_drag_a_dept from w_center
end type
type dw_dept from datawindow within w_drag_a_dept
end type
end forward

global type w_drag_a_dept from w_center
int X=25
int Y=17
int Width=1017
int Height=625
boolean TitleBar=true
string Title="Department Listing"
string MenuName="m_mdiframe"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
string Icon="emp.ico"
dw_dept dw_dept
end type
global w_drag_a_dept w_drag_a_dept

type variables

end variables

forward prototypes
public subroutine wf_current_dept (ref integer ai_dept, ref string as_dept_name)
end prototypes

public subroutine wf_current_dept (ref integer ai_dept, ref string as_dept_name);///////////////////////////////////////////////////////////////////////////////////////////////
// Function: wf_current_dept
// Called by: m_mdiframe
///////////////////////////////////////////////////////////////////////////////////////////////

long ll_row

// Get the currently selected row
ll_row = dw_dept.getRow( )

// Get the Department Id and Department Name
if ll_row > 0 then
	ai_dept = dw_dept.object.dept_id[ll_row]
	as_dept_name = dw_dept.object.dept_name[ll_row]
else
	ai_dept = 0
	as_dept_name = ''
end if
end subroutine

event open;call super::open;///////////////////////////////////////////////////////////////////////////////////////////////////
//Open script for w_drag_a_dept
///////////////////////////////////////////////////////////////////////////////////////////////////

dw_dept.SetTransObject(sqlca)
dw_dept.Retrieve( )

end event

on w_drag_a_dept.create
if this.MenuName = "m_mdiframe" then this.MenuID = create m_mdiframe
this.dw_dept=create dw_dept
this.Control[]={ this.dw_dept}
end on

on w_drag_a_dept.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_dept)
end on

type dw_dept from datawindow within w_drag_a_dept
int X=11
int Y=17
int Width=929
int Height=388
string DragIcon="row.ico"
string DataObject="d_dept_name"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for dw_dept
///////////////////////////////////////////////////////////////////////////////////////////////////

//Check the user clicked on a valid row
if row > 0 then
	
	// Select the Clicked row
	dw_dept.SelectRow(0, false)
	dw_dept.SelectRow(row, true)
	
	// Begin the drag
	this.drag(begin!)
end if
end event

