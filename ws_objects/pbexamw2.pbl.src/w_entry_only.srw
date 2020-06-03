$PBExportHeader$w_entry_only.srw
$PBExportComments$A sales order entry window that allows rows to be inserted into the DataWindow but not modified.
forward
global type w_entry_only from w_center
end type
type st_windowback from statictext within w_entry_only
end type
type st_buttonface from statictext within w_entry_only
end type
type cb_delete from commandbutton within w_entry_only
end type
type cb_update from commandbutton within w_entry_only
end type
type cb_retrieve from commandbutton within w_entry_only
end type
type cb_insert from commandbutton within w_entry_only
end type
type cb_close from commandbutton within w_entry_only
end type
type dw_1 from datawindow within w_entry_only
end type
end forward

global type w_entry_only from w_center
int X=427
int Y=413
int Width=2066
int Height=1098
boolean TitleBar=true
string Title="Add-Only DataWindow"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_windowback st_windowback
st_buttonface st_buttonface
cb_delete cb_delete
cb_update cb_update
cb_retrieve cb_retrieve
cb_insert cb_insert
cb_close cb_close
dw_1 dw_1
end type
global w_entry_only w_entry_only

type variables
// Keeps track of the rows that cannot be deleted
long   il_perm_count
end variables

event open;call super::open;dw_1.SetTransObject (sqlca)

end event

on close;w_main.Show()
end on

on w_entry_only.create
this.st_windowback=create st_windowback
this.st_buttonface=create st_buttonface
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.cb_insert=create cb_insert
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={ this.st_windowback,&
this.st_buttonface,&
this.cb_delete,&
this.cb_update,&
this.cb_retrieve,&
this.cb_insert,&
this.cb_close,&
this.dw_1}
end on

on w_entry_only.destroy
destroy(this.st_windowback)
destroy(this.st_buttonface)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.cb_retrieve)
destroy(this.cb_insert)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type st_windowback from statictext within w_entry_only
int X=1743
int Y=749
int Width=193
int Height=65
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_buttonface from statictext within w_entry_only
int X=1732
int Y=647
int Width=193
int Height=65
boolean Visible=false
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_delete from commandbutton within w_entry_only
int X=1682
int Y=257
int Width=342
int Height=93
int TabOrder=20
boolean Enabled=false
string Text="&Delete Row"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Delete the current row of the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_1.SetRedraw (false)
dw_1.DeleteRow (0)

// Disable the Delete Row button if there are no more new rows
if il_perm_count = dw_1.RowCount() then
	cb_delete.enabled = false
else
	dw_1.SetColumn (1)
	dw_1.SetFocus()
end if

dw_1.SetRedraw (true)
end on

type cb_update from commandbutton within w_entry_only
int X=1682
int Y=365
int Width=342
int Height=93
int TabOrder=60
boolean Enabled=false
string Text="&Update"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Update the DataWindow
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_1.SetRedraw (false)
if dw_1.Update() = -1 then
	rollback;
else
	commit;
end if
dw_1.SetRedraw (true)
end on

type cb_retrieve from commandbutton within w_entry_only
int X=1682
int Y=39
int Width=342
int Height=93
int TabOrder=30
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//dw_1.SetRedraw (false)
dw_1.Retrieve()
//dw_1.SetRedraw (true)
end on

type cb_insert from commandbutton within w_entry_only
int X=1682
int Y=148
int Width=342
int Height=93
int TabOrder=50
string Text="&Add Row"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Insert a new row into the DataWindow prior to the current row.
//
// The expression for the protect attribute for the DataWindow columns, set in the DataWindow
// painter, will evaluate whether the row is new.  If the row is new, the column will not be 
// protected.  If the row is not new, the column will be protected.  An expression for the background
// color attribute will similarly determine that the background is white for columns on new rows, 
// and light gray for columns on other rows.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
long	ll_new_row


cb_delete.enabled = true
cb_update.enabled = true


ll_new_row = dw_1.InsertRow(0)

dw_1.SetFocus()
dw_1.ScrollToRow(ll_new_row)
dw_1.SetColumn(1)

end on

type cb_close from commandbutton within w_entry_only
int X=1682
int Y=471
int Width=342
int Height=93
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// close the window
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

close (parent)
end on

type dw_1 from datawindow within w_entry_only
int X=57
int Y=61
int Width=1572
int Height=881
int TabOrder=10
string DataObject="d_sales_order_items"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on retrieveend;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Enable command buttons
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
il_perm_count = this.RowCount()

cb_delete.enabled = false
cb_insert.enabled = true
cb_retrieve.enabled = true
cb_update.enabled = false


end on

on retrievestart;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Disable command buttons
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
cb_delete.enabled = false
cb_insert.enabled = false
cb_retrieve.enabled = false
cb_update.enabled = false
end on

