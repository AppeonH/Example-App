$PBExportHeader$w_change_emp_status.srw
$PBExportComments$Drag-and-drop to change Employee Status
forward
global type w_change_emp_status from w_center
end type
type st_10 from statictext within w_change_emp_status
end type
type st_9 from statictext within w_change_emp_status
end type
type st_8 from statictext within w_change_emp_status
end type
type st_7 from statictext within w_change_emp_status
end type
type st_5 from statictext within w_change_emp_status
end type
type st_4 from statictext within w_change_emp_status
end type
type st_3 from statictext within w_change_emp_status
end type
type st_2 from statictext within w_change_emp_status
end type
type st_message from statictext within w_change_emp_status
end type
type cb_close from commandbutton within w_change_emp_status
end type
type dw_emp from datawindow within w_change_emp_status
end type
type dw_dept from datawindow within w_change_emp_status
end type
type dw_one_emp from datawindow within w_change_emp_status
end type
type p_terminated from picture within w_change_emp_status
end type
type p_onleave from picture within w_change_emp_status
end type
type p_active from picture within w_change_emp_status
end type
type gb_1 from groupbox within w_change_emp_status
end type
end forward

global type w_change_emp_status from w_center
int X=33
int Y=65
int Width=2903
int Height=1837
boolean TitleBar=true
string Title="Change Employee Status"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
string Icon="emp.ico"
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_message st_message
cb_close cb_close
dw_emp dw_emp
dw_dept dw_dept
dw_one_emp dw_one_emp
p_terminated p_terminated
p_onleave p_onleave
p_active p_active
gb_1 gb_1
end type
global w_change_emp_status w_change_emp_status

type variables
// determines if left mouse button is down for employees datawindow
boolean    ib_down

// determines if left mouse button is down for employee details datawindow
boolean   ib_detail_down

// determines if message to drag detail employee is displayed
boolean   ib_detail_message

// Test if any employees status has been changed.
boolean   ib_changed


end variables

event closequery;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Prompt to save changes back to database if any data has been changed.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int	li_ret

if ib_changed then
	li_ret = MessageBox (this.title, "Save changes back to database?", question!, YesNoCancel!)
	if li_ret = 1 then
		commit;
	else
		if li_ret = 2 then
			rollback;
		else
			//User hit 'cancel' - Do not close the window
			message.ReturnValue = 1
		end if
	end if
end if
end event

on dragdrop;st_message.text = ''
end on

event open;call super::open;long ll_dept_id

// Set transaction objects for datawindows
dw_one_emp.SetTransObject (sqlca)
dw_emp.SetTransObject (sqlca)
dw_dept.SetTransObject (sqlca)

//Retrieve the departments
if dw_dept.Retrieve() < 1 then return

//Retrieve the employees for the first department
If dw_dept.RowCount() > 0 Then
	ll_dept_id = dw_dept.object.dept_id[1]
	dw_emp.Retrieve (ll_dept_id)
End If
end event

on close;w_main.Show()
end on

on w_change_emp_status.create
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_message=create st_message
this.cb_close=create cb_close
this.dw_emp=create dw_emp
this.dw_dept=create dw_dept
this.dw_one_emp=create dw_one_emp
this.p_terminated=create p_terminated
this.p_onleave=create p_onleave
this.p_active=create p_active
this.gb_1=create gb_1
this.Control[]={ this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_message,&
this.cb_close,&
this.dw_emp,&
this.dw_dept,&
this.dw_one_emp,&
this.p_terminated,&
this.p_onleave,&
this.p_active,&
this.gb_1}
end on

on w_change_emp_status.destroy
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_message)
destroy(this.cb_close)
destroy(this.dw_emp)
destroy(this.dw_dept)
destroy(this.dw_one_emp)
destroy(this.p_terminated)
destroy(this.p_onleave)
destroy(this.p_active)
destroy(this.gb_1)
end on

