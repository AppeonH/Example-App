$PBExportHeader$w_dw_rows.srw
$PBExportComments$dwRowsMove, dwRowsCopy, and dwRowsDiscard example.
forward
global type w_dw_rows from w_center
end type
type st_filter_count from statictext within w_dw_rows
end type
type st_delete_count from statictext within w_dw_rows
end type
type st_primary_count from statictext within w_dw_rows
end type
type st_3 from statictext within w_dw_rows
end type
type st_2 from statictext within w_dw_rows
end type
type st_1 from statictext within w_dw_rows
end type
type dw_filtered from datawindow within w_dw_rows
end type
type dw_deleted from datawindow within w_dw_rows
end type
type dw_1 from datawindow within w_dw_rows
end type
type cb_help from commandbutton within w_dw_rows
end type
type cb_close from commandbutton within w_dw_rows
end type
type cb_retrieve from commandbutton within w_dw_rows
end type
type ln_1 from line within w_dw_rows
end type
type ln_2 from line within w_dw_rows
end type
end forward

global type w_dw_rows from w_center
int X=228
int Y=7
int Width=2493
int Height=1933
boolean TitleBar=true
string Title="Copy, Move, and Discard DataWindow Rows"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_filter_count st_filter_count
st_delete_count st_delete_count
st_primary_count st_primary_count
st_3 st_3
st_2 st_2
st_1 st_1
dw_filtered dw_filtered
dw_deleted dw_deleted
dw_1 dw_1
cb_help cb_help
cb_close cb_close
cb_retrieve cb_retrieve
ln_1 ln_1
ln_2 ln_2
end type
global w_dw_rows w_dw_rows

type variables
// Keeps track of the last row that was clicked in the
// three datawindows
long   il_prim_lastclicked, &
         il_del_lastclicked, &
         il_fil_lastclicked

// Determines if left mouse button is down in the 3 DataWindows
boolean   ib_prim_ldown, &
              ib_del_ldown, &
              ib_fil_ldown

// Used when rows that are clicked have already been
// selected.  This is necessary to drag a group of rows.
boolean   ib_already_selected
long   il_selected_clicked

// Determine whether user is copying or moving rows.
string   is_action

end variables

forward prototypes
public subroutine wf_set_rowcounts ()
protected subroutine wf_discard_rows ()
protected subroutine wf_change_buffer (datawindow adw_source, datawindow adw_target)
protected function integer wf_shift_highlight (datawindow adw_current, long al_clickedrow)
end prototypes

public subroutine wf_set_rowcounts ();//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: wf_set_rowcounts
//
// Purpose: Sets the displayed row counts of the "primary", "deleted", and "filtered" DataWindows
//
// Scope: public
//
// Arguments: none
//
// Returns: none
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

st_primary_count.text = String (dw_1.RowCount()) + " rows"
st_delete_count.text = String (dw_1.DeletedCount()) + " rows"
st_filter_count.text = String (dw_1.FilteredCount()) + " rows"
end subroutine

protected subroutine wf_discard_rows ();///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Discard all selected rows in the DataWindow which has focus.
//
// (Because this example is visually "showing" the three buffers for one DataWindow, there
//  are two operations that must be performed on any action:  the actual movement between
//  buffers of the rows in dw_1 (referred to in this example as "Internal operation"), and the visual 
//  representation of the movement which is moving rows from one DataWindow to another
//  (referred to in this example as "External operation"))  
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

graphicobject	lgo_focus
DataWindow	ldw_control
long			ll_selected_rows[], &
				ll_selected_count
dwbuffer			lb_buffer
string			ls_buffer


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Determine the type of control that has focus
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
lgo_focus = GetFocus()
if TypeOf (lgo_focus) <> DataWindow! then
	return
else
	ldw_control = lgo_focus
end if


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Determine the selected rows in the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ll_selected_count = f_return_selected (ldw_control, ll_selected_rows)
if ll_selected_count = 0 then
	return
end if


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// External operation
// Discard all selected rows from the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ldw_control.RowsDiscard (ll_selected_rows[1], ll_selected_rows[ll_selected_count], primary!) = -1 then
	MessageBox ("Error", "An error occured performing RowsDiscard function.", exclamation!)
	return
end if


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Internal operation
// Discard all selected rows from the appropriate buffer in dw_1
//
// If we have already discarded from dw_1, then we are done.  The rows were discarded from
// the primary buffer.  If the current DataWindow is deleted or filtered DataWindows, we need
// to discard from the deleted or filtered buffer of dw_1.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ldw_control = dw_1 then
	return
