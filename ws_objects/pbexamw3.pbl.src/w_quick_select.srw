$PBExportHeader$w_quick_select.srw
$PBExportComments$Quick Select Response dialog, illustrates Query Sort
forward
global type w_quick_select from w_center
end type
type rb_tabular from radiobutton within w_quick_select
end type
type rb_form from radiobutton within w_quick_select
end type
type rb_grid from radiobutton within w_quick_select
end type
type cb_addall from commandbutton within w_quick_select
end type
type st_16 from statictext within w_quick_select
end type
type st_15 from statictext within w_quick_select
end type
type st_14 from statictext within w_quick_select
end type
type st_13 from statictext within w_quick_select
end type
type st_12 from statictext within w_quick_select
end type
type st_11 from statictext within w_quick_select
end type
type mle_comments from multilineedit within w_quick_select
end type
type st_10 from statictext within w_quick_select
end type
type dw_criteria from datawindow within w_quick_select
end type
type dw_columns from datawindow within w_quick_select
end type
type dw_tables from datawindow within w_quick_select
end type
type st_9 from statictext within w_quick_select
end type
type st_8 from statictext within w_quick_select
end type
type cb_cancel from commandbutton within w_quick_select
end type
type cb_ok from commandbutton within w_quick_select
end type
type st_7 from statictext within w_quick_select
end type
type st_6 from statictext within w_quick_select
end type
type st_5 from statictext within w_quick_select
end type
type st_4 from statictext within w_quick_select
end type
type st_3 from statictext within w_quick_select
end type
type st_2 from statictext within w_quick_select
end type
type st_1 from statictext within w_quick_select
end type
type gb_styl from groupbox within w_quick_select
end type
end forward

global type w_quick_select from w_center
integer x = 192
integer y = 16
integer width = 2615
integer height = 1968
string title = "DataWindow Query Painter"
windowtype windowtype = popup!
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
rb_tabular rb_tabular
rb_form rb_form
rb_grid rb_grid
cb_addall cb_addall
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
st_12 st_12
st_11 st_11
mle_comments mle_comments
st_10 st_10
dw_criteria dw_criteria
dw_columns dw_columns
dw_tables dw_tables
st_9 st_9
st_8 st_8
cb_cancel cb_cancel
cb_ok cb_ok
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_styl gb_styl
end type
global w_quick_select w_quick_select

type variables
integer il_HighlightedTable, il_HighlightedColumn
String is_visiblecolumns[], is_TableName



end variables

forward prototypes
public function string wf_replace_underscores_with_spaces (string a_instring)
end prototypes

public function string wf_replace_underscores_with_spaces (string a_instring);// string Function wf_replace_underscores_with_spaces (string a_instring)

// Returns value of a_instring with each underscore replaced by a space character

int		p
string	s_in, s_out

s_in = a_instring
p = Pos ( s_in, '_' )

do while p > 0
	s_out =	s_out + Left ( s_in, p -1 ) + ' '
	s_in   = Mid ( s_in, p +1)	
	p = Pos (s_in, '_' )
loop

s_out = s_out + s_in

return  s_out

end function

event open;call super::open;// Open script for w_quick_select

dw_tables.SetTransObject (sqlca)
dw_columns.SetTransObject (sqlca)

//populate the tables datawindow
// f_set_table_select is a user function to modify the select used by
// the table selection data window, based on which DBMS we're connected
// to; This function adjusts to the differences in catalog structures
// between the DBMS's

if f_set_table_select(dw_tables) < 0 then
	MessageBox("Error", &
					"Unable to set SQL select statement for tables list", &
					StopSign!)
	this.TriggerEvent(Close!)
end if

dw_tables.Retrieve ()
end event

