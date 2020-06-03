$PBExportHeader$w_menu_functions.srw
$PBExportComments$MenuItem Attributes example
forward
global type w_menu_functions from w_center
end type
type dw_3 from datawindow within w_menu_functions
end type
type dw_2 from datawindow within w_menu_functions
end type
type dw_1 from datawindow within w_menu_functions
end type
type dw_menuitem from datawindow within w_menu_functions
end type
type dw_toolbaritem from datawindow within w_menu_functions
end type
type rb_main_menu from radiobutton within w_menu_functions
end type
type rb_alt_menu from radiobutton within w_menu_functions
end type
type gb_toolbar from groupbox within w_menu_functions
end type
type gb_2 from groupbox within w_menu_functions
end type
type gb_1 from groupbox within w_menu_functions
end type
end forward

global type w_menu_functions from w_center
integer x = 114
integer y = 208
integer width = 2825
integer height = 1628
string title = "Menu Editor"
string menuname = "m_menu_functions_main"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event ue_exit pbm_custom01
event ue_tile pbm_custom02
event ue_layer pbm_custom03
event ue_cascade pbm_custom04
event ue_arrange pbm_custom05
event ue_open pbm_custom06
event ue_htile pbm_custom07
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
dw_menuitem dw_menuitem
dw_toolbaritem dw_toolbaritem
rb_main_menu rb_main_menu
rb_alt_menu rb_alt_menu
gb_toolbar gb_toolbar
gb_2 gb_2
gb_1 gb_1
end type
global w_menu_functions w_menu_functions

type variables
// menu variables
m_menu_functions_main   im_main
m_menu_functions_alt      im_alt

// determines current datawindow selections
Integer    ii_cur_dw

// frame window
w_frame_menu_functions  iw_frame

// Do not show menuitem attributes until entire entire
// menu has been "built" into the DataWindows
Boolean   ib_menu_built = true

// Save window background color
Long   il_ButtonFace
end variables

forward prototypes
protected function integer wf_show_menu ()
protected function integer wf_display_menuitem (integer ai_row)
protected function integer wf_change_menuitem (datawindow adw_current, string as_colname)
end prototypes

event ue_exit;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_exit script for w_menu_functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////


// exit this example by closing the frame window
Close (iw_frame)
end event

event ue_tile;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_tile script for w_menu_functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// Tile the open sheets
iw_frame.ArrangeSheets (tile!)
end event

event ue_layer;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_layer script for w_menu_functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// Layer the open sheets
iw_frame.ArrangeSheets (layer!)
end event

event ue_cascade;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_cascade script for w_menu_functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// Cascade the open sheets
iw_frame.ArrangeSheets (cascade!)
end event

event ue_arrange;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_arrange script for w_menu_functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// Arrange the open sheets
iw_frame.ArrangeSheets (Icons!)
end event

event ue_open;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_open script for w_menu_functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////
//	call the wf_show_menu function which will display the
//	current menu items in the three datawindows
//////////////////////////////////////////////////////////////////////

this.ChangeMenu (im_main)

this.SetRedraw (false)

dw_menuitem.InsertRow (0)
dw_toolbaritem.InsertRow (0)
dw_1.SetRowFocusIndicator (hand!, -10, -10)
dw_2.SetRowFocusIndicator (hand!, -10, -10)
dw_3.SetRowFocusIndicator (hand!, -10, -10)

wf_show_menu()
dw_1.SetFocus()
ii_cur_dw = 1
if dw_1.RowCount() > 0 then
	dw_1.SetRow (1)
	dw_1.Trigger Event rowfocuschanged (dw_1.GetRow())
end if

this.SetRedraw (true)

end event

event ue_htile;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_htile script for w_menu_functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// Horizontally tile the open sheets
iw_frame.ArrangeSheets (TileHorizontal!)
end event

protected function integer wf_show_menu ();//////////////////////////////////////////////////////////////////////
//
// Function: wf_show_menu
//
// Purpose: Populate the datawindows with the current menu items
//
//	Scope: protected
//
//	Arguments: none		
//
//	Returns: integer   1 = success
//							-1 = error
//
//////////////////////////////////////////////////////////////////////

int		li_ret = 1, i, j, k, 	li_size1, li_size2, li_size3, li_row, li_pos, 	li_counter = 0
string	ls_txt


dw_1.Reset()
dw_2.Reset()
dw_3.Reset()

