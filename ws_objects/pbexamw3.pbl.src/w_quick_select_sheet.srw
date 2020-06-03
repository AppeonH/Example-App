$PBExportHeader$w_quick_select_sheet.srw
$PBExportComments$Sheet containing newly created datawindow that was created in w_quick_select
forward
global type w_quick_select_sheet from w_center
end type
type uo_color from u_color_bar within w_quick_select_sheet
end type
type uo_style from u_style_bar within w_quick_select_sheet
end type
type dw_1 from datawindow within w_quick_select_sheet
end type
end forward

global type w_quick_select_sheet from w_center
integer x = 41
integer y = 48
integer width = 2862
integer height = 1664
string title = "Runtime DataWindow Painter"
string menuname = "m_quick_select_sheet"
long backcolor = 74481808
string icon = "tutorial.ico"
toolbaralignment toolbaralignment = alignatleft!
event ue_savedw pbm_custom01
event ue_postopen pbm_custom02
event ue_closesheet pbm_custom03
uo_color uo_color
uo_style uo_style
dw_1 dw_1
end type
global w_quick_select_sheet w_quick_select_sheet

type variables
string is_object_name []
string is_hold_color []
string is_hold_backcolor []
string is_hold_backmode []
boolean is_text
boolean ib_updating
end variables

forward prototypes
public function string wf_convert_height_to_points (datawindow adw_parm, string as_height)
public function string wf_update_item (datawindow adw_parm, string adw_type)
end prototypes

on ue_savedw;//This will open a new window and pass to it the datawindow contained on this sheet.
//The new window will be able to save this datawindow to a PBL file.
//Because the datawindow is passed in the message.parm, the window does 
//not need to know which sheet called it. In an MDI frame, there could be many
//sheets open with many datawindows on them.
openwithparm(w_save_Quick_select,dw_1)
end on

event ue_postopen;/*************************************************************************
		Make sure that the Quick Select window is open,  if it is then
		use the syntax in the grid datawindow (dw_criteria) as the source 
		for the DataWindow control in this window.  If the Quick Select 
		window is not open then give a message and default with a blank 
		DW Control and disable the capability of saving the DataWindow.

		The syntax for the datawindow will have to be modified to discover
		the visible fields, and then to build the Where statement by taking
		values out of the Grid DataWindow.  The Existing Grid DataWindow 
		Selects all columns from the table and then works depending on the 
		visible attributes.
*************************************************************************/
int 			li_createreturncode, li_arraybound, li_index, li_colcount
String 		ls_dwSyntax,  ls_dwerrorbuffer, ls_visiblecolumns[], ls_dwselectstmt
String		ls_tablename, ls_style, ls_whereclause, ls_criteriaselectstmt, ls_rc
String		ls_orderclause, ls_column, ls_report_type
DataWindow 	ldw_newdw
long		ll_start, ll_end, ll_rc
m_quick_select_sheet	 lm_menu 

//get id of the menu instance for this window
lm_menu = this.menuid

If Handle(w_quick_select) < 1 then
	MessageBox("There is No Quick Selection", "Unable to create Datawindow")
	Return
