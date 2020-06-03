$PBExportHeader$u_selection_list.sru
$PBExportComments$Selects entry as user types characters
forward
global type u_selection_list from userobject
end type
type dw_1 from datawindow within u_selection_list
end type
type cb_ok from commandbutton within u_selection_list
end type
type cb_cancel from commandbutton within u_selection_list
end type
type sle_find from singlelineedit within u_selection_list
end type
type st_1 from statictext within u_selection_list
end type
end forward

global type u_selection_list from userobject
integer width = 1321
integer height = 1276
boolean border = true
long backcolor = 78682240
long tabtextcolor = 33554432
event ue_entry_chosen pbm_custom01
dw_1 dw_1
cb_ok cb_ok
cb_cancel cb_cancel
sle_find sle_find
st_1 st_1
end type
global u_selection_list u_selection_list

type variables
long   il_selectedrow

string  is_filter
end variables

forward prototypes
public function string create_datawindow (transaction trans, string select_statement)
public function string return_selected ()
end prototypes

public function string create_datawindow (transaction trans, string select_statement);// String Function CREATE_DATAWINDOW (transaction TRANS,
//												  string SELECT_STATEMENT)
// for U_SELECTION_LIST

string	ls_dwSyntax, &
		ls_create_error, &
		ls_rc, &
		ls_modstring
ls_dwSyntax = trans.SyntaxFromSQL ( select_statement, "", ls_create_error)

if Len(ls_dwSyntax) > 0 then
	dw_1.Create (ls_dwSyntax)
	dw_1.SetTransObject (trans)
	dw_1.SetSort ("1A")
	dw_1.SetTabOrder (1, 0)		// Protect the first column
	dw_1.Retrieve ()
	sle_find.SetFocus ()

// Clear out anything left from previous use of this UO

	il_selectedrow = 0
	is_filter = ""
	sle_find.text = ""
else
	MessageBox ("Error", "Error creating DataWindow:  " + ls_create_error)
end if

//change background color to gray (non editable)
ls_modstring = "DataWindow.Detail.Color = 12632256 " + & 
	"DataWindow.Header.Color = 12632256 DataWindow.Footer.Color = 12632256 " + &
	"DataWindow.Summary.Color = 12632256 DataWindow.Color = 12632256 "

ls_rc = dw_1.Modify(ls_modstring)
If ls_rc <> "" Then MessageBox ("Error Color Change",ls_rc)

return ""
end function

public function string return_selected ();// String Function RETURN_SELECTED () in U_SELECTION_LIST

string	ls_return_val

if il_selectedrow > 0 then
	ls_return_val = GetItemString (dw_1, il_selectedrow, 1)
else
	ls_return_val = ""
end if

return ls_return_val
end function

on u_selection_list.create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.sle_find=create sle_find
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.cb_ok,&
this.cb_cancel,&
this.sle_find,&
this.st_1}
end on

on u_selection_list.destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.sle_find)
destroy(this.st_1)
end on

type dw_1 from datawindow within u_selection_list
integer x = 50
integer y = 152
integer width = 1170
integer height = 956
integer taborder = 40
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

on doubleclicked;// DoubleClicked Script for dw_1

cb_ok.TriggerEvent(Clicked!)
end on

event clicked;// Clicked Script for dw_1 

// Un-highlight old row
dw_1.SelectRow(il_selectedrow, FALSE)	

//Get new row
il_selectedrow = row

//seletion of row set text to this row and set filter to this
if il_selectedrow <> 0 Then
	dw_1.SelectRow(0,False)
	dw_1.SelectRow(il_selectedrow, TRUE)		// Highlight new row
	sle_find.text = dw_1.GetItemString(il_selectedrow, 1)
	is_filter = sle_find.text
End If


end event

type cb_ok from commandbutton within u_selection_list
integer x = 233
integer y = 1132
integer width = 279
integer height = 104
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

on clicked;// Clicked script for cb_ok

parent.TriggerEvent("ue_entry_chosen")
end on

type cb_cancel from commandbutton within u_selection_list
integer x = 704
integer y = 1132
integer width = 279
integer height = 104
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

on clicked;// Clicked script for cb_cancel
// Reset box to none selected, no text

dw_1.SetRedraw(FALSE)
dw_1.SelectRow(il_selectedrow, FALSE)
dw_1.ScrollToRow(1)
dw_1.SetRedraw(TRUE)
sle_find.text = ""
is_filter = ""
il_selectedrow = 0
sle_find.SetFocus()

parent.TriggerEvent("ue_entry_chosen")
end on

type sle_find from singlelineedit within u_selection_list
event key_pressed pbm_keydown
integer x = 183
integer y = 20
integer width = 983
integer height = 96
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "arrow!"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event key_pressed;// Key_Pressed Script for sle_find

// key pressed in datawindow
// capture up and down arrows to move the selection up and down

int li_movement 
long ll_row

If KeyDown (keyUparrow!) then
	li_movement = -1
End If


If KeyDown (keyDownarrow!) then
	li_movement = 1
End If

If li_movement <> 0 Then
	dw_1.SetRedraw(False)
	ll_row = dw_1.GetSelectedRow(0)
	ll_row = ll_row + li_movement
	If ll_row < 1 or ll_row > dw_1.RowCount( ) Then 
		Beep(1)
		Return
	End If
	dw_1.selectrow(0,False)
	dw_1.SelectRow(ll_row , True)
	dw_1.ScrollToRow (ll_row)
	sle_find.text = dw_1.GetItemString(ll_row , 1)
	is_filter = sle_find.text
	il_selectedrow = ll_row
	dw_1.SetRedraw(True)
	sle_find.SelectText(len(sle_find.text) + 1,0)
	message.processed = true
	Return
End If


string	ls_character
long	ll_found_row
int		li_num_chars

ls_character = Char(message.wordparm)

//filter out non alpha characters
//CR149983
If ls_character <> " " Then
	If (Lower(ls_character) < "a" or Lower(ls_character) > "z") and  ls_character <> Char(8) Then 
		message.processed = true
		Return
	End If
End If

// Backspace 
If message.wordparm = 8   then
	li_num_chars = Len(is_filter)
	If li_num_chars > 0 then is_filter = Left(is_filter, li_num_chars -1)		
else
	is_filter = is_filter + ls_character
end if



// Do case-insensitive search
If Len(is_filter) > 0 Then
	ll_found_row = dw_1.Find("Lower(#1)>=~"" + Lower(is_filter) + "~"",1, 99999)
	If ll_found_row > 0 then 
		dw_1.SetRedraw(FALSE)
		dw_1.SelectRow(0, FALSE)
		dw_1.ScrollToRow(ll_found_row)
		dw_1.SelectRow(ll_found_row, TRUE)
		dw_1.SetRedraw(TRUE)
// is_filterer function did not find any matching row
	Else
            Beep(1)
		li_num_chars = Len(is_filter)
		If li_num_chars > 0 Then is_filter = Left(is_filter, li_num_chars -1)		
// Throw away last character
		message.processed = true
	End If
// is_filterer length is 0, so unhighlight former selected row
Else	
	dw_1.SelectRow(0, FALSE)
End If

// Remember number of highlighted row
il_selectedrow = ll_found_row			

	
end event

type st_1 from statictext within u_selection_list
integer x = 32
integer y = 32
integer width = 137
integer height = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 78682240
string text = "Find:"
end type

