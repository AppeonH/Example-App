$PBExportHeader$w_populate_ddlb_from_db.srw
$PBExportComments$Fill DDLB at runtime from database using generalized function
forward
global type w_populate_ddlb_from_db from w_center
end type
type st_7 from statictext within w_populate_ddlb_from_db
end type
type st_num_items from statictext within w_populate_ddlb_from_db
end type
type st_5 from statictext within w_populate_ddlb_from_db
end type
type st_4 from statictext within w_populate_ddlb_from_db
end type
type st_3 from statictext within w_populate_ddlb_from_db
end type
type st_1 from statictext within w_populate_ddlb_from_db
end type
type dw_tables from datawindow within w_populate_ddlb_from_db
end type
type dw_columns from datawindow within w_populate_ddlb_from_db
end type
type st_2 from statictext within w_populate_ddlb_from_db
end type
type ddlb_from_db from dropdownlistbox within w_populate_ddlb_from_db
end type
type cb_cancel from commandbutton within w_populate_ddlb_from_db
end type
end forward

shared variables
string style_name [8] = &
    {"detail_top_margin",  &
     "detail_bottom_margin", &
     "vertical_spread", &
     "vertical_size", &
     "header_top_margin", &
     "header_bottom_margin", &
     "left_margin", &
     "horizontal_spread"}
string style_size [8] = {"1","1","1","1","1","1","1","1"}
end variables

global type w_populate_ddlb_from_db from w_center
int X=151
int Y=320
int Width=2633
int Height=1304
boolean TitleBar=true
string Title="Populate a DropDownListBox from the Database"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_7 st_7
st_num_items st_num_items
st_5 st_5
st_4 st_4
st_3 st_3
st_1 st_1
dw_tables dw_tables
dw_columns dw_columns
st_2 st_2
ddlb_from_db ddlb_from_db
cb_cancel cb_cancel
end type
global w_populate_ddlb_from_db w_populate_ddlb_from_db

type variables
string is_table

string is_object_type = "lb"

end variables

on open;//Open script for w_populate_ddlb_from_db

dw_columns.SetTransObject(sqlca)
dw_tables.SetTransObject(sqlca)

// In DW_TABLES, set proper SELECT statement for the current DBMS type 
if f_set_table_select(dw_tables) < 0 then
	MessageBox("Error", &
					"Unable to set SQL select statement for tables list", &
					StopSign!)
	this.TriggerEvent(Close!)
end if

//populate the tables datawindow w/valid tables from pb system table
dw_tables.Retrieve( )



end on

on w_populate_ddlb_from_db.create
this.st_7=create st_7
this.st_num_items=create st_num_items
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.dw_tables=create dw_tables
this.dw_columns=create dw_columns
this.st_2=create st_2
this.ddlb_from_db=create ddlb_from_db
this.cb_cancel=create cb_cancel
this.Control[]={this.st_7,&
this.st_num_items,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_1,&
this.dw_tables,&
this.dw_columns,&
this.st_2,&
this.ddlb_from_db,&
this.cb_cancel}
end on

on w_populate_ddlb_from_db.destroy
destroy(this.st_7)
destroy(this.st_num_items)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.dw_tables)
destroy(this.dw_columns)
destroy(this.st_2)
destroy(this.ddlb_from_db)
destroy(this.cb_cancel)
end on

on close;//Close script for w_w_populate_ddlb_from_db

this.Hide( )
w_main.Show()
end on

type st_7 from statictext within w_populate_ddlb_from_db
int X=1746
int Y=572
int Width=736
int Height=72
boolean Enabled=false
string Text="Items in Drop Down Listbox:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_num_items from statictext within w_populate_ddlb_from_db
int X=2002
int Y=652
int Width=183
int Height=72
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_populate_ddlb_from_db
int X=41
int Y=68
int Width=2501
int Height=116
boolean Enabled=false
string Text="After you select a table and column, the Drop Down List Box (3) will contain the values in the database for that column."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_populate_ddlb_from_db
int X=41
int Y=12
int Width=2048
int Height=72
boolean Enabled=false
string Text="This example will populate a Drop Down List Box at runtime from the database."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_populate_ddlb_from_db
int X=1737
int Y=296
int Width=727
int Height=72
boolean Enabled=false
string Text="3) View Drop Down List Box"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_populate_ddlb_from_db
int X=32
int Y=296
int Width=503
int Height=72
string Text="1) Select a Table:"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_tables from datawindow within w_populate_ddlb_from_db
int X=32
int Y=376
int Width=805
int Height=560
int TabOrder=20
string DataObject="d_table_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event clicked;// Clicked script for dw_tables

string 	ls_table_key

//Change pointer to hourglass
SetPointer(Hourglass!)

//if heading or side was clicked, an invalid row number is returned
If row < 1 Then return

//select the clicked row
dw_tables.SelectRow(0, False)
dw_tables.SelectRow(row, True)

//get the table name
is_table = Lower(dw_tables.object.tname[row])

// In DW_COLUMNS, set proper SELECT statement to retrieve column names
If f_set_column_select(dw_columns, is_table) < 0 Then
	MessageBox("Error", &
					"Unable to set SQL select statement for columns list", &
					StopSign!)
	this.TriggerEvent(Close!)
End If

//load the columns for that table
dw_columns.Retrieve( )	  /* Note:  Retrieve argument not used any
									  longer, as F_SET_COLUMN_SELECT inserts
									  the proper table name */

end event

type dw_columns from datawindow within w_populate_ddlb_from_db
int X=887
int Y=376
int Width=805
int Height=560
int TabOrder=30
string DataObject="d_column_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event clicked;//Clicked script for dw_columns

int		li_ret
string	ls_column

//Change pointer to hourglass
SetPointer(Hourglass!)

//if heading or side was clicked, an invalid row number is returned
If row < 1 Then return

//Highlight row
dw_columns.SelectRow(0, False)
dw_columns.SelectRow(row, True)

//Get the column name
ls_column = Lower(dw_columns.object.cname[row])

li_ret = f_populate_ddlb_from_db (is_table, ls_column, ddlb_from_db)

if li_ret <> 0 then
	MessageBox("Error!", sqlca.sqlerrtext)
else
	ddlb_from_db.SelectItem(1)
	st_num_items.text = String( ddlb_from_db.totalitems ( ))
end if


end event

type st_2 from statictext within w_populate_ddlb_from_db
int X=887
int Y=296
int Width=613
int Height=72
string Text="2) Select a Column:"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_from_db from dropdownlistbox within w_populate_ddlb_from_db
int X=1737
int Y=376
int Width=805
int Height=560
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_populate_ddlb_from_db
int X=1152
int Y=1004
int Width=352
int Height=104
int TabOrder=10
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_cancel

Close(parent)
end on