else
	if ldw_control = dw_deleted then
		lb_buffer = delete!
		ls_buffer = "delete"
	else
		lb_buffer = filter!
		ls_buffer = "filter"
	end if
	if dw_1.RowsDiscard (ll_selected_rows[1], ll_selected_rows[ll_selected_count], lb_buffer) = -1 then
		MessageBox ("Error", "An error occured performing RowsDiscard function~r" + &
						"when discarding from the " + ls_buffer + " buffer", exclamation!)
	end if
end if

wf_set_rowcounts()

end subroutine

protected subroutine wf_change_buffer (datawindow adw_source, datawindow adw_target);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: wf_change_buffer
//
// Purpose: Performs RowsCopy or RowsMove from the source DataWindow
//		     to the target DataWindow.
// (Because this example is visually "showing" the three buffers for one DataWindow, there
//  are two operations that must be performed on any action:  the actual movement between
//  buffers of the rows in dw_1 (referred to in this example as "Internal operation"), and the visual 
//  representation of the movement which is moving rows from one DataWindow to another
//  (referred to in this example as "External operation"))
//
// Scope: protected
//
// Arguments: adw_source		the source datawindow
//			   adw_target		the target datawindow
//		
// Returns: none
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long		ll_selected_rows[], &
			ll_selected_count, &
			ll_rowcount
dwbuffer		lb_source_buffer, &
			lb_target_buffer



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Store the row numbers of the selected rows in an array
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ll_selected_count = f_return_selected (adw_source, ll_selected_rows)
if ll_selected_count = 0 then return


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// External action
// Copy the rows from the source datawindow to the target datawindow.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if adw_target <> dw_1 then
	adw_source.RowsCopy (ll_selected_rows[1], ll_selected_rows[ll_selected_count], &
								primary!, adw_target, adw_target.RowCount() + 1, primary!)	
end if


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Internal action
// Depending upon the action (move or copy), move or copy the rows from the buffer specified
// by the source DataWindow to the buffer specified by the target DataWindow.  
// Example - if moving from the "deleted buffer" DataWindow to the "primary buffer" DataWindow,
//			 then a RowsMove will be issued from the deleted buffer of dw_1 to the
//			 primary buffer of dw_1.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
choose case adw_source
	case dw_1
		lb_source_buffer = primary!

	case dw_deleted
		lb_source_buffer = delete!

	case dw_filtered
		lb_source_buffer = filter!
end choose

choose case adw_target
	case dw_1
		lb_target_buffer = primary!

	case dw_deleted
		lb_target_buffer = delete!

	case dw_filtered
		lb_target_buffer = filter!
end choose

if is_action = "copy" then
	dw_1.RowsCopy (ll_selected_rows[1], ll_selected_rows[ll_selected_count], &
								lb_source_buffer, dw_1, dw_1.RowCount() + 1, lb_target_buffer)	
else
	dw_1.RowsMove (ll_selected_rows[1], ll_selected_rows[ll_selected_count], &
								lb_source_buffer, dw_1, dw_1.RowCount() + 1, lb_target_buffer)	
end if


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// External action
// If moving from the deleted or filtered DataWindows, then discard the rows that were moved
// from the source DataWindow.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if (is_action = "move") and (adw_source = dw_deleted or adw_source = dw_filtered) then
	adw_source.RowsDiscard (ll_selected_rows[1], ll_selected_rows[ll_selected_count], primary!)
end if

wf_set_rowcounts()
adw_target.SetFocus()
ll_rowcount = adw_target.RowCount()
adw_target.ScrollToRow(ll_rowcount)
end subroutine

protected function integer wf_shift_highlight (datawindow adw_current, long al_clickedrow);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: wf_shift_highlight
//
// Purpose:	This function will verify that there is a prior selected row and
//			then highlight all Rows between the two.  If there is no previously
//			selected row then it will highlight only the row clicked.  
//			This function will not unhighlight any other rows to allow for a 
//			mix of shift and Control key inter-mingling. 
//
//			The argument passed will be the currently clicked row.  This 
//			function will use the existing DataWindow and the instance variable
//			il_LastClickedRow to perform it's scrolling.		
//
// Scope: protected
//
// Arguments: adw_current - Current datawidnow
//					al_clickedrow - Current clicked row on datawindow
//		
// Returns: integer		the number of rows selected
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