else	
	//*********************************************************************
	//		Build the Select statement Based on the Visible columns
	//		Copy the Grid DW from the Quick Select window to the local
	//		DW here and the instance array of visible column names.
	//*********************************************************************	
	ldw_newdw = W_quick_select.dw_Criteria
	ls_criteriaselectstmt = ldw_newdw.getsqlselect()
 	ls_visiblecolumns = w_quick_select.is_VisibleColumns
	ls_tablename	= w_quick_select.is_TableName

	//get the type datawindow from the quick select menu
	If w_quick_select.rb_grid.checked Then
		ls_report_type = "grid"
	ElseIf w_quick_select.rb_form.checked Then
		ls_report_type = "form"
	ElseIf  w_quick_select.rb_tabular.checked Then
		ls_report_type = "tabular"
	End if
	ls_style = 'style(type=' + ls_report_type + ')' + &
				'Text(background.mode=0 background.color=1073741824 color=0 ' +&
				'font.face = "MS Sans Serif"  font.height = -10  font.weight = 400 font.family = 2 ' + &
						'font.pitch=2  ) ' + &
				'Column(background.mode=0 background.color=1073741824 color=0 ' +&
				'font.face = "MS Sans Serif"  font.height = -8  font.weight = 400 font.family = 2 ' + &
						'font.pitch = 2 ) ' 
	this.title = "Datawindow for table - " + ls_tablename

	//*********************************************************************
	//		Build the Select Statement
	//*********************************************************************
	ls_dwselectstmt = "Select " 
	li_arraybound = UpperBound(ls_visiblecolumns)
	For li_index = 1 to li_arraybound
			If ls_visiblecolumns[li_index] <> "" then
				ls_dwselectstmt = ls_dwselectstmt + ls_visiblecolumns[li_index]
				If li_index <> li_arraybound then
					ls_dwselectstmt = ls_dwselectstmt + ", "
				End If
			End If
	end for	

	// add the FROM clause 
	ls_dwselectstmt = ls_dwselectstmt + " From " + ls_tablename

	////////////////////////////////////////////////////////////////////////////////////
	//build the where clause from the querymode datawindow
	///////////////////////////////////////////////////////////////////////////////////
	ll_start = pos(lower(ls_criteriaselectstmt)," where ")
	
	If ll_start > 0 Then
	//order of stmts after where are groub by, having, order by 
	//however, in this example, only ORDER BY can occur
	//check if this occurs, if so, this is the end of the where clause
		ll_end = Pos(lower(ls_criteriaselectstmt)," order by ")

		If ll_end = 0 Then 	// no order by
			ll_end = len (ls_criteriaselectstmt)
		End If

		ls_whereclause = Mid ( ls_criteriaselectstmt, ll_start, ll_end - ll_start +1)
		ls_dwselectstmt = ls_dwselectstmt + ls_whereclause	

	End If 	//Get Where Clause


	////////////////////////////////////////////////////////////////////////////////////
	//build the order by clause from the querymode datawindow
	//This routine will parse through the criteria order by statement
	//converting the column #'s to database column names.
	//This is because the column #'s do not match the new
	//datawindow's column numbers.
	///////////////////////////////////////////////////////////////////////////////////
	ll_start = pos(lower(ls_criteriaselectstmt)," order by ")
	
	If ll_start > 0 Then
		// there is an order by, now parse it out
		ll_end = len (ls_criteriaselectstmt)
	
		ls_orderclause = " Order By "
	
		ll_start = ll_start + 11 // skip past the order by
		ll_end = pos(ls_criteriaselectstmt, " ", ll_start)
		do while ll_end > 0
			If Lower(Mid(ls_criteriaselectstmt, ll_start, 1)) = "a" or  &
			   Lower(Mid(ls_criteriaselectstmt, ll_start, 1)) = "d"  Then
				//This is the asc or desc stmt, just copy it
				ll_rc = pos (ls_criteriaselectstmt, ",", ll_end) + 1   // adjust for space after order sequence 
				If ll_rc > 1 Then ll_end = ll_rc    //no need to adjust if this was the last asc/desc 
				ls_orderclause = ls_orderclause + mid(ls_criteriaselectstmt, ll_start, ll_end - ll_start + 1)
		      Else  			// must be a column # --- convert it to a column name
				ls_column = mid (ls_criteriaselectstmt, ll_start, ll_end - ll_start +1)
				ls_orderclause = ls_orderclause + &
					ldw_newdw.describe ("#" + ls_column + ".dbname") + " "
		      End If				

			//move start to next token
			ll_start = ll_end + 1
			ll_end = pos(ls_criteriaselectstmt, " ", ll_start)
		loop
		
		//build it into main select statement
		ls_dwselectstmt = ls_dwselectstmt + ls_orderclause	

	End If 	//Get Order Clause

	ls_dwSyntax= Sqlca.SyntaxFromSQL( ls_dwselectstmt, ls_style, ls_dwerrorbuffer)
	
	li_createreturncode = dw_1.Create(ls_dwSyntax)

