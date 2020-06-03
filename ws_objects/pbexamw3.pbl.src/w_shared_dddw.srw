$PBExportHeader$w_shared_dddw.srw
$PBExportComments$Example of sharing DropDownDataWindows.
forward
global type w_shared_dddw from w_center
end type
type cb_help from commandbutton within w_shared_dddw
end type
type cb_close from commandbutton within w_shared_dddw
end type
type cb_delete from commandbutton within w_shared_dddw
end type
type cb_insert from commandbutton within w_shared_dddw
end type
type cb_reset from commandbutton within w_shared_dddw
end type
type cb_retrieve from commandbutton within w_shared_dddw
end type
type dw_sales_orders from datawindow within w_shared_dddw
end type
type cbx_share from checkbox within w_shared_dddw
end type
end forward

global type w_shared_dddw from w_center
int X=168
int Y=369
int Width=2596
int Height=1188
boolean TitleBar=true
string Title="Sharing DropDownDataWindows"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
cb_help cb_help
cb_close cb_close
cb_delete cb_delete
cb_insert cb_insert
cb_reset cb_reset
cb_retrieve cb_retrieve
dw_sales_orders dw_sales_orders
cbx_share cbx_share
end type
global w_shared_dddw w_shared_dddw

type variables
// Handles to DropDownDataWindows
datawindowchild   idw_customer
datawindowchild   idw_sales_rep
datawindowchild   idw_fin_code
end variables

on w_shared_dddw.create
this.cb_help=create cb_help
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.cb_reset=create cb_reset
this.cb_retrieve=create cb_retrieve
this.dw_sales_orders=create dw_sales_orders
this.cbx_share=create cbx_share
this.Control[]={ this.cb_help,&
this.cb_close,&
this.cb_delete,&
this.cb_insert,&
this.cb_reset,&
this.cb_retrieve,&
this.dw_sales_orders,&
this.cbx_share}
end on

on w_shared_dddw.destroy
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.cb_reset)
destroy(this.cb_retrieve)
destroy(this.dw_sales_orders)
destroy(this.cbx_share)
end on

event close;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_shared_dddw
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Show the front-end for the Code Examples
w_main.Show()
end event

event open;call super::open;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_shared_dddw
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Set the transaction object
dw_sales_orders.SetTransObject (sqlca)

// For this example, retrieve as needed will be turned off
dw_sales_orders.Object.datawindow.retrieve.asneeded = 'no'

// Obtain references to the DropDownDataWindows
dw_sales_orders.GetChild ("cust_id", idw_customer)
dw_sales_orders.GetChild ("sales_rep", idw_sales_rep)
dw_sales_orders.GetChild ("fin_code_id", idw_fin_code)

// Open the window containing the primary DropDownDataWindows
Open (w_master_dddw)




end event

type cb_help from commandbutton within w_shared_dddw
int X=2184
int Y=580
int Width=342
int Height=93
int TabOrder=50
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_help
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Display help for this window
f_open_help (parent.ClassName())
end event

type cb_close from commandbutton within w_shared_dddw
int X=2184
int Y=452
int Width=342
int Height=93
int TabOrder=60
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_close
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Close the window containing the primary DropDownDataWindows
if IsValid (w_master_dddw) then
	Close (w_master_dddw)
end if

// Close parent window
close (parent)
end event

type cb_delete from commandbutton within w_shared_dddw
int X=2184
int Y=349
int Width=342
int Height=93
int TabOrder=70
boolean Enabled=false
string Text="&Delete Row"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_delete
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//	Delete the current row from the DataWindow
dw_sales_orders.DeleteRow (0)
dw_sales_orders.SetFocus()

// If the datawindow does not have any rows left, disable it.
if dw_sales_orders.RowCount() = 0 then
	this.enabled = false
end if
end event

type cb_insert from commandbutton within w_shared_dddw
int X=2184
int Y=244
int Width=342
int Height=93
int TabOrder=40
string Text="&Insert Row"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_insert
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


long	ll_cur_row, &
		ll_new_row
		
// Insert a row into the DataWindow prior to the current row
ll_cur_row = dw_sales_orders.GetRow()
ll_new_row = dw_sales_orders.InsertRow(ll_cur_row)
dw_sales_orders.ScrollToRow(ll_new_row)
dw_sales_orders.SetColumn(1)
dw_sales_orders.SetFocus()

// Enable the Delete Row button
cb_delete.enabled = true
end event

type cb_reset from commandbutton within w_shared_dddw
int X=2184
int Y=141
int Width=342
int Height=93
int TabOrder=30
string Text="R&eset"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_reset
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Reset the DataWindow
dw_sales_orders.Reset()

// Disable the Delete Row button
cb_delete.enabled = false
end event

type cb_retrieve from commandbutton within w_shared_dddw
int X=2184
int Y=36
int Width=342
int Height=93
int TabOrder=20
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_retrieve
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Retrieve the DataWindow
dw_sales_orders.Retrieve()

// Enable the Delete Row button, if necessary
if dw_sales_orders.RowCount() > 0 then
	cb_delete.enabled = true
end if
end event

type dw_sales_orders from datawindow within w_shared_dddw
int X=40
int Y=151
int Width=2088
int Height=893
int TabOrder=10
string DataObject="d_sales_orders"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cbx_share from checkbox within w_shared_dddw
int X=40
int Y=33
int Width=897
int Height=71
string Text="Share DropDownDataWindows"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cbx_share
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// 	Share DropDownDataWindows with the DataWindows on w_master_dddw
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


// Check to see if w_master_dddw is open (where primary DataWindows are located)
if not IsValid (w_master_dddw) then
	MessageBox ("Error", "Window containing primary DataWindows is not open", exclamation!)
	return
end if

if this.checked then
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Share data between DataWindows on w_master_dddw and DropDownDataWindows
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if w_master_dddw.dw_customers.ShareData (idw_customer) = -1 then
		MessageBox ("Error", "Unable to share customer data", exclamation!)
	end if

	if w_master_dddw.dw_sales_reps.ShareData (idw_sales_rep) = -1 then
		MessageBox ("Error", "Unable to share sales reps data", exclamation!)
	end if

	if w_master_dddw.dw_fin_codes.ShareData (idw_fin_code) = -1 then
		MessageBox ("Error", "Unable to share financial codes data", exclamation!)
	end if
else
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// Stop sharing data
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	w_master_dddw.dw_customers.ShareDataOff()
	w_master_dddw.dw_sales_reps.ShareDataOff()
	w_master_dddw.dw_fin_codes.ShareDataOff()
end if
	
end event

