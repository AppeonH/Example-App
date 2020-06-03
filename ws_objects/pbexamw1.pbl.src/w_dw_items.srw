$PBExportHeader$w_dw_items.srw
$PBExportComments$Demonstrates use of item vs text in a datawindow; use of accept text as well as itemchanged event
forward
global type w_dw_items from w_center
end type
type sle_item from singlelineedit within w_dw_items
end type
type sle_text from singlelineedit within w_dw_items
end type
type cb_help from commandbutton within w_dw_items
end type
type dw_1 from datawindow within w_dw_items
end type
type st_item_label from statictext within w_dw_items
end type
type st_text_label from statictext within w_dw_items
end type
type cb_close from commandbutton within w_dw_items
end type
type cb_3 from commandbutton within w_dw_items
end type
end forward

global type w_dw_items from w_center
int X=105
int Y=132
int Width=2702
int Height=1660
boolean TitleBar=true
string Title="DataWindow Column Text Value vs. Item Value"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_postopen pbm_custom01
sle_item sle_item
sle_text sle_text
cb_help cb_help
dw_1 dw_1
st_item_label st_item_label
st_text_label st_text_label
cb_close cb_close
cb_3 cb_3
end type
global w_dw_items w_dw_items

type variables

end variables

on ue_postopen;dw_1.SetTransObject (sqlca)
dw_1.Retrieve()
end on

on close;//Close script for w_dw_items

w_main.Show()

end on

on w_dw_items.create
this.sle_item=create sle_item
this.sle_text=create sle_text
this.cb_help=create cb_help
this.dw_1=create dw_1
this.st_item_label=create st_item_label
this.st_text_label=create st_text_label
this.cb_close=create cb_close
this.cb_3=create cb_3
this.Control[]={ this.sle_item,&
this.sle_text,&
this.cb_help,&
this.dw_1,&
this.st_item_label,&
this.st_text_label,&
this.cb_close,&
this.cb_3}
end on

on w_dw_items.destroy
destroy(this.sle_item)
destroy(this.sle_text)
destroy(this.cb_help)
destroy(this.dw_1)
destroy(this.st_item_label)
destroy(this.st_text_label)
destroy(this.cb_close)
destroy(this.cb_3)
end on

on open;//Open script for w_dw_items
//Retrieve data in post open for faster window visible
this.postevent("ue_postopen")

end on

type sle_item from singlelineedit within w_dw_items
int X=229
int Y=148
int Width=777
int Height=72
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_text from singlelineedit within w_dw_items
int X=229
int Y=48
int Width=777
int Height=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_help from commandbutton within w_dw_items
int X=2263
int Y=316
int Width=370
int Height=108
int TabOrder=40
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help ('w_dw_items')
end on

type dw_1 from datawindow within w_dw_items
int X=41
int Y=268
int Width=2162
int Height=1252
int TabOrder=10
string DataObject="d_retrieve_cust"
boolean VScrollBar=true
boolean LiveScroll=true
end type

on editchanged;/////////////////////////////////////////////////////////////////////
// 
// Purpose: to show the text value of the current column changing
//				as data is entered by the user.	
// 
// Log:
//	
//	  DATE	WHO	WHAT
//	--------	---	----
//	04/11/94	mco	initial version
//
/////////////////////////////////////////////////////////////////////


sle_text.text = dw_1.GetText()

end on

on itemfocuschanged;/////////////////////////////////////////////////////////////////////
// 
// Purpose: to show the text and item values of the current column
//		
// 
// Log:
//	
//	  DATE	WHO	WHAT
//	--------	---	----
//	04/11/94	mco	initial version
//
/////////////////////////////////////////////////////////////////////

string	ls_val


// Read & display the column data
if this.GetColumnName() = 'id' then
	ls_val = String (this.GetItemNumber (this.GetRow(), this.GetColumn()))
else
	ls_val = this.GetItemString (this.GetRow(), this.GetColumn())
end if

sle_text.text = ls_val
sle_item.text = ls_val


	
end on

type st_item_label from statictext within w_dw_items
int X=41
int Y=148
int Width=165
int Height=72
boolean Enabled=false
string Text="Item:"
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

type st_text_label from statictext within w_dw_items
int X=41
int Y=48
int Width=160
int Height=72
boolean Enabled=false
string Text="Text:"
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

type cb_close from commandbutton within w_dw_items
int X=2263
int Y=172
int Width=370
int Height=108
int TabOrder=30
string Text="Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Clicked script for cb_close

Close (parent)
end on

type cb_3 from commandbutton within w_dw_items
int X=2263
int Y=48
int Width=370
int Height=108
int TabOrder=20
string Text="Accept Text"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;/////////////////////////////////////////////////////////////////////
// 
// Purpose: perform the AcceptText() function to dw_1 and redisplay
//				the current row/column item value.
// 
// Log:
//	
//	  DATE	WHO	WHAT
//	--------	---	----
//	04/11/94	mco	initial version
//
/////////////////////////////////////////////////////////////////////

if dw_1.AcceptText() = 1 then
	if dw_1.GetColumnName() = 'id' then
		sle_item.text = String (dw_1.GetItemNumber (dw_1.GetRow(), dw_1.GetColumn()))
	else
		sle_item.text = dw_1.GetItemString (dw_1.GetRow(), dw_1.GetColumn())
	end if	
end if



end on