on w_quick_select.create
int iCurrent
call super::create
this.rb_tabular=create rb_tabular
this.rb_form=create rb_form
this.rb_grid=create rb_grid
this.cb_addall=create cb_addall
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.mle_comments=create mle_comments
this.st_10=create st_10
this.dw_criteria=create dw_criteria
this.dw_columns=create dw_columns
this.dw_tables=create dw_tables
this.st_9=create st_9
this.st_8=create st_8
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_styl=create gb_styl
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_tabular
this.Control[iCurrent+2]=this.rb_form
this.Control[iCurrent+3]=this.rb_grid
this.Control[iCurrent+4]=this.cb_addall
this.Control[iCurrent+5]=this.st_16
this.Control[iCurrent+6]=this.st_15
this.Control[iCurrent+7]=this.st_14
this.Control[iCurrent+8]=this.st_13
this.Control[iCurrent+9]=this.st_12
this.Control[iCurrent+10]=this.st_11
this.Control[iCurrent+11]=this.mle_comments
this.Control[iCurrent+12]=this.st_10
this.Control[iCurrent+13]=this.dw_criteria
this.Control[iCurrent+14]=this.dw_columns
this.Control[iCurrent+15]=this.dw_tables
this.Control[iCurrent+16]=this.st_9
this.Control[iCurrent+17]=this.st_8
this.Control[iCurrent+18]=this.cb_cancel
this.Control[iCurrent+19]=this.cb_ok
this.Control[iCurrent+20]=this.st_7
this.Control[iCurrent+21]=this.st_6
this.Control[iCurrent+22]=this.st_5
this.Control[iCurrent+23]=this.st_4
this.Control[iCurrent+24]=this.st_3
this.Control[iCurrent+25]=this.st_2
this.Control[iCurrent+26]=this.st_1
this.Control[iCurrent+27]=this.gb_styl
end on

on w_quick_select.destroy
call super::destroy
destroy(this.rb_tabular)
destroy(this.rb_form)
destroy(this.rb_grid)
destroy(this.cb_addall)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.mle_comments)
destroy(this.st_10)
destroy(this.dw_criteria)
destroy(this.dw_columns)
destroy(this.dw_tables)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_styl)
end on

type rb_tabular from radiobutton within w_quick_select
integer x = 2103
integer y = 1488
integer width = 306
integer height = 72
integer taborder = 100
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Tabular"
boolean checked = true
end type

type rb_form from radiobutton within w_quick_select
integer x = 2103
integer y = 1416
integer width = 256
integer height = 72
integer taborder = 90
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Form"
end type

type rb_grid from radiobutton within w_quick_select
integer x = 2103
integer y = 1344
integer width = 247
integer height = 72
integer taborder = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Grid"
end type

type cb_addall from commandbutton within w_quick_select
integer x = 2117
integer y = 572
integer width = 265
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "A&dd All"
end type

event clicked;/************************************************************************
	If the current column was previously selected, Skip it.
	If the Current column was not previoustly selected, selected it and 
		make it visible in the criteria grid.
*************************************************************************/
int			li_current_visibility, li_new_visibility
int			li_DWColumnsRows
string		ls_name, ls_colname, ls_moderr
long		ll_row

SetPointer(HourGlass!)

li_DWColumnsRows = dw_columns.RowCount()

For ll_row = 1 To li_DWColumnsRows

	il_HighLightedColumn = ll_row
	ls_colname = dw_columns.Object.cname[ll_row]		/*****  Get name of column that was clicked	*****/
	ls_name = ls_colname + '.visible'

	/************************************************************************
		Find out if this column had already been chosen or not, by seeing 
		if it is presently visible in the Criteria grid.
	*************************************************************************/
	li_current_visibility = Integer ( dw_criteria.Describe ( ls_name ) )

	/************************************************************************
		Set New Visibility to the opposite of Current Visibility
	*************************************************************************/
	li_new_visibility = 1 - li_current_visibility

	/************************************************************************
		Select or deselect this column's name in the column list.
	*************************************************************************/
	If li_new_visibility = 1 Then
		dw_columns.SelectRow ( ll_row, TRUE )
		il_HighLightedColumn = ll_row
		if cb_ok.enabled = FALSE then cb_ok.enabled = TRUE
		is_VisibleColumns[UpperBound(is_VisibleColumns) + 1 ] = ls_colname
	End If

	/************************************************************************
		Make this column visible if it is not already in the Criteria grid.
	*************************************************************************/
	if li_new_visibility > 0 then
		ls_name = ls_colname + '.visible="' + String ( li_new_visibility ) + '"'
	end if
	ls_moderr = dw_criteria.Modify ( ls_name )
	//dw_criteria.Object.datawindow.QuerySort = 'YES'
	dw_criteria.Modify("DataWindow.QuerySort=yes")	
next

end event

type st_16 from statictext within w_quick_select
integer x = 18
integer y = 1572
integer width = 265
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Or:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_15 from statictext within w_quick_select
integer x = 18
integer y = 1504
integer width = 265
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Or:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_14 from statictext within w_quick_select
integer x = 18
integer y = 1428
integer width = 265
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Or:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_13 from statictext within w_quick_select
integer x = 18
integer y = 1364
integer width = 265
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Criteria:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_12 from statictext within w_quick_select
integer x = 18
integer y = 1300
integer width = 265
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Sort:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within w_quick_select
integer x = 32
integer y = 1124
integer width = 521
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "&Selected Columns:"
boolean focusrectangle = false
end type

