$PBExportHeader$u_employee_object.sru
$PBExportComments$Employee class
forward
global type u_employee_object from u_business_object
end type
end forward

global type u_employee_object from u_business_object
end type
global u_employee_object u_employee_object

forward prototypes
public function int uf_delete_row (long al_row)
public function long uf_insert_row (long al_row)
end prototypes

public function int uf_delete_row (long al_row);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: uf_delete_row
//
// Purpose:  Deletes the row specified from the DataWindow.  If al_row = 0, the current row
//			will be deleted.
//			Confirm before deleting.
//			Employees with active status cannot be deleted.
//
// Scope: public
//
// Arguments: al_row	
//
// Returns: integer	1 success
//					-1 error
//					-2 employee has active status and cannot be deleted
//					0 user chose not to delete the employee
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int				li_rc
string			ls_status
string			ls_last_name, ls_first_name
dwitemstatus	le_status


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Obtain the current row number, if necessary
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if al_row = 0 then
	al_row = idw_parm.GetRow()
	if al_row <= 0 then
		return -1
	end if
end if


if al_row > 0 and al_row <= idw_parm.RowCount() then

	le_status = idw_parm.GetItemStatus (al_row, 0, primary!)
	if le_status <> new! and le_status <> newmodified! then	

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// Confirm before deleting.
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		ls_last_name = idw_parm.GetItemString (al_row, "emp_lname")
		ls_first_name = idw_parm.GetItemString (al_row, "emp_fname")
		if MessageBox ("Please confirm", "Delete " + ls_first_name + 	" " + ls_last_name + "?", question!, yesno!) = 2 then
			return 0
		end if		

		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
		// Check employee status before deleting.
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		ls_status = idw_parm.GetItemString (al_row, "status")
		if Upper (ls_status) = "A" then
			return -2
		end if

	end if

	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Delete row
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	li_rc = idw_parm.DeleteRow (al_row)
	idw_parm.SetFocus()
	return li_rc
else
	return -1
end if

end function

public function long uf_insert_row (long al_row);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: uf_insert_row
//
// Purpose: Inserts a new row into the DataWindow.  If al_row = 0, the new row will be inserted
//		     after the last row.  Otherwise, the new row will be inserted prior to the value of al_row.
//
//		     New employees must be confirmed before they are added.
//
// Scope: public
//
// Arguments: al_row	0 to insert the new row after the last row of the DataWindow
//						or the row number that you want the new row to be inserted before.
//
// Returns: long		the row number of the new row that was added
//					-1 error
//					0 if the user did not want to insert a new row
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Confirm before adding a new employee.  If user wants to add a new employee, call standard
// insert_row function in the ancestor object.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if MessageBox ("New Employee", "Are you sure you want to add a new employee?", question!, yesno!) = 1 then
	return super::uf_insert_row (al_row)
end if
return 0
end function

on u_employee_object.create
TriggerEvent( this, "constructor" )
end on

on u_employee_object.destroy
TriggerEvent( this, "destructor" )
end on

