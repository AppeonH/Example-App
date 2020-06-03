$PBExportHeader$w_mult_tab_update.srw
$PBExportComments$Shows technique to allow multiple table updates from a single DataWindow
forward
global type w_mult_tab_update from w_center
end type
type cb_retrieve from commandbutton within w_mult_tab_update
end type
type cb_close from commandbutton within w_mult_tab_update
end type
type cb_update from commandbutton within w_mult_tab_update
end type
type dw_sale_cust from datawindow within w_mult_tab_update
end type
end forward

global type w_mult_tab_update from w_center
integer x = 201
integer y = 260
integer width = 2583
integer height = 1400
string title = "Multiple Table Update with Single DataWindow"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event ue_postopen pbm_custom01
cb_retrieve cb_retrieve
cb_close cb_close
cb_update cb_update
dw_sale_cust dw_sale_cust
end type
global w_mult_tab_update w_mult_tab_update

on ue_postopen;dw_sale_cust.settransobject(sqlca)
dw_sale_cust.retrieve()

Commit using Sqlca;
end on

on open;this.postevent("ue_postopen")
end on

on w_mult_tab_update.create
int iCurrent
call super::create
this.cb_retrieve=create cb_retrieve
this.cb_close=create cb_close
this.cb_update=create cb_update
this.dw_sale_cust=create dw_sale_cust
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_retrieve
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_update
this.Control[iCurrent+4]=this.dw_sale_cust
end on

on w_mult_tab_update.destroy
call super::destroy
destroy(this.cb_retrieve)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.dw_sale_cust)
end on

on close;show(w_main)
end on

type cb_retrieve from commandbutton within w_mult_tab_update
integer x = 1074
integer y = 1132
integer width = 311
integer height = 104
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Retrieve"
end type

on clicked;dw_sale_cust.reset()
dw_sale_cust.retrieve()
Commit using Sqlca;
end on

type cb_close from commandbutton within w_mult_tab_update
integer x = 1449
integer y = 1132
integer width = 297
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

on clicked;close(parent)

end on

type cb_update from commandbutton within w_mult_tab_update
integer x = 713
integer y = 1132
integer width = 297
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Update"
end type

event clicked;int li_rc
string ls_err
string ls_mod

//The DataWindow is setup to update the sales order table first. 
//Perform that update
li_rc =dw_sale_cust.Update(true,false)

If li_rc = 1 Then
	//turn off update of sales_order columns
	ls_mod = "sales_order_order_date.Update=No "
	ls_mod= ls_mod + "sales_order_sales_rep.Update=No "
	ls_mod= ls_mod + "sales_order_region.Update=No "
	ls_mod= ls_mod + "sales_order_id.Key=No "
		
	//make customer table the new update table and set its key.
	ls_mod= ls_mod + "DataWindow.Table.UpdateTable='customer' "
	ls_mod= ls_mod + "customer_id.Key=Yes "

	//Turn on update for customer columns
	ls_mod= ls_mod + "customer_fname.Update=Yes "
	ls_mod= ls_mod + "customer_lname.Update=Yes "
	ls_mod= ls_mod + "customer_address.Update=Yes "
	ls_mod= ls_mod + "customer_city.Update=Yes "
	ls_mod= ls_mod + "customer_state.Update=Yes "
	ls_mod= ls_mod + "customer_zip.Update=Yes "
	ls_mod= ls_mod + "customer_phone.Update=Yes "

	//update DataWindow and check return code
	ls_err = dw_sale_cust.modify(ls_mod)
	If ls_err <> "" Then Messagebox("DataWindow Modify Error",ls_err)

	//Update the customer table
	li_rc = dw_sale_cust.Update()
	If li_rc = 1 Then
		COMMIT using sqlca;
		If sqlca.sqlcode <> 0 Then
			Messagebox("Error on Commit",Sqlca.sqlerrtext)
		End If
	else
		Messagebox("Update of Customer Table Failed","Rolling back changes to " +&
			"Sales Order and Customer Tables")
		ROLLBACK using sqlca;
	End If
Else //the update of sales order failed... display message and rollback changed
	Messagebox("Update of Sales Order Table Failed","Rolling back changes to " +&
		"Sales Order Table")
	ROLLBACK using sqlca;
End If


//Reset the DataWindow back to its original state.
//turn on update of sales_order columns
ls_mod = "sales_order_order_date.Update=Yes "
ls_mod= ls_mod + "sales_order_sales_rep.Update=Yes "
ls_mod= ls_mod + "sales_order_region.Update=Yes "
ls_mod= ls_mod + "DataWindow.Table.UpdateTable='sales_order' "
ls_mod= ls_mod + "sales_order_id.Key=Yes "	

//Turn off update for customer columns
ls_mod= ls_mod + "customer_fname.Update=No "
ls_mod= ls_mod + "customer_lname.Update=No "
ls_mod= ls_mod + "customer_address.Update=No "
ls_mod= ls_mod + "customer_city.Update=No "
ls_mod= ls_mod + "customer_state.Update=No "
ls_mod= ls_mod + "customer_zip.Update=No "
ls_mod= ls_mod + "customer_phone.Update=No "
ls_mod= ls_mod + "customer_id.Key=No "

//update DataWindow and check return code
ls_err = dw_sale_cust.modify(ls_mod)
If ls_err <> "" Then Messagebox("DataWindow Modify Error",ls_err)
end event

type dw_sale_cust from datawindow within w_mult_tab_update
integer x = 23
integer y = 20
integer width = 2501
integer height = 1036
integer taborder = 10
string dataobject = "d_sales_cust_update"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

