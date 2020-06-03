$PBExportHeader$w_nested_reference.srw
$PBExportComments$Example showing direct reference of a nested report
forward
global type w_nested_reference from w_center
end type
type cb_print from commandbutton within w_nested_reference
end type
type em_above from editmask within w_nested_reference
end type
type em_below from editmask within w_nested_reference
end type
type cb_help from commandbutton within w_nested_reference
end type
type cb_cancel from commandbutton within w_nested_reference
end type
type st_2 from statictext within w_nested_reference
end type
type st_1 from statictext within w_nested_reference
end type
type cb_prev from commandbutton within w_nested_reference
end type
type cb_next from commandbutton within w_nested_reference
end type
type cb_ok from commandbutton within w_nested_reference
end type
type dw_1 from datawindow within w_nested_reference
end type
end forward

global type w_nested_reference from w_center
int X=4
int Y=4
int Width=2955
int Height=1850
boolean TitleBar=true
string Title="Direct Nested Report Reference"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_print cb_print
em_above em_above
em_below em_below
cb_help cb_help
cb_cancel cb_cancel
st_2 st_2
st_1 st_1
cb_prev cb_prev
cb_next cb_next
cb_ok cb_ok
dw_1 dw_1
end type
global w_nested_reference w_nested_reference

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

dw_1.Object.DataWindow.Zoom = 85

end event

on w_nested_reference.create
this.cb_print=create cb_print
this.em_above=create em_above
this.em_below=create em_below
this.cb_help=create cb_help
this.cb_cancel=create cb_cancel
this.st_2=create st_2
this.st_1=create st_1
this.cb_prev=create cb_prev
this.cb_next=create cb_next
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={ this.cb_print,&
this.em_above,&
this.em_below,&
this.cb_help,&
this.cb_cancel,&
this.st_2,&
this.st_1,&
this.cb_prev,&
this.cb_next,&
this.cb_ok,&
this.dw_1}
end on

on w_nested_reference.destroy
destroy(this.cb_print)
destroy(this.em_above)
destroy(this.em_below)
destroy(this.cb_help)
destroy(this.cb_cancel)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_prev)
destroy(this.cb_next)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event close;Show(w_main)

end event

type cb_print from commandbutton within w_nested_reference
int X=1721
int Y=58
int Width=278
int Height=87
int TabOrder=32
string Text="Print"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.Print(True)

end event

type em_above from editmask within w_nested_reference
int X=1195
int Y=106
int Width=200
int Height=87
int TabOrder=40
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="#0%"
boolean Spin=true
string DisplayData="D"
double Increment=1
string MinMax="0~~99"
string Text="5"
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_below from editmask within w_nested_reference
int X=1195
int Y=10
int Width=200
int Height=87
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="#0%"
boolean Spin=true
string DisplayData=""
double Increment=1
string MinMax="0~~99"
string Text="10"
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_help from commandbutton within w_nested_reference
int X=2326
int Y=58
int Width=278
int Height=87
int TabOrder=50
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help(Parent.ClassName())

end event

type cb_cancel from commandbutton within w_nested_reference
int X=2024
int Y=58
int Width=278
int Height=87
int TabOrder=30
string Text="Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type st_2 from statictext within w_nested_reference
int Y=116
int Width=1185
int Height=65
boolean Enabled=false
string Text="Percentage Raise for Employees Above the Average:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_nested_reference
int Y=20
int Width=1185
int Height=65
boolean Enabled=false
string Text="Percentage Raise for Employees Below the Average:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_prev from commandbutton within w_nested_reference
int X=2706
int Y=58
int Width=100
int Height=87
int TabOrder=60
string Text="<<"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollPriorPage()

end event

type cb_next from commandbutton within w_nested_reference
int X=2809
int Y=58
int Width=100
int Height=87
int TabOrder=70
string Text=">>"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.ScrollNextPage()

end event

type cb_ok from commandbutton within w_nested_reference
int X=1419
int Y=58
int Width=278
int Height=87
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer		li_Cnt1, li_Cnt2, li_Depts, li_Rows
Double		ldb_Avg, ldb_Below, ldb_Above, ldb_DeptTotal
String		ls_Output
Any			la_Data[]
dwobject	ldwo_Current

// Calculate the raise percentages
em_below.GetData(ldb_Below)
em_above.GetData(ldb_Above)
ldb_Below = 1 + ldb_Below
ldb_Above = 1 + ldb_Above

SetPointer(HourGlass!)

li_Depts = dw_1.RowCount()

// Make changes for each department.
For li_Cnt1 = 1 To li_Depts
	ldb_DeptTotal = 0

	// Set a dwobject variable to point to the nested report for that department.
	ldwo_Current = dw_1.Object.nest_rep[li_Cnt1]

	// Need to know how many rows are in the nested report.  Get this by
	// copying the data into an array of type Any and checking the upper bound.
	la_Data = ldwo_Current.Object.Data
	li_Rows = UpperBound(la_Data)

	// Get the average salary for that department.
	ldb_Avg = ldwo_Current.Object.avg_sal[1]

	// Give the appropriate raises.
	For li_Cnt2 = 1 To li_Rows
		If ldwo_Current.Object.salary[li_Cnt2] < ldb_Avg Then
			ldwo_Current.Object.salary[li_Cnt2] = ldwo_Current.Object.salary[li_Cnt2] * ldb_Below
		Else
			ldwo_Current.Object.salary[li_Cnt2] = ldwo_Current.Object.salary[li_Cnt2] * ldb_Above
		End If

		// Keep new total salary for each department
		ldb_DeptTotal = ldb_DeptTotal + ldwo_Current.Object.salary[li_Cnt2]
	Next

	// Will be outputing the new department total at the end.
	ls_Output = ls_Output + "~r~n" + dw_1.Object.department_dept_name[li_Cnt1] + "~t-~t" + &
					String(ldb_DeptTotal, "$###,###.00")
Next

// Display the new department totals.
MessageBox("New Department Total Salaries", ls_Output, Information!)

end event

type dw_1 from datawindow within w_nested_reference
int X=11
int Y=234
int Width=2898
int Height=1501
string DataObject="d_dept_manage_emp"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