// Loop through the item arrays of the menu, adding the menu items
//	to the appropriate datawindows.  
// Strip out the shortcut keys and hot keys from the menu item text.

li_size1 = UpperBound (this.menuid.item)
for i = 1 to li_size1
	li_row = dw_1.InsertRow (0)

	ls_txt = f_remove_char (this.menuid.item[i].text, '&')
	li_pos = Pos (ls_txt, '~t', 1)
	if li_pos > 0 then
		ls_txt = Left (ls_txt, li_pos - 1)
	end if

	dw_1.object.menuitem[li_row] = ls_txt
	dw_1.object.menulevel[li_row] = string(i)
	dw_1.object.num[li_row] = li_counter
	li_counter++

	li_size2 = UpperBound (this.menuid.item[i].item)
	for j = 1 to li_size2
		li_row = dw_2.InsertRow (0)

		ls_txt = f_remove_char (this.menuid.item[i].item[j].text, '&')
		li_pos = Pos (ls_txt, '~t', 1)
		if li_pos > 0 then
			ls_txt = Left (ls_txt, li_pos - 1)
		end if

		dw_2.object.menuitem[li_row] = ls_txt
		dw_2.object.menulevel[li_row] = string(i)
		dw_2.object.num[li_row] = li_counter
		li_counter++

		li_size3 = UpperBound (this.menuid.item[i].item[j].item)
		for k = 1 to li_size3
			li_row = dw_3.InsertRow (0)

			ls_txt = f_remove_char (this.menuid.item[i].item[j].item[k].text, '&')
			li_pos = Pos (ls_txt, '~t', 1)
			if li_pos > 0 then
				ls_txt = Left (ls_txt, li_pos - 1)
			end if

			dw_3.object.menuitem[li_row] = ls_txt
			dw_3.object.menulevel[li_row] = string(i)
			dw_3.object.num[li_row] = li_counter
			li_counter++
		next
	next
next

return li_ret

end function

protected function integer wf_display_menuitem (integer ai_row);//////////////////////////////////////////////////////////////////////
//
// Function: wf_display_menuitem
//
// Purpose: Shows the attribute values of the current (selected)
//				menu item
//
//	Scope: protected
//
//	Arguments: ai_row		{current row in the current datawindow}
//
//	Returns: integer   1 = success
//							-1 = error
//
//////////////////////////////////////////////////////////////////////

string ls_col_count
int	li_level1, li_level2, li_col_count, i
long	ll_color


if ai_row <= 0 or ii_cur_dw <= 0 then
	return -1
end if

