$PBExportHeader$w_french.srw
$PBExportComments$Inheritance:  French descendant
forward
global type w_french from w_ancestor
end type
type st_5 from statictext within w_french
end type
type sle_tva from singlelineedit within w_french
end type
end forward

global type w_french from w_ancestor
int Width=2088
int Height=909
boolean TitleBar=true
string Title="Calcul du Prix en Francais"
st_5 st_5
sle_tva sle_tva
end type
global w_french w_french

type variables
decimal vat
end variables

forward prototypes
public function decimal wf_total (decimal ac_price, decimal ac_quantity, decimal ac_tva)
end prototypes

public function decimal wf_total (decimal ac_price, decimal ac_quantity, decimal ac_tva);//////////////////////////////////////////////////////////////////////
//
// Function: wf_total
//
// Purpose: compute total
//
//	Scope: public
//
//	Arguments: ac_price		the price
//				  ac_quantity	the quantity
//				  ac_tva			additional amount for France
//
//	Returns: decimal		
//
//////////////////////////////////////////////////////////////////////


return (ac_quantity * ac_price) + ac_tva

end function

on w_french.create
int iCurrent
call w_ancestor::create
this.st_5=create st_5
this.sle_tva=create sle_tva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_5
this.Control[iCurrent+2]=sle_tva
end on

on w_french.destroy
call w_ancestor::destroy
destroy(this.st_5)
destroy(this.sle_tva)
end on

type st_1 from w_ancestor`st_1 within w_french
int Y=196
string Text="Quantite:"
end type

type st_2 from w_ancestor`st_2 within w_french
int X=392
int Y=337
int Width=136
string Text="Prix:"
end type

type sle_price from w_ancestor`sle_price within w_french
int Y=327
end type

type sle_qty from w_ancestor`sle_qty within w_french
int Y=189
end type

type cb_1 from w_ancestor`cb_1 within w_french
int X=1697
int Width=310
int TabOrder=50
string Text="Addition"
end type

on cb_1::clicked;// override ancestor script because the computation for the total
// will be difference for France.  The wf_total window function on
// this window will override the ancestor window function wf_total.

decimal	lc_price, &
			lc_quantity, &
			lc_total, &
			lc_tva

lc_price = Dec (sle_price.text)
lc_quantity = Dec (sle_qty.text)
lc_tva = Dec (sle_tva.text)

lc_total = wf_total (lc_price, lc_quantity, lc_tva)
sle_total.text = String (lc_total, '[currency]')
end on

type cb_2 from w_ancestor`cb_2 within w_french
int X=1697
int Width=310
int TabOrder=60
end type

type st_4 from w_ancestor`st_4 within w_french
int X=97
int Width=434
string Text="Date de l'achat:"
end type

type st_3 from w_ancestor`st_3 within w_french
int X=345
int Y=628
int Width=182
end type

type sle_total from w_ancestor`sle_total within w_french
int Y=621
end type

type st_5 from statictext within w_french
int X=392
int Y=481
int Width=136
int Height=81
string Text="TVA:"
Alignment Alignment=Right!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_tva from singlelineedit within w_french
int X=569
int Y=471
int Width=598
int Height=97
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
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