event mousemove;If NOT ib_down Then
	// Blank out the text
	If st_message.text <> '' Then
		st_message.text = ''
	End If
End If
end event

type st_10 from statictext within w_change_emp_status
int X=311
int Y=1413
int Width=307
int Height=69
boolean Enabled=false
string Text="Terminated"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within w_change_emp_status
int X=311
int Y=1205
int Width=257
int Height=69
boolean Enabled=false
string Text="On Leave"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_change_emp_status
int X=311
int Y=1025
int Width=229
int Height=69
boolean Enabled=false
string Text="Active"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_change_emp_status
int X=33
int Y=85
int Width=2213
int Height=69
boolean Enabled=false
string Text="To change an employee's status, drag the employee's picture onto one of the actions."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_change_emp_status
int X=33
int Y=21
int Width=2286
int Height=69
boolean Enabled=false
string Text="Select a department and then drag an employee name into the employee details section."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_change_emp_status
int X=709
int Y=821
int Width=453
int Height=69
boolean Enabled=false
string Text="Employee Details"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_change_emp_status
int X=1057
int Y=245
int Width=293
int Height=69
boolean Enabled=false
string Text="Employees"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_change_emp_status
int X=65
int Y=245
int Width=385
int Height=69
boolean Enabled=false
string Text="Departments"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_message from statictext within w_change_emp_status
int X=10
int Y=1605
int Width=2798
int Height=69
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_change_emp_status
int X=2506
int Y=37
int Width=275
int Height=97
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_emp from datawindow within w_change_emp_status
event ue_buttondown pbm_lbuttondown
event ue_buttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
int X=1057
int Y=325
int Width=929
int Height=389
string DragIcon="emp.ico"
string DataObject="d_emp_list_by_dept"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on ue_buttondown;ib_down = true
end on

on ue_buttonup;ib_down = false

end on

event ue_mousemove;//////////////////////////////////////////////////////////////////////
// if left mouse button is down and user moves the mouse, initiate drag mode
//////////////////////////////////////////////////////////////////////

string	ls_emp_fname, &
			ls_emp_lname, &
			ls_col, &
			ls_new_text
int		li_row, &
			li_pos

// if pointer is positioned over an employee name, display message
// that it is ok to drag here

ls_col = this.GetObjectAtPointer() 

if Len (ls_col) > 0 then
	li_pos = Pos (ls_col, '~t')

	// get the employee name from the row that was returned from the
	// dwGetObjectAtPointer function.
	if li_pos > 0 then
		li_row = Integer (Right (ls_col, Len (ls_col) - li_pos))
		ls_emp_fname = this.object.emp_fname[li_row]
		ls_emp_lname = this.object.emp_lname[li_row]
	end if
	ls_new_text =	'Hold left mouse button down to drag ' + &
						ls_emp_fname + ' ' + ls_emp_lname + &
						' onto the employee details or actions.'
	if st_message.text <> ls_new_text then
		st_message.text = ls_new_text
	end if
	
	// if left mouse button is down, begin drag mode
	if ib_down then
		this.Drag (begin!)
	end if
else
	if Len (st_message.text) > 0 then
		st_message.text = ''
	end if
end if

end event

on retrieveend;this.TriggerEvent (rowfocuschanged!)
end on

event doubleclicked;/////////////////////////////////////////////////////////////////////
// Get the selected row, highlite it and retrieve the detail for the
// selected employee
/////////////////////////////////////////////////////////////////////

int	li_emp_id

if row > 0 then
	li_emp_id = this.object.emp_id[row]
	dw_one_emp.Retrieve (li_emp_id)
end if
	
end event

on rowfocuschanged;// highlite the current row

f_select_current_row (this)
end on

type dw_dept from datawindow within w_change_emp_status
int X=65
int Y=325
int Width=929
int Height=389
string DragIcon="emp.ico"
string DataObject="d_dept_name"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;//////////////////////////////////////////////////////////////////////
// retrieve the employees for the current department row
//////////////////////////////////////////////////////////////////////

