$PBExportHeader$w_update_trigger.srw
$PBExportComments$Demonstrates a trigger defined to update the employee table when the department table changes.
forward
global type w_update_trigger from w_center
end type
type st_trig2 from statictext within w_update_trigger
end type
type st_trig1 from statictext within w_update_trigger
end type
type cb_help from commandbutton within w_update_trigger
end type
type cb_close from commandbutton within w_update_trigger
end type
type cb_update from commandbutton within w_update_trigger
end type
type st_2 from statictext within w_update_trigger
end type
type st_1 from statictext within w_update_trigger
end type
type dw_emp from datawindow within w_update_trigger
end type
type dw_dept from datawindow within w_update_trigger
end type
type ln_1a from line within w_update_trigger
end type
type ln_1b from line within w_update_trigger
end type
type ln_1c from line within w_update_trigger
end type
type ln_2a from line within w_update_trigger
end type
type ln_2b from line within w_update_trigger
end type
type ln_2c from line within w_update_trigger
end type
end forward

global type w_update_trigger from w_center
int X=459
int Y=100
int Width=1999
int Height=1729
boolean TitleBar=true
string Title="Update Trigger"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_open pbm_custom01
st_trig2 st_trig2
st_trig1 st_trig1
cb_help cb_help
cb_close cb_close
cb_update cb_update
st_2 st_2
st_1 st_1
dw_emp dw_emp
dw_dept dw_dept
ln_1a ln_1a
ln_1b ln_1b
ln_1c ln_1c
ln_2a ln_2a
ln_2b ln_2b
ln_2c ln_2c
end type
global w_update_trigger w_update_trigger

type variables

end variables

event ue_open;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_open script for w_update_trigger
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Set commit option to ON
execute immediate "set option wait_for_commit = on";

//Set transaction objects
dw_dept.SetTransObject (SQLCA)
dw_emp.SetTransObject (SQLCA)

//Retrive the department datawindow
dw_dept.Retrieve()
end event

on w_update_trigger.create
this.st_trig2=create st_trig2
this.st_trig1=create st_trig1
this.cb_help=create cb_help
this.cb_close=create cb_close
this.cb_update=create cb_update
this.st_2=create st_2
this.st_1=create st_1
this.dw_emp=create dw_emp
this.dw_dept=create dw_dept
this.ln_1a=create ln_1a
this.ln_1b=create ln_1b
this.ln_1c=create ln_1c
this.ln_2a=create ln_2a
this.ln_2b=create ln_2b
this.ln_2c=create ln_2c
this.Control[]={ this.st_trig2,&
this.st_trig1,&
this.cb_help,&
this.cb_close,&
this.cb_update,&
this.st_2,&
this.st_1,&
this.dw_emp,&
this.dw_dept,&
this.ln_1a,&
this.ln_1b,&
this.ln_1c,&
this.ln_2a,&
this.ln_2b,&
this.ln_2c}
end on

on w_update_trigger.destroy
destroy(this.st_trig2)
destroy(this.st_trig1)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_emp)
destroy(this.dw_dept)
destroy(this.ln_1a)
destroy(this.ln_1b)
destroy(this.ln_1c)
destroy(this.ln_2a)
destroy(this.ln_2b)
destroy(this.ln_2c)
end on

event close;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_update_trigger
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Set commit option to OFF
execute immediate "set option wait_for_commit = off";

w_main.Show()
end event

event open;call super::open;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_update_trigger
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// To allow window to open faster, postevent to perform open operations
this.PostEvent ("ue_open")
end event

type st_trig2 from statictext within w_update_trigger
int X=385
int Y=708
int Width=904
int Height=71
boolean Enabled=false
string Text="the employee table"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8421504
long BackColor=74481808
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_trig1 from statictext within w_update_trigger
int X=385
int Y=653
int Width=904
int Height=71
boolean Enabled=false
string Text="Trigger will automatically update"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8421504
long BackColor=74481808
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_help from commandbutton within w_update_trigger
int X=1672
int Y=292
int Width=249
int Height=100
int TabOrder=50
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_help
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

f_open_help (parent.ClassName())
end event

type cb_close from commandbutton within w_update_trigger
int X=1672
int Y=161
int Width=249
int Height=100
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_close
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

close (parent)
end event

type cb_update from commandbutton within w_update_trigger
int X=1672
int Y=45
int Width=249
int Height=100
int TabOrder=30
boolean Enabled=false
string Text="&Update"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_update
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Update the departments DataWindow.  A trigger will fire that will automatically update the
// employees DataWindow.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long	ll_cur_row, ll_dep_id, ll_Gray


