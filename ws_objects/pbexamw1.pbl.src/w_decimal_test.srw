$PBExportHeader$w_decimal_test.srw
$PBExportComments$Shows various uses of decimal data with truncation and rounding
forward
global type w_decimal_test from w_center
end type
type st_15 from statictext within w_decimal_test
end type
type st_14 from statictext within w_decimal_test
end type
type st_13 from statictext within w_decimal_test
end type
type st_12 from statictext within w_decimal_test
end type
type st_11 from statictext within w_decimal_test
end type
type st_10 from statictext within w_decimal_test
end type
type st_dec10 from statictext within w_decimal_test
end type
type st_dec8 from statictext within w_decimal_test
end type
type st_dec6 from statictext within w_decimal_test
end type
type st_dec4 from statictext within w_decimal_test
end type
type st_dec2 from statictext within w_decimal_test
end type
type st_dec0 from statictext within w_decimal_test
end type
type st_3 from statictext within w_decimal_test
end type
type ddlb_1 from dropdownlistbox within w_decimal_test
end type
type em_2 from editmask within w_decimal_test
end type
type em_1 from editmask within w_decimal_test
end type
type st_2 from statictext within w_decimal_test
end type
type st_1 from statictext within w_decimal_test
end type
type cb_close from commandbutton within w_decimal_test
end type
end forward

global type w_decimal_test from w_center
int X=136
int Y=385
int Width=2635
int Height=1133
boolean TitleBar=true
string Title="Decimal Data Type Precision"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_dec10 st_dec10
st_dec8 st_dec8
st_dec6 st_dec6
st_dec4 st_dec4
st_dec2 st_dec2
st_dec0 st_dec0
st_3 st_3
ddlb_1 ddlb_1
em_2 em_2
em_1 em_1
st_2 st_2
st_1 st_1
cb_close cb_close
end type
global w_decimal_test w_decimal_test

forward prototypes
protected subroutine wf_calculate ()
end prototypes

protected subroutine wf_calculate ();//////////////////////////////////////////////////////////////////////
//
// Function: wf_calculate
//
// Purpose: calculate the result applying the operator to the two
//				values, and display the different decimal precision values
//				of the result.
//
//	Scope: protected
//
//	Arguments: none
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

dec{0}	lc_0
dec{2}	lc_2
dec{4}	lc_4
dec{6}	lc_6
dec{8}	lc_8
dec{10}	lc_10
dec		lc_op1, lc_op2
string	ls_operator


// get the two values as decimals
lc_op1 = Dec (em_1.text)
lc_op2 = Dec (em_2.text)

// get the operator
ls_operator = ddlb_1.text

// calculate results
choose case ls_operator

	case '+'
		lc_0 = lc_op1 + lc_op2
		lc_2 = lc_op1 + lc_op2
		lc_4 = lc_op1 + lc_op2
		lc_6 = lc_op1 + lc_op2
		lc_8 = lc_op1 + lc_op2
		lc_10 = lc_op1 + lc_op2

	case '-'
		lc_0 = lc_op1 - lc_op2
		lc_2 = lc_op1 - lc_op2
		lc_4 = lc_op1 - lc_op2
		lc_6 = lc_op1 - lc_op2
		lc_8 = lc_op1 - lc_op2
		lc_10 = lc_op1 - lc_op2

	case '*'
		lc_0 = lc_op1 * lc_op2
		lc_2 = lc_op1 * lc_op2
		lc_4 = lc_op1 * lc_op2
		lc_6 = lc_op1 * lc_op2
		lc_8 = lc_op1 * lc_op2
		lc_10 = lc_op1 * lc_op2

	case '/'
		// check for division by zero
		if lc_op2 = 0 then
			MessageBox ('Error', 'Division by zero is not allowed!', exclamation!)
			em_2.SetFocus()
			em_2.SelectText (1, Len (em_2.text))
			return
		end if
		lc_0 = lc_op1 / lc_op2
		lc_2 = lc_op1 / lc_op2
		lc_4 = lc_op1 / lc_op2
		lc_6 = lc_op1 / lc_op2
		lc_8 = lc_op1 / lc_op2
		lc_10 = lc_op1 / lc_op2

