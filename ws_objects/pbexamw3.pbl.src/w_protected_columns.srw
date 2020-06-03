$PBExportHeader$w_protected_columns.srw
$PBExportComments$Update the data in the sales order table, only allowing modifications to the region specifed.
forward
global type w_protected_columns from w_center
end type
type sle_color from singlelineedit within w_protected_columns
end type
type ddlb_region from dropdownlistbox within w_protected_columns
end type
type st_1 from statictext within w_protected_columns
end type
type cb_help from commandbutton within w_protected_columns
end type
type cb_delete from commandbutton within w_protected_columns
end type
type cb_update from commandbutton within w_protected_columns
end type
type cb_insert from commandbutton within w_protected_columns
end type
type cb_close from commandbutton within w_protected_columns
end type
type dw_1 from datawindow within w_protected_columns
end type
end forward

global type w_protected_columns from w_center
integer x = 110
integer y = 4
integer width = 2629
integer height = 1840
string title = "Attribute Expressions"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event ue_open pbm_custom01
sle_color sle_color
ddlb_region ddlb_region
st_1 st_1
cb_help cb_help
cb_delete cb_delete
cb_update cb_update
cb_insert cb_insert
cb_close cb_close
dw_1 dw_1
end type
global w_protected_columns w_protected_columns

type variables
string   is_region
end variables

event ue_open;////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_open script for w_protected_columns
////////////////////////////////////////////////////////////////////////////////////////////////////////

// Set the transaction object
dw_1.SetTransObject (sqlca)

// Retrieve the region specified in the Region DropDownListBox.
is_region = ddlb_region.text
ddlb_region.TriggerEvent (selectionchanged!)

end event

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_protected_columns
////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_1.Object.backcolor.Expression = String(sle_color.BackColor)
dw_1.Object.windowcolor.Expression = String(sle_color.TextColor)

// Post a user-defined event for DataWindow retrieval.  This allows the window to be
// displayed faster when it is opened.
this.PostEvent ("ue_open")
end event

event close;////////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_protected_columns
////////////////////////////////////////////////////////////////////////////////////////////////////////

w_main.Show()
end event

on w_protected_columns.create
int iCurrent
call super::create
this.sle_color=create sle_color
this.ddlb_region=create ddlb_region
this.st_1=create st_1
this.cb_help=create cb_help
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.cb_insert=create cb_insert
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_color
this.Control[iCurrent+2]=this.ddlb_region
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_help
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_update
this.Control[iCurrent+7]=this.cb_insert
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.dw_1
end on

on w_protected_columns.destroy
call super::destroy
destroy(this.sle_color)
destroy(this.ddlb_region)
destroy(this.st_1)
destroy(this.cb_help)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.cb_insert)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type sle_color from singlelineedit within w_protected_columns
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 1086902488
long backcolor = 74481808
boolean autohscroll = false
integer x = 1545
integer y = 60
integer width = 192
integer height = 80
integer taborder = 10
boolean visible = false
end type

type ddlb_region from dropdownlistbox within w_protected_columns
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
string text = "Central"
boolean vscrollbar = true
string item[] = {"Eastern","Western","Central","South","Canada"}
borderstyle borderstyle = stylelowered!
integer x = 727
integer y = 64
integer width = 370
integer height = 424
integer taborder = 20
end type

event selectionchanged;////////////////////////////////////////////////////////////////////////////////////////////////////////
// selectionchanged script for ddlb_region
////////////////////////////////////////////////////////////////////////////////////////////////////////

// Retrieve the DataWindow, passing the current selection of the ddlb as the retrieval argument.
long	ll_row
is_region = this.text
dw_1.Retrieve(is_region)

// Scroll to the first row that is not protected
ll_row = dw_1.Find("region = '" + is_region + "'", 1, dw_1.RowCount())
if ll_row > 0 then
	dw_1.SetFocus()
	dw_1.ScrollToRow(ll_row)
	dw_1.SetColumn(1)
end if


end event

type st_1 from statictext within w_protected_columns
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Allow modifications to Region:"
boolean focusrectangle = false
integer x = 55
integer y = 76
integer width = 672
integer height = 72
end type

type cb_help from commandbutton within w_protected_columns
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Help"
integer x = 1865
integer y = 1620
integer width = 343
integer height = 88
integer taborder = 50
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_help
////////////////////////////////////////////////////////////////////////////////////////////////////////

