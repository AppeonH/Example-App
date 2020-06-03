$PBExportHeader$w_print_employee_roster.srw
$PBExportComments$Produces printed report with control breaks; demonstatrates use of several print functions
forward
global type w_print_employee_roster from w_center
end type
type st_2 from statictext within w_print_employee_roster
end type
type st_1 from statictext within w_print_employee_roster
end type
type st_rows from statictext within w_print_employee_roster
end type
type cb_close from commandbutton within w_print_employee_roster
end type
type dw_employee_roster from datawindow within w_print_employee_roster
end type
type st_please_wait from statictext within w_print_employee_roster
end type
type cb_pr_setup from commandbutton within w_print_employee_roster
end type
type cb_print from commandbutton within w_print_employee_roster
end type
type cb_retrieve from commandbutton within w_print_employee_roster
end type
end forward

global type w_print_employee_roster from w_center
int X=196
int Y=301
int Width=2721
int Height=2026
boolean TitleBar=true
string Title="Printing DataWindows from a Script"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
st_2 st_2
st_1 st_1
st_rows st_rows
cb_close cb_close
dw_employee_roster dw_employee_roster
st_please_wait st_please_wait
cb_pr_setup cb_pr_setup
cb_print cb_print
cb_retrieve cb_retrieve
end type
global w_print_employee_roster w_print_employee_roster

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////////////////////
//Open script for w_print_employee_roster
////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_employee_roster.SetTransObject(sqlca)
end event

on w_print_employee_roster.create
this.st_2=create st_2
this.st_1=create st_1
this.st_rows=create st_rows
this.cb_close=create cb_close
this.dw_employee_roster=create dw_employee_roster
this.st_please_wait=create st_please_wait
this.cb_pr_setup=create cb_pr_setup
this.cb_print=create cb_print
this.cb_retrieve=create cb_retrieve
this.Control[]={ this.st_2,&
this.st_1,&
this.st_rows,&
this.cb_close,&
this.dw_employee_roster,&
this.st_please_wait,&
this.cb_pr_setup,&
this.cb_print,&
this.cb_retrieve}
end on

on w_print_employee_roster.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_rows)
destroy(this.cb_close)
destroy(this.dw_employee_roster)
destroy(this.st_please_wait)
destroy(this.cb_pr_setup)
destroy(this.cb_print)
destroy(this.cb_retrieve)
end on

event close;////////////////////////////////////////////////////////////////////////////////////////////////////////
//Close script for w_print_employee_roster
////////////////////////////////////////////////////////////////////////////////////////////////////////

this.Hide( )
w_main.Show( )
end event

type st_2 from statictext within w_print_employee_roster
int X=164
int Y=81
int Width=2450
int Height=71
boolean Enabled=false
string Text="Notice the names displayed in the lower left corner as each line is manually printed by the script."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_print_employee_roster
int X=164
int Y=7
int Width=2009
int Height=71
boolean Enabled=false
string Text="Click Retrieve to load the Datawindow.  Then hit the Print Button to begin printing."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_rows from statictext within w_print_employee_roster
int X=11
int Y=1713
int Width=626
int Height=129
Alignment Alignment=Center!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_print_employee_roster
int X=1928
int Y=1687
int Width=310
int Height=97
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//Clicked script for cb_close
////////////////////////////////////////////////////////////////////////////////////////////////////////

Close(parent)
end event

type dw_employee_roster from datawindow within w_print_employee_roster
int X=164
int Y=196
int Width=2358
int Height=1437
int TabOrder=10
string DataObject="d_employees_by_dept"
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_please_wait from statictext within w_print_employee_roster
int Y=1639
int Width=626
int Height=65
boolean Visible=false
string Text="Printing, please wait..."
Alignment Alignment=Center!
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="Helv"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_pr_setup from commandbutton within w_print_employee_roster
int X=1387
int Y=1687
int Width=481
int Height=97
int TabOrder=50
string Text="Printer &Setup..."
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//Clicked script for cb_pr_setup
////////////////////////////////////////////////////////////////////////////////////////////////////////

if PrintSetup( ) = -1 then
	MessageBox("Error!","PrintSetup Failed")
end if
end event

type cb_print from commandbutton within w_print_employee_roster
int X=1035
int Y=1687
int Width=310
int Height=97
int TabOrder=30
boolean Enabled=false
string Text="&Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//Clicked script for cb_print
////////////////////////////////////////////////////////////////////////////////////////////////////////

int			li_print_ret
int			li_current_dept, li_new_dept
int			li_font_height
long			ll_print_job
long			ll_dw_row, ll_max_row
string		ls_current_name
string		ls_font_facename

decimal{2}	lc_current_salary, lc_department_total_salary , lc_grand_total_salary

ll_max_row = dw_employee_roster.RowCount( )