integer		li_Idx
long			ll_count, &
				ll_last_clicked


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Check to make sure the row is valid
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if al_clickedrow <= 0 then return 0

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Determine which instance variable to use for last clicked row
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
choose case adw_current

	case dw_1
		ll_last_clicked = il_prim_lastclicked		

	case dw_deleted
		ll_last_clicked = il_del_lastclicked

	case dw_filtered
		ll_last_clicked = il_fil_lastclicked

end choose


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If there is no previous clicked row, then only select the row that was clicked
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If ll_last_clicked = 0 then
	adw_current.selectrow (al_clickedrow, true)
	return 1
end if

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Select all rows in between last clicked row and clicked row
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if ll_last_clicked > al_clickedrow then
	for li_Idx = ll_last_clicked to al_clickedrow step -1
		adw_current.selectrow (li_Idx, true)	
		ll_count++
	next
else
	for li_Idx = ll_last_clicked to al_clickedrow
		adw_current.selectrow (li_Idx, true)	
		ll_count++
	next	
end if

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Multiple rows are now selected in the DataWindow, so change its drag icon to the 
// multiple rows icon.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
adw_current.DragIcon = "rows.ico"

return ll_count

end function

on mousemove;ib_prim_ldown = false
ib_fil_ldown = false
ib_del_ldown = false


end on

on open;dw_1.SetTransObject (sqlca)

end on

on close;w_main.Show()
end on

on w_dw_rows.create
this.st_filter_count=create st_filter_count
this.st_delete_count=create st_delete_count
this.st_primary_count=create st_primary_count
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_filtered=create dw_filtered
this.dw_deleted=create dw_deleted
this.dw_1=create dw_1
this.cb_help=create cb_help
this.cb_close=create cb_close
this.cb_retrieve=create cb_retrieve
this.ln_1=create ln_1
this.ln_2=create ln_2
this.Control[]={ this.st_filter_count,&
this.st_delete_count,&
this.st_primary_count,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_filtered,&
this.dw_deleted,&
this.dw_1,&
this.cb_help,&
this.cb_close,&
this.cb_retrieve,&
this.ln_1,&
this.ln_2}
end on

on w_dw_rows.destroy
destroy(this.st_filter_count)
destroy(this.st_delete_count)
destroy(this.st_primary_count)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_filtered)
destroy(this.dw_deleted)
destroy(this.dw_1)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.cb_retrieve)
destroy(this.ln_1)
destroy(this.ln_2)
end on

type st_filter_count from statictext within w_dw_rows
int X=385
int Y=1300
int Width=356
int Height=71
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0 rows"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_delete_count from statictext within w_dw_rows
int X=385
int Y=769
int Width=356
int Height=71
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0 rows"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_primary_count from statictext within w_dw_rows
int X=385
int Y=33
int Width=356
int Height=71
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0 rows"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_dw_rows
int X=54
int Y=769
int Width=331
int Height=71
boolean Enabled=false
string Text="Deleted buffer:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_dw_rows
int X=54
int Y=1300
int Width=328
int Height=71
boolean Enabled=false
string Text="Filtered buffer:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_dw_rows
int X=54
int Y=33
int Width=342
int Height=71
boolean Enabled=false
string Text="Primary buffer:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_filtered from datawindow within w_dw_rows
event ue_key pbm_dwnkey
event ue_lmouse_down pbm_lbuttondown
event ue_lmouse_up pbm_lbuttonup
event ue_mousemove pbm_mousemove
int X=54
int Y=1393
int Width=1675
int Height=388
int TabOrder=60
string DragIcon="row.ico"
string DataObject="d_state_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on ue_key;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Discard DataWindow rows when the Delete key is pressed
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if KeyDown (keydelete!) then
	wf_discard_rows()
end if
end on

on ue_lmouse_down;ib_fil_ldown = true
end on

on ue_lmouse_up;ib_fil_ldown = false

// Handle case where row is already selected.  If a row is already selected, we want to handle
// the clicked behavior at the time the left mouse button goes up.
if ib_already_selected then
	this.TriggerEvent (clicked!)
end if


end on

on ue_mousemove;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If left mouse button is down and user moves the mouse, initiate drag mode.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ib_fil_ldown and this.RowCount() > 0 then

	// If the Control key is held down, then the rows will be copied with dwRowsCopy
	if KeyDown (keyControl!) then
		is_action = "copy"
	else
		is_action = "move"
	end if

	this.Drag (begin!)