end choose

// display results
st_dec0.text = String (lc_0, '#####0.0000000000')
st_dec2.text = String (lc_2, '#####0.0000000000')
st_dec4.text = String (lc_4, '#####0.0000000000')
st_dec6.text = String (lc_6, '#####0.0000000000')
st_dec8.text = String (lc_8, '#####0.0000000000')
st_dec10.text = String (lc_10, '#####0.0000000000')
end subroutine

on open;// Set the initial operator to addition

ddlb_1.SelectItem (1)
end on

on w_decimal_test.create
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_dec10=create st_dec10
this.st_dec8=create st_dec8
this.st_dec6=create st_dec6
this.st_dec4=create st_dec4
this.st_dec2=create st_dec2
this.st_dec0=create st_dec0
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.em_2=create em_2
this.em_1=create em_1
this.st_2=create st_2
this.st_1=create st_1
this.cb_close=create cb_close
this.Control[]={ this.st_15,&
this.st_14,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_dec10,&
this.st_dec8,&
this.st_dec6,&
this.st_dec4,&
this.st_dec2,&
this.st_dec0,&
this.st_3,&
this.ddlb_1,&
this.em_2,&
this.em_1,&
this.st_2,&
this.st_1,&
this.cb_close}
end on

on w_decimal_test.destroy
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_dec10)
destroy(this.st_dec8)
destroy(this.st_dec6)
destroy(this.st_dec4)
destroy(this.st_dec2)
destroy(this.st_dec0)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_close)
end on

on close;w_main.Show()
end on

type st_15 from statictext within w_decimal_test
int X=2294
int Y=849
int Width=246
int Height=71
boolean Enabled=false
string Text="dec {10}"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_14 from statictext within w_decimal_test
int X=2294
int Y=733
int Width=246
int Height=71
boolean Enabled=false
string Text="dec {8}"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_13 from statictext within w_decimal_test
int X=2294
int Y=621
int Width=246
int Height=71
boolean Enabled=false
string Text="dec {6}"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within w_decimal_test
int X=2294
int Y=509
int Width=246
int Height=71
boolean Enabled=false
string Text="dec {4}"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within w_decimal_test
int X=2294
int Y=397
int Width=246
int Height=71
boolean Enabled=false
string Text="dec {2}"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within w_decimal_test
int X=2294
int Y=285
int Width=246
int Height=71
boolean Enabled=false
string Text="dec {0}"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dec10 from statictext within w_decimal_test
int X=1668
int Y=836
int Width=577
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dec8 from statictext within w_decimal_test
int X=1668
int Y=724
int Width=577
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dec6 from statictext within w_decimal_test
int X=1668
int Y=612
int Width=577
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dec4 from statictext within w_decimal_test
int X=1668
int Y=500
int Width=577
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dec2 from statictext within w_decimal_test
int X=1668
int Y=388
int Width=577
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_dec0 from statictext within w_decimal_test
int X=1668
int Y=276
int Width=577
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_decimal_test
int X=1579
int Y=285
int Width=72
int Height=71
boolean Enabled=false
string Text="="
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_1 from dropdownlistbox within w_decimal_test
int X=676
int Y=273
int Width=246
int Height=407
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"+",&
"-",&
"*",&
"/"}
end type

on selectionchanged;// call window function to calculate result

wf_calculate()
end on

type em_2 from editmask within w_decimal_test
int X=961
int Y=273
int Width=577
int Height=100
int TabOrder=30
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="######.######00"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;// call window function to calculate result

wf_calculate()
end on

type em_1 from editmask within w_decimal_test
int X=65
int Y=273
int Width=577
int Height=100
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="######.########00"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;// call window function to calculate result

wf_calculate()
end on

type st_2 from statictext within w_decimal_test
int X=22
int Y=81
int Width=2027
int Height=71
boolean Enabled=false
string Text="that have been declared of data type decimal {n}."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_decimal_test
int X=22
int Y=20
int Width=2027
int Height=71
boolean Enabled=false
string Text="Enter two values and an operator.  The results that are displayed are variables"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_decimal_test
int X=2337
int Y=36
int Width=246
int Height=109
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

