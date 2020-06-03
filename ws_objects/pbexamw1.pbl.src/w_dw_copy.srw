$PBExportHeader$w_dw_copy.srw
$PBExportComments$Copy data from one DataWindow to another using an array of structures
forward
global type w_dw_copy from w_center
end type
type cb_rowscopy from commandbutton within w_dw_copy
end type
type st_rowscopy from statictext within w_dw_copy
end type
type st_5 from statictext within w_dw_copy
end type
type cb_array from commandbutton within w_dw_copy
end type
type st_array from statictext within w_dw_copy
end type
type st_4 from statictext within w_dw_copy
end type
type st_7 from statictext within w_dw_copy
end type
type st_6 from statictext within w_dw_copy
end type
type st_2 from statictext within w_dw_copy
end type
type st_clipboard from statictext within w_dw_copy
end type
type st_getitem from statictext within w_dw_copy
end type
type st_1 from statictext within w_dw_copy
end type
type st_3 from statictext within w_dw_copy
end type
type st_direct from statictext within w_dw_copy
end type
type cb_clipboard from commandbutton within w_dw_copy
end type
type cb_getitem from commandbutton within w_dw_copy
end type
type cb_close from commandbutton within w_dw_copy
end type
type cb_help from commandbutton within w_dw_copy
end type
type cb_direct from commandbutton within w_dw_copy
end type
type dw_dest from datawindow within w_dw_copy
end type
type dw_source from datawindow within w_dw_copy
end type
end forward

type os_data from structure
	integer		id
	integer		line_id
	integer		prod_id
	integer		quantity
	datetime		ship_date
end type

global type w_dw_copy from w_center
int X=4
int Y=4
int Width=2767
int Height=1850
boolean TitleBar=true
string Title="DataWindow Copy"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_postopen ( )
cb_rowscopy cb_rowscopy
st_rowscopy st_rowscopy
st_5 st_5
cb_array cb_array
st_array st_array
st_4 st_4
st_7 st_7
st_6 st_6
st_2 st_2
st_clipboard st_clipboard
st_getitem st_getitem
st_1 st_1
st_3 st_3
st_direct st_direct
cb_clipboard cb_clipboard
cb_getitem cb_getitem
cb_close cb_close
cb_help cb_help
cb_direct cb_direct
dw_dest dw_dest
dw_source dw_source
end type
global w_dw_copy w_dw_copy

type variables
Long	il_Begin, il_Rows

end variables

forward prototypes
public function double of_calctime ()
end prototypes

event ue_postopen;SetPointer(HourGlass!)

dw_source.SetTransObject(sqlca)
il_Rows = dw_source.Retrieve()

end event

public function double of_calctime ();Long		ll_End
Double	ldb_Diff

ll_End = CPU()

ldb_Diff = (ll_End - il_Begin) / 1000

Return ldb_Diff

end function

event open;call super::open;Post Event ue_postopen()

end event

on w_dw_copy.create
this.cb_rowscopy=create cb_rowscopy
this.st_rowscopy=create st_rowscopy
this.st_5=create st_5
this.cb_array=create cb_array
this.st_array=create st_array
this.st_4=create st_4
this.st_7=create st_7
this.st_6=create st_6
this.st_2=create st_2
this.st_clipboard=create st_clipboard
this.st_getitem=create st_getitem
this.st_1=create st_1
this.st_3=create st_3
this.st_direct=create st_direct
this.cb_clipboard=create cb_clipboard
this.cb_getitem=create cb_getitem
this.cb_close=create cb_close
this.cb_help=create cb_help
this.cb_direct=create cb_direct
this.dw_dest=create dw_dest
this.dw_source=create dw_source
this.Control[]={ this.cb_rowscopy,&
this.st_rowscopy,&
this.st_5,&
this.cb_array,&
this.st_array,&
this.st_4,&
this.st_7,&
this.st_6,&
this.st_2,&
this.st_clipboard,&
this.st_getitem,&
this.st_1,&
this.st_3,&
this.st_direct,&
this.cb_clipboard,&
this.cb_getitem,&
this.cb_close,&
this.cb_help,&
this.cb_direct,&
this.dw_dest,&
this.dw_source}
end on

on w_dw_copy.destroy
destroy(this.cb_rowscopy)
destroy(this.st_rowscopy)
destroy(this.st_5)
destroy(this.cb_array)
destroy(this.st_array)
destroy(this.st_4)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_2)
destroy(this.st_clipboard)
destroy(this.st_getitem)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_direct)
destroy(this.cb_clipboard)
destroy(this.cb_getitem)
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.cb_direct)
destroy(this.dw_dest)
destroy(this.dw_source)
end on

event close;Show(w_main)

end event

type cb_rowscopy from commandbutton within w_dw_copy
event clicked pbm_bnclicked
int X=25
int Y=449
int Width=690
int Height=87
int TabOrder=50
string Text="Copy Using RowsCopy()"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

// First, reset the destination DataWindow
dw_dest.Reset()

// Start Timer
il_Begin = CPU()

// Copy the data to the destination DataWindow
dw_source.RowsCopy(1, il_Rows, Primary!, dw_dest, 1, Primary!)

// Display Time
st_rowscopy.Text = String(of_calctime())

end event

