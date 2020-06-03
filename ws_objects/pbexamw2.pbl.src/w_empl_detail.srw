$PBExportHeader$w_empl_detail.srw
$PBExportComments$Shows employee detail in employee information system
forward
global type w_empl_detail from w_center
end type
type cb_cancel from commandbutton within w_empl_detail
end type
type cb_delete from commandbutton within w_empl_detail
end type
type cb_apply from commandbutton within w_empl_detail
end type
type dw_empl from datawindow within w_empl_detail
end type
end forward

global type w_empl_detail from w_center
int X=169
int Y=32
int Width=2601
int Height=1884
boolean TitleBar=true
string Title="Employee Details"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_cancel cb_cancel
cb_delete cb_delete
cb_apply cb_apply
dw_empl dw_empl
end type
global w_empl_detail w_empl_detail

type variables
s_employee   istr_info
end variables

forward prototypes
protected function integer wf_update (boolean ab_accept)
end prototypes

protected function integer wf_update (boolean ab_accept);//////////////////////////////////////////////////////////////////////
//
// Function: wf_update
//
// Purpose: updates the employee detail datawindow and 'refreshes'
//				the department and employee lists
//
//	Scope: protected
//
//	Arguments: ab_accept		true if accepttext should be performed prior to update
//									false if accepttext should not be performed
//
//	Returns: 1		successful update
//				-1		an error occured on the update
//				-2		AcceptText failed
//
//////////////////////////////////////////////////////////////////////

integer	li_dept, &
			li_emp


// perform accepttext if ab_accept argument is true
if ab_accept then
	if dw_empl.AcceptText() = -1 then
		return -2
	end if
end if

// Employee deletion
if dw_empl.RowCount() > 0 then
	// obtain data from primary buffer
	li_dept = dw_empl.Object.dept_id[1]
	li_emp  = dw_empl.Object.emp_id[1]
else
	// obtain information from the delete buffer
	li_dept = dw_empl.Object.dept_id.delete.current[1]
	li_emp  = dw_empl.Object.emp_id.delete.current[1]	
end if


if dw_empl.Update (false) = 1 then
	commit;
else
	rollback;
	return -1
end if


//////////////////////////////////////////////////////////////////////
// if update was successful, refresh the department and employee
// datawindows on the parent windows.
//////////////////////////////////////////////////////////////////////

istr_info.dept_win.wf_refresh_dept (li_dept)
istr_info.emp_win.wf_refresh_emp (li_dept, li_emp)
return 1
end function

event open;call super::open;//////////////////////////////////////////////////////////////////////
//
// Get the employee id, department id, and manager id from the 
// message object.  If the employee id is 0, then it is a new employee.
//
//////////////////////////////////////////////////////////////////////

string	ls_gray, ls_white
string	ls_col_count
int		li_col_count, i


// Get the color values of gray and white for Modify function
ls_white = String (RGB (255, 255, 255))
ls_gray = String(This.BackColor)


dw_empl.SetTransObject (sqlca)

//////////////////////////////////////////////////////////////////////
// get values from the message object
//////////////////////////////////////////////////////////////////////
istr_info = Message.PowerObjectParm


//////////////////////////////////////////////////////////////////////
// if this window is being called from another example, check to see
// if we want to disallow the updating capabilities
//////////////////////////////////////////////////////////////////////
if istr_info.no_edit then
	cb_delete.enabled = false

	// for all columns on datawindow - set taborder to 0, gray background
	ls_col_count = dw_empl.Object.datawindow.column.count
	li_col_count = Integer (ls_col_count)
	for i = 1 to li_col_count
		dw_empl.Modify ('#' + String (i) + '.tabsequence = 0  ' + &
							'#' + String (i) + ".background.color = '" + ls_gray + "'")
	next
end if


//////////////////////////////////////////////////////////////////////
// if employee id is zero, insert a row in the datawindow for a new
// employee.  If not, then retrieve the employee.
//////////////////////////////////////////////////////////////////////
if istr_info.employee_id = 0 then
	cb_delete.enabled = false
	cb_apply.enabled = true
	dw_empl.SetTabOrder (1, 5)		// Unprotect employee ID
	dw_empl.SetTabOrder (5, 0)		// Protect department ID
	dw_empl.SetTabOrder (2, 0)		// Protect manager ID
	dw_empl.Object.emp_id.background.color = ls_white
	dw_empl.Object.dept_id.background.color = ls_gray
	dw_empl.Object.manager_id.background.color = ls_gray 

	dw_empl.InsertRow (0)
	dw_empl.Object.dept_id[1] = istr_info.department
	dw_empl.Object.manager_id[1] = istr_info.manager_id
	this.title = "Employee Details - New Employee"
else
	if	dw_empl.Retrieve (istr_info.employee_id) <= 0 then
		close (this)
		return
	else
		string ls_emp_fname, ls_emp_lname
		ls_emp_lname = dw_empl.Object.emp_lname[1]
		ls_emp_fname = dw_empl.Object.emp_fname[1]
		this.title = "Employee Details - " + ls_emp_lname + ", " + ls_emp_fname
	end if
