$PBExportHeader$w_update_sales_order.srw
$PBExportComments$Example of using rowfocuchanging event
forward
global type w_update_sales_order from w_center
end type
type cb_help from commandbutton within w_update_sales_order
end type
type cb_close from commandbutton within w_update_sales_order
end type
type cb_save from commandbutton within w_update_sales_order
end type
type cb_delete from commandbutton within w_update_sales_order
end type
type cb_add from commandbutton within w_update_sales_order
end type
type dw_items from datawindow within w_update_sales_order
end type
type dw_order from datawindow within w_update_sales_order
end type
end forward

global type w_update_sales_order from w_center
integer x = 370
integer y = 348
integer width = 1774
integer height = 1244
string title = "Update Sales Order"
long backcolor = 79741120
cb_help cb_help
cb_close cb_close
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
dw_items dw_items
dw_order dw_order
end type
global w_update_sales_order w_update_sales_order

type variables
Boolean	ib_RowChanged = False, &
	ib_SaveNeeded = False
Integer	ii_OrderNo

Boolean ib_DeletingRow = False
end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_get_max_line ()
public function integer of_validate_data (integer ai_row)
public function integer of_save ()
end prototypes

public function integer of_retrieve ();Integer		li_Order, li_RC

li_Order = dw_order.Object.id[dw_order.GetRow()]

li_RC = dw_order.Retrieve(li_Order)

If li_RC < 1 Then Return li_RC

ii_OrderNo = li_Order

Return dw_items.Retrieve(li_Order)

end function

public function integer of_get_max_line ();Integer		li_Max, li_Cnt, li_Rows, li_Line

li_Rows = dw_items.RowCount()
For li_Cnt = 1 To li_Rows
	li_Line = Integer(dw_items.Object.line_id[li_Cnt])
	If li_Line > li_Max Then
		li_Max = li_Line
	End If
Next

Return li_Max
end function

public function integer of_validate_data (integer ai_row);//When no row is getting focus, validation is not needed
If ai_Row = 0 Then
	Return 0
End If
//When deleting a row, validation is also not needed
If ib_DeletingRow = True Then
	Return 0
End If

If IsNull(dw_items.Object.prod_id[ai_Row]) Or (dw_items.Object.prod_id[ai_Row] = 0) Then
	MessageBox("Invalid Data", "A Product ID must be selected.", Exclamation!)
	Return 1
End If

If Not DateTime(dw_items.Object.ship_date[ai_Row]) >= DateTime(dw_order.Object.order_date[dw_order.GetRow()]) Then
	MessageBox("Invalid Data", "The Ship Date must be greater than or equal to the Order Date.", Exclamation!)
	Return 1
End If

If Not dw_items.Object.quantity[ai_Row] > 0 Then
	MessageBox("Invalid Data", "Quantity must be greater than 0.", Exclamation!)
	Return 1
End If

Return 0

end function

public function integer of_save ();dw_order.Update()
dw_items.Update()

ib_RowChanged = False
ib_SaveNeeded = False

Return 1

end function

on w_update_sales_order.create
int iCurrent
call super::create
this.cb_help=create cb_help
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_items=create dw_items
this.dw_order=create dw_order
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_help
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.dw_items
this.Control[iCurrent+7]=this.dw_order
end on

on w_update_sales_order.destroy
call super::destroy
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_items)
destroy(this.dw_order)
end on

event open;call super::open;dw_order.SetTransObject(sqlca)
dw_order.InsertRow(0)

dw_items.SetTransObject(sqlca)
dw_items.SetRowFocusIndicator(Hand!)

end event

event close;w_main.Show()

end event

event closequery;Integer		li_RC

If ib_SaveNeeded Then
	li_RC = MessageBox("Warning", "Changes have been made to the data.  Do you wish to save before closing?", Question!, YesNoCancel!, 1)
	If li_RC = 1 Then
		cb_save.Trigger Event clicked()
		Return 0
	ElseIf li_RC = 2 Then
		Return 0
	Else
		Return 1
	End If
End If

end event

type cb_help from commandbutton within w_update_sales_order
integer x = 1385
integer y = 992
integer width = 293
integer height = 108
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Help"
end type

event clicked;String				ls_Win

ls_win = parent.ClassName()

f_open_help(ls_win)

end event

type cb_close from commandbutton within w_update_sales_order
integer x = 1079
integer y = 992
integer width = 293
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;Close(Parent)

end event

type cb_save from commandbutton within w_update_sales_order
integer x = 645
integer y = 992
integer width = 293
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
end type

event clicked;If ib_RowChanged Then
	If of_validate_data(dw_items.GetRow()) = 0 Then
		of_save()
	Else
		dw_items.SetFocus()
	End If
Else
	of_save()
End If


end event

type cb_delete from commandbutton within w_update_sales_order
integer x = 343
integer y = 992
integer width = 293
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete Item"
end type

event clicked;ib_DeletingRow = True
dw_items.DeleteRow(dw_items.GetRow())
ib_DeletingRow = False

ib_SaveNeeded = True

end event

type cb_add from commandbutton within w_update_sales_order
integer x = 41
integer y = 992
integer width = 293
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Item"
end type

event clicked;Integer		li_Row

li_Row = dw_items.InsertRow(0)

dw_items.Object.id[li_Row] = ii_OrderNo
dw_items.Object.line_id[li_Row] = of_get_max_line() + 1

dw_items.ScrollToRow(li_Row)

ib_SaveNeeded = True
ib_RowChanged = True

end event

type dw_items from datawindow within w_update_sales_order
integer x = 41
integer y = 416
integer width = 1637
integer height = 540
integer taborder = 20
string dataobject = "d_update_sales_order_items"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;ib_RowChanged = True
ib_SaveNeeded = True

end event

event rowfocuschanging;If ib_RowChanged Then Return of_validate_data(currentrow)

end event

event rowfocuschanged;ib_RowChanged = False

end event

event losefocus;This.AcceptText()

end event

type dw_order from datawindow within w_update_sales_order
integer y = 8
integer width = 1719
integer height = 376
integer taborder = 10
string dataobject = "d_update_sales_order"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String	ls_Object

ls_Object = String(dwo.name)

If ls_Object = "id" Then
	If ib_RowChanged Then
		If of_validate_data(dw_items.GetRow()) = 1 Then
			This.Object.id[This.GetRow()] = ii_OrderNo
			dw_items.SetFocus()
			Return
		End If
	End If
	
	Post of_retrieve()
End If

end event