type st_rowscopy from statictext within w_dw_copy
int X=751
int Y=449
int Width=207
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_dw_copy
int X=975
int Y=458
int Width=221
int Height=65
boolean Enabled=false
string Text="seconds"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_array from commandbutton within w_dw_copy
event clicked pbm_bnclicked
int X=25
int Y=237
int Width=690
int Height=87
int TabOrder=30
string Text="Copy Using Structure Array"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;os_data	lstr_Data[]

SetPointer(HourGlass!)

// First, reset the destination DataWindow
dw_dest.Reset()

// Start Timer
il_Begin = CPU()

// Copy the data from the source DataWindow to the array of structures
lstr_Data = dw_source.Object.Data

// Copy the data from the array of structures to the destination DataWindow
dw_dest.Object.Data = lstr_Data

// Display Time
st_array.Text = String(of_calctime())

end event

type st_array from statictext within w_dw_copy
int X=751
int Y=237
int Width=207
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_dw_copy
int X=975
int Y=247
int Width=221
int Height=65
boolean Enabled=false
string Text="seconds"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_dw_copy
int X=1369
int Y=586
int Width=363
int Height=65
boolean Enabled=false
string Text="Destination"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_dw_copy
int X=15
int Y=586
int Width=313
int Height=65
boolean Enabled=false
string Text="Source"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_dw_copy
int X=975
int Y=141
int Width=221
int Height=65
boolean Enabled=false
string Text="seconds"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_clipboard from statictext within w_dw_copy
int X=751
int Y=132
int Width=207
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_getitem from statictext within w_dw_copy
int X=751
int Y=26
int Width=207
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_dw_copy
int X=975
int Y=36
int Width=221
int Height=65
boolean Enabled=false
string Text="seconds"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_dw_copy
int X=975
int Y=353
int Width=221
int Height=65
boolean Enabled=false
string Text="seconds"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_direct from statictext within w_dw_copy
int X=751
int Y=343
int Width=207
int Height=87
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_clipboard from commandbutton within w_dw_copy
event clicked pbm_bnclicked
int X=25
int Y=132
int Width=690
int Height=87
int TabOrder=20
string Text="Copy Using Clipboard"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

// First, reset the destination DataWindow
dw_dest.Reset()

// Start Timer
il_Begin = CPU()

// Copy the data to the clipboard
dw_source.SaveAs("", Clipboard!, False)

// Copy the data from the clipboard to the destination DataWindow
dw_dest.ImportClipboard()

// Display Time
st_clipboard.Text = String(of_calctime())

end event

type cb_getitem from commandbutton within w_dw_copy
event clicked pbm_bnclicked
int X=25
int Y=26
int Width=690
int Height=87
int TabOrder=10
string Text="Copy Using GetItem/SetItem"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long			ll_Cnt
Integer		li_Data
DateTime	ldt_Data

SetPointer(HourGlass!)

// First, reset the destination DataWindow and turn redraw off
dw_dest.Reset()
dw_dest.SetRedraw(False)

// Start Timer
il_Begin = CPU()

For ll_Cnt = 1 To il_Rows
	
	// Insert a blank row
	dw_dest.InsertRow(0)
	
	// Copy data from the source DataWindow using GetItem...
	// And write it to the destination DataWindow using SetItem
	li_Data = dw_source.GetItemNumber(ll_Cnt, "id")
	dw_dest.SetItem(ll_Cnt, "id", li_Data)
	
	li_Data = dw_source.GetItemNumber(ll_Cnt, "line_id")
	dw_dest.SetItem(ll_Cnt, "line_id", li_Data)
	
	li_Data = dw_source.GetItemNumber(ll_Cnt, "prod_id")
	dw_dest.SetItem(ll_Cnt, "prod_id", li_Data)
	
	li_Data = dw_source.GetItemNumber(ll_Cnt, "quantity")
	dw_dest.SetItem(ll_Cnt, "quantity", li_Data)
	
	ldt_Data = dw_source.GetItemDateTime(ll_Cnt, "ship_date")
	dw_dest.SetItem(ll_Cnt, "ship_date", ldt_Data)
Next

// Display Time
st_getitem.Text = String(of_calctime())

dw_dest.SetRedraw(True)

end event

type cb_close from commandbutton within w_dw_copy
int X=2390
int Y=129
int Width=303
int Height=87
int TabOrder=70
string Text="Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_help from commandbutton within w_dw_copy
int X=2390
int Y=26
int Width=303
int Height=87
int TabOrder=60
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help("w_dw_copy")

end event

type cb_direct from commandbutton within w_dw_copy
int X=25
int Y=343
int Width=690
int Height=87
int TabOrder=40
string Text="Copy Using Direct Reference"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer(HourGlass!)

// First, reset the destination DataWindow
dw_dest.Reset()

// Start Timer
il_Begin = CPU()

// Copy the data to the destination DataWindow
dw_dest.Object.Data = dw_source.Object.Data

// Display Time
st_direct.Text = String(of_calctime())

end event

type dw_dest from datawindow within w_dw_copy
int X=1369
int Y=657
int Width=1323
int Height=1085
string DataObject="d_items"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_source from datawindow within w_dw_copy
int X=15
int Y=657
int Width=1323
int Height=1085
string DataObject="d_items"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

