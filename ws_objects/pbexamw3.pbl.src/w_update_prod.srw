$PBExportHeader$w_update_prod.srw
$PBExportComments$Window to update a product, used by w_prod_listview
forward
global type w_update_prod from Window
end type
type p_product from picture within w_update_prod
end type
type cb_cancel from commandbutton within w_update_prod
end type
type cb_ok from commandbutton within w_update_prod
end type
type dw_prod from datawindow within w_update_prod
end type
end forward

global type w_update_prod from w_center
int X=174
int Y=228
int Width=2171
int Height=744
boolean TitleBar=true
string Title="Edit Product"
long BackColor=75530304
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
p_product p_product
cb_cancel cb_cancel
cb_ok cb_ok
dw_prod dw_prod
end type
global w_update_prod w_update_prod

type variables
Boolean	ib_Changed
end variables

event open;call super::open;Integer	li_ID
Blob		lblb_BMP

li_ID = Message.DoubleParm

// Retrieve data into DataWindow
dw_prod.SetTransObject(sqlca)
dw_prod.Retrieve(li_ID)

// Retrieve blob into picture
SelectBlob catalog_picture
into :lblb_BMP
from product
where id = :li_ID;

p_product.SetPicture(lblb_BMP)

ib_Changed = False

end event

on w_update_prod.create
this.p_product=create p_product
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_prod=create dw_prod
this.Control[]={ this.p_product,&
this.cb_cancel,&
this.cb_ok,&
this.dw_prod}
end on

on w_update_prod.destroy
destroy(this.p_product)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_prod)
end on

event closequery;Integer	li_Ans

If ib_Changed Then
	li_Ans = MessageBox("Update Product", "Changes to this product have been made.  Do you want to save them before you exit?", &
									Question!, YesNoCancel!)
	If li_Ans = 3 Then
		Message.ReturnValue = 1
	Elseif li_Ans = 1 Then
		dw_prod.Update()
		commit;
		Message.DoubleParm = 1
	End if
End if

end event

type p_product from picture within w_update_prod
int X=9
int Y=12
int Width=654
int Height=588
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type cb_cancel from commandbutton within w_update_prod
int X=1463
int Y=528
int Width=247
int Height=88
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, 0)

end event

type cb_ok from commandbutton within w_update_prod
int X=1138
int Y=528
int Width=247
int Height=88
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_prod.AcceptText()

If ib_Changed Then
	dw_prod.Update()
	commit;
	ib_Changed = False
	CloseWithReturn(Parent, 1)
Else
	CloseWIthReturn(Parent, 0)
End if

end event

type dw_prod from datawindow within w_update_prod
int X=709
int Y=60
int Width=1335
int Height=376
int TabOrder=10
string DataObject="d_edit_product"
boolean Border=false
boolean LiveScroll=true
end type

event itemchanged;ib_Changed = True

end event