choose case ii_cur_dw

	case 1
		dw_menuitem.object.visible[1] = f_boolean_to_char (this.menuid.item[ai_row].visible)
		dw_menuitem.object.enabled[1] = f_boolean_to_char (this.menuid.item[ai_row].enabled)
		dw_menuitem.object.checked[1] = f_boolean_to_char (this.menuid.item[ai_row].checked)
		dw_menuitem.object.microhelp[1] = this.menuid.item[ai_row].microhelp
	
		dw_toolbaritem.object.tb_visible[1] = f_boolean_to_char (this.menuid.item[ai_row].ToolbarItemVisible)
		dw_toolbaritem.object.down[1] = f_boolean_to_char (this.menuid.item[ai_row].ToolbarItemDown)
		dw_toolbaritem.object.name[1] = this.menuid.item[ai_row].ToolbarItemName
		dw_toolbaritem.object.itemtext[1] = this.menuid.item[ai_row].ToolbarItemText
	
		//////////////////////////////////////////////////////////////////////
		// If the MenuItem has items under it (i.e. cascading menus or 
		// top-level menus), disallow changes to the toolbar attributes
		// by setting the taborder on the datawindow to zero and graying
		// out the text.
		//////////////////////////////////////////////////////////////////////

		ls_col_count = dw_toolbaritem.object.datawindow.column.count
		li_col_count = Integer(ls_col_count)
		if UpperBound (this.menuid.item[ai_row].item) > 0 then
			dw_toolbaritem.enabled = false
			gb_toolbar.enabled = false
			ll_color = RGB (128, 128, 128)	// dark grey
		else
			dw_toolbaritem.enabled = true
			gb_toolbar.enabled = true
			ll_color = gb_1.TextColor 	// window text
		end if
		for i = 1 to li_col_count
			dw_toolbaritem.Modify ("#" + String (i) + ".color = '" + &
											 String (ll_color) + "'")
		next
		dw_toolbaritem.Modify ("name_t.color = '" + String (ll_color) + "'" + &
										 " itemtext_t.color = '" + String (ll_color) + "'")
		

	case 2
		li_level1 = dw_1.GetRow()
		if li_level1 > 0 then
			
			dw_menuitem.object.visible[1] = f_boolean_to_char (this.menuid.item[li_level1].item[ai_row].visible)
			dw_menuitem.object.enabled[1] = f_boolean_to_char (this.menuid.item[li_level1].item[ai_row].enabled)
			dw_menuitem.object.checked[1] = f_boolean_to_char (this.menuid.item[li_level1].item[ai_row].checked)
			dw_menuitem.object.microhelp[1] = this.menuid.item[li_level1].item[ai_row].microhelp

			dw_toolbaritem.object.tb_visible[1] = f_boolean_to_char (this.menuid.item[li_level1].item[ai_row].ToolbarItemVisible)
			dw_toolbaritem.object.down[1] = f_boolean_to_char (this.menuid.item[li_level1].item[ai_row].ToolbarItemDown)
			dw_toolbaritem.object.name[1] = this.menuid.item[li_level1].item[ai_row].ToolbarItemName
			dw_toolbaritem.object.itemtext[1] = this.menuid.item[li_level1].item[ai_row].ToolbarItemText

			//////////////////////////////////////////////////////////////////////
			// If the MenuItem has items under it (i.e. cascading menus or 
			// top-level menus), disallow changes to the toolbar attributes
			// by setting the taborder on the datawindow to zero and graying
			// out the text.
			//////////////////////////////////////////////////////////////////////

			ls_col_count = dw_toolbaritem.object.datawindow.column.count
			li_col_count = Integer(ls_col_count)
			if UpperBound (this.menuid.item[li_level1].item[ai_row].item) > 0 then
				dw_toolbaritem.enabled = false
				gb_toolbar.enabled = false
				ll_color = RGB (128, 128, 128)	// dark grey
			else
				dw_toolbaritem.enabled = true
				gb_toolbar.enabled = true
				ll_color = gb_1.TextColor 	// window text
			end if
			for i = 1 to li_col_count
				dw_toolbaritem.Modify ("#" + String (i) + ".color = '" + &
												 String (ll_color) + "'")
			next
			dw_toolbaritem.Modify ("name_t.color = '" + String (ll_color) + "'" + &
											 " itemtext_t.color = '" + String (ll_color) + "'")
			end if



	case 3
		li_level1 = dw_1.GetRow()
		li_level2 = dw_2.GetRow()

		if li_level1 > 0 and li_level2 > 0 then
		
			dw_menuitem.object.visible[1] = f_boolean_to_char (this.menuid.item[li_level1].item[li_level2].item[ai_row].visible)
			dw_menuitem.object.enabled[1] = f_boolean_to_char (this.menuid.item[li_level1].item[li_level2].item[ai_row].enabled)
			dw_menuitem.object.checked[1] = f_boolean_to_char (this.menuid.item[li_level1].item[li_level2].item[ai_row].checked)
			dw_menuitem.object.microhelp[1] = this.menuid.item[li_level1].item[li_level2].item[ai_row].microhelp

			dw_toolbaritem.object.tb_visible[1] = f_boolean_to_char (this.menuid.item[li_level1].item[li_level2].item[ai_row].ToolbarItemVisible)
			dw_toolbaritem.object.down[1] = f_boolean_to_char (this.menuid.item[li_level1].item[li_level2].item[ai_row].ToolbarItemDown)
			dw_toolbaritem.object.name[1] = this.menuid.item[li_level1].item[li_level2].item[ai_row].ToolbarItemName
			dw_toolbaritem.object.itemtext[1] = this.menuid.item[li_level1].item[li_level2].item[ai_row].ToolbarItemText


			//////////////////////////////////////////////////////////////////////
			// If the MenuItem has items under it (i.e. cascading menus or 
			// top-level menus), disallow changes to the toolbar attributes
			// by setting the taborder on the datawindow to zero and graying
			// out the text.
			//////////////////////////////////////////////////////////////////////

			ls_col_count = dw_toolbaritem.object.datawindow.column.count
			li_col_count = Integer(ls_col_count)
			if UpperBound (this.menuid.item[li_level1].item[li_level2].item[ai_row].item) > 0 then
				dw_toolbaritem.enabled = false
				gb_toolbar.enabled = false
				ll_color = RGB (128, 128, 128)	// dark grey
			else
				dw_toolbaritem.enabled = true
				gb_toolbar.enabled = true
				ll_color = gb_1.TextColor 	// window text
			end if
			for i = 1 to li_col_count
				dw_toolbaritem.Modify ("#" + String (i) + ".color = '" + &
											 String (ll_color) + "'")
			next
			dw_toolbaritem.Modify ("name_t.color = '" + String (ll_color) + "'" + &
											 " itemtext_t.color = '" + String (ll_color) + "'")
		end if