// Open print job and assign job number
ll_print_job = PrintOpen( )				
if ll_print_job < 0 then
	MessageBox("Error in PrintOpen",ll_print_job,StopSign!)
	return
end if

st_please_wait.Show( )

// Define font #1 as Bold with default printer font 
ls_font_facename = "Arial"				// Change font to Arial
li_font_height = 0						// current height remains the same
li_print_ret = PrintDefineFont(ll_print_job,1, &
					ls_font_facename, &
					li_font_height,   &
					700,           &
					Default!,      &
					AnyFont!,      &
					False,         	/* Italic */	&
					False)				/* Underline */

// Define font #2 as Bold/Underline with default printer font 
li_print_ret = PrintDefineFont(ll_print_job,2, &
					ls_font_facename, &
					li_font_height,   &
					700,           &
					Default!,      &
					AnyFont!,      &
					False,         	/* Italic */	&
					True)					/* Underline */


// Initialize loop counter
ll_dw_row  = 1						

// Initialize grand total	
lc_grand_total_salary = 0.00			


////////////////////////////////////////////////////////////////////////////////////////////////////////
// Print Report Title and Current Date 
////////////////////////////////////////////////////////////////////////////////////////////////////////

// Set Bold font
li_print_ret = PrintSetFont(ll_print_job,1)		

li_print_ret = Print(ll_print_job, "Employee Compensation Report", 4500)

li_print_ret = Print(ll_print_job, String(Today( ),"mmmm d, yyyy"))

// Restore default font
li_print_ret = PrintSetFont(ll_print_job,0)		

// Print 2 blank lines
li_print_ret = Print(ll_print_job, " ")			
li_print_ret = Print(ll_print_job, " ")

do While ll_dw_row <= ll_max_row

	// Begin processing a Department 
	li_print_ret = PrintSetFont(ll_print_job,2)
	li_print_ret = Print(ll_print_job, 2200, "Department Number:  ", 1)

	li_current_dept = dw_employee_roster.Object.dept_id[ll_dw_row]
	li_print_ret = Print(ll_print_job, String(li_current_dept))

	// Restore default font
	li_print_ret = PrintSetFont(ll_print_job,0)	

	// Print a blank line
	li_print_ret = Print(ll_print_job," ")			

	// Begin loop for employees within this department 
	li_new_dept = li_current_dept
	lc_department_total_salary = 0.00			// Initialize group total
	Do While li_new_dept = li_current_dept

		// Concatenate Lastname, Firstname 
		string ls_fname, ls_lname
		ls_fname = dw_employee_roster.Object.emp_fname[ll_dw_row] 
		ls_lname = dw_employee_roster.Object.emp_lname[ll_dw_row]
		ls_current_name = ls_fname + ', ' + ls_lname

		//update status display
		st_rows.text = "Printing Employee:  " + ls_current_name

		lc_current_salary = dw_employee_roster.Object.salary[ll_dw_row]
		lc_department_total_salary = lc_department_total_salary + lc_current_salary
		li_print_ret = Print(ll_print_job, ls_current_name, 5000)
		li_print_ret = Print(ll_print_job, &
							f_right_adjust_dec(lc_current_salary,"$###,###"))
		ll_dw_row = ll_dw_row + 1
		if ll_dw_row > ll_max_row then exit
		li_new_dept = dw_employee_roster.Object.dept_id[ll_dw_row]
	loop	// Loop for employees within this department 

	li_print_ret = Print(ll_print_job, " ")
	li_print_ret = Print(ll_print_job, 3000, "Department total:", 5000)
		li_print_ret = Print(ll_print_job, &
							f_right_adjust_dec(lc_department_total_salary,"$###,###"))
	li_print_ret = Print(ll_print_job, " ")
	li_print_ret = Print(ll_print_job, " ")
	li_current_dept = li_new_dept
	lc_grand_total_salary = lc_grand_total_salary + lc_department_total_salary

loop	// Loop for each department 

// Now print grand total 
li_print_ret = Print(ll_print_job, " ")
li_print_ret = Print(ll_print_job, 3400, "Grand total:", 5000)
li_print_ret = Print(ll_print_job, &
					f_right_adjust_dec(lc_grand_total_salary,"$###,###"))

// Close print job
li_print_ret = PrintClose(ll_print_job)
if li_print_ret < 0 then
	MessageBox("Error on PrintClose", li_print_ret, StopSign!)
end if

st_please_wait.Hide( ) 
st_rows.text = ""

end event

type cb_retrieve from commandbutton within w_print_employee_roster
int X=658
int Y=1687
int Width=310
int Height=97
int TabOrder=20
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//Clicked script for cb_retrieve
////////////////////////////////////////////////////////////////////////////////////////////////////////

// Retrieve the employee data
dw_employee_roster.Retrieve( )

// Enable the print button
cb_print.enabled = true
end event

