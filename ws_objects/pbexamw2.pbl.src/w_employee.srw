$PBExportHeader$w_employee.srw
$PBExportComments$Uses the employee business object.
forward
global type w_employee from w_ancestor_one_dw
end type
type cb_about from commandbutton within w_employee
end type
type st_1 from statictext within w_employee
end type
type st_2 from statictext within w_employee
end type
type st_3 from statictext within w_employee
end type
type st_4 from statictext within w_employee
end type
end forward

global type w_employee from w_ancestor_one_dw
int X=32
int Y=320
int Width=2857
int Height=1356
boolean TitleBar=true
string Title="Business Class"
cb_about cb_about
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type
global w_employee w_employee

on w_employee.create
int iCurrent
call w_ancestor_one_dw::create
this.cb_about=create cb_about
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=cb_about
this.Control[iCurrent+2]=st_1
this.Control[iCurrent+3]=st_2
this.Control[iCurrent+4]=st_3
this.Control[iCurrent+5]=st_4
end on

on w_employee.destroy
call w_ancestor_one_dw::destroy
destroy(this.cb_about)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

on close;call w_ancestor_one_dw::close;w_main.Show()
end on

event ue_delete_row;call super::ue_delete_row;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Display error message if trying to delete an employee with active status.
// AncestorReturnValue is the return value of the ue_delete_row event in 
// w_ancestor_one_dw.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

If AncestorReturnValue = -2 Then
	MessageBox ("Delete Not Allowed", "Employees with Active status may not be deleted.")
End If

end event

type cb_close from w_ancestor_one_dw`cb_close within w_employee
int X=2455
end type

type cb_delete from w_ancestor_one_dw`cb_delete within w_employee
int X=2455
end type

type cb_insert from w_ancestor_one_dw`cb_insert within w_employee
int X=2455
end type

type cb_update from w_ancestor_one_dw`cb_update within w_employee
int X=2455
end type

type cb_retrieve from w_ancestor_one_dw`cb_retrieve within w_employee
int X=2455
end type

type dw_1 from w_ancestor_one_dw`dw_1 within w_employee
int Y=320
int Width=2377
int Height=888
string DataObject="d_employee_required"
end type

on dw_1::ue_create_business_object;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Override the ancestor script.
// Create employee business object.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

iuo_business_object = create u_employee_object
end on

type cb_about from commandbutton within w_employee
int X=2455
int Y=636
int Width=352
int Height=100
int TabOrder=70
boolean BringToTop=true
string Text="&About..."
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Display an about box with credits for this example
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

OpenWithParm (w_about_with_parm, "Business Class@The techniques used in this example were contributed by:~r~n" + &
				"Wain Kellum~r~nOmni Training Centers~r~n~r~n" + &
				"Steve Benfield~r~nConsulting Partner~r~nCCS Consulting~r~n981 Woodward Park Drive~r~nSuwanee, GA 30174~r~nPhone: (404) 813-0480~r~nFax: (404) 813-1203")
end on

type st_1 from statictext within w_employee
int X=41
int Y=24
int Width=937
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="Business rules for employee object:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_employee
int X=41
int Y=84
int Width=1097
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="1) Confirm before adding a new employee."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_employee
int X=41
int Y=204
int Width=1321
int Height=72
boolean Enabled=false
boolean BringToTop=true
string Text="3) Employees with active status cannot be deleted."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_employee
int X=41
int Y=144
int Width=1257
int Height=68
boolean Enabled=false
boolean BringToTop=true
string Text="2) Confirm before deleting an existing employee."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

