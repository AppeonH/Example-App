$PBExportHeader$w_dynsql_format3.srw
$PBExportComments$Dynamic SQL Format 3 Example
forward
global type w_dynsql_format3 from w_center
end type
type st_2 from statictext within w_dynsql_format3
end type
type st_1 from statictext within w_dynsql_format3
end type
type lb_employee from listbox within w_dynsql_format3
end type
type lb_dept from listbox within w_dynsql_format3
end type
end forward

global type w_dynsql_format3 from w_center
int X=644
int Y=529
int Width=1615
int Height=916
boolean TitleBar=true
string Title="Dynamic SQL: Format 3"
string MenuName="m_dynsql_format3"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_open pbm_custom01
st_2 st_2
st_1 st_1
lb_employee lb_employee
lb_dept lb_dept
end type
global w_dynsql_format3 w_dynsql_format3

on ue_open;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Use format 3 of dynamic sql to populate a listbox with manager names
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string				ls_sql, &
					ls_dept_name
m_dynsql_frame		lm_menuid



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Associate the dynamic staging area with a dynamic cursor
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
declare lc_dept dynamic cursor for sqlsa;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Prepare the dynamic staging area with an SQL statement
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ls_sql = "select dept_name from department"
prepare sqlsa from :ls_sql;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Open the dynamic cursor
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
open dynamic lc_dept;
if sqlca.sqlcode = -1 then
	MessageBox ("Error", string (sqlca.sqldbcode) + ":  " + sqlca.sqlerrtext)
	close lc_dept;	
	return
end if


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Fetch rows, adding them to the manager ListBox
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
do while sqlca.sqlcode = 0
	fetch lc_dept into :ls_dept_name;
	if sqlca.sqlcode = 0 then
		lb_dept.AddItem (ls_dept_name)
	end if
loop
	

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Close the dynamic cursor
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
close lc_dept;
end on

on w_dynsql_format3.create
if this.MenuName = "m_dynsql_format3" then this.MenuID = create m_dynsql_format3
this.st_2=create st_2
this.st_1=create st_1
this.lb_employee=create lb_employee
this.lb_dept=create lb_dept
this.Control[]={ this.st_2,&
this.st_1,&
this.lb_employee,&
this.lb_dept}
end on

on w_dynsql_format3.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.lb_employee)
destroy(this.lb_dept)
end on

on open;this.PostEvent ("ue_open")
end on

type st_2 from statictext within w_dynsql_format3
int X=833
int Y=55
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

type st_1 from statictext within w_dynsql_format3
int X=75
int Y=55
int Width=331
int Height=71
boolean Enabled=false
string Text="Department:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_employee from listbox within w_dynsql_format3
int X=833
int Y=135
int Width=683
int Height=545
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_dept from listbox within w_dynsql_format3
int X=72
int Y=135
int Width=683
int Height=545
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on selectionchanged;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Use format 3 of dynamic sql to retrieve the employees for the current department
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string				ls_sql, &
					ls_emp_namef, ls_emp_namel, &
					ls_dept_name
window				lw_frame


ls_dept_name = this.SelectedItem()
lb_employee.Reset()

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Associate the dynamic staging area with a dynamic cursor
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
declare lc_emp dynamic cursor for sqlsa;


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Prepare the dynamic staging area with an SQL statement
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ls_sql = "select emp_lname, emp_fname from employee e, department d " + &
		" where d.dept_name = ? and d.dept_id = e.dept_id"
prepare sqlsa from :ls_sql;

// Set microhelp to display the sql statement
lw_frame = parent.ParentWindow()
if IsValid (lw_frame) then
	lw_frame.SetMicroHelp ("Dynamic SQL statement: " + ls_sql)
end if


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Open the dynamic cursor
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
open dynamic lc_emp using :ls_dept_name;
if sqlca.sqlcode = -1 then
	MessageBox ("Error", string (sqlca.sqldbcode) + ":  " + sqlca.sqlerrtext)
	close lc_emp;	
	return
end if


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Fetch rows, adding them to the employees ListBox
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
do while sqlca.sqlcode = 0
	fetch lc_emp into :ls_emp_namel, :ls_emp_namef ;
	if sqlca.sqlcode = 0 then
		lb_employee.AddItem (ls_emp_namel + ", " + ls_emp_namef)
	end if
loop
	

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Close the dynamic cursor
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
close lc_emp;
end on