End If

ls_rc = dw_1.modify ("datawindow.selected.mouse=no")
if ls_rc <>"" then messagebox("hi",ls_rc)

If li_createreturncode > 0 then
	li_colcount = Integer (dw_1.Describe ("datawindow.column.count"))
	
	For li_index = 1 to li_colcount
		dw_1.SetTabOrder(li_index,0)
	Next

	dw_1.settransobject( sqlca)	
	dw_1.retrieve( )

	//Enable local sheet save dw
	Enable (lm_menu.m_file.m_savedatawindow)
	

	close(w_quick_select)
Else
	messagebox("Creation of the DataWindow Failed",  "The return code is "+ string(li_createreturncode))
	w_quick_select.dw_criteria.Modify("DataWindow.QuerySort = Yes")
End If

end event

on ue_closesheet;//close this sheet

close(this)
end on

public function string wf_convert_height_to_points (datawindow adw_parm, string as_height);string 	ls_units
int		li_converted

li_converted = Integer(as_height)

ls_units = adw_parm.describe ("datawindow.units")
choose case ls_units
	case "0" //pb units
		li_converted = li_converted / 4
	case "1" //pixels
		li_converted = li_converted 
	case "2" //inches
		li_converted = li_converted / 12
	case "3" //cm
		li_converted = li_converted / 31
end choose

Return String(li_converted)
end function

public function string wf_update_item (datawindow adw_parm, string adw_type);//This is called from the User Object Style Bar or User Object Color bar when its values
//are changed
object_style lstr_style
string	ls_f_color, ls_b_color, ls_mod_string, ls_rc, ls_change_type
int		li_index

//If setting items, dont want to trigger updates
If ib_updating Then Return ""

SetPointer(HourGlass!)

// Set up modIfy string and execute Modify For all selected objects
For li_index = 1 to UpperBound(is_object_name)
	If is_object_name [li_index] = "" then continue

	//set colors
	If adw_type = "fore_color" then
		//get attributes from color bar
		uo_color.uf_get_colors(ls_f_color, ls_b_color)
		is_hold_color[li_index] = ls_f_color
		ls_mod_string = ls_mod_string + is_object_name[li_index] + ".color=~"" + ls_f_color + "~" "
	ElseIf adw_type = "back_color" then
		uo_color.uf_get_colors(ls_f_color, ls_b_color)
		is_hold_backcolor[li_index] = ls_b_color

		// If mode is transparent, reset to transparent (may have been Forced
		// to opaque when selected); otherwise set background color
		If is_hold_backmode[li_index] = "1" then
			ls_mod_string = ls_mod_string + is_object_name[li_index] + '.background.mode="1" '
		else
			ls_mod_string = ls_mod_string + is_object_name[li_index] + ".background.color=~"" + ls_b_color + "~" "
		end If

		//set font
	ElseIf adw_type = "font" then
		// get attributes from style bar
		ls_change_type = uo_style.uf_get_style(lstr_style)

		//This will change the appropriate font attribute
		Choose Case lower(ls_change_type)
		
		Case "font"
			ls_mod_string = ls_mod_string + is_object_name[li_index] + ".font.face=~"" + lstr_style.font_face + "~" "
		Case "bold"
			ls_mod_string = ls_mod_string + is_object_name[li_index] + ".font.weight=~"" + lstr_style.font_weight + "~" "
		Case "italic"
			ls_mod_string = ls_mod_string + is_object_name[li_index] +".font.italic=~"" + lstr_style.italic + "~" "
		Case "underline"
			ls_mod_string = ls_mod_string + is_object_name[li_index] +".font.underline=~"" + lstr_style.underline + "~" "
		Case "border"
			ls_mod_string = ls_mod_string + is_object_name[li_index] + ".border=~"" + lstr_style.border + "~" "
		Case "size"
			lstr_style.font_height = String(Integer(lstr_style.font_height) * -1)
			ls_mod_string = ls_mod_string + is_object_name[li_index] + ".font.height=~"" + lstr_style.font_height + "~" "
		Case "left", "right", "center"
			ls_mod_string = ls_mod_string + is_object_name[li_index] + ".alignment=~"" + lstr_style.alignment + "~" "
		Case "text"
			If is_text then 
				//check For nested quotes
				lstr_style.text = f_remove_char ( lstr_style.text, "~"" )
				ls_mod_string = ls_mod_string + is_object_name[li_index] + ".text=~"" + lstr_style.text + "~" "
			End If
		End Choose

	End If
Next


//Apply the change
If ls_mod_string <> "" Then
	ls_rc = dw_1.Modify(ls_mod_string)
End If


return ls_rc
end function

on open;this.postevent("ue_postopen")

end on

on w_quick_select_sheet.create
int iCurrent
call super::create
if this.MenuName = "m_quick_select_sheet" then this.MenuID = create m_quick_select_sheet
this.uo_color=create uo_color
this.uo_style=create uo_style
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_color
this.Control[iCurrent+2]=this.uo_style
this.Control[iCurrent+3]=this.dw_1
end on

on w_quick_select_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_color)
destroy(this.uo_style)
destroy(this.dw_1)
end on

