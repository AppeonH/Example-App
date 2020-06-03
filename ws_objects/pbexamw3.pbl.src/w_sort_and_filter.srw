$PBExportHeader$w_sort_and_filter.srw
$PBExportComments$Uses a variety of datawindow functions including sort and filter
forward
global type w_sort_and_filter from w_center
end type
type cb_1 from commandbutton within w_sort_and_filter
end type
type st_1 from statictext within w_sort_and_filter
end type
type ddlb_data from dropdownlistbox within w_sort_and_filter
end type
type cb_filter from commandbutton within w_sort_and_filter
end type
type cb_close from commandbutton within w_sort_and_filter
end type
type ddlb_filtercol from dropdownlistbox within w_sort_and_filter
end type
type cb_retrieve from commandbutton within w_sort_and_filter
end type
type cb_print from commandbutton within w_sort_and_filter
end type
type cb_insert from commandbutton within w_sort_and_filter
end type
type cb_delete from commandbutton within w_sort_and_filter
end type
type cb_update from commandbutton within w_sort_and_filter
end type
type dw_1 from datawindow within w_sort_and_filter
end type
type ddlb_sortcol from dropdownlistbox within w_sort_and_filter
end type
type rb_desc from radiobutton within w_sort_and_filter
end type
type rb_asc from radiobutton within w_sort_and_filter
end type
type ddlb_op from dropdownlistbox within w_sort_and_filter
end type
type gb_2 from groupbox within w_sort_and_filter
end type
type gb_1 from groupbox within w_sort_and_filter
end type
end forward

global type w_sort_and_filter from w_center
int X=1
int Y=1
int Width=2994
int Height=1962
boolean TitleBar=true
string Title="Sort & Filter Example"
string MenuName="m_sort_and_filter"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
event ue_postopen pbm_custom06
event ue_insert_dw pbm_custom08
event ue_delete_dw pbm_custom09
event ue_update_dw pbm_custom10
event ue_print_dw pbm_custom11
event ue_retrieve_dw ( )
cb_1 cb_1
st_1 st_1
ddlb_data ddlb_data
cb_filter cb_filter
cb_close cb_close
ddlb_filtercol ddlb_filtercol
cb_retrieve cb_retrieve
cb_print cb_print
cb_insert cb_insert
cb_delete cb_delete
cb_update cb_update
dw_1 dw_1
ddlb_sortcol ddlb_sortcol
rb_desc rb_desc
rb_asc rb_asc
ddlb_op ddlb_op
gb_2 gb_2
gb_1 gb_1
end type
global w_sort_and_filter w_sort_and_filter

type variables
string is_sort_sequence


end variables

forward prototypes
public subroutine wf_reset_ddlb ()
public subroutine wf_sort_dw (string as_column, string as_sort_sequence)
public subroutine wf_filter_dw ()
end prototypes

event ue_postopen;////////////////////////////////////////////////////////////////////////////////////////////////////////
//ue_postopen script for w_sort_and_filter
////////////////////////////////////////////////////////////////////////////////////////////////////////

//This will set the transaction object for the datawindow dw_1.
//The Transaction object must be set before retrieving data into a datawindow.
dw_1.SetTransObject(sqlca)

//This will cause the user defined event retrieve_dw to be executed
Trigger Event ue_retrieve_dw()

end event

event ue_insert_dw;////////////////////////////////////////////////////////////////////////////////////////////////////////
//ue_insert_dw script for w_sort_and_filter
////////////////////////////////////////////////////////////////////////////////////////////////////////

//insert a new row after current position and move current row to this new row
dw_1.InsertRow(dw_1.GetRow( )+1)
dw_1.SetRow(dw_1.GetRow( )+1)
dw_1.SetColumn(1)
f_Select_Current_Row(dw_1)

end event

event ue_delete_dw;////////////////////////////////////////////////////////////////////////////////////////////////////////
//ue_delete_dw script for w_sort_and_filter
////////////////////////////////////////////////////////////////////////////////////////////////////////

//delete current row and reset selected row
dw_1.DeleteRow(0)
f_Select_Current_Row(dw_1)
end event

event ue_update_dw;////////////////////////////////////////////////////////////////////////////////////////////////////////
//ue_update script for w_sort_and_filter
////////////////////////////////////////////////////////////////////////////////////////////////////////

int	li_rtn

li_rtn = dw_1.Update( )

// Error handling
If li_rtn = 1 then
	COMMIT using SQLCA ;
else
	ROLLBACK using SQLCA ;
end if

If SQLCA.SQLCode = -1 then
	MessageBox ('Error', SQLCA.SQLErrText, exclamation!)
End If



end event

event ue_print_dw;////////////////////////////////////////////////////////////////////////////////////////////////////////
//ue_print_dw script for w_sort_and_filter
////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_1.Print( )
end event