end choose

return 1
end function

protected function integer wf_change_menuitem (datawindow adw_current, string as_colname);//////////////////////////////////////////////////////////////////////
//
// Function: wf_change_menuitem
//
// Purpose: Changes the attribute values of the current (selected)
//				menu item to the user's specification.
//
//	Scope: protected
//
//	Arguments: adw_current, the datawindow (menuitem or toolbar item)
//									that the user is editing an attribute value from
//				  as_colname,  the column name that the user is editing
//									the value of
//
//	Returns: integer   1 = success
//							-1 = error
//
//////////////////////////////////////////////////////////////////////

int			li_first_row, li_second_row, li_third_row, 	li_size
string		ls_val
boolean		lb_val, lb_visible
menu			lm_curr_menu


lm_curr_menu = this.menuid

//////////////////////////////////////////////////////////////////////
// Determine what the current menuitem is
//////////////////////////////////////////////////////////////////////

choose case ii_cur_dw
	case 1
		li_first_row = dw_1.GetRow()

	case 2
		li_first_row = dw_1.GetRow()
		li_second_row = dw_2.GetRow()

	case 3
		li_first_row = dw_1.GetRow()
		li_second_row = dw_2.GetRow()
		li_third_row = dw_3.GetRow()

end choose


//////////////////////////////////////////////////////////////////////
// Change the value of the current menu item attribute
//////////////////////////////////////////////////////////////////////

choose case as_colname

	case 'visible'
		lb_val = f_char_to_boolean (adw_current.GetText())
		if ii_cur_dw = 1 then
			lm_curr_menu.item[li_first_row].visible = lb_val
		else
			if ii_cur_dw = 2 then
				lm_curr_menu.item[li_first_row].item[li_second_row].visible = lb_val
			else
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].visible = lb_val
			end if
		end if

	case 'enabled'
		lb_val = f_char_to_boolean (adw_current.GetText())
		if ii_cur_dw = 1 then
			lm_curr_menu.item[li_first_row].enabled = lb_val
		else
			if ii_cur_dw = 2 then
				lm_curr_menu.item[li_first_row].item[li_second_row].enabled = lb_val
			else
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].enabled = lb_val
			end if
		end if

	case 'checked'
		lb_val = f_char_to_boolean (adw_current.GetText())
		if ii_cur_dw = 1 then
			lm_curr_menu.item[li_first_row].checked = lb_val
		else
			if ii_cur_dw = 2 then
				lm_curr_menu.item[li_first_row].item[li_second_row].checked = lb_val
			else
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].checked = lb_val
			end if
		end if

	case 'tb_visible'
		lb_val = f_char_to_boolean (adw_current.GetText())
		if ii_cur_dw = 1 then
			lm_curr_menu.item[li_first_row].ToolbarItemVisible = lb_val
		else
			if ii_cur_dw = 2 then
				lm_curr_menu.item[li_first_row].item[li_second_row].ToolbarItemVisible = lb_val
			else
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].ToolbarItemVisible = lb_val
			end if
		end if

	case 'down'
		lb_val = f_char_to_boolean (adw_current.GetText())
		if ii_cur_dw = 1 then
			lm_curr_menu.item[li_first_row].ToolbarItemDown = lb_val
		else
			if ii_cur_dw = 2 then
				lm_curr_menu.item[li_first_row].item[li_second_row].ToolbarItemDown = lb_val
			else
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].ToolbarItemDown = lb_val
			end if
		end if

	case 'microhelp'
		ls_val = adw_current.GetText()
		if ii_cur_dw = 1 then
			lm_curr_menu.item[li_first_row].MicroHelp = ls_val
		else
			if ii_cur_dw = 2 then
				lm_curr_menu.item[li_first_row].item[li_second_row].MicroHelp = ls_val
			else
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].MicroHelp = ls_val
			end if
		end if

	case 'name'
		ls_val = adw_current.GetText()

		SetPointer (hourglass!)	