end if


end on

on dragdrop;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Move or copy the DataWindow rows that were dropped on this datawindow to the 
// filtered buffer.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DragObject		ldo_object
DataWindow	ldw_control


ldo_object = DraggedObject()
if TypeOf (ldo_object) = DataWindow! then
	ldw_control = ldo_object
	if ldw_control <> this then
		wf_change_buffer (ldw_control, this)
	end if
end if
end on

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Allow user to use Shift-click to highlight all rows betwen first clicked row and the
// row that was Shift-clicked.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_clicked


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// First make sure the user clicked on a Row.  Clicking on WhiteSpace or in the header 
// will return a clicked row value of 0.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If row = 0 then return

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If the clicked row is already selected, handle highlite processing for it in the left mouse
// button up event.  This is necessary so groups of selected rows can be dragged.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if this.GetSelectedRow (row - 1) = row and ib_already_selected = false then
	ib_already_selected = true
	il_selected_clicked = row
	return
else

	if ib_already_selected then
		ll_clicked = il_selected_clicked		
	else
		ll_clicked = row
	end if

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// case of select multiple rows range using the shift key
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if Keydown (KeyShift!) and not ib_already_selected then
		wf_shift_highlight (this, ll_clicked)
	else
		this.SelectRow (0, false)
		this.SelectRow (ll_clicked, true)

		// A single row is now selected in the DataWindow, so change its drag icon to the 
		// single rows icon.
		this.DragIcon = "row.ico"
	end if

	ib_already_selected = false
	il_fil_lastclicked = ll_clicked
end if
end event

on losefocus;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Deselect all rows and reset the last clicked instance variable
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
this.SelectRow (0, false)
il_fil_lastclicked = 0
end on

type dw_deleted from datawindow within w_dw_rows
event ue_key pbm_dwnkey
event ue_lmouse_down pbm_lbuttondown
event ue_lmouse_up pbm_lbuttonup
event ue_mousemove pbm_mousemove
int X=54
int Y=861
int Width=1675
int Height=388
int TabOrder=50
string DragIcon="row.ico"
string DataObject="d_state_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on ue_key;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Discard DataWindow rows when the Delete key is pressed
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if KeyDown (keydelete!) then
	wf_discard_rows()
end if
end on

on ue_lmouse_down;ib_del_ldown = true



end on

on ue_lmouse_up;ib_del_ldown = false

// Handle case where row is already selected.  If a row is already selected, we want to handle
// the clicked behavior at the time the left mouse button goes up.
if ib_already_selected then
	this.TriggerEvent (clicked!)
end if


end on

on ue_mousemove;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If left mouse button is down and user moves the mouse, initiate drag mode.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ib_del_ldown and this.RowCount() > 0 then

	// If the Control key is held down, then the rows will be copied with dwRowsCopy
	if KeyDown (keyControl!) then
		is_action = "copy"
	else
		is_action = "move"
	end if

	this.Drag (begin!)
end if



end on

on dragdrop;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Move or copy the DataWindow rows that were dropped on this datawindow to the 
// deleted buffer.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DragObject		ldo_object
DataWindow	ldw_control


ldo_object = DraggedObject()
if TypeOf (ldo_object) = DataWindow! then
	ldw_control = ldo_object
	if ldw_control <> this then
		wf_change_buffer (ldw_control, this)
	end if
end if
end on

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Allow user to use Shift-click to highlight all rows betwen first clicked row and the
// row that was Shift-clicked.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_clicked


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// First make sure the user clicked on a Row.  Clicking on WhiteSpace or in the header 
// will return a clicked row value of 0.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If row = 0 then return

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If the clicked row is already selected, handle highlite processing for it in the left mouse
// button up event.  This is necessary so groups of selected rows can be dragged.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if this.GetSelectedRow (row - 1) = row and ib_already_selected = false then
	ib_already_selected = true
	il_selected_clicked = row
	return
else

	if ib_already_selected then
		ll_clicked = il_selected_clicked		
	else
		ll_clicked = row
	end if

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// case of select multiple rows range using the shift key
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if Keydown (KeyShift!) and not ib_already_selected then
		wf_shift_highlight (this, ll_clicked)
	else
		this.SelectRow (0, false)
		this.SelectRow (ll_clicked, true)

		// A single row is now selected in the DataWindow, so change its drag icon to the 
		// single rows icon.
		this.DragIcon = "row.ico"
	end if

	ib_already_selected = false
	il_del_lastclicked = ll_clicked
