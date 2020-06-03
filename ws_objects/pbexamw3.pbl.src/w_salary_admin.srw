$PBExportHeader$w_salary_admin.srw
$PBExportComments$Salary Administration example - shows datawindow modification
forward
global type w_salary_admin from w_center
end type
type cb_help from commandbutton within w_salary_admin
end type
type cb_reset from commandbutton within w_salary_admin
end type
type em_startdate from editmask within w_salary_admin
end type
type st_5 from statictext within w_salary_admin
end type
type cb_cancel from commandbutton within w_salary_admin
end type
type cb_update from commandbutton within w_salary_admin
end type
type cb_change from commandbutton within w_salary_admin
end type
type st_4 from statictext within w_salary_admin
end type
type st_3 from statictext within w_salary_admin
end type
type st_dept from statictext within w_salary_admin
end type
type st_2 from statictext within w_salary_admin
end type
type cb_highlight from commandbutton within w_salary_admin
end type
type st_1 from statictext within w_salary_admin
end type
type sle_pct from singlelineedit within w_salary_admin
end type
type rb_minus from radiobutton within w_salary_admin
end type
type rb_plus from radiobutton within w_salary_admin
end type
type rb_terminated from radiobutton within w_salary_admin
end type
type rb_leave from radiobutton within w_salary_admin
end type
type rb_active from radiobutton within w_salary_admin
end type
type dw_dept from datawindow within w_salary_admin
end type
type dw_employees from datawindow within w_salary_admin
end type
type gb_2 from groupbox within w_salary_admin
end type
type gb_1 from groupbox within w_salary_admin
end type
end forward

global type w_salary_admin from w_center
integer y = 4
integer width = 2862
integer height = 1708
string title = "Salary Administration"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event ue_postopen ( )
cb_help cb_help
cb_reset cb_reset
em_startdate em_startdate
st_5 st_5
cb_cancel cb_cancel
cb_update cb_update
cb_change cb_change
st_4 st_4
st_3 st_3
st_dept st_dept
st_2 st_2
cb_highlight cb_highlight
st_1 st_1
sle_pct sle_pct
rb_minus rb_minus
rb_plus rb_plus
rb_terminated rb_terminated
rb_leave rb_leave
rb_active rb_active
dw_dept dw_dept
dw_employees dw_employees
gb_2 gb_2
gb_1 gb_1
end type
global w_salary_admin w_salary_admin

type variables
Integer	ii_Rows, ii_Dept
Double	id_Pct
String	is_Status = "A"
end variables

event ue_postopen;datawindowchild	ldwc_Dept

SetPointer(Hourglass!)

dw_dept.InsertRow(0)
dw_dept.GetChild("dept_id", ldwc_Dept)
ldwc_Dept.SetTransObject(sqlca)
ldwc_Dept.Retrieve()

dw_employees.SetTransObject(sqlca)
dw_employees.Retrieve()

ii_Rows = dw_employees.RowCount()

end event

on w_salary_admin.create
int iCurrent
call super::create
this.cb_help=create cb_help
this.cb_reset=create cb_reset
this.em_startdate=create em_startdate
this.st_5=create st_5
this.cb_cancel=create cb_cancel
this.cb_update=create cb_update
this.cb_change=create cb_change
this.st_4=create st_4
this.st_3=create st_3
this.st_dept=create st_dept
this.st_2=create st_2
this.cb_highlight=create cb_highlight
this.st_1=create st_1
this.sle_pct=create sle_pct
this.rb_minus=create rb_minus
this.rb_plus=create rb_plus
this.rb_terminated=create rb_terminated
this.rb_leave=create rb_leave
this.rb_active=create rb_active
this.dw_dept=create dw_dept
this.dw_employees=create dw_employees
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_help
this.Control[iCurrent+2]=this.cb_reset
this.Control[iCurrent+3]=this.em_startdate
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_update
this.Control[iCurrent+7]=this.cb_change
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_dept
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.cb_highlight
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.sle_pct
this.Control[iCurrent+15]=this.rb_minus
this.Control[iCurrent+16]=this.rb_plus
this.Control[iCurrent+17]=this.rb_terminated
this.Control[iCurrent+18]=this.rb_leave
this.Control[iCurrent+19]=this.rb_active
this.Control[iCurrent+20]=this.dw_dept
this.Control[iCurrent+21]=this.dw_employees
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.gb_1
end on

on w_salary_admin.destroy
call super::destroy
destroy(this.cb_help)
destroy(this.cb_reset)
destroy(this.em_startdate)
destroy(this.st_5)
destroy(this.cb_cancel)
destroy(this.cb_update)
destroy(this.cb_change)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_dept)
destroy(this.st_2)
destroy(this.cb_highlight)
destroy(this.st_1)
destroy(this.sle_pct)
destroy(this.rb_minus)
destroy(this.rb_plus)
destroy(this.rb_terminated)
destroy(this.rb_leave)
destroy(this.rb_active)
destroy(this.dw_dept)
destroy(this.dw_employees)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;call super::open;Post Event ue_PostOpen()

end event

event close;Show(w_main)

end event

type cb_help from commandbutton within w_salary_admin
integer x = 2048
integer y = 980
integer width = 704
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "H&elp"
end type

event clicked;f_open_help ("w_salary_admin")

end event

type cb_reset from commandbutton within w_salary_admin
integer x = 2048
integer y = 592
integer width = 704
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Reset Data"
end type

event clicked;dw_employees.Reset()