long ll_dept_id

// highlite the current row
f_select_current_row (this)

// retrieve the employees
ll_dept_id = this.object.dept_id[this.GetRow()]
dw_emp.Retrieve (ll_dept_id)

end event

type dw_one_emp from datawindow within w_change_emp_status
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
int X=709
int Y=893
int Width=2090
int Height=645
string DragIcon="emp.ico"
string DataObject="d_change_emp_status"
BorderStyle BorderStyle=StyleLowered!
end type

on ue_lbuttondown;ib_detail_down = true
end on

on ue_lbuttonup;ib_detail_down = false
end on

event ue_mousemove;//////////////////////////////////////////////////////////////////////
// if left mouse button is down and user moves the mouse and 
// the pointer is over the employee picture, initiate drag mode.
//////////////////////////////////////////////////////////////////////

string	ls_emp_fname, &
			ls_emp_lname

// if pointer is over employee picture, display message to let
// user know its ok to drag here

if Left (this.GetObjectAtPointer(), 8) = 'emp_face' then
	ls_emp_fname = this.object.emp_fname[1]
	ls_emp_lname = this.object.emp_lname[1]

	// if message is not already being displayed, display it
	if not ib_detail_message then
		st_message.text = 'Hold left mouse button down to drag ' + &
								ls_emp_fname + ' ' + ls_emp_lname + &
								' onto one of the actions.'
		ib_detail_message = true
	end if

	// initiate drag mode if left mouse button is down
	if ib_detail_down then
		this.Drag (begin!)
	end if
else
	// if message was being displayed, clear it
	if ib_detail_message then
		st_message.text = ''
		ib_detail_message = false
	end if
end if



end event

event retrieveend;//////////////////////////////////////////////////////////////////////
// Display appropriate message depending on status of employee.
//////////////////////////////////////////////////////////////////////

string	ls_status_msg, &
			ls_status


// Get the status for the employee
ls_status = this.object.status[1]

// Depending on status, set the appropriate text
choose case ls_status
	case "A"
		ls_status_msg = "Employee is in good standing."
	case "T"
		ls_status_msg = "Employee has been terminated."
	case "L"
		ls_status_msg = "Employee is on leave of absence."
end choose

// Now, modify the text of the message column to show the text
this.object.status_message.text = "~"" + ls_status_msg + "~""

end event

event dragdrop;/////////////////////////////////////////////////////////////////////
// If an employee from the dw_emp datawindow is dropped, retrieve
// the employee.
/////////////////////////////////////////////////////////////////////

DragObject	ldo_control
int			li_row, &
				li_emp_id

// Get the dragged object.
ldo_control = DraggedObject()

// Determine if the dragged object is the employee datawindow
if ldo_control = dw_emp then
	// Retrieve the employee detail information according to the selected 
	// row on the employee datawindow
	li_row = dw_emp.GetRow()
	if li_row > 0 then
		li_emp_id = dw_emp.object.emp_id[li_row]
		dw_one_emp.Retrieve (li_emp_id)
	end if
end if

// clear out the message at the bottom of the window
st_message.text = ''
	

end event

event dragenter;//////////////////////////////////////////////////////////////////////
//
// Determine which object is being dragged.  If an employee from the
// dw_emp datawindow is being dragged, display help message.
//
//////////////////////////////////////////////////////////////////////

DragObject	ldo_control
int			li_row
string		ls_emp_fname
string		ls_emp_lname

// Get the dragged object.
ldo_control = DraggedObject()

// Determine if the dragged object is the employee datawindow
if ldo_control = dw_emp then
	// Display employee name on message according to the selected 
	// row on the employee datawindow
	li_row = dw_emp.GetRow()
	if li_row > 0 then
		ls_emp_fname = dw_emp.object.emp_fname[li_row]
		ls_emp_lname = dw_emp.object.emp_lname[li_row]
		st_message.text = 'Drop ' + ls_emp_fname+' '+ls_emp_lname + &
								' here to view employee details.'
	end if
