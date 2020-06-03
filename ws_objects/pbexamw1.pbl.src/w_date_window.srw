$PBExportHeader$w_date_window.srw
$PBExportComments$Window for Year 2000 window example
forward
global type w_date_window from w_center
end type
type cb_subtract from commandbutton within w_date_window
end type
type cb_add from commandbutton within w_date_window
end type
type st_6 from statictext within w_date_window
end type
type rb_year from radiobutton within w_date_window
end type
type rb_month from radiobutton within w_date_window
end type
type rb_day from radiobutton within w_date_window
end type
type mle_1 from multilineedit within w_date_window
end type
type st_3 from statictext within w_date_window
end type
type sle_1 from singlelineedit within w_date_window
end type
type em_1 from editmask within w_date_window
end type
type gb_2 from groupbox within w_date_window
end type
type gb_1 from groupbox within w_date_window
end type
type rb_1 from radiobutton within w_date_window
end type
type rb_2 from radiobutton within w_date_window
end type
type gb_3 from groupbox within w_date_window
end type
end forward

global type w_date_window from w_center
int X=5
int Y=4
int Width=1362
int Height=1340
boolean TitleBar=true
string Title="Year 2000 Window Example"
long BackColor=80242744
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_subtract cb_subtract
cb_add cb_add
st_6 st_6
rb_year rb_year
rb_month rb_month
rb_day rb_day
mle_1 mle_1
st_3 st_3
sle_1 sle_1
em_1 em_1
gb_2 gb_2
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
gb_3 gb_3
end type
global w_date_window w_date_window

type variables
Boolean	ib_LongDate = False, &
	ib_LastYear = False, &
	ib_Mod = False
Date	id_Date
Integer	ii_Day, ii_Month, ii_Year


end variables

forward prototypes
public function boolean of_is_leap_year (integer ai_year)
public subroutine of_days ()
public subroutine of_mod ()
public subroutine of_initialize ()
public subroutine of_update ()
end prototypes

public function boolean of_is_leap_year (integer ai_year);//	The year is a leap year if it is divisible by 4, but not by 100, unless it is also divisible by 400
If ((Mod(ai_Year, 4) = 0 And Mod(ai_Year,100) <> 0) Or (Mod(ai_Year,400) = 0)) Then
	Return True
Else
	Return False
End If

end function

public subroutine of_days ();Choose Case ii_Month
	Case 09, 04, 06, 11
		If ii_Day > 30 Then
			ii_Day = 30
		End If
	Case 02
		If ii_Day > 28 Then
			If of_is_leap_year(ii_Year) Then 
				ii_Day = 29
			Else
				ii_Day = 28
			End If
		End If
End Choose

end subroutine

public subroutine of_mod ();If Not ib_Mod Then
	MessageBox("Date Test", "If no date is entered, today's date will be used", Information!)
	id_Date = Today()
	em_1.Text = String(id_Date, "mm/dd/yy")
	ib_Mod = True
End If

end subroutine

public subroutine of_initialize ();of_mod()

ii_Month = Month(id_Date)
ii_Year = Year(id_Date)
ii_Day = Day(id_Date)

end subroutine

public subroutine of_update ();//updates the edit mask and sle control
String	ls_Date

ls_Date = String(ii_Year) + "/" + String(ii_Month)  + "/" + String(ii_Day)
id_Date = Date(ls_Date)

em_1.Text = String(id_Date)
If ib_LongDate Then
	sle_1.Text = String(id_Date, "dddd, mmmm dd, yyyy")
Else
	sle_1.Text = String(id_Date, "mm/dd/yyyy")
End If

end subroutine

on w_date_window.create
this.cb_subtract=create cb_subtract
this.cb_add=create cb_add
this.st_6=create st_6
this.rb_year=create rb_year
this.rb_month=create rb_month
this.rb_day=create rb_day
this.mle_1=create mle_1
this.st_3=create st_3
this.sle_1=create sle_1
this.em_1=create em_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.gb_3=create gb_3
this.Control[]={this.cb_subtract,&
this.cb_add,&
this.st_6,&
this.rb_year,&
this.rb_month,&
this.rb_day,&
this.mle_1,&
this.st_3,&
this.sle_1,&
this.em_1,&
this.gb_2,&
this.gb_1,&
this.rb_1,&
this.rb_2,&
this.gb_3}
end on