type uo_color from u_color_bar within w_quick_select_sheet
integer y = 1336
end type

on ue_lbuttondown;call u_color_bar::ue_lbuttondown;//Left_button_click(user defined) script for uo_color
//inherited from u_color_bar

long ll_color
int li_xloc
string	ls_rc 

li_xloc = PointerX( )
ll_color = uo_color.uf_get_rgb(li_xloc)

// With control key down, change DataWindow background ll_color now.
// Otherwise, just set the ll_color.
If KeyDown(keycontrol!) then
	dw_1.Modify("datawindow.ll_color = " + String(ll_color))
else
	uo_color.uf_set_foreground(ll_color)
end if

ls_rc = wf_update_item(dw_1,"fore_color")
If ls_rc <> "" then messagebox("Modify err",ls_rc)
end on

on rbuttondown;call u_color_bar::rbuttondown;//Right_button_click(user defined) script for uo_color
//inherited from u_color_bar

string	ls_rc 
long ll_color
int li_xloc
li_xloc = PointerX( )
ll_color = uo_color.uf_get_rgb(li_xloc)
uo_color.uf_set_background(ll_color)


ls_rc = wf_update_item(dw_1,"back_color")
If ls_rc <> "" then messagebox("dwmodify err",ls_rc)

end on

on uo_color.destroy
call u_color_bar::destroy
end on

type uo_style from u_style_bar within w_quick_select_sheet
end type

on ue_style_changed;call u_style_bar::ue_style_changed;string	ls_rc 
ls_rc = wf_update_item(dw_1,"font")
If ls_rc <> "" then 
	messagebox("dwmodify err",ls_rc)
end if

end on

on uo_style.destroy
call u_style_bar::destroy
end on

type dw_1 from datawindow within w_quick_select_sheet
event ue_leftbuttonup pbm_lbuttonup
integer x = 18
integer y = 160
integer width = 2807
integer height = 1168
integer taborder = 10
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_leftbuttonup;//left button up on datawindow
object_style lstr_style
string ls_mod_string, ls_obj_name, ls_backcolor
int li_index

// If previous objects were selected and the cntl key is not down,
// this is not a multi-select and we must de-select all prior selected
// objects by resetting the Foreground and background colors 
// to the old values