end if






end event

event dragleave;// clear out the message at the bottom of the window
st_message.text = ''
end event

type p_terminated from picture within w_change_emp_status
int X=101
int Y=1357
int Width=170
int Height=149
int TabOrder=30
string PictureName="exitdoor.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

event dragdrop;//////////////////////////////////////////////////////////////////////
// The terminated picture has been dropped on; change the message to 
// 'Terminated', reset the status column and update the database. 
//////////////////////////////////////////////////////////////////////

DragObject	ldo_control
int			li_row
string		ls_emp_fname
string		ls_emp_lname
long			ll_emp_id

//Get the dragged object
ldo_control = DraggedObject()

// if user is dragging from the employee list, retrieve the 
// employee detail first
if ldo_control = dw_emp then
	li_row = dw_emp.GetRow()
	if li_row > 0 then
		ll_emp_id = dw_emp.object.emp_id[li_row]
		if dw_one_emp.Retrieve (ll_emp_id) < 1 then return
	else
		return
	end if
end if

ls_emp_fname = dw_one_emp.object.emp_fname[1]
ls_emp_lname = dw_one_emp.object.emp_lname[1]
if MessageBox ("Please confirm!", &
					"Are you sure you want to terminate " + &
					ls_emp_fname + ' ' + ls_emp_lname + &
					"?", Question!, YesNo!) = 1 then
 
	// If you really mean it, set the 'Terminated' message, set the status 
	// column and update the database.

	dw_one_emp.object.status_message.text = "~"Employee has been terminated~""
	dw_one_emp.object.status[1] = 'T'
	if dw_one_emp.Update() = -1 then
		rollback;
		MessageBox ('Update Failed!', 'Update could not be performed.')
	end if
end if

st_message.text = ''
ib_changed = true

end event

event dragenter;//////////////////////////////////////////////////////////////////////
// display help message
//////////////////////////////////////////////////////////////////////

DragObject	ldo_control
int			li_row
string		ls_emp_fname
string		ls_emp_lname


//Get the dragged object
ldo_control = DraggedObject()

if ldo_control = dw_one_emp then
	// The dragged object is from the Single record employee datawindow
	ls_emp_fname = dw_one_emp.object.emp_fname[1]
	ls_emp_lname = dw_one_emp.object.emp_lname[1]
else
	// The dragged object is from the Multiple record employee datawindow
	li_row = dw_emp.GetRow()
	if li_row > 0 then
		ls_emp_fname = dw_emp.object.emp_fname[li_row]
		ls_emp_lname = dw_emp.object.emp_lname[li_row]
	end if
end if

// Display help message on screen
If Len(ls_emp_fname + ls_emp_lname) > 0 Then
	st_message.text = 'Drop here to terminate ' + ls_emp_fname + ' ' + ls_emp_lname
End If


end event

on dragleave;// clear out the message at the bottom of the window

st_message.text = ''
end on

type p_onleave from picture within w_change_emp_status
int X=101
int Y=1169
int Width=170
int Height=149
int TabOrder=20
string PictureName="beach.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

event dragdrop;//////////////////////////////////////////////////////////////////////
//
// The 'on leave' picture has been dropped on; change the message to 
// 'on leave', reset the status column and update the database. 
//
//////////////////////////////////////////////////////////////////////

DragObject	ldo_control
int			li_row

//Get the dragged object
ldo_control = DraggedObject()

// if user is dragging from the employee list, retrieve the 
// employee detail first
if ldo_control = dw_emp then
	li_row = dw_emp.GetRow()
	if li_row > 0 then
		if dw_one_emp.Retrieve (dw_emp.object.emp_id[li_row]) < 1 then return
	else
		return
	end if