type mle_comments from multilineedit within w_quick_select
integer x = 32
integer y = 884
integer width = 2016
integer height = 196
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_10 from statictext within w_quick_select
integer x = 32
integer y = 820
integer width = 293
integer height = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Comments:"
boolean focusrectangle = false
end type

type dw_criteria from datawindow within w_quick_select
integer x = 311
integer y = 1232
integer width = 1733
integer height = 528
integer taborder = 60
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_columns from datawindow within w_quick_select
event rbuttonup pbm_rbuttonup
integer x = 1079
integer y = 336
integer width = 969
integer height = 480
integer taborder = 20
string dataobject = "d_column_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on rbuttonup;/*************************************************************************
		When the Minor mouse button is released:
			Remove the FocusIndicator
			Reset the current row to the proper table
			Force the repaint of the datawindow to remove the focus indicator
			Clear out the comments field
**************************************************************************/
SetRowFocusIndicator(Off!)
setrow(il_HighLightedColumn)

setredraw(TRUE)
mle_comments.text = ""

end on

event clicked;/************************************************************************
	If the clicked column was previously selected, deselect it and make it 
		invisible in the criteria grid.
	If the clicked column was previoustly not selected, selected it and 
		make it visible in the criteria grid.
*************************************************************************/

Long		ll_ReturnCode
Integer	li_current_visibility, li_new_visibility, li_Index, li_ArrayBound
String	ls_name, ls_colname, ls_moderr

il_HighLightedColumn = Row
ls_colname = This.Object.cname[row]		/*****  Get name of column that was clicked	*****/
ls_name = ls_colname + '.visible'

/************************************************************************
	Find out If this column had already been chosen or not, by seeing 
	If it is presently visible in the Criteria grid.
*************************************************************************/
li_current_visibility = Integer ( dw_criteria.Describe ( ls_name ) )

/************************************************************************
	Set New Visibility to the opposite of Current Visibility
*************************************************************************/
li_new_visibility = 1 - li_current_visibility

/************************************************************************
	Select or deselect this column's name in the column list.
*************************************************************************/
If li_new_visibility = 1 Then
	selectRow ( Row , True )
	il_HighLightedColumn = Row
	If cb_ok.enabled = False Then cb_ok.enabled = True
	is_VisibleColumns[UpperBound(is_VisibleColumns) + 1 ] = ls_colname
Else
	selectRow ( row, False )
	il_HighLightedColumn = 0
	ll_returncode = GetSelectedRow(0)
	If ll_returncode < 1 Then cb_ok.enabled = False
	li_ArrayBound = UpperBound(is_VisibleColumns)
	For li_Index = 1 to li_ArrayBound
		If is_VisibleColumns[li_Index] = ls_colname Then
			is_VisibleColumns[li_Index] = ""
		End If 
	Next
End If

/************************************************************************
	Make this column visible or invisible in the Criteria grid.
*************************************************************************/
ls_name = ls_colname + '.visible="' + String ( li_new_visibility ) + '"'
ls_moderr = dw_criteria.Modify ( ls_name )
//dw_criteria.Object.DataWindow.QuerySort = 'YES'
dw_criteria.Modify("DataWindow.QuerySort=yes")	

end event

event rbuttondown;/***********************************************************************
		Get the row that has been 'clicked' and take the value out of 
		pbc_cmnt column for comments.  If there is no value in this column
		then display the default message - 'TThis column has no comments"

************************************************************************/

	integer lCurrentRow
	string 	lObjectAtPointer, lStrRow, lComments

	lObjectAtPointer = this.GetObjectAtPointer()

	If lObjectAtPointer = "" then return   // all done white space clicked

	lStrRow = Mid(lObjectATPointer, Pos(lObjectAtPointer, "~t") + 1, 2)
//**********************************************************************
//		Comments for the Column DataWindow are in Column 3 pbcatcol pbc_cmnt
//**********************************************************************
	lComments = this.Object.pbc_cmnt[integer(lStrRow)]

	this.setrowfocusindicator(FocusRect!)
	this.setrow(integer(lStrRow))
	
	If Trim(lComments) = "" or IsNull(lComments)  then
		mle_comments.text = "This column has no comments."
	else
		mle_comments.text = lComments
	end if

	this.setredraw(TRUE)
end event

