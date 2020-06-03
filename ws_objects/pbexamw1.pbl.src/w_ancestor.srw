$PBExportHeader$w_ancestor.srw
$PBExportComments$Ancestor window for multi-lingual example.
forward
global type w_ancestor from w_center
end type
type em_date from editmask within w_ancestor
end type
type st_1 from statictext within w_ancestor
end type
type st_2 from statictext within w_ancestor
end type
type sle_price from singlelineedit within w_ancestor
end type
type sle_qty from singlelineedit within w_ancestor
end type
type cb_1 from commandbutton within w_ancestor
end type
type cb_2 from commandbutton within w_ancestor
end type
type st_4 from statictext within w_ancestor
end type
type st_3 from statictext within w_ancestor
end type
type sle_total from singlelineedit within w_ancestor
end type
end forward

global type w_ancestor from w_center
int X=420
int Y=513
int Width=2081
int Height=903
boolean TitleBar=true
string Title="Price Calculation in English (US dollars)"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
em_date em_date
st_1 st_1
st_2 st_2
sle_price sle_price
sle_qty sle_qty
cb_1 cb_1
cb_2 cb_2
st_4 st_4
st_3 st_3
sle_total sle_total
end type
global w_ancestor w_ancestor

type variables

end variables

forward prototypes
public function decimal wf_total (decimal ac_price, decimal ac_quantity)
end prototypes

public function decimal wf_total (decimal ac_price, decimal ac_quantity);//////////////////////////////////////////////////////////////////////
//
// Function: wf_total
//
// Purpose: compute the total for the price and quantity arguments
//
//	Scope: public
//
//	Arguments: ac_price		the price
//				  ac_quantity	the quantity
//
//	Returns: decimal		
//
//////////////////////////////////////////////////////////////////////


return ac_quantity * ac_price

end function

on open;// default purchase date as today's date

em_date.text = String (Today())
end on

on w_ancestor.create
this.em_date=create em_date
this.st_1=create st_1
this.st_2=create st_2
this.sle_price=create sle_price
this.sle_qty=create sle_qty
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_4=create st_4
this.st_3=create st_3
this.sle_total=create sle_total
this.Control[]={ this.em_date,&
this.st_1,&
this.st_2,&
this.sle_price,&
this.sle_qty,&
this.cb_1,&
this.cb_2,&
this.st_4,&
this.st_3,&
this.sle_total}
end on

on w_ancestor.destroy
destroy(this.em_date)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_price)
destroy(this.sle_qty)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_total)
end on

type em_date from editmask within w_ancestor
int X=569
int Y=39
int Width=324
int Height=93
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_ancestor
int X=260
int Y=247
int Width=267
int Height=81
string Text="Quantity:"
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

type st_2 from statictext within w_ancestor
int X=246
int Y=388
int Width=281
int Height=81
string Text="Unit Price:"
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

type sle_price from singlelineedit within w_ancestor
int X=569
int Y=375
int Width=598
int Height=90
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Pointer="arrow!"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;if not IsNumber (this.text) then
	this.text = '0'
end if

end on

on getfocus;this.SelectText (1, Len (this.text))
end on

type sle_qty from singlelineedit within w_ancestor
int X=569
int Y=234
int Width=598
int Height=90
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Pointer="arrow!"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on getfocus;this.SelectText (1, Len (this.text))
end on

on modified;if not IsNumber (this.text) then
	this.text = '0'
end if
end on

type cb_1 from commandbutton within w_ancestor
int X=1526
int Y=49
int Width=481
int Height=109
int TabOrder=40
string Text="Compute Total"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// call the window function to calculate the total

decimal	lc_price, &
			lc_quantity, &
			lc_total

lc_price = Dec (sle_price.text)
lc_quantity = Dec (sle_qty.text)

lc_total = wf_total (lc_price, lc_quantity)
sle_total.text = String (lc_total, '[currency]')
end on

type cb_2 from commandbutton within w_ancestor
int X=1526
int Y=183
int Width=481
int Height=109
int TabOrder=50
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type st_4 from statictext within w_ancestor
int X=50
int Y=52
int Width=481
int Height=81
string Text="Date of Purchase:"
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

type st_3 from statictext within w_ancestor
int X=360
int Y=573
int Width=168
int Height=81
string Text="Total:"
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

type sle_total from singlelineedit within w_ancestor
int X=569
int Y=561
int Width=598
int Height=90
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Pointer="arrow!"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