on w_date_window.destroy
destroy(this.cb_subtract)
destroy(this.cb_add)
destroy(this.st_6)
destroy(this.rb_year)
destroy(this.rb_month)
destroy(this.rb_day)
destroy(this.mle_1)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.em_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.gb_3)
end on

event open;call super::open;SetNull(id_Date)

end event

type cb_subtract from commandbutton within w_date_window
int X=878
int Y=992
int Width=297
int Height=108
int TabOrder=60
string Text="Subtract"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_initialize()

If rb_day.Checked Then
	// subtract a day
	id_Date = RelativeDate(id_Date, -1)
	ii_Day = Day(id_Date)
	ii_Month = Month(id_Date)
	ii_Year = Year(id_Date)
Else
	If rb_month.Checked Then
		// subtract a month
		If ii_Month = 1 Then
			ii_Year --
			ii_Month = 12
		Else
			ii_Month --
			of_days()
		End If
	Else
		If rb_year.Checked Then
			// subtract a year
			ii_Year --
			of_days()	
		End If
	End If
End If

of_update()

end event

type cb_add from commandbutton within w_date_window
int X=878
int Y=848
int Width=297
int Height=108
int TabOrder=50
string Text="Add"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_initialize()

If rb_day.Checked Then
	// add a day
	id_Date = RelativeDate(id_Date, 1)
	ii_Day = Day(id_Date)
	ii_Month = Month(id_Date)
	ii_Year = Year(id_Date)
Else
	If rb_month.Checked Then
		// add a month
		If ii_Month = 12 Then
			ii_Year ++
			ii_Month = 1
		Else
			ii_Month ++
			of_days()
		End If
	Else
		If rb_year.Checked Then
			// add a year
			ii_Year ++
			of_days()	
		End If
	End If
End If

of_update()

end event

type st_6 from statictext within w_date_window
int X=146
int Y=760
int Width=814
int Height=72
boolean Enabled=false
string Text="Changes the date used above"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_year from radiobutton within w_date_window
int X=210
int Y=1000
int Width=430
int Height=64
string Text="Year"
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_month from radiobutton within w_date_window
int X=210
int Y=932
int Width=430
int Height=64
string Text="Month"
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_day from radiobutton within w_date_window
int X=210
int Y=864
int Width=466
int Height=64
string Text="Day"
boolean Checked=true
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_1 from multilineedit within w_date_window
int Y=24
int Width=1024
int Height=64
boolean Border=false
string Text="Enter any date into this Date format edit mask:"
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_date_window
int Y=468
int Width=535
int Height=76
boolean Enabled=false
string Text="Resulting date display:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_date_window
int X=110
int Y=556
int Width=1102
int Height=92
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_date_window
int X=110
int Y=92
int Width=256
int Height=80
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;ib_Mod = True
id_Date = Date(em_1.Text)

end event

type gb_2 from groupbox within w_date_window
int X=105
int Y=688
int Width=1106
int Height=460
int TabOrder=40
string Text="Date Arithmetic"
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_date_window
int X=1184
int Y=236
int Width=827
int Height=268
int TabOrder=20
boolean Visible=false
string Text="none"
long TextColor=12632256
long BackColor=16777215
int TextSize=-11
int Weight=700
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_date_window
int X=155
int Y=252
int Width=430
int Height=76
boolean BringToTop=true
string Text="mm/dd/yyyy"
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_mod()

sle_1.Text = String(id_Date, "mm/dd/yyyy")
ib_LongDate = False

end event

type rb_2 from radiobutton within w_date_window
int X=155
int Y=324
int Width=585
int Height=76
boolean BringToTop=true
string Text="dddd/mmmm d, yyyy"
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_mod()

sle_1.Text = String(id_Date, "dddd, mmmm d, yyyy")
ib_LongDate = True

end event

type gb_3 from groupbox within w_date_window
int X=110
int Y=196
int Width=690
int Height=240
int TabOrder=30
string Text="Display Format:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