f_open_help (parent.ClassName())
end event

type cb_delete from commandbutton within w_protected_columns
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Delete Row"
integer x = 727
integer y = 1620
integer width = 343
integer height = 88
integer taborder = 40
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_delete
////////////////////////////////////////////////////////////////////////////////////////////////////////

integer	li_currentrow

// Delete the current row of the DataWindow
dw_1.DeleteRow (0)
dw_1.SetFocus()
dw_1.Trigger Event rowfocuschanged (dw_1.GetRow())

// Enable the update button
cb_update.enabled = true
end event

type cb_update from commandbutton within w_protected_columns
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Update"
integer x = 1097
integer y = 1620
integer width = 343
integer height = 88
integer taborder = 80
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_update
////////////////////////////////////////////////////////////////////////////////////////////////////////
int li_rc

// Update the DataWindow
if dw_1.Update() = -1 then
	rollback using sqlca ;
	if sqlca.sqlcode <> 0 then
		messagebox ( "RollBack Failed", sqlca.sqlerrtext ) 
	end if
else
	commit using sqlca ;
	if sqlca.sqlcode <> 0 then
		messagebox ( "Commit Failed", sqlca.sqlerrtext ) 
	end if
	this.enabled = false
end if

end event

type cb_insert from commandbutton within w_protected_columns
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Insert Row"
integer x = 361
integer y = 1620
integer width = 343
integer height = 88
integer taborder = 70
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_insert
////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Insert a new row into the DataWindow prior to the current row.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_new_row, &
		ll_get_row


dw_1.SetRedraw (false)
ll_get_row = dw_1.GetRow()
ll_new_row = dw_1.InsertRow(ll_get_row)

// Automatically fill in data for the region, order date columns
dw_1.Object.region[ll_new_row] = is_region
dw_1.Object.order_date[ll_new_row] = Today()

dw_1.SetFocus()
dw_1.ScrollToRow(ll_new_row)
dw_1.SetColumn(1)

dw_1.SetRedraw(true)

// Enable the update button
cb_update.enabled = true
end event

type cb_close from commandbutton within w_protected_columns
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
integer x = 1472
integer y = 1620
integer width = 343
integer height = 88
integer taborder = 60
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_cancel
////////////////////////////////////////////////////////////////////////////////////////////////////////
close (parent)
end event

type dw_1 from datawindow within w_protected_columns
string dataobject = "d_region_sales"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
integer x = 55
integer y = 232
integer width = 2455
integer height = 1332
integer taborder = 30
end type

event rowfocuschanged;////////////////////////////////////////////////////////////////////////////////////////////////////////
// rowfocuschanged script for dw_1
////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Enable the delete button if the current row is a new or modified row, or if the row has not
// been modified and the region is equal to the region specified by the user.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dwItemStatus	l_status
string			ls_region

if currentrow > 0 then
	l_status = dw_1.GetItemStatus (currentrow, 0, primary!)
	ls_region = dw_1.Object.region[currentrow]
	
	if l_status <> NotModified! or &
		(l_status = NotModified! and is_region = ls_region) then
		cb_delete.enabled = true
	else
		cb_delete.enabled = false
	end if
else
	cb_delete.enabled = false
end if

end event

event retrievestart;////////////////////////////////////////////////////////////////////////////////////////////////////////
// retrievestart script for dw_1
////////////////////////////////////////////////////////////////////////////////////////////////////////

// Disable command buttons and ddlb
cb_delete.enabled = false
cb_insert.enabled = false
cb_update.enabled = false
cb_close.enabled = false
ddlb_region.enabled = false
end event

event retrieverow;////////////////////////////////////////////////////////////////////////////////////////////////////////
// retrieverow script for dw_1
////////////////////////////////////////////////////////////////////////////////////////////////////////

SetPointer (hourglass!)
end event

event retrieveend;////////////////////////////////////////////////////////////////////////////////////////////////////////
// retrieveend script for dw_1
////////////////////////////////////////////////////////////////////////////////////////////////////////

// Enable command buttons and ddlb
cb_insert.enabled = true
cb_close.enabled = true
ddlb_region.enabled = true

end event

event itemchanged;/////////////////////////////////////////////////////////////////////////////////////////////////////
// itemchanged script for dw_1
/////////////////////////////////////////////////////////////////////////////////////////////////////

// Enable the update button
cb_update.enabled = true
end event