//		iw_frame.SetRedraw (false)
		if ii_cur_dw = 2 then
			// (Check for cascading menu)
			li_size = UpperBound (lm_curr_menu.item[li_first_row].item[li_second_row].item)
			if li_size = 0 then
				lb_visible = lm_curr_menu.item[li_first_row].item[li_second_row].visible
				lm_curr_menu.item[li_first_row].item[li_second_row].visible = not lb_visible
				lm_curr_menu.item[li_first_row].item[li_second_row].ToolbarItemName = ls_val
				lm_curr_menu.item[li_first_row].item[li_second_row].visible = lb_visible
			end if
		else
			if ii_cur_dw = 3 then
				dw_1.SetRedraw (false)
				lb_visible = lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].visible
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].visible = not lb_visible
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].ToolbarItemName = ls_val
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].visible = lb_visible
				dw_1.SetRedraw (true)
			end if
		end if
//		iw_frame.SetRedraw (true)

	case 'itemtext'
		ls_val = adw_current.GetText()
		if ii_cur_dw = 1 then
			lm_curr_menu.item[li_first_row].ToolbarItemText = ls_val
		else
			if ii_cur_dw = 2 then
				lm_curr_menu.item[li_first_row].item[li_second_row].ToolbarItemText = ls_val
			else
				lm_curr_menu.item[li_first_row].item[li_second_row].item[li_third_row].ToolbarItemText = ls_val
			end if
		end if

end choose


//////////////////////////////////////////////////////////////////////
// Set focus to the appropriate datawindow
//////////////////////////////////////////////////////////////////////
choose case ii_cur_dw

	case 1
		dw_1.SetFocus()

	case 2
		dw_2.SetFocus()

	case 3
		dw_3.SetFocus()

end choose

return 1
end function

event open;call super::open;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_menu_functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////

// Save the window background color
il_ButtonFace = This.BackColor

/////////////////////////////////////////////////////////////////////
//	Create instances of the two menus used for this example
/////////////////////////////////////////////////////////////////////

// iw_frame contains a reference to the frame window that this window
// was opened from
iw_frame = this.ParentWindow()

// Create instances of the two menus that will be used for the window
im_main = create m_menu_functions_main
im_alt = create m_menu_functions_alt

this.PostEvent ('ue_open')

end event

event rbuttondown;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// rbuttondown script for w_menu_functions
//////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////
// Purpose: 
//		When right mouse button is clicked, display popup menu at
//		the current pointer location.
/////////////////////////////////////////////////////////////////////


if this.menuid = im_main then
	this.menuid.item[2].item[1].PopMenu (this.ParentWindow().PointerX(), this.ParentWindow().PointerY())
else
	this.menuid.item[2].PopMenu (this.ParentWindow().PointerX(), this.ParentWindow().PointerY())
end if
end event

on w_menu_functions.create
int iCurrent
call super::create
if this.MenuName = "m_menu_functions_main" then this.MenuID = create m_menu_functions_main
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_menuitem=create dw_menuitem
this.dw_toolbaritem=create dw_toolbaritem
this.rb_main_menu=create rb_main_menu
this.rb_alt_menu=create rb_alt_menu
this.gb_toolbar=create gb_toolbar
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_menuitem
this.Control[iCurrent+5]=this.dw_toolbaritem
this.Control[iCurrent+6]=this.rb_main_menu
this.Control[iCurrent+7]=this.rb_alt_menu
this.Control[iCurrent+8]=this.gb_toolbar
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_1
end on

on w_menu_functions.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_menuitem)
destroy(this.dw_toolbaritem)
destroy(this.rb_main_menu)
destroy(this.rb_alt_menu)
destroy(this.gb_toolbar)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type dw_3 from datawindow within w_menu_functions
integer x = 1513
integer y = 200
integer width = 695
integer height = 468
string dataobject = "d_menuitem_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;/////////////////////////////////////////////////////////////////////
// 
//	Highlight the current row and deselect all other rows.
//
/////////////////////////////////////////////////////////////////////

string	ls_level

IF IsNull(currentrow) THEN
	Messagebox('current row is null','')
End If

if currentrow <= 0 then
	return
end if

this.SetRedraw (false)
dw_1.SetRedraw (false)
dw_2.SetRedraw (false)