end if
end event

on losefocus;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Deselect all rows and reset the last clicked instance variable
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
this.SelectRow (0, false)
il_del_lastclicked = 0
end on

type dw_1 from datawindow within w_dw_rows
event ue_key pbm_dwnkey
event ue_lmouse_down pbm_lbuttondown
event ue_lmouse_up pbm_lbuttonup
event ue_mousemove pbm_mousemove
int X=54
int Y=129
int Width=1675
int Height=567
int TabOrder=40
string DragIcon="row.ico"
string DataObject="d_state_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on ue_key;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Discard DataWindow rows when the Delete key is pressed
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if KeyDown (keydelete!) then
	wf_discard_rows()
end if
end on

on ue_lmouse_down;ib_prim_ldown = true
end on

on ue_lmouse_up;ib_prim_ldown = false

// Handle case where row is already selected.  If a row is already selected, we want to handle
// the clicked behavior at the time the left mouse button goes up.
if ib_already_selected then
	this.TriggerEvent (clicked!)
end if




end on

on ue_mousemove;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If left mouse button is down and user moves the mouse, initiate drag mode.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ib_prim_ldown and this.RowCount() > 0 then

	// If the Control key is held down, then the rows will be copied with dwRowsCopy
	if KeyDown (keyControl!) then
		is_action = "copy"
	else
		is_action = "move"
	end if

	this.Drag (begin!)
end if



end on

on dragdrop;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Move or copy the DataWindow rows that were dropped on this datawindow to the 
// primary buffer.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DragObject		ldo_object
DataWindow	ldw_control


ldo_object = DraggedObject()
if TypeOf (ldo_object) = DataWindow! then
	ldw_control = ldo_object
	if ldw_control <> this then
		wf_change_buffer (ldw_control, this)
	end if
end if
end on

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Allow user to use Shift-click to highlight all rows betwen first clicked row and the
// row that was Shift-clicked.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


long	ll_clicked

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// First make sure the user clicked on a Row.  Clicking on WhiteSpace or in the header 
// will return a clicked row value of 0.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If row = 0 then return

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If the clicked row is already selected, handle highlite processing for it in the left mouse
// button up event.  This is necessary so groups of selected rows can be dragged.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if this.GetSelectedRow (row - 1) = row and ib_already_selected = false then
	ib_already_selected = true
	il_selected_clicked = row
	return
else

	if ib_already_selected then
		ll_clicked = il_selected_clicked
	else
		ll_clicked = row
	end if

	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// case of select multiple rows range using the shift key
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if Keydown (KeyShift!) and not ib_already_selected then
		wf_shift_highlight (this, ll_clicked)
	else
		this.SelectRow (0, false)
		this.SelectRow (ll_clicked, true)

		// A single row is now selected in the DataWindow, so change its drag icon to the 
		// single rows icon.
		this.DragIcon = "row.ico"
	end if

	ib_already_selected = false
	il_prim_lastclicked = ll_clicked
end if
end event

on losefocus;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Deselect all rows and reset the last clicked instance variable
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
this.SelectRow (0, false)
il_prim_lastclicked = 0
end on

type cb_help from commandbutton within w_dw_rows
int X=2059
int Y=257
int Width=345
int Height=93
int TabOrder=30
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help (parent.ClassName())
end on

type cb_close from commandbutton within w_dw_rows
int X=2059
int Y=135
int Width=345
int Height=93
int TabOrder=20
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close (parent)
end on

type cb_retrieve from commandbutton within w_dw_rows
int X=2059
int Y=29
int Width=345
int Height=93
int TabOrder=10
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Retrieve the "primary" DataWindow
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if dw_1.AcceptText() = -1 then
	return
else
	if dw_1.Retrieve() = -1 then
		return
	else
		// Reset the "deleted" and "filtered" DataWindows
		dw_deleted.Reset()
		dw_filtered.Reset()

		// Redisplay the row counts
		wf_set_rowcounts()
	end if
end if
end on

type ln_1 from line within w_dw_rows
boolean Enabled=false
int BeginX=2450
int BeginY=727
int EndY=727
int LineThickness=4
end type

type ln_2 from line within w_dw_rows
boolean Enabled=false
int BeginX=2450
int BeginY=733
int EndY=733
int LineThickness=4
long LineColor=16777215
end type