if dw_dept.Update() = 1 then
	commit;
	if sqlca.sqlcode <> 0 then
		messagebox("Error " + String (SQLCA.SQLDBCode), SQLCA.SQLErrText)
		return
	end if

	// Since we want to show the effects that the trigger had on the employee table, re-retrieve the
	// employees DataWindow.

	ll_cur_row = dw_dept.GetRow()
	if ll_cur_row > 0 then
		ll_dep_id = dw_dept.Object.dept_id[ll_cur_row]
		dw_emp.Retrieve (ll_dep_id)
	end if

else
	rollback;
end if


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Disable the update button and grey out the trigger help text
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

// Disable the update button
this.enabled = false

// Change back to gray
ll_Gray = RGB(128, 128, 128)
st_trig1.TextColor = ll_Gray
st_trig2.TextColor = ll_Gray

// Change arrows
ln_1a.LineColor = ll_Gray
ln_1b.LineColor = ll_Gray
ln_1c.LineColor = ll_Gray
ln_2a.LineColor = ll_Gray
ln_2b.LineColor = ll_Gray
ln_2c.LineColor = ll_Gray

end event

type st_2 from statictext within w_update_trigger
int X=57
int Y=823
int Width=310
int Height=71
boolean Enabled=false
string Text="Employees:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_update_trigger
int X=57
int Y=49
int Width=363
int Height=71
boolean Enabled=false
string Text="Departments:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_emp from datawindow within w_update_trigger
int X=57
int Y=900
int Width=1554
int Height=644
int TabOrder=20
string DataObject="d_emp_managed_by"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_dept from datawindow within w_update_trigger
int X=57
int Y=125
int Width=1554
int Height=452
int TabOrder=10
string DataObject="d_departments"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event rowfocuschanged;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// rowfocuschanged script for dw_dept
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Retrieve the employees for the current department
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

long 	ll_dept_id

If currentrow > 0 then
	ll_dept_id = this.Object.dept_id[currentrow]
	dw_emp.Retrieve (ll_dept_id)
End If
end event

event editchanged;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// editchanged script for dw_dept
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// When data changes, enable the update button and change color of trigger help text
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Long		ll_Blue

// Enable update button
cb_update.enabled = true

// Bright blue color
ll_Blue = RGB(0, 0, 255)
st_trig1.TextColor = ll_Blue
st_trig2.TextColor = ll_Blue

// Blue arrows
ln_1a.LineColor = ll_Blue
ln_1b.LineColor = ll_Blue
ln_1c.LineColor = ll_Blue
ln_2a.LineColor = ll_Blue
ln_2b.LineColor = ll_Blue
ln_2c.LineColor = ll_Blue

end event

event itemchanged;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// itemchanged script for dw_dept
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Long		ll_Blue

// Enable update button
cb_update.enabled = true

// Bright blue color
ll_Blue = RGB(0, 0, 255)
st_trig1.TextColor = ll_Blue
st_trig2.TextColor = ll_Blue

// Blue arrows
ln_1a.LineColor = ll_Blue
ln_1b.LineColor = ll_Blue
ln_1c.LineColor = ll_Blue
ln_2a.LineColor = ll_Blue
ln_2b.LineColor = ll_Blue
ln_2c.LineColor = ll_Blue

end event

type ln_1a from line within w_update_trigger
boolean Enabled=false
int BeginX=331
int BeginY=637
int EndX=331
int EndY=769
int LineThickness=13
long LineColor=8421504
end type

type ln_1b from line within w_update_trigger
boolean Enabled=false
int BeginX=303
int BeginY=711
int EndX=328
int EndY=769
int LineThickness=10
long LineColor=8421504
end type

type ln_1c from line within w_update_trigger
boolean Enabled=false
int BeginX=356
int BeginY=711
int EndX=331
int EndY=769
int LineThickness=10
long LineColor=8421504
end type

type ln_2a from line within w_update_trigger
boolean Enabled=false
int BeginX=1334
int BeginY=637
int EndX=1334
int EndY=769
int LineThickness=13
long LineColor=8421504
end type

type ln_2b from line within w_update_trigger
boolean Enabled=false
int BeginX=1305
int BeginY=711
int EndX=1330
int EndY=769
int LineThickness=10
long LineColor=8421504
end type

type ln_2c from line within w_update_trigger
boolean Enabled=false
int BeginX=1359
int BeginY=711
int EndX=1334
int EndY=769
int LineThickness=10
long LineColor=8421504
end type

