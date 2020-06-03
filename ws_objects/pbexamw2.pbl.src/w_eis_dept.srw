$PBExportHeader$w_eis_dept.srw
$PBExportComments$Lists departments for employee information system
forward
global type w_eis_dept from w_center
end type
type cb_1 from commandbutton within w_eis_dept
end type
type cb_close from commandbutton within w_eis_dept
end type
type st_1 from statictext within w_eis_dept
end type
type dw_dept_list from datawindow within w_eis_dept
end type
end forward

global type w_eis_dept from w_center
int X=153
int Y=109
int Width=1871
int Height=1447
boolean TitleBar=true
string Title="Department Listing"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_1 cb_1
cb_close cb_close
st_1 st_1
dw_dept_list dw_dept_list
end type
global w_eis_dept w_eis_dept

type variables
int mgrid
int deptnum


end variables

forward prototypes
public function int wf_refresh_dept (int ai_dept)
end prototypes

public function int wf_refresh_dept (int ai_dept);//////////////////////////////////////////////////////////////////////
//
// Function: wf_refresh_dept
//
// Purpose: retrieves the department datawindow, and selects the
//				desired row
//
//	Scope: public
//
//	Arguments: ai_dept	the department number to be selected
//
//	Returns: integer		the value returned from the retrieve function
//
//////////////////////////////////////////////////////////////////////

int	li_rc, &
		li_row, &
		li_rowcount


li_rc = dw_dept_list.Retrieve()
if li_rc = -1 then
	return li_rc
else

	// select the row with department id = department argument (ai_dept)
	li_rowcount = dw_dept_list.RowCount()
	if li_rowcount > 0 then
		li_row = dw_dept_list.Find ('dept_id = ' + String (ai_dept), 1, li_rowcount)
		dw_dept_list.SelectRow (0, false)		
		if li_row > 0 then
			dw_dept_list.SelectRow (li_row, true)
			dw_dept_list.ScrollToRow (li_row)
		end if
	end if

	return li_rc
end if
end function

on open;
// retrieve the departments

dw_dept_list.SetTransObject (SQLCA)
dw_dept_list.Retrieve()

end on

on close;w_main.Show()
end on

on w_eis_dept.create
this.cb_1=create cb_1
this.cb_close=create cb_close
this.st_1=create st_1
this.dw_dept_list=create dw_dept_list
this.Control[]={ this.cb_1,&
this.cb_close,&
this.st_1,&
this.dw_dept_list}
end on

on w_eis_dept.destroy
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.dw_dept_list)
end on

type cb_1 from commandbutton within w_eis_dept
int X=609
int Y=1153
int Width=246
int Height=109
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_dept_list.TriggerEvent (doubleclicked!)
end on

type cb_close from commandbutton within w_eis_dept
int X=886
int Y=1153
int Width=246
int Height=109
int TabOrder=10
string Text="Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type st_1 from statictext within w_eis_dept
int X=18
int Y=13
int Width=1761
int Height=71
boolean Enabled=false
string Text="Double-click a department to view or change employee information."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_dept_list from datawindow within w_eis_dept
int X=75
int Y=129
int Width=1668
int Height=951
int TabOrder=30
string DataObject="d_dept"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;//////////////////////////////////////////////////////////////////////
// When a department is doubleclicked, pass the department number
// to the w_eis_emp window.  On the open event of the w_eis_emp
// window, the employees for the department that was doubleclicked
// will be retrieved.
//////////////////////////////////////////////////////////////////////

s_employee	lstr_info
int			li_row, &
				li_rc

// assign a reference to this window in the employee info structure
// so that functions from this window can be called by the employee
// detail window.
lstr_info.dept_win = parent

// get clicked row number
li_row = dw_dept_list.GetRow()
if li_row > 0 then 
	
	SetPointer(HourGlass!)
	
	// deselect old row, select new row
	dw_dept_list.SelectRow (0, false)
	dw_dept_list.SelectRow (li_row, true)
	
	// pass the department number and manager id to the employees window.
	// The auto_new field specifies whether to immediately go to the 
	// employee detail window.
	lstr_info.dept_name = dw_dept_list.Object.dept_name[li_row]
	lstr_info.department = dw_dept_list.Object.dept_id[li_row]
	lstr_info.manager_id = dw_dept_list.Object.dept_head_id[li_row]
	lstr_info.auto_new = false
	OpenWithParm (w_eis_emp, lstr_info)
	
	// if there was a retrieve problem in the employee window, display message.
	li_rc = Message.DoubleParm
	if li_rc = 0 then
		if MessageBox ('No data retrieved', 'There are no employees in department ' + &
						lstr_info.dept_name + '.  Would you like to enter a new employee?', question!, YesNo!) = 1 then
			lstr_info.auto_new = true
			OpenWithParm (w_eis_emp, lstr_info)
		end if
	end if
	
end if

end event

on rowfocuschanged;// select the current row

f_select_current_row (this)
end on