type dw_tables from datawindow within w_quick_select
event rbuttonup pbm_rbuttonup
integer x = 87
integer y = 336
integer width = 969
integer height = 480
integer taborder = 10
string dataobject = "d_table_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

on rbuttonup;/*************************************************************************
		When the Minor mouse button is released:
			Remove the FocusIndicator
			Reset the current row to the proper table
			Force the repaint of the datawindow
			Clear out the comments field
**************************************************************************/

setrowfocusindicator(Off!)
setrow(il_HighLightedTable)
setredraw(TRUE)
mle_comments.text = ""

end on

event clicked;Integer		li_index, li_num_of_gobs
String		ls_name, ls_tname , ls_sql_syntax , ls_dw_syntax , ls_errors
String		dw_style , ls_hdgs[] , ls_cols[] , cols_no_underscores[]
String 		ls_emptyarray []

/******************************************************************************************************
	Clear out DataObject name (if any), in case user has already selected a table, and
	now is selecting a different one
 ******************************************************************************************************/

dw_criteria.DataObject = ''
is_visiblecolumns[] = ls_emptyarray[]
/******************************************************************************************************
	Note that the Repository definitions for fonts prevail over the parameters specified
	in dw_style, below.  Thus, the several Modify commands after the Create, below.
******************************************************************************************************/
dw_style =	'style(Type=grid) ' + &
				'Text(font.face="MS Sans Serif"  font.Height=12  font.weight=400 font.family=2 ' + &
						'font.pitch=2 font.charset=0) ' + &
				'Column(font.face="MS Sans Serif"  font.Height=12  font.weight=400 font.family=2 ' + &
						'font.pitch=2 font.charset=0) ' 

SetPointer ( HourGlass! )
	
// Highlight this row
selectRow (0, False )			
selectRow (row, True )
il_HighlightedTable = Row

// Get table name
ls_tname = This.Object.tname[row]		
is_TableName = ls_tname
mle_comments.Text = '~tRetrieving Column NameS For table ' + Lower ( ls_tname ) + '...'

dw_columns.SetRedraw ( False )

//  Load up the column names	
If f_set_column_select(dw_columns, is_TableName) < 0 Then
	MessageBox("Error", &
					"Unable to Set SQL Select statement For Columns list", &
					StopSign!)
	Return
End If

dw_columns.Retrieve( )	  /* Note:  No Retrieve argument is used, 
									  since F_SET_COLUMN_SELECT inserts
									  the proper table name */

//	Build generic SELECT statement and generate DataWindow syntax
ls_sql_syntax = 'SELECT * FROM ' + ls_tname
ls_dw_syntax = SQLCA.SyntaxFromSQL( ls_sql_syntax, dw_style, ls_errors)

// If no ls_errors (there shouldn't be any), create the Criteria grid-style DataWindow
If Len(ls_errors) = 0 Then
	Parent.SetRedraw ( False )			/*****  Prevent "flash"	*****/
	cb_addAll.enabled = True

	If dw_criteria.Create (ls_dw_syntax) > 0 Then
		dw_criteria.Modify ('datawindow.Detail.Height=70 ')

		//  Insert 6 rows for Sort & Criteria
		For li_index = 1 to 6						
			dw_criteria.InsertRow ( 0 )
		Next

		//	Get names of heading-text items into hdgs[ ] array, 
		// and names of column items into cols[ ] array.
		li_num_of_gobs= f_parse_obj_string(dw_criteria, ls_hdgs, "text", "header")
		li_num_of_gobs= f_parse_obj_string(dw_criteria, ls_cols, "column", "detail")

		//	For each column (and its heading), set font and other attributes.  Also, make
		//	each of them invisible for now.
 
		For li_index = 1 to li_num_of_gobs
			//	Substitute spaces for underscores in column names.
			cols_no_underscores[li_index] = wf_replace_underscores_with_spaces( ls_cols[li_index] )

			//	Build the Modify command string
			ls_name = 'datawindow.header.Height=70 ' + &
			ls_hdgs[li_index] + '.Text="***~tWordcap(~'' + cols_no_underscores[li_index] + '~' )" ' + &
			ls_hdgs[li_index] + '.Font.Face="MS Sans Serif" ' + &
			ls_hdgs[li_index] + '.Font.Height="60" ' + &
			ls_hdgs[li_index] + '.Height="60" ' + &
			ls_hdgs[li_index] + '.Font.Weight="400" ' + &
			ls_hdgs[li_index] + '.Font.Family="0" ' + &
			ls_hdgs[li_index] + '.Font.Pitch="2" ' + &
			ls_hdgs[li_index] + '.Font.Charset="0" ' + &
			ls_cols[li_index]  + '.y="4" ' + &
			ls_cols[li_index] + '.Font.Face="MS Sans Serif" ' + &
			ls_cols[li_index] + '.Font.Height="52" ' + &
			ls_cols[li_index] + '.Height="60" ' + &
			ls_cols[li_index] + '.Font.Weight="400" ' + &
			ls_cols[li_index] + '.Font.Family="0" ' + &
			ls_cols[li_index] + '.Font.Pitch="2" ' + &
			ls_cols[li_index] + '.Font.Charset="0" ' + &
			ls_cols[li_index] + '.Visible="0" ' + &
			' '
			dw_criteria.Modify (ls_name)
		Next
	End If
