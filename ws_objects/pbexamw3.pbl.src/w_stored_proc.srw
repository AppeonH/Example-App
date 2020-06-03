$PBExportHeader$w_stored_proc.srw
$PBExportComments$Stored Procedure source DataWindows example
forward
global type w_stored_proc from w_center
end type
type dw_cust from datawindow within w_stored_proc
end type
type cb_help from commandbutton within w_stored_proc
end type
type cb_close from commandbutton within w_stored_proc
end type
type dw_prod_info from datawindow within w_stored_proc
end type
type dw_prod_graph from datawindow within w_stored_proc
end type
type dw_sales_orders from datawindow within w_stored_proc
end type
end forward

global type w_stored_proc from w_center
int X=4
int Y=17
int Width=2920
int Height=1898
boolean TitleBar=true
string Title="Stored Procedure Source DataWindows Example"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_open pbm_custom01
dw_cust dw_cust
cb_help cb_help
cb_close cb_close
dw_prod_info dw_prod_info
dw_prod_graph dw_prod_graph
dw_sales_orders dw_sales_orders
end type
global w_stored_proc w_stored_proc

type variables
integer   ii_cust_id
end variables

on ue_open;DataWindowChild	ldw_child


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set transaction objects
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_prod_graph.SetTransObject (sqlca)
dw_prod_info.SetTransObject (sqlca)
dw_sales_orders.SetTransObject (sqlca)


///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Retrieve customers list
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_cust.GetChild ("cust_id", ldw_child)
ldw_child.SetTransObject (sqlca)
ldw_child.Retrieve()

dw_cust.InsertRow (0)



end on

on close;w_main.Show()
end on

on open;this.PostEvent ("ue_open")
end on

on w_stored_proc.create
this.dw_cust=create dw_cust
this.cb_help=create cb_help
this.cb_close=create cb_close
this.dw_prod_info=create dw_prod_info
this.dw_prod_graph=create dw_prod_graph
this.dw_sales_orders=create dw_sales_orders
this.Control[]={ this.dw_cust,&
this.cb_help,&
this.cb_close,&
this.dw_prod_info,&
this.dw_prod_graph,&
this.dw_sales_orders}
end on

on w_stored_proc.destroy
destroy(this.dw_cust)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.dw_prod_info)
destroy(this.dw_prod_graph)
destroy(this.dw_sales_orders)
end on

type dw_cust from datawindow within w_stored_proc
int X=33
int Y=39
int Width=680
int Height=103
int TabOrder=40
string DataObject="d_choose_customer"
boolean Border=false
end type

on itemchanged;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// A new customer has been selected, retrieve the product orders graph
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

ii_cust_id = Integer (this.GetText())
dw_prod_graph.Retrieve (ii_cust_id)


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Reset the product info and sales orders DataWindows
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_prod_info.Reset()
dw_sales_orders.Reset()
end on

type cb_help from commandbutton within w_stored_proc
int X=2614
int Y=173
int Width=246
int Height=100
int TabOrder=60
string Text="&Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help (parent.ClassName())
end on

type cb_close from commandbutton within w_stored_proc
int X=2614
int Y=39
int Width=246
int Height=100
int TabOrder=50
string Text="&Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type dw_prod_info from datawindow within w_stored_proc
int X=11
int Y=977
int Width=1096
int Height=797
int TabOrder=10
string DataObject="d_product_info"
boolean Border=false
end type

type dw_prod_graph from datawindow within w_stored_proc
int X=22
int Y=180
int Width=2497
int Height=733
int TabOrder=20
string DataObject="d_cust_products"
BorderStyle BorderStyle=StyleLowered!
end type

on clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Retrieve the product and sales order data for the category (product) that was clicked on
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

grObjectType	le_type
int				li_series, &
				li_category, &
				li_product_id


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Find out where the user clicked on the graph
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
le_type = this.ObjectAtPointer ("gr_1", li_series, li_category)


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If user clicked on a category, retrieve the product information and sales orders
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if le_type = TypeData!  or le_type = TypeCategory!  then
	li_product_id  = Integer (this.CategoryName ("gr_1", li_category))

	SetPointer (hourglass!)
	dw_prod_info.Retrieve (li_product_id)
	dw_sales_orders.Retrieve (ii_cust_id, li_product_id)
end if
end on

type dw_sales_orders from datawindow within w_stored_proc
int X=1145
int Y=977
int Width=1721
int Height=781
int TabOrder=30
string DataObject="d_sp_orders"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

