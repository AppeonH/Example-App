$PBExportHeader$u_business_object.sru
$PBExportComments$Base ancestor user object for implementing business rules
forward
global type u_business_object from nonvisualobject
end type
end forward

global type u_business_object from nonvisualobject
end type
global u_business_object u_business_object

type variables
datawindow   idw_parm

// determines if uf_init( ) has been called
boolean   ib_initialized

end variables

forward prototypes
public subroutine uf_init (ref datawindow adw_parm)
public function long uf_retrieve ()
public function int uf_delete_row (long al_row)
public function long uf_insert_row (long al_row)
public function int uf_update ()
end prototypes

public subroutine uf_init (ref datawindow adw_parm);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: uf_init
//
// Purpose: Holds a reference to the DataWindow passed to this function
//
// Scope: public
//
// Arguments: adw_parm		a DataWindow passed by reference
//
// Returns: none
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

idw_parm = adw_parm
ib_initialized = true
end subroutine

public function long uf_retrieve ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: uf_retrieve
//
// Purpose: Retrieves the DataWindow
//
// Scope: public
//
// Arguments: none
//
// Returns: long		# of rows retrieved
//					-1 an error occurred during retrieval
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

return idw_parm.Retrieve()

end function

public function int uf_delete_row (long al_row);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: uf_delete_row
//
// Purpose: Deletes the row specified from the DataWindow.  If al_row = 0, the current row
//			will be deleted.
//
// Scope: public
//
// Arguments: al_row	
//
// Returns: integer	1 success
//					-1 error
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int		li_rc


if al_row >= 0 and al_row <= idw_parm.RowCount() then
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
// Scope: public
//
// Arguments: al_row	0 to insert the new row after the last row of the DataWindow
//						or the row number that you want the new row to be inserted before.
//
// Returns: long		the row number of the new row that was added
//					-1 error
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_rc


ll_rc = idw_parm.InsertRow (al_row)
if ll_rc > 0 then
	idw_parm.ScrollToRow(ll_rc)
	idw_parm.SetFocus()
end if

return ll_rc


end function

public function int uf_update ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: uf_update
//
// Purpose: Updates the DataWindow.
//
// Scope: public
//
// Arguments: none
//
// Returns: integer	1 success
//					-1 error
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int	li_rc


li_rc = idw_parm.Update()
if li_rc = 1 then
	commit;
else
	rollback;
end if

return li_rc


end function

on u_business_object.create
TriggerEvent( this, "constructor" )
end on

on u_business_object.destroy
TriggerEvent( this, "destructor" )
end on