end if

dw_one_emp.object.status_message.text = "~"Employee is on leave~""
dw_one_emp.object.status[1] = 'L'
if dw_one_emp.Update() = -1 then
	rollback;
	MessageBox ('Update Failed!', 'Update could not be performed.')
end if

st_message.text = ''
ib_changed = true
end event

on dragleave;// clear out the message at the bottom of the window

st_message.text = ''
end on

event dragenter;//////////////////////////////////////////////////////////////////////
// display help message
//////////////////////////////////////////////////////////////////////

DragObject	ldo_control
int			li_row
string		ls_emp_fname
string		ls_emp_lname

//Get the dragged object
ldo_control = DraggedObject()

if ldo_control = dw_one_emp then
	// The dragged object is from the Single record employee datawindow
	ls_emp_fname = dw_one_emp.object.emp_fname[1]
	ls_emp_lname = dw_one_emp.object.emp_lname[1]
else
	// The dragged object is from the Multiple record employee datawindow
	li_row = dw_emp.GetRow()
	if li_row > 0 then
		ls_emp_fname = dw_emp.object.emp_fname[li_row]
		ls_emp_lname = dw_emp.object.emp_lname[li_row]
	end if
end if

// Display help message on screen
If Len(ls_emp_fname + ls_emp_lname) > 0 Then
	st_message.text = 'Drop ' + ls_emp_fname + ' ' + ls_emp_lname + &
							' here to set his/her status to "on leave".'
End If


end event

type p_active from picture within w_change_emp_status
int X=101
int Y=981
int Width=170
int Height=149
int TabOrder=10
string PictureName="update.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

event dragdrop;//////////////////////////////////////////////////////////////////////
// The active picture has been dropped on; change the message to 
// 'Active', reset the status column and update the database. 
//////////////////////////////////////////////////////////////////////

DragObject	ldo_control
int			li_row


//Get the dragged object
ldo_control = DraggedObject()

// if user is dragging from the employee list, retrieve the 
// employee detail first
if ldo_control = dw_emp then
	li_row = dw_emp.GetRow()
	if li_row > 0 then
		if dw_one_emp.Retrieve (dw_emp.object.emp_id[li_row]) < 1 then return
	else
		return
	end if
end if

dw_one_emp.object.status_message.text = "~"Employee is in good standing~""
dw_one_emp.object.status[1] = 'A'
if dw_one_emp.Update() = -1 then
	rollback;
	MessageBox ('Update Failed!', 'Update could not be performed.')
end if

st_message.text =""
ib_changed = true

end event

event dragenter;//////////////////////////////////////////////////////////////////////
// display help message
//////////////////////////////////////////////////////////////////////

DragObject	ldo_control
int			li_row
string		ls_emp_fname
string		ls_emp_lname

//Get the dragged object
ldo_control = DraggedObject()

if ldo_control = dw_one_emp then
	// The dragged object is from the Single record employee datawindow
	ls_emp_fname = dw_one_emp.object.emp_fname[1]
	ls_emp_lname = dw_one_emp.object.emp_lname[1]
else
	// The dragged object is from the Multiple record employee datawindow
	li_row = dw_emp.GetRow()
	if li_row > 0 then
		ls_emp_fname = dw_emp.object.emp_fname[li_row]
		ls_emp_lname = dw_emp.object.emp_lname[li_row]
	end if
end if

// Display help message on screen
If Len(ls_emp_fname + ls_emp_lname) > 0 Then
	st_message.text = 'Drop ' + ls_emp_fname + ' ' + ls_emp_lname + &
							' here to set his/her status to active.'
End If


end event

event dragleave;// clear out the message at the bottom of the window
st_message.text = ''
end event

type gb_1 from groupbox within w_change_emp_status
int X=65
int Y=901
int Width=577
int Height=629
int TabOrder=50
string Text="Actions"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

