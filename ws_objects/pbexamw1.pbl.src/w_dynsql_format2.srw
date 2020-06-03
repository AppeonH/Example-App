$PBExportHeader$w_dynsql_format2.srw
$PBExportComments$Dynamic SQL: Format 2 example
forward
global type w_dynsql_format2 from w_center
end type
type st_1 from statictext within w_dynsql_format2
end type
type cbx_life from checkbox within w_dynsql_format2
end type
type cbx_health from checkbox within w_dynsql_format2
end type
type dw_manager from datawindow within w_dynsql_format2
end type
type dw_emp from datawindow within w_dynsql_format2
end type
type dw_dept from datawindow within w_dynsql_format2
end type
type gb_1 from groupbox within w_dynsql_format2
end type
end forward

global type w_dynsql_format2 from w_center
int X=249
int Y=308
int Width=2440
int Height=1319
boolean TitleBar=true
string Title="Dynamic SQL: Format 2 Example"
string MenuName="m_dynsql_format2"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_execute pbm_custom01
event ue_open pbm_custom02
st_1 st_1
cbx_life cbx_life
cbx_health cbx_health
dw_manager dw_manager
dw_emp dw_emp
dw_dept dw_dept
gb_1 gb_1
end type
global w_dynsql_format2 w_dynsql_format2

type variables

end variables

event ue_execute;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Update the database using Format 2 of Dynamic SQL
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string	ls_sql
int		li_manager_id, &
		li_dept_id
window	lw_frame


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Obtain input parameter for dynamic SQL statement
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_dept.AcceptText()
li_dept_id = dw_dept.object.dept_id[1]
if IsNull (li_dept_id) then
	MessageBox ("", "Please choose a department first")
	return
end if


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Build update syntax from the columns that were selected to be updated
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ls_sql = "update employee set "

// Manager ID
dw_manager.AcceptText()
li_manager_id = dw_manager.object.manager_id[1]
if not IsNull (li_manager_id) then
	ls_sql = ls_sql + "manager_id = " + String (li_manager_id) + ", "
end if

// Health Insurance
if cbx_health.checked then
	ls_sql = ls_sql + "bene_health_ins = 'Y', "
else
	ls_sql = ls_sql + "bene_health_ins = 'N', "
end if

// Life Insurance
if cbx_life.checked then
	ls_sql = ls_sql + "bene_life_ins = 'Y', "
else
	ls_sql = ls_sql + "bene_life_ins = 'N', "
end if

// Strip off the unnecessary comma
ls_sql = Left (ls_sql, Len (ls_sql) - 2)

// Add "where" clause for department that was chosen
ls_sql = ls_sql + " where dept_id = ?" 


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Show the dynamic SQL statement in the microhelp
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
lw_frame = this.ParentWindow()
if IsValid (lw_frame) then
	lw_frame.SetMicroHelp ("Dynamic SQL Statement:  " + ls_sql)
end if


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Prepare and execute the SQL statement
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
prepare SQLSA from :ls_sql;
execute SQLSA using :li_dept_id;

if sqlca.sqlcode = -1 then
	MessageBox ("Error", String (sqlca.sqldbcode) + ":  " + sqlca.sqlerrtext)
end if


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Re-retrieve the employee DataWindow so changes made to the database are shown
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_emp.Retrieve (li_dept_id)
end event

on ue_open;DataWindowChild	ldw_dept, &
					ldw_manager


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Obtain handles to child DataWindows
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_dept.GetChild ("dept_id", ldw_dept)
dw_manager.GetChild ("manager_id", ldw_manager)


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set transaction objects
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_emp.SetTransObject (sqlca)
ldw_dept.SetTransObject (sqlca)
ldw_manager.SetTransObject (sqlca)


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Retreive child DataWindows
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ldw_dept.Retrieve()
ldw_manager.Retrieve()


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Insert row for external source DataWindows
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_dept.InsertRow (0)
dw_manager.InsertRow (0)

end on

on w_dynsql_format2.create
if this.MenuName = "m_dynsql_format2" then this.MenuID = create m_dynsql_format2
this.st_1=create st_1
this.cbx_life=create cbx_life
this.cbx_health=create cbx_health
this.dw_manager=create dw_manager
this.dw_emp=create dw_emp
this.dw_dept=create dw_dept
this.gb_1=create gb_1
this.Control[]={ this.st_1,&
this.cbx_life,&
this.cbx_health,&
this.dw_manager,&
this.dw_emp,&
this.dw_dept,&
this.gb_1}
end on

on w_dynsql_format2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.cbx_life)
destroy(this.cbx_health)
destroy(this.dw_manager)
destroy(this.dw_emp)
destroy(this.dw_dept)
destroy(this.gb_1)
end on

on open;this.PostEvent ("ue_open")
end on

type st_1 from statictext within w_dynsql_format2
int X=47
int Y=49
int Width=289
int Height=65
boolean Enabled=false
string Text="Department:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_life from checkbox within w_dynsql_format2
int X=1110
int Y=961
int Width=452
int Height=71
int TabOrder=60
string Text="Life Insurance"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_health from checkbox within w_dynsql_format2
int X=1110
int Y=865
int Width=520
int Height=71
int TabOrder=50
string Text="Health Insurance"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_manager from datawindow within w_dynsql_format2
int X=72
int Y=865
int Width=865
int Height=100
int TabOrder=40
string DataObject="d_choose_manager"
boolean Border=false
end type

type dw_emp from datawindow within w_dynsql_format2
int X=36
int Y=161
int Width=2322
int Height=471
int TabOrder=20
string DataObject="d_employee_dept_listing"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_dept from datawindow within w_dynsql_format2
int X=328
int Y=39
int Width=726
int Height=103
int TabOrder=10
string DataObject="d_choose_department"
boolean Border=false
end type

event itemchanged;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// When a department is selected, retrieve the employees for that department
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string	ls_dept_id
int		li_null
SetNull (li_null)


ls_dept_id = this.GetText()
dw_emp.Retrieve (Integer (ls_dept_id))

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Clear out the manager name and insurance benefits from the update group
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_manager.object.manager_id[1] = li_null

cbx_health.checked = false
cbx_life.checked = false

end event

type gb_1 from groupbox within w_dynsql_format2
int X=36
int Y=775
int Width=1796
int Height=311
int TabOrder=30
string Text="Update all Employees"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