End if
Parent.SetRedraw ( True )		//  Now, get the window ready to show criteria	

mle_comments.Text = ''
dw_criteria.setTransObject(sqlca)
dw_columns.SetRedraw ( True )

end event

event rbuttondown;/***********************************************************************
		Get the row that has been 'clicked' and take the value out of 
		pbt_cmnt column for comments.  If there is no value in this column
		then display the default message - 'There are no comments for this
		table."
************************************************************************/
	setpointer(hourglass!)

	string 	ls_objectatpointer, ls_strrow, ls_comments

	ls_objectatpointer = this.GetObjectAtPointer() 

	If ls_objectatpointer = "" then return   // all done white space clicked

	ls_strrow = Mid(ls_objectatpointer, Pos(ls_objectatpointer, "~t") + 1, 2)
//**********************************************************************
//		Comments for the Table DataWindow are in column two pbt_cmnt
//**********************************************************************
	ls_comments = this.Object.pbt_cmnt[ integer(ls_strrow) ]

	this.setrowfocusindicator(FocusRect!)
	this.setrow(integer(ls_strrow))
	
	If Trim(ls_comments) = "" or IsNull(ls_comments)  then
		mle_comments.text = "This table has no comments."
	else
		mle_comments.text = ls_comments
	end if

	this.setredraw(TRUE)
end event

type st_9 from statictext within w_quick_select
integer x = 1074
integer y = 260
integer width = 279
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "&Columns:"
boolean focusrectangle = false
end type

type st_8 from statictext within w_quick_select
integer x = 23
integer y = 260
integer width = 242
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "&Tables:"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_quick_select
integer x = 2117
integer y = 440
integer width = 274
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
boolean cancel = true
end type

on clicked;// Clicked script for cb_cancel

Close (Parent)

end on

type cb_ok from commandbutton within w_quick_select
integer x = 2117
integer y = 328
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&OK"
boolean default = true
end type

event clicked;/*************************************************************************
		When this button is clicked open up the window to test the
		DataWindow.  Open a new sheet in the frame to create
		the datawindow in.
*************************************************************************/

SetPointer(HourGlass!)

window newwindow

int	li_rc
li_rc = dw_criteria.accepttext( )

If li_rc = 1 Then
	OpenSheet(newwindow,"w_quick_select_sheet", ParentWindow(), 2, Original!)
End If

end event

type st_7 from statictext within w_quick_select
integer x = 1074
integer y = 132
integer width = 690
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "the right mouse button."
boolean focusrectangle = false
end type

type st_6 from statictext within w_quick_select
integer x = 1074
integer y = 76
integer width = 832
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "table or column, press and hold"
boolean focusrectangle = false
end type

type st_5 from statictext within w_quick_select
integer x = 1074
integer y = 20
integer width = 690
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "To display comments for a"
boolean focusrectangle = false
end type

type st_4 from statictext within w_quick_select
integer x = 110
integer y = 188
integer width = 901
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "in the Selected Columns box."
boolean focusrectangle = false
end type

type st_3 from statictext within w_quick_select
integer x = 32
integer y = 132
integer width = 960
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "3.  (Optional) Enter selection criteria"
boolean focusrectangle = false
end type

type st_2 from statictext within w_quick_select
integer x = 32
integer y = 80
integer width = 837
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "2.  Select one or more columns."
boolean focusrectangle = false
end type

type st_1 from statictext within w_quick_select
integer x = 32
integer y = 20
integer width = 567
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "1.  Select a table."
boolean focusrectangle = false
end type

type gb_styl from groupbox within w_quick_select
integer x = 2080
integer y = 1280
integer width = 343
integer height = 300
integer taborder = 70
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Style"
end type