end if
end event

on closequery;//////////////////////////////////////////////////////////////////////
//
// Check to see if changes were made and provide ability to update
// before closing the details window
//
//////////////////////////////////////////////////////////////////////

dwItemStatus	l_mod


// Check the rowcount first, if employee has been deleted then the
// row count will be zero.

if dw_empl.RowCount() > 0 then
	l_mod = dw_empl.GetItemStatus (1, 0, primary!)
	if l_mod = DataModified! or l_mod = NewModified! then

		if MessageBox ('Employee Details', 'Apply changes before closing?', &
							question!, YesNo!) = 1 then

			// if return value from wf_update is -2, then accepttext failed.
			// Do not close the window at this point if accepttext fails.
			if wf_update (true) = -2 then
				Message.ReturnValue = 1
			end if

		end if
	end if
end if
end on

on w_empl_detail.create
this.cb_cancel=create cb_cancel
this.cb_delete=create cb_delete
this.cb_apply=create cb_apply
this.dw_empl=create dw_empl
this.Control[]={ this.cb_cancel,&
this.cb_delete,&
this.cb_apply,&
this.dw_empl}
end on

on w_empl_detail.destroy
destroy(this.cb_cancel)
destroy(this.cb_delete)
destroy(this.cb_apply)
destroy(this.dw_empl)
end on

type cb_cancel from commandbutton within w_empl_detail
int X=1696
int Y=1588
int Width=242
int Height=96
int TabOrder=30
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type cb_delete from commandbutton within w_empl_detail
int X=1111
int Y=1588
int Width=521
int Height=96
int TabOrder=40
string Text="&Delete Employee"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//////////////////////////////////////////////////////////////////////
// Delete the employee from the database
//////////////////////////////////////////////////////////////////////

string	ls_emp_fname, ls_emp_lname
string	ls_empname

ls_emp_fname = dw_empl.Object.emp_fname[1]
ls_emp_lname = dw_empl.Object.emp_lname[1]
ls_empname = ls_emp_fname + ' ' + ls_emp_lname

// Ask if it's ok to delete
if MessageBox ('Employee Information System', 'OK to delete employee ' + &
					ls_empname + '?', question!, YesNo!) = 1 then
	dw_empl.DeleteRow (0)
	wf_update (false)
	close (parent)
end if

end event

type cb_apply from commandbutton within w_empl_detail
int X=594
int Y=1588
int Width=453
int Height=96
int TabOrder=20
boolean Enabled=false
string Text="&Apply Changes"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//////////////////////////////////////////////////////////////////////
//
// update the database with the changes to employee detail datawindow
//
//////////////////////////////////////////////////////////////////////


// call the window function wf_update with a true argument passed
// to specify that accepttext is to be performed.  The wf_update
// function will refresh the department and employee lists on the
// parent windows after updating the employee details datawindow.
wf_update (true)







end on

type dw_empl from datawindow within w_empl_detail
int X=50
int Y=64
int Width=2432
int Height=1460
int TabOrder=10
string DataObject="d_empl_f_arg"
BorderStyle BorderStyle=StyleLowered!
end type

event itemchanged;//////////////////////////////////////////////////////////////////////
//
// If employee status changes to terminated, unprotect terminated date.
// If department id changes, manager id will change to correct value.
//
//////////////////////////////////////////////////////////////////////

string	ls_white, &
			ls_gray, &
			ls_tab
integer	li_manager_id, &
			li_dept

//////////////////////////////////////////////////////////////////////
// get the white and gray RGB values to be used in Modify expressions
//////////////////////////////////////////////////////////////////////
ls_white = String (RGB (255, 255, 255))
ls_gray = String (RGB (192, 192, 192))


//////////////////////////////////////////////////////////////////////
// enable the apply button when data is changed on the datawindow
//////////////////////////////////////////////////////////////////////
cb_apply.enabled = true


choose case this.GetColumnName()

	case 'emp_status'
		if this.GetText() = 'T' then
			dw_empl.Object.terminated_date.background.color = ls_white 
			dw_empl.Object.terminated_date.tabsequence = '135'
		else
			ls_tab = dw_empl.Object.terminated_date.tabsequence
			if ls_tab <> '0' then
				dw_empl.Object.terminated_date.background.color = ls_gray
				dw_empl.Object.terminated_date.tabsequence = '0'
			end if
		end if


	case 'dept_id'
		// get the department
		if IsNumber (this.GetText()) then
			li_dept = Integer (this.GetText())

			select department.dept_head_id
			into :li_manager_id
			from department
			where dept_id = :li_dept;

			// error handling
			if SQLCA.SQLCode = -1 then
				MessageBox ('Error', SQLCA.SQLErrText)
			end if

			this.Object.manager_id[1] = li_manager_id
		end if

end choose
end event

event editchanged;//////////////////////////////////////////////////////////////////////
// enable the apply button when data is changed on the datawindow
//////////////////////////////////////////////////////////////////////
cb_apply.enabled = true
end event