event ue_retrieve_dw;////////////////////////////////////////////////////////////////////////////////////////////////////////
//ue_retrieve script for w_sort_and_filter
////////////////////////////////////////////////////////////////////////////////////////////////////////

//call window function to reset the dialogs
wf_reset_ddlb()

//retrieve data into datawindow
dw_1.Retrieve( )

//function to select current row
f_select_current_row(dw_1)
end event

public subroutine wf_reset_ddlb ();int		li_column_count,li_counter
string 	ls_column_name

ddlb_data.reset()
ddlb_filtercol.reset()
cb_filter.text = "&Filter"
ddlb_sortcol.reset()

//fill sort column list box with column name as defined in the datawindow

//Get the number of columns on this datawindow.
li_column_count = Integer(dw_1.Object.DataWindow.Column.Count)

For li_counter =  li_column_count to 1 step -1
	ls_column_name = dw_1.Describe("#"+string(li_counter)+".Name")
	ddlb_sortcol.InsertItem(ls_column_name,1)
	ddlb_filtercol.InsertItem(ls_column_name,1)
Next

ddlb_sortcol.text = ls_column_name
is_sort_sequence = "a"
rb_asc.Checked=True
wf_sort_dw(ddlb_sortcol.Text,is_sort_sequence)


dw_1.setfilter("")
dw_1.filter()

end subroutine

public subroutine wf_sort_dw (string as_column, string as_sort_sequence);dw_1.SetSort(as_column + " " + as_sort_sequence)
dw_1.Sort()
end subroutine

public subroutine wf_filter_dw ();string ls_quote, ls_column_name, ls_match_data, ls_filter

If ddlb_filtercol.text = "id" then 
	ls_quote = ""
	ls_column_name = Trim(ddlb_filtercol.text)
	ls_match_data = ddlb_data.text
Else 
	ls_quote = "'"
	ls_column_name = "upper("+Trim(ddlb_filtercol.text)+")"
	ls_match_data = Upper(ddlb_data.text)
End if

ls_filter =  ls_column_name + ddlb_op.text + 	ls_quote + ls_match_data + ls_quote


// Setls_filterer sets ls_filterer criteria, but does not execute ls_filterer. ls_filterer
// is required to execute ls_filterer and change display.

dw_1.Setfilter(ls_filter)
dw_1.filter( )

//reselect current row
f_select_current_row(dw_1)
end subroutine

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////////////////////
//Open script for w_sort_and_filter
////////////////////////////////////////////////////////////////////////////////////////////////////////

//This window will load a datawindow and perform various functions on it.
//The Sort and Filter Column DDLB's are dynamically loaded from the current datawindow

this.postevent("ue_postopen")

end event

on w_sort_and_filter.create
if this.MenuName = "m_sort_and_filter" then this.MenuID = create m_sort_and_filter
this.cb_1=create cb_1
this.st_1=create st_1
this.ddlb_data=create ddlb_data
this.cb_filter=create cb_filter
this.cb_close=create cb_close
this.ddlb_filtercol=create ddlb_filtercol
this.cb_retrieve=create cb_retrieve
this.cb_print=create cb_print
this.cb_insert=create cb_insert
this.cb_delete=create cb_delete
this.cb_update=create cb_update
this.dw_1=create dw_1
this.ddlb_sortcol=create ddlb_sortcol
this.rb_desc=create rb_desc
this.rb_asc=create rb_asc
this.ddlb_op=create ddlb_op
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={ this.cb_1,&
this.st_1,&
this.ddlb_data,&
this.cb_filter,&
this.cb_close,&
this.ddlb_filtercol,&
this.cb_retrieve,&
this.cb_print,&
this.cb_insert,&
this.cb_delete,&
this.cb_update,&
this.dw_1,&
this.ddlb_sortcol,&
this.rb_desc,&
this.rb_asc,&
this.ddlb_op,&
this.gb_2,&
this.gb_1}
end on

on w_sort_and_filter.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.ddlb_data)
destroy(this.cb_filter)
destroy(this.cb_close)
destroy(this.ddlb_filtercol)
destroy(this.cb_retrieve)
destroy(this.cb_print)
destroy(this.cb_insert)
destroy(this.cb_delete)
destroy(this.cb_update)
destroy(this.dw_1)
destroy(this.ddlb_sortcol)
destroy(this.rb_desc)
destroy(this.rb_asc)
destroy(this.ddlb_op)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event close;////////////////////////////////////////////////////////////////////////////////////////////////////////
//Close script for w_sort_and_filter
////////////////////////////////////////////////////////////////////////////////////////////////////////

w_main.Show( )
end event

type cb_1 from commandbutton within w_sort_and_filter
int X=2536
int Y=1172
int Width=338
int Height=97
int TabOrder=140
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for cb_help
////////////////////////////////////////////////////////////////////////////////////////////////////////