// Change the colors back
dw_employees.object.selected.brush.color = "73955432"
dw_employees.object.employee_salary.color = String(st_dept.TextColor)

dw_employees.Retrieve()

end event

type em_startdate from editmask within w_salary_admin
integer x = 1207
integer y = 220
integer width = 251
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "01/01/08"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yy"
end type

type st_5 from statictext within w_salary_admin
integer x = 864
integer y = 228
integer width = 334
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Started Before:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_salary_admin
integer x = 2048
integer y = 836
integer width = 704
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "C&ancel"
boolean cancel = true
end type

event clicked;Close(Parent)

end event

type cb_update from commandbutton within w_salary_admin
integer x = 2048
integer y = 736
integer width = 704
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Update"
end type

event clicked;dw_employees.Update()
Commit;

end event

type cb_change from commandbutton within w_salary_admin
integer x = 2048
integer y = 448
integer width = 709
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Calculate Employee Salaries"
end type

event clicked;Integer	li_Cnt
DateTime	ldt_StartDate

If ii_Dept <= 0 Then
	MessageBox("Error", "You must Select A department.", Exclamation!)
	Return
End If

If em_startdate.Text = "" Then
	ldt_StartDate = DateTime("12/31/99")
Else
	em_startdate.GetData(ldt_StartDate)
End If

For li_Cnt = 1 to ii_Rows

	If dw_employees.Object.employee_dept_id[li_Cnt] = ii_Dept And &
		dw_employees.Object.employee_status[li_Cnt] = is_Status And &
		dw_employees.Object.employee_start_date[li_Cnt] <= ldt_StartDate Then

		dw_employees.Object.employee_salary[li_Cnt] = dw_employees.Object.employee_salary[li_Cnt] * id_Pct
	End If
Next

end event

type st_4 from statictext within w_salary_admin
integer x = 5
integer y = 140
integer width = 608
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "(or deduction) percentage."
boolean focusrectangle = false
end type

type st_3 from statictext within w_salary_admin
integer x = 5
integer y = 92
integer width = 777
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Date, and Status and enter a raise"
boolean focusrectangle = false
end type

type st_dept from statictext within w_salary_admin
integer x = 869
integer y = 44
integer width = 274
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Department:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_salary_admin
integer x = 5
integer y = 44
integer width = 800
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Select a Department, Minimum Start"
boolean focusrectangle = false
end type

type cb_highlight from commandbutton within w_salary_admin
integer x = 2048
integer y = 340
integer width = 709
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Highlight Employees to Change"
end type

event clicked;String	ls_Filter

If ii_Dept <= 0 Then
	MessageBox("Error", "You must select a department.", Exclamation!)
	Return
End if

ls_Filter = "employee_dept_id = " + String(ii_Dept) + " And employee_status = '" + is_Status + "'"

If em_startdate.Text <> "" Then
	ls_Filter = ls_Filter + " And employee_start_date <= Date('" + em_startdate.Text + "')"
End if

// Change the color of the rectangle under the row to yellow
dw_employees.object.selected.brush.color = "0~tIf ( " + ls_Filter + ", RGB(255, 255, 0), 73955432)"

// Change the color of the text of the salary to blue
dw_employees.object.employee_salary.color = "0~tIf ( " + ls_Filter + ", RGB(255, 0, 0), " + &
																				String(st_dept.TextColor) + " )"

end event

type st_1 from statictext within w_salary_admin
integer x = 2528
integer y = 116
integer width = 41
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "%"
boolean focusrectangle = false
end type

type sle_pct from singlelineedit within w_salary_admin
integer x = 2304
integer y = 108
integer width = 206
integer height = 68
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;If rb_minus.Checked Then
	id_Pct = 1 - (Double(This.Text) / 100)
Else
	id_Pct = 1 + (Double(This.Text) / 100)
End if

end event

type rb_minus from radiobutton within w_salary_admin
integer x = 2057
integer y = 148
integer width = 224
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Minus"
end type

event clicked;sle_pct.textcolor = 255
id_Pct = 1 - (Double(sle_pct.Text) / 100)

end event

type rb_plus from radiobutton within w_salary_admin
integer x = 2057
integer y = 84
integer width = 224
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Plus"
boolean checked = true
end type

event clicked;sle_pct.textcolor = 0
id_Pct = 1 + (Double(sle_pct.Text) / 100)

end event

type rb_terminated from radiobutton within w_salary_admin
integer x = 1641
integer y = 208
integer width = 338
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Terminated"
end type

event clicked;is_Status = "T"

end event

type rb_leave from radiobutton within w_salary_admin
integer x = 1641
integer y = 144
integer width = 306
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "On Leave"
end type

event clicked;is_Status = "L"

end event

type rb_active from radiobutton within w_salary_admin
integer x = 1641
integer y = 84
integer width = 233
integer height = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Active"
boolean checked = true
end type

event clicked;is_Status = "A"

end event

type dw_dept from datawindow within w_salary_admin
integer x = 864
integer y = 108
integer width = 718
integer height = 92
integer taborder = 10
string dataobject = "d_choose_department"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_Dept = Integer(data)

end event

type dw_employees from datawindow within w_salary_admin
integer x = 32
integer y = 340
integer width = 1970
integer height = 1236
string dataobject = "d_salary_adm"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_salary_admin
integer x = 2025
integer y = 20
integer width = 576
integer height = 208
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Salary Treatment"
end type

type gb_1 from groupbox within w_salary_admin
integer x = 1609
integer y = 20
integer width = 384
integer height = 268
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Status"
end type