dw_1.SelectRow (0, false)
dw_2.SelectRow (0, false)
this.SelectRow (0, false)
this.SelectRow (currentrow, true)

this.SetRedraw (true)
dw_1.SetRedraw (true)
dw_2.SetRedraw (true)

// Display the values of the current (selected) menuitem attributes
if ib_menu_built then
	wf_display_menuitem (currentrow)
end if


end event

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for dw_3
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_row

ll_row = this.GetRow()
if ll_row > 0 then
	ii_cur_dw = 3
end if
	
if ll_row = row then
	this.Trigger Event rowfocuschanged (this.GetRow())
end if


end event

event rbuttondown;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// rbuttondow script for dw_3
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////
// Purpose: 
//		When right mouse button is clicked, display popup menu at
//		the current pointer location.
/////////////////////////////////////////////////////////////////////


if parent.menuid = im_main then
	parent.menuid.item[2].item[1].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
else
	parent.menuid.item[2].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
end if
end event

type dw_2 from datawindow within w_menu_functions
integer x = 791
integer y = 200
integer width = 695
integer height = 468
string dataobject = "d_menuitem_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;/////////////////////////////////////////////////////////////////////
// 
// Purpose: 
//		Highlight the current row and deselect all other rows.
//		Filter the third datawindow to maintain correct menu hierarchy.
//
/////////////////////////////////////////////////////////////////////

string	ls_level

IF IsNull(currentrow) THEN
	Messagebox('current row is null','')
End If

if currentrow <= 0 then
	return
end if

this.SetRedraw (false)
dw_3.SetRedraw (false)

if currentrow > 0 then
	//ls_level = this.object.menulevel[currentrow]
	ls_level = this.GetItemString(currentrow, 'menulevel')  //obsolete code
	if not IsNull (ls_level) then
		dw_3.SetFilter ("menulevel = '" + ls_level + "'")
		dw_3.Filter()
	end if
end if

dw_1.SelectRow (0, false)
dw_3.SelectRow (0, false)
this.SelectRow (0, false)
this.SelectRow (currentrow, true)

this.SetRedraw (true)
dw_3.SetRedraw (true)

// Display the values of the current (selected) menuitem attributes
if ib_menu_built then
	wf_display_menuitem (currentrow)
end if
end event

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked  script for dw_2
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_row

ll_row = this.GetRow()
if ll_row > 0 then
	ii_cur_dw = 2
end if
	
if ll_row = row then
	this.Trigger Event rowfocuschanged (this.GetRow())
end if

end event

event rbuttondown;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// rbuttondow script for dw_2
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////
// Purpose: 
//		When right mouse button is clicked, display popup menu at
//		the current pointer location.
/////////////////////////////////////////////////////////////////////


if parent.menuid = im_main then
	parent.menuid.item[2].item[1].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
else
	parent.menuid.item[2].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
end if
end event

type dw_1 from datawindow within w_menu_functions
integer x = 64
integer y = 200
integer width = 695
integer height = 468
string dataobject = "d_menuitem_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;/////////////////////////////////////////////////////////////////////
// Purpose: 
//		Highlight the current row and deselect all other rows.
//		Filter the other datawindows to display the appropriate menu hierarchy
/////////////////////////////////////////////////////////////////////

string	ls_level

IF IsNull(currentrow) THEN
	Messagebox('current row is null','')
End If

if currentrow <= 0 then
	return
end if	

this.SetRedraw (false)
dw_2.SetRedraw (false)
dw_3.SetRedraw (false)

if currentrow > 0 then
	//ls_level = this.object.menulevel[currentrow]
	ls_level = this.GetItemString(currentrow, 'menulevel') //obsolete code
	if not IsNull (ls_level) then
		dw_2.SetFilter ("menulevel = '" + ls_level + "'")
		dw_2.Filter()
		dw_3.SetFilter ("menulevel = '-1'")
		dw_3.Filter()
	end if
end if

dw_2.SelectRow (0, false)
dw_3.SelectRow (0, false)
this.SelectRow (0, false)
this.SelectRow (currentrow, true)

this.SetRedraw (true)
dw_2.SetRedraw (true)
dw_3.SetRedraw (true)

// Display the values of the current (selected) menuitem attributes
if ib_menu_built then
	wf_display_menuitem (currentrow)
end if

end event

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for dw_1
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_row

