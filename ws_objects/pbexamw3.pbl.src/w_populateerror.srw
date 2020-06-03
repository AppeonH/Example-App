$PBExportHeader$w_populateerror.srw
$PBExportComments$Window demonstrating the use of the PopulateError function
forward
global type w_populateerror from w_center
end type
type cb_help from commandbutton within w_populateerror
end type
type cb_close from commandbutton within w_populateerror
end type
type st_3 from statictext within w_populateerror
end type
type st_2 from statictext within w_populateerror
end type
type st_1 from statictext within w_populateerror
end type
type sle_date from singlelineedit within w_populateerror
end type
type sle_number from singlelineedit within w_populateerror
end type
type sle_letter from singlelineedit within w_populateerror
end type
type cb_validate from commandbutton within w_populateerror
end type
end forward

global type w_populateerror from w_center
int X=713
int Y=600
int Width=1669
int Height=960
boolean TitleBar=true
string Title="PopulateError"
long BackColor=80242744
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_help cb_help
cb_close cb_close
st_3 st_3
st_2 st_2
st_1 st_1
sle_date sle_date
sle_number sle_number
sle_letter sle_letter
cb_validate cb_validate
end type
global w_populateerror w_populateerror

type variables
Boolean	ib_Error = False
end variables

forward prototypes
public subroutine of_validate_letter ()
public subroutine of_validate_number ()
public subroutine of_validate_date ()
end prototypes

public subroutine of_validate_letter ();If Len(sle_letter.Text) <> 1 Then
	ib_Error = True
	PopulateError(1, "You must only enter one letter.")
	SignalError()
End If

If Not ((Lower(sle_letter.Text) >= "a") And (Lower(sle_letter.Text) <= "l")) Then
	ib_Error = True
	PopulateError(2, "The letter must be between 'A' and 'L'.")
	SignalError()
End If

end subroutine

public subroutine of_validate_number ();If Not IsNumber(sle_number.Text) Then
	ib_Error = True
	PopulateError(3, "The value entered is not a number.")
	SignalError()
End If

If (Integer(sle_number.Text) < 100) Or (Integer(sle_number.Text) > 1000) Then
	ib_Error = True
	PopulateError(4, "The number must be between 100 and 1000.")
	SignalError()
End If

end subroutine

public subroutine of_validate_date ();Date		ld_Today, ld_LastYear
Integer	li_Year, li_Month, li_Day

ld_Today = Today()
li_Year = Year(ld_Today)
li_Month = Month(ld_Today)
li_Day = Day(ld_Today)

ld_LastYear = Date(String(li_Year - 1) + "/" + String(li_Month) + "/" + String(li_Day))

If Not IsDate(sle_date.Text) Then
	ib_Error = True
	PopulateError(5, "The value entered is not a date.")
	SignalError()
End If

If (Date(sle_date.Text) < ld_LastYear) Or (Date(sle_date.Text) > ld_Today) Then
	ib_Error = True
	PopulateError(6, "The date must be between " + String(ld_LastYear) + " and " + String(ld_Today) + ".")
	SignalError()
End If

end subroutine

on w_populateerror.create
this.cb_help=create cb_help
this.cb_close=create cb_close
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_date=create sle_date
this.sle_number=create sle_number
this.sle_letter=create sle_letter
this.cb_validate=create cb_validate
this.Control[]={this.cb_help,&
this.cb_close,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_date,&
this.sle_number,&
this.sle_letter,&
this.cb_validate}
end on

on w_populateerror.destroy
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_date)
destroy(this.sle_number)
destroy(this.sle_letter)
destroy(this.cb_validate)
end on

event close;w_main.Show()

end event

type cb_help from commandbutton within w_populateerror
int X=1106
int Y=644
int Width=261
int Height=108
int TabOrder=60
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String				ls_Win

ls_win = parent.ClassName()

f_open_help(ls_win)
end event

type cb_close from commandbutton within w_populateerror
int X=663
int Y=644
int Width=261
int Height=108
int TabOrder=50
string Text="Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type st_3 from statictext within w_populateerror
int X=206
int Y=420
int Width=763
int Height=76
boolean Enabled=false
string Text="Enter a date within the last year:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_populateerror
int X=55
int Y=252
int Width=914
int Height=76
boolean Enabled=false
string Text="Enter a number between 100 and 1000:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_populateerror
int X=219
int Y=84
int Width=750
int Height=76
boolean Enabled=false
string Text="Enter a letter between A and L:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_date from singlelineedit within w_populateerror
int X=997
int Y=412
int Width=261
int Height=92
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_number from singlelineedit within w_populateerror
int X=997
int Y=244
int Width=155
int Height=92
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_letter from singlelineedit within w_populateerror
int X=997
int Y=76
int Width=133
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_validate from commandbutton within w_populateerror
int X=219
int Y=644
int Width=261
int Height=108
int TabOrder=40
string Text="Validate"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_validate_letter()
of_validate_number()
of_validate_date()

If Not ib_Error Then
	MessageBox("Valid", "Congratulations, you follow directions very well!", Information!)
Else
	ib_Error = False
End If

end event