f_open_help(parent.ClassName( ))
end event

type st_1 from statictext within w_sort_and_filter
int X=43
int Y=4
int Width=2827
int Height=116
boolean Enabled=false
string Text="Use the Sort and Filter options to change the DataWindow below. Use the buttons on the right side of the screen to use the basic row functions of the DataWindow."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_data from dropdownlistbox within w_sort_and_filter
int X=2294
int Y=212
int Width=577
int Height=493
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=true
boolean VScrollBar=true
boolean AllowEdit=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;////////////////////////////////////////////////////////////////////////////////////////////////////////
//selectionchanged script for ddlb_data
////////////////////////////////////////////////////////////////////////////////////////////////////////

//Apply filter to new criteria if a filter is already in place (button will have unfilter on it)
If cb_filter.text = "Un&filter" Then wf_filter_dw()
end event

type cb_filter from commandbutton within w_sort_and_filter
int X=2518
int Y=321
int Width=338
int Height=97
int TabOrder=40
string Text="&Filter"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for cb_filter
////////////////////////////////////////////////////////////////////////////////////////////////////////


//Apply the filter selected
//This button will allow the filtered datawindow to be unfiltered by clicking again 
//on the button

string filt,quote

string	ls_column_name

string 	ls_match_data

//If the filter is on a text field, the compairson of the two strings will be made case insensitive
//by converting the column and comparsion string to upper case.
//If the field is numeric, a straight comparison is used.
If cb_filter.Text = "Un&filter" then
	cb_filter.Text = "&Filter"
	filt=""
	dw_1.Setfilter(filt)
	dw_1.filter( )
Else
	cb_filter.Text = "Un&filter"
	wf_filter_dw()
End If
end event

type cb_close from commandbutton within w_sort_and_filter
int X=2536
int Y=1044
int Width=338
int Height=97
int TabOrder=130
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for cb_close
////////////////////////////////////////////////////////////////////////////////////////////////////////

//close main window
close(parent)
end event

type ddlb_filtercol from dropdownlistbox within w_sort_and_filter
int X=1526
int Y=212
int Width=577
int Height=493
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=true
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;////////////////////////////////////////////////////////////////////////////////////////////////////////
//selectionchanged script for ddlb_filtercol
////////////////////////////////////////////////////////////////////////////////////////////////////////

//This script will load the ddlb.data with unique values for the column that was selected.

dwBuffer	le_buffertype
Int			li_buffers, li_items, li_index
Long 		ll_row_counter, ll_rows_buffer
String 		ls_column_name,ls_col_type,ls_insert_item
String		ls_buffertype


SetPointer(Hourglass!)

//Reset the filter status back to unfiltered
If cb_filter.text = "Un&filter" Then cb_filter.Triggerevent(clicked!)

//get column name from the datawindow that was selected
ls_column_name = ddlb_filtercol.text

//clear out the data drop down list box
ddlb_data.Reset()

//determine if the column selected is numeric or strings
ls_col_type = dw_1.Describe(ls_column_name+".ColType")

//This is the routine that will actually load the data into the ddlb.data from datawindow dw_1
//To do this, two passes are required because the data in the datawindow may already
//be filtered. The first pass will load data from the appropriate column of data already
//visible (Primary buffer). The second pass will load data from the appropriate column if
//some rows have already been filtered.
//There are two types of "Get" from the datawindow, getitemstring and getitemnumber,
//which is depent of the type of row selected.
le_buffertype = Primary!
ll_rows_buffer = dw_1.RowCount()

For li_buffers = 1 to 2
	For ll_row_counter = 1 to ll_rows_buffer
		If left(ls_col_type,4) = "char" then
			ls_insert_item = Trim(dw_1.GetItemString(ll_row_counter, ls_column_name, &
									le_buffertype, False))
		ElseIf ls_col_type = "number" then
			ls_insert_item = String(dw_1.GetItemnumber(ll_row_counter, ls_column_name, &
									le_buffertype, False))
		End If

		ddlb_data.InsertItem(ls_insert_item,1)
	Next
	le_buffertype=Filter!
	ll_rows_buffer=dw_1.FilteredCount()
Next

//Resort the data in listbox
ddlb_data.Sorted=True
ddlb_data.Visible=True

//After all of the rows have been added to the listbox, this will go through the sorted listbox
//and remove all duplicate row. This is more efficient than preventing a duplicate inserted 
//row.
li_items = ddlb_data.TotalItems()
li_index = 1
Do While li_index <= li_items - 1
	If ddlb_data.text(li_index) = ddlb_data.text(li_index+1) Then
		li_items = ddlb_data.DeleteItem ( li_index )
	Else
		li_index ++
	End If
