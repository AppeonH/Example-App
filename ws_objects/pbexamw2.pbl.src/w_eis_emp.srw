$PBExportHeader$w_eis_emp.srw
$PBExportComments$Lists employees in department for employee information system
forward
global type w_eis_emp from w_center
end type
type cb_ok from commandbutton within w_eis_emp
end type
type st_1 from statictext within w_eis_emp
end type
type cb_new from commandbutton within w_eis_emp
end type
type cb_close from commandbutton within w_eis_emp
end type
type dw_emp_list from datawindow within w_eis_emp
end type
end forward

global type w_eis_emp from w_center
int X=470
int Y=353
int Width=1800
int Height=1447
boolean TitleBar=true
string Title="Employees for "
long BackColor=74481808
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_ok cb_ok
st_1 st_1
cb_new cb_new
cb_close cb_close
dw_emp_list dw_emp_list
end type
global w_eis_emp w_eis_emp

type variables
// structure which holds the department, manager id, 
// and employee id
s_employee    istr_info


end variables

forward prototypes
public function integer wf_refresh_emp (integer ai_dept, integer ai_emp)
end prototypes

public function integer wf_refresh_emp (integer ai_dept, integer ai_emp);//////////////////////////////////////////////////////////////////////
//
// Function: wf_refresh_emp
//
// Purpose: retrieves the employees datawindow, 
//				selects the desired employee id,
//				changes the title of the window to match department argument
//
//	Scope: public
//
//	Arguments: ai_dept			the department number retrieval argument
//				  ai_emp				the employee number to be selected
//
//	Returns: integer		the value returned from the retrieve function
//
//////////////////////////////////////////////////////////////////////

int		li_rc, &
			li_row, &
			li_rowcount
string	ls_dept_name


li_rc = dw_emp_list.Retrieve (ai_dept)

if li_rc = -1 then
	return li_rc
else
	// select the department name and
	// change the window title to match the department name argument

	select department.dept_name
	into :ls_dept_name
	from department
	where dept_id = :ai_dept;

	this.title = 'Employees for department ' + ls_dept_name


	// select the employee 
	li_rowcount = dw_emp_list.RowCount()
	if li_rowcount > 0 then
		li_row = dw_emp_list.Find ('emp_id = ' + String (ai_emp), 1, li_rowcount)
		dw_emp_list.SelectRow (0, false)		
		if li_row > 0 then
			dw_emp_list.SelectRow (li_row, true)
			dw_emp_list.ScrollToRow (li_row)
		end if
	end if

	return li_rc
end if

end function

event open;call super::open;//////////////////////////////////////////////////////////////////////
//
// Get the department number and manager id from the message object
// and retrieve the employees for department.
//
//////////////////////////////////////////////////////////////////////

int	li_rc


dw_emp_list.SetTransObject (SQLCA)

istr_info = message.PowerObjectParm

// assign a reference to this window in the employee info structure
// so that functions from this window can be called by the employee
// detail window.
istr_info.emp_win = this

// update the title of this window with the department name
this.title = this.title + istr_info.dept_name + ' department'

// if the auto_new field is true, then the user wants to enter a new
// employee without having to click the 'New Employee' button.
if istr_info.auto_new then
	cb_new.PostEvent (clicked!)
else
	li_rc = dw_emp_list.Retrieve (istr_info.department)
	if li_rc <= 0 then
		CloseWithReturn (this, li_rc)
		return
	end if
end if
end event

on w_eis_emp.create
this.cb_ok=create cb_ok
this.st_1=create st_1
this.cb_new=create cb_new
this.cb_close=create cb_close
this.dw_emp_list=create dw_emp_list
this.Control[]={ this.cb_ok,&
this.st_1,&
this.cb_new,&
this.cb_close,&
this.dw_emp_list}
end on

on w_eis_emp.destroy
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.cb_new)
destroy(this.cb_close)
destroy(this.dw_emp_list)
end on

type cb_ok from commandbutton within w_eis_emp
int X=385
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

on clicked;dw_emp_list.TriggerEvent (doubleclicked!)
end on

type st_1 from statictext within w_eis_emp
int X=11
int Y=13
int Width=1352
int Height=71
boolean Enabled=false
string Text="Double-click an employee or enter a new employee."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_new from commandbutton within w_eis_emp
int X=1000
int Y=1153
int Width=438
int Height=109
int TabOrder=30
string Text="&New Employee"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//////////////////////////////////////////////////////////////////////
// open the employee detail window, passing a 0 for employee id
// to signify a new employee to the detail window.
//////////////////////////////////////////////////////////////////////

istr_info.employee_id = 0
OpenWithParm (w_empl_detail, istr_info)

end on

type cb_close from commandbutton within w_eis_emp
int X=658
int Y=1153
int Width=289
int Height=109
int TabOrder=10
string Text="Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// close the window and pass 1 to the parent window
// In the parent window, if a 1 is returned, no errors occured.

CloseWithReturn (parent, 1)
end on

type dw_emp_list from datawindow within w_eis_emp
int X=82
int Y=151
int Width=1590
int Height=900
int TabOrder=40
string DataObject="d_emplist"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event doubleclicked;//////////////////////////////////////////////////////////////////////
// When an employee is doubleclicked, pass the employee id
// to the employee detail window.
//////////////////////////////////////////////////////////////////////

int			li_row

// get clicked row number
li_row = dw_emp_list.GetRow()
if li_row > 0 then 
	
	SetPointer(HourGlass!)
	
	// deselect old row, select new row
	dw_emp_list.SelectRow (0, false)
	dw_emp_list.SelectRow (li_row, true)
	
	// pass the employee id to the employee detail window
	istr_info.employee_id = dw_emp_list.Object.emp_id[li_row]
	istr_info.department = dw_emp_list.Object.dept_id[li_row]
	istr_info.manager_id = dw_emp_list.Object.manager_id[li_row]
	OpenWithParm (w_empl_detail, istr_info)
	
end if

end event

on rowfocuschanged;// select the current row

f_select_current_row (this)
end on

