$PBExportHeader$w_date_functions.srw
$PBExportComments$Enter a day name/date combination to check if the date entered is valid for the day name entered.
forward
global type w_date_functions from w_center
end type
type cb_help from commandbutton within w_date_functions
end type
type st_1 from statictext within w_date_functions
end type
type st_3 from statictext within w_date_functions
end type
type st_2 from statictext within w_date_functions
end type
type dw_1 from datawindow within w_date_functions
end type
type cb_ok from commandbutton within w_date_functions
end type
type cb_cancel from commandbutton within w_date_functions
end type
type gb_1 from groupbox within w_date_functions
end type
end forward

global type w_date_functions from w_center
int X=523
int Y=503
int Width=1885
int Height=935
boolean TitleBar=true
string Title="Date Functions"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_help cb_help
st_1 st_1
st_3 st_3
st_2 st_2
dw_1 dw_1
cb_ok cb_ok
cb_cancel cb_cancel
gb_1 gb_1
end type
global w_date_functions w_date_functions

event open;call super::open;/////////////////////////////////////////////////////////////////////
// initialize datawindow, set test date default as current date
/////////////////////////////////////////////////////////////////////

dw_1.InsertRow (0)
dw_1.Object.test_date[1] = Today()
end event

on close;w_main.Show()
end on

on w_date_functions.create
this.cb_help=create cb_help
this.st_1=create st_1
this.st_3=create st_3
this.st_2=create st_2
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.gb_1=create gb_1
this.Control[]={ this.cb_help,&
this.st_1,&
this.st_3,&
this.st_2,&
this.dw_1,&
this.cb_ok,&
this.cb_cancel,&
this.gb_1}
end on

on w_date_functions.destroy
destroy(this.cb_help)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.gb_1)
end on

type cb_help from commandbutton within w_date_functions
int X=1561
int Y=260
int Width=246
int Height=100
int TabOrder=40
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help (parent.ClassName())
end on

type st_1 from statictext within w_date_functions
int X=82
int Y=461
int Width=1643
int Height=71
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_date_functions
int X=82
int Y=628
int Width=1665
int Height=71
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_date_functions
int X=82
int Y=561
int Width=1665
int Height=71
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from datawindow within w_date_functions
int X=43
int Y=49
int Width=1003
int Height=247
int TabOrder=10
string DataObject="d_date_functions"
boolean Border=false
end type

type cb_ok from commandbutton within w_date_functions
int X=1561
int Y=23
int Width=246
int Height=100
int TabOrder=20
string Text="Test"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////
// Purpose:  Determine whether the specified test date is valid for
//				 the specified day name.  Display information as to
//				 whether the date is valid or invalid.  
////////////////////////////////////////////////////////////////////

date		ld_testdate, &
			ld_closest
string	ls_dayname, &
			ls_when
long		ll_days


/////////////////////////////////////////////////////////////////////
// Check if both columns have been entered on the datawindow
/////////////////////////////////////////////////////////////////////
if dw_1.AcceptText() = -1 then
	return
end if


/////////////////////////////////////////////////////////////////////
// Get the data
/////////////////////////////////////////////////////////////////////
ls_dayname = dw_1.Object.day_name[1]
ld_testdate = dw_1.Object.test_date[1]


/////////////////////////////////////////////////////////////////////
// call the check_dayname function to determine whether the test date
// is valid for the day name.
/////////////////////////////////////////////////////////////////////
if f_check_dayname (ls_dayname, ld_testdate) then
	// Display message to show that test date is valid for day name
	st_1.text = 'Yes, ' + String (ld_testdate, 'mm/dd/yy') + ' is a ' + ls_dayname + '!'
	st_2.text = ''
	st_3.text = ''
else
	st_1.text = 'No, ' + String (ld_testdate, 'mm/dd/yy') + ' is a ' + &
					DayName (ld_testdate) + '.'

	// Determine which date is the closest [dayname] to [testdate]
	ld_closest = f_closest_date (ls_dayname, ld_testdate)
	st_2.text = 'The closest ' + ls_dayname + ' to ' + &
					String (ld_testdate, 'mm/dd/yy') + ' is ' + String (ld_closest, 'mmmm dd, yyyy')

	// Determine the relative number of days from closest date to test date
	ll_days = DaysAfter (ld_testdate, ld_closest)
	if ll_days > 0 then
		ls_when = ' after '
	else
		ls_when = ' before '
	end if
	st_3.text = 'which occurs ' + String (Abs (ll_days)) + ' days' + &
					ls_when + String (ld_testdate, 'mm/dd/yy') + '.'
end if



end event

type cb_cancel from commandbutton within w_date_functions
int X=1561
int Y=135
int Width=246
int Height=100
int TabOrder=30
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close (parent)
end on

type gb_1 from groupbox within w_date_functions
int X=43
int Y=369
int Width=1764
int Height=413
string Text="Date Information"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