If KeyDown(keycontrol!) = false and UpperBound(is_object_name) > 0 then
	For li_index = 1 to UpperBound(is_object_name)
		If is_object_name[li_index] <> "" then
			// Original background transparent? Set it back to transparent
			If is_hold_backmode [li_index] = "1" then
				ls_backcolor = is_object_name [li_index] + ".background.mode=~"1~"" 
			else
				ls_backcolor = is_object_name [li_index] + ".background.color=~"" + &
								is_hold_backcolor[li_index] + "~""
			end If
			ls_mod_string = is_object_name[li_index] + ".color=~"" + is_hold_color[li_index] + &
							"~" " + ls_backcolor
			dw_1.Modify(ls_mod_string)
			is_object_name[li_index] = ""
		end If
	next
end If

// Get the is_object_name of the object selected;
ls_obj_name = dw_1.GetObjectAtPointer( )
If ls_obj_name = "" then Return
ls_obj_name = f_get_token(ls_obj_name, "~t")

// find the next available slot and leave its index in i
If UpperBound(is_object_name) = 0 then
	li_index = 1
else
	For li_index = 1 to UpperBound(is_object_name)
		// If this object is already selected, do nothing
		If is_object_name [li_index] = ls_obj_name then return
		If is_object_name [li_index] = "" then exit
	next
end If

// Put the object name in the selected list
is_object_name[li_index] = ls_obj_name

// Remember its current Foreground and background colors
is_hold_color[li_index] = dw_1.Describe(ls_obj_name + ".color")
is_hold_backcolor [li_index] = dw_1.Describe(ls_obj_name + ".background.color")
is_hold_backmode [li_index] = dw_1.Describe(ls_obj_name + ".background.mode")


// For now, If no text color was specIfied in the create, Force it
// to black
If is_hold_color[li_index] = "?" then is_hold_color[li_index] = "0"

// If background is transparent, use the datawindow background color
If is_hold_backmode [li_index] = "1" then
	is_hold_backcolor [li_index] = dw_1.Describe("datawindow.color")
end If

// Get the current style bar attributes For the object
lstr_style.font_face = dw_1.Describe(ls_obj_name + ".font.face")
lstr_style.font_weight = dw_1.Describe(ls_obj_name + ".font.weight") 
lstr_style.italic = dw_1.Describe(ls_obj_name + ".font.italic")
lstr_style.underline = dw_1.Describe(ls_obj_name + ".font.underline")
lstr_style.border = dw_1.Describe(ls_obj_name + ".border")
lstr_style.alignment = dw_1.Describe(ls_obj_name + ".alignment")
lstr_style.font_height = dw_1.Describe(ls_obj_name + ".font.height")

//negative height means its already in points
If Integer(lstr_style.font_height) > 0 Then 
	lstr_style.font_height = 	wf_convert_height_to_points(dw_1,lstr_style.font_height)
else
	//strip negative sign
	lstr_style.font_height =  String(Abs(Integer(lstr_style.font_height)))
End If


// If its text and the only object selected, show the text edit box 
// with the current text value .  Strip any quotes out of the text string.
If dw_1.Describe(ls_obj_name + ".type") = "text" and li_index = 1 then
	lstr_style.text = f_remove_char (dw_1.Describe(ls_obj_name + ".text"), "~"")
	is_text = true
else
	lstr_style.text = ""
	is_text = false
end If


// Set to white Foreground on black background to show its selected.
// Force to opaque mode so the black background showlstr_style.
ls_mod_string = ls_obj_name + ".background.mode=~"0~" " + &
				 ls_obj_name + ".color=~"" + string(rgb(255,255,255)) + "~" " + &
				 ls_obj_name + ".background.color=~"0~"" 
dw_1.Modify(ls_mod_string)


//set boolean true that a new column was selected and the style/color bar will
//be changed, but these are not user keyed changes
ib_updating = true

// Now, set the visible values to match the current object
uo_style.uf_set_style(lstr_style)

// Set the color bar attributes
uo_color.uf_set_Foreground(Long(is_hold_color[li_index]))
uo_color.uf_set_background(Long(is_hold_backcolor[li_index]))

//updating is over see above
ib_updating = false
end event