ll_row = this.GetRow()
if ll_row > 0 then
	ii_cur_dw = 1
end if
	
if ll_row = row then
	this.Trigger Event rowfocuschanged (this.GetRow())
end if


end event

event rbuttondown;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// rbuttondown script for dw_1
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////
// Purpose: 
//		When right mouse button is clicked, display popup menu at
//		the current pointer location.
/////////////////////////////////////////////////////////////////////
//Window win1 = (Window)parent
if parent.menuid = im_main then
	parent.menuid.item[2].item[1].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
else
	parent.menuid.item[2].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
end if
end event

type dw_menuitem from datawindow within w_menu_functions
integer x = 41
integer y = 844
integer width = 1545
integer height = 360
integer taborder = 10
string dataobject = "d_menuitem_attributes"
boolean border = false
end type

on itemchanged;wf_change_menuitem (this, this.GetColumnName())
end on

event rbuttondown;/////////////////////////////////////////////////////////////////////
// 
// Purpose: 
//		When right mouse button is clicked, display popup menu at
//		the current pointer location.
//
/////////////////////////////////////////////////////////////////////


if parent.menuid = im_main then
	parent.menuid.item[2].item[1].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
else
	parent.menuid.item[2].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
end if
end event

on losefocus;this.AcceptText()
end on

type dw_toolbaritem from datawindow within w_menu_functions
integer x = 1673
integer y = 844
integer width = 905
integer height = 396
integer taborder = 20
string dataobject = "d_toolbar_attributes"
boolean border = false
end type

on itemchanged;wf_change_menuitem (this, this.GetColumnName())
end on

on losefocus;this.AcceptText()
end on

event rbuttondown;/////////////////////////////////////////////////////////////////////
// 
// Purpose: 
//		When right mouse button is clicked, display popup menu at
//		the current pointer location.
//
/////////////////////////////////////////////////////////////////////


if parent.menuid = im_main then
	parent.menuid.item[2].item[1].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
else
	parent.menuid.item[2].PopMenu (parent.ParentWindow().PointerX(), parent.ParentWindow().PointerY())
end if
end event

type rb_main_menu from radiobutton within w_menu_functions
integer x = 73
integer y = 100
integer width = 297
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Menu 1"
boolean checked = true
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for rb_main_menu
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////
// Purpose: 
//		Change the current menu to m_menu_functions_main
/////////////////////////////////////////////////////////////////////

if parent.menuid <> im_main then
	ib_menu_built = false

	SetPointer (hourglass!)
//	iw_frame.SetRedraw (false)
	parent.ChangeMenu (im_main)

	parent.SetRedraw (false)

	wf_show_menu()
	ib_menu_built = true

	ii_cur_dw = 1
	dw_1.SetFocus()

	if dw_1.RowCount() > 0 then
		dw_1.SetRow (1)
		dw_1.Trigger Event rowfocuschanged (dw_1.GetRow())
	end if

	parent.SetRedraw (true)

//	iw_frame.SetRedraw (true)
end if



end event

type rb_alt_menu from radiobutton within w_menu_functions
integer x = 407
integer y = 100
integer width = 297
integer height = 72
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Menu 2"
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for rb_alt_menu
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


/////////////////////////////////////////////////////////////////////
// Purpose: 
//		Change the current menu to m_menu_functions_alt
/////////////////////////////////////////////////////////////////////

if parent.menuid <> im_alt then
	ib_menu_built = false

	SetPointer (hourglass!)
//	iw_frame.SetRedraw (false)
	parent.ChangeMenu (im_alt)

	parent.SetRedraw (false)

	wf_show_menu()
	ib_menu_built = true

	ii_cur_dw = 1
	dw_1.SetFocus()

	if dw_1.RowCount() > 0 then
		dw_1.SetRow (1)
		dw_1.Trigger Event rowfocuschanged (dw_1.GetRow())
	end if

	parent.SetRedraw (true)

//	iw_frame.SetRedraw (true)
end if
end event

type gb_toolbar from groupbox within w_menu_functions
integer x = 1641
integer y = 748
integer width = 965
integer height = 524
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Toolbar Item"
end type

type gb_2 from groupbox within w_menu_functions
integer x = 18
integer y = 748
integer width = 1591
integer height = 524
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Menu Item"
end type

type gb_1 from groupbox within w_menu_functions
integer x = 18
integer y = 8
integer width = 2231
integer height = 700
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Current Menu"
end type