Loop

end event

type cb_retrieve from commandbutton within w_sort_and_filter
int X=2536
int Y=484
int Width=338
int Height=97
int TabOrder=20
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for cb_retrieve
////////////////////////////////////////////////////////////////////////////////////////////////////////

//run user defined event in main window called "retrieve_dw"
Parent.Trigger Event ue_retrieve_dw()
end event

type cb_print from commandbutton within w_sort_and_filter
int X=2536
int Y=916
int Width=338
int Height=97
int TabOrder=100
string Text="&Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for cb_print
////////////////////////////////////////////////////////////////////////////////////////////////////////

//run user defined event in main window called "print_dw"
parent.TriggerEvent("ue_print_dw")

end event

type cb_insert from commandbutton within w_sort_and_filter
int X=2536
int Y=804
int Width=338
int Height=97
int TabOrder=90
string Text="&Insert Row"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for cb_insert
////////////////////////////////////////////////////////////////////////////////////////////////////////

//run user defined event in main window called "insert_dw"
parent.TriggerEvent("ue_insert_dw")
end event

type cb_delete from commandbutton within w_sort_and_filter
int X=2536
int Y=701
int Width=338
int Height=97
int TabOrder=60
string Text="&Delete Row"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for cb_delete
////////////////////////////////////////////////////////////////////////////////////////////////////////

//run user defined event in main window called "delete_dw"
parent.TriggerEvent("ue_delete_dw")

end event

type cb_update from commandbutton within w_sort_and_filter
int X=2536
int Y=593
int Width=338
int Height=97
int TabOrder=50
string Text="&Update"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for cb_update
////////////////////////////////////////////////////////////////////////////////////////////////////////

//run user defined event in main window called "update_dw"
parent.TriggerEvent("ue_update_dw")

end event

type dw_1 from datawindow within w_sort_and_filter
int X=43
int Y=484
int Width=2450
int Height=1245
int TabOrder=120
string DataObject="d_cust"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event itemfocuschanged;////////////////////////////////////////////////////////////////////////////////////////////////////////
//itemfocuschanged script for dw_1
////////////////////////////////////////////////////////////////////////////////////////////////////////

//Call window function to move the selected row to match the cursor position
f_select_current_row(dw_1)
end event

type ddlb_sortcol from dropdownlistbox within w_sort_and_filter
int X=104
int Y=212
int Width=577
int Height=493
int TabOrder=30
string Text="id"
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=true
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;////////////////////////////////////////////////////////////////////////////////////////////////////////
//selectionchanged script for ddlb_sortcol
////////////////////////////////////////////////////////////////////////////////////////////////////////

// The currently selected column name is 
// Concatenated with the sort_sequence,
// set by the radio buttons (A - ascending or D - descending and
// use as the sort criteria in WF_Sort_DW. 

//window function to handle sorting of datawindow
Wf_Sort_Dw(ddlb_sortcol.text,is_sort_sequence)

end event

type rb_desc from radiobutton within w_sort_and_filter
int X=843
int Y=289
int Width=417
int Height=77
string Text="Descending"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for rb_desc
////////////////////////////////////////////////////////////////////////////////////////////////////////

//Will change sort order to descending

//send the selected column name and sort order to the window function
//to resort datawindow
//is_sort_sequence holds the sort order
is_sort_sequence="d"
wf_sort_dw(ddlb_sortcol.text,is_sort_sequence)
end event

type rb_asc from radiobutton within w_sort_and_filter
int X=843
int Y=212
int Width=392
int Height=77
string Text="Ascending"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for rb_asc
////////////////////////////////////////////////////////////////////////////////////////////////////////


//Will change sort order to ascending

//send the selected column name and sort order to the window function
//to resort datawindow
//is_sort_sequence holds the sort order
is_sort_sequence="a"
wf_sort_dw(ddlb_sortcol.text,is_sort_sequence)
end event

type ddlb_op from dropdownlistbox within w_sort_and_filter
int X=2116
int Y=212
int Width=161
int Height=493
int TabOrder=110
string Text="="
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean AutoHScroll=true
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"=",&
"<",&
">",&
"<=",&
">=",&
"<>"}
end type

event selectionchanged;////////////////////////////////////////////////////////////////////////////////////////////////////////
//selectionchanged script for ddlb_op
////////////////////////////////////////////////////////////////////////////////////////////////////////

//Reset the filter status back to unfiltered
If cb_filter.text = "Un&filter" Then cb_filter.Triggerevent(clicked!)
end event

type gb_2 from groupbox within w_sort_and_filter
int X=1476
int Y=145
int Width=1409
int Height=305
int TabOrder=10
string Text="Filter Column:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_sort_and_filter
int X=54
int Y=145
int Width=1409
int Height=305
string Text="Sort On Column:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

