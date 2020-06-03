$PBExportHeader$w_main.srw
$PBExportComments$Code Examples front-end
forward
global type w_main from window
end type
type tab_info from tab within w_main
end type
type tabpage_desc from userobject within tab_info
end type
type st_3 from statictext within tabpage_desc
end type
type st_2 from statictext within tabpage_desc
end type
type mle_desc from multilineedit within tabpage_desc
end type
type mle_tech from multilineedit within tabpage_desc
end type
type tabpage_desc from userobject within tab_info
st_3 st_3
st_2 st_2
mle_desc mle_desc
mle_tech mle_tech
end type
type tabpage_usage from userobject within tab_info
end type
type tv_usage from treeview within tabpage_usage
end type
type tabpage_usage from userobject within tab_info
tv_usage tv_usage
end type
type tab_info from tab within w_main
tabpage_desc tabpage_desc
tabpage_usage tabpage_usage
end type
type lb_cwd from listbox within w_main
end type
type tab_examples from tab within w_main
end type
type tabpage_examples from userobject within tab_examples
end type
type tv_examples from treeview within tabpage_examples
end type
type ddplb_state from dropdownpicturelistbox within tabpage_examples
end type
type tabpage_examples from userobject within tab_examples
tv_examples tv_examples
ddplb_state ddplb_state
end type
type tabpage_search from userobject within tab_examples
end type
type tv_search from treeview within tabpage_search
end type
type dw_search from datawindow within tabpage_search
end type
type rb_event from radiobutton within tabpage_search
end type
type rb_powerscript from radiobutton within tabpage_search
end type
type rb_user_func from radiobutton within tabpage_search
end type
type rb_objects from radiobutton within tabpage_search
end type
type st_1 from statictext within tabpage_search
end type
type cb_perform_search from commandbutton within tabpage_search
end type
type cb_reset_query from commandbutton within tabpage_search
end type
type gb_search from groupbox within tabpage_search
end type
type tabpage_search from userobject within tab_examples
tv_search tv_search
dw_search dw_search
rb_event rb_event
rb_powerscript rb_powerscript
rb_user_func rb_user_func
rb_objects rb_objects
st_1 st_1
cb_perform_search cb_perform_search
cb_reset_query cb_reset_query
gb_search gb_search
end type
type tab_examples from tab within w_main
tabpage_examples tabpage_examples
tabpage_search tabpage_search
end type
type gb_current from groupbox within w_main
end type
type ostr_script from structure within w_main
end type
end forward

type ostr_script from structure
	string		s_scriptname
	string		s_source
end type

global type w_main from window
integer width = 2953
integer height = 1856
boolean titlebar = true
string title = "Code Examples"
string menuname = "m_main"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 81838264
string icon = "Application!"
toolbaralignment toolbaralignment = alignatleft!
event ue_post_open ( )
tab_info tab_info
lb_cwd lb_cwd
tab_examples tab_examples
gb_current gb_current
end type
global w_main w_main

type variables
Integer	ii_window_index, ii_event_index, ii_function_index, &
	ii_datawindow_index, ii_pipeline_index, ii_menu_index, &
	ii_structure_index, ii_userobject_index, ii_dw_index, &
	ii_uo_index, ii_cb_index, ii_gb_index, ii_sb_index, ii_lb_index, &
	ii_ddlb_index, ii_mle_index, ii_pb_index, ii_rb_index, ii_sle_index, &
	ii_st_index, ii_gr_index, ii_p_index, ii_em_index, ii_tc_index, &
	ii_rte_index, ii_plb_index, ii_ddplb_index, ii_lv_index, ii_tv_index, &
	ii_cbx_index, ii_ln_index, ii_ov_index, ii_rect_index, ii_rr_index, &
	ii_objfunc_index, ii_mdi_index, ii_vb_index, ii_ole_index, &
	ii_htrackbar_index, ii_vtrackbar_index, ii_hprogbar_index, ii_vprogbar_index, &
	ii_sthyperlink, ii_pichyperlink, ii_appl_index
String	is_Filter, is_last_win, is_search_sql, &
	is_curr_col, is_LibraryList[], is_searchfilter
DataStore	ids_Objects, ids_Events, ids_Funcs, ids_SearchResults, &
		ids_Categories, ids_Examples, ids_New, ids_Enhanced, &
		ids_SearchExamples
Long il_root, il_searchroot
Long il_SelectedExample = 0
end variables

forward prototypes
public subroutine of_start_querymode (boolean ab_redraw)
public subroutine of_change_object (string as_ColName, string as_ColLabel)
public subroutine of_show_col (string as_colname)
public subroutine of_refresh_info ()
public subroutine of_open_help (string as_window)
public function integer of_run_window (string as_window)
public subroutine of_run_report ()
public function boolean of_has_help ()
public function boolean of_set_cwd (string as_newdirectory)
public function integer of_getcurrent (ref string as_window, ref integer ai_row)
public function boolean of_has_children (ref datastore ads_data, string as_category)
public subroutine of_add_objects (string as_window)
public function string of_get_object_name (long al_current)
public subroutine of_get_scripts (string as_object, ref ostr_script astr_events[], ref ostr_script astr_functions[])
public function boolean of_exampleselected ()
end prototypes

event ue_post_open;String	ls_PBType, ls_OSType, ls_Category, ls_LowerCat
Integer	li_NumRows, li_Row, li_PictureIndex

// Set library list to be used for metaclass information
is_LibraryList[1] = "pbexamfe.pbl"
is_LibraryList[2] = "pbexamd1.pbl"
is_LibraryList[3] = "pbexamd2.pbl"
is_LibraryList[4] = "pbexamfn.pbl"
is_LibraryList[5] = "pbexammn.pbl"
is_LibraryList[6] = "pbexamuo.pbl"
is_LibraryList[7] = "pbexamw1.pbl"
is_LibraryList[8] = "pbexamw2.pbl"
is_LibraryList[9] = "pbexamw3.pbl"
If (ge_Environment.OSType = sol2!) Or (ge_Environment.OSType = aix!) Or (ge_Environment.OSType = hpux!) Then
	is_LibraryList[10] = "pbexamsy.pbl"
	is_LibraryList[11] = "pbexamor.pbl"
Else
	is_LibraryList[10] = "pbexamsa.pbl"
End If

// Filter datawindow to only display examples used in this environment
Choose Case ge_Environment.OSType
	Case windows!
		If ge_Environment.OSMajorRevision = 4 Then
			// Windows 95
			ls_OSType = "winnt"
		Else
			ls_OSType = "windows"
		End If
	Case windowsnt!
		ls_OSType = "winnt"
	Case aix!
		ls_OSType = "aix"
	Case hpux!
		ls_OSType = "hpux"
	Case sol2!
		ls_OSType = "sol2"
End Choose

If ge_Environment.PBType = enterprise! Then
	ls_PBType = "enterprise"
Else
	ls_PBType = "desktop"
End If

is_Filter = "(ostype NOT LIKE '%" + ls_OSType + "%')" + &
				" And (pbtype NOT LIKE '%" + ls_PBType + "%')"

ids_Examples.SetFilter(is_Filter)
ids_Examples.Filter()

tab_examples.tabpage_examples.tv_examples.Post Event ue_reset_categories()

Close(w_splash)
end event

public subroutine of_start_querymode (boolean ab_redraw);If ab_Redraw Then tab_examples.tabpage_search.dw_search.SetRedraw(False)

 tab_examples.tabpage_search.dw_search.SetRedraw(False)
 tab_examples.tabpage_search.dw_search.object.datawindow.querymode = 'yes'
 tab_examples.tabpage_search.dw_search.RowsDiscard(2, 24, primary!)

If ab_Redraw Then tab_examples.tabpage_search.dw_search.SetRedraw(True)
end subroutine

public subroutine of_change_object (string as_ColName, string as_ColLabel);Integer					li_Resp
datawindowchild	ldwc_Object

SetPointer(hourglass!)
tab_examples.tabpage_search.dw_search.SetRedraw(False)

tab_examples.tabpage_search.dw_search.DataObject = 'd_search_object_ref'
tab_examples.tabpage_search.dw_search.SetTransObject(sqlca)
of_start_querymode(False)

li_Resp = tab_examples.tabpage_search.dw_search.GetChild('object_ref', ldwc_Object)
ldwc_Object.SetFilter('object_type = "' + as_ColName + '"')
ldwc_Object.Filter()
tab_examples.tabpage_search.dw_search.object.label_t.text = as_ColLabel

tab_examples.tabpage_search.dw_search.SetRedraw(True)
end subroutine

public subroutine of_show_col (string as_colname);String	ls_Command, ls_Resp

// reset the query criteria
SetPointer(hourglass!)

tab_examples.tabpage_search.dw_search.DataObject = tab_examples.tabpage_search.dw_search.DataObject
tab_examples.tabpage_search.dw_search.SetTransObject(sqlca)
tab_examples.tabpage_search.dw_search.SetRedraw(False)

of_start_querymode(False)

tab_examples.tabpage_search.dw_search.SetPosition(as_ColName, '' ,True)
tab_examples.tabpage_search.dw_search.SetPosition(as_ColName + '_t', '', True)

If Len(is_curr_col) > 0 Then ls_Command = is_curr_col + '.tabsequence = 0 '
ls_Command = ls_Command + as_ColName + '.tabsequence = 1'

ls_Resp = tab_examples.tabpage_search.dw_search.Modify(ls_Command)

tab_examples.tabpage_search.dw_search.SetRedraw(True)

If Len(ls_Resp) > 0 Then MessageBox(ls_Resp, ls_Command)

is_curr_col = as_ColName
end subroutine

public subroutine of_refresh_info ();String				ls_Tmp, ls_Win
Integer				li_CurrRow
Long					ll_Handle
TreeViewItem	ltvi_Window, ltvi_Item, ltvi_Current

// Determine the current window and Datastore row
of_getcurrent(ls_Win, li_CurrRow)

If ls_Win = is_last_win Then Return  //  eliminate redundent redraws
is_last_win = ls_Win

// Change Group Box title
If li_CurrRow > 0 Then
	ls_Tmp = ids_Examples.object.title[li_CurrRow]
Else
	ls_Tmp = "Current Example"
End if
gb_current.Text = ls_Tmp

// Change description
If li_CurrRow > 0 Then
	ls_Tmp = ids_Examples.object.description[li_CurrRow]
Else
	ls_Tmp = ""
End if
tab_info.tabpage_desc.mle_desc.Text = ls_Tmp

// Change technique
If li_CurrRow > 0 Then
	ls_Tmp = ids_Examples.object.technique[li_CurrRow]
Else
	ls_Tmp = ""
End if
tab_info.tabpage_desc.mle_tech.Text = ls_Tmp

// Add objects to tree
// Clear current tree view
tab_info.tabpage_usage.tv_usage.SetRedraw(False)

ll_Handle = tab_info.tabpage_usage.tv_usage.FindItem(RootTreeItem!, 0)
tab_info.tabpage_usage.tv_usage.DeleteItem(ll_Handle)
tab_info.tabpage_usage.tv_usage.DeleteItem(0)

If ls_Win <> "" Then of_add_objects(ls_Win)

tab_info.tabpage_usage.tv_usage.SetRedraw(True)
end subroutine

public subroutine of_open_help (string as_window);Integer				li_CurrRow
String				ls_Win

If as_Window <> "" Then
	f_open_help(as_Window)
Else
	// Determine the current window and Datastore row
	of_getcurrent(ls_Win, li_CurrRow)

	If ls_Win = "" Then
		Return
	Else
		f_open_help(ls_Win)
	End if
End if
end subroutine

public function integer of_run_window (string as_window);// Window function wf_run_window ()
// Opens the window currently selected by the user
Integer				li_CurrRow, li_Resp, li_return
Window				lw_Ex
DataWindow		ldw_Current	

If as_Window  = "" Then
	// Determine the current window and Datastore row
	li_return = of_getcurrent(as_Window, li_CurrRow)
End If

if li_return < 0  then return -1

This.Hide()
li_Resp = Open(lw_Ex, as_Window)

If li_Resp <> 1 Then This.Show()
Return li_Resp
end function

public subroutine of_run_report ();// Run report for currently selected example
Integer						li_CurrRow
String						ls_Win
u_report_structure	luo_Parm

// Determine the current window and Datastore row
of_getcurrent(ls_Win, li_CurrRow)

If li_CurrRow >= 1 Then
	luo_Parm.is_Application = 'example115'
	luo_Parm.is_Object = ls_Win
	luo_Parm.is_Title = ids_Examples.object.title[li_CurrRow]
	
	This.Hide()
	OpenWithParm(w_example_report_frame, luo_Parm)
End if
end subroutine

public function boolean of_has_help ();String			ls_Win
Integer			li_CurrRow

// Determine the current window and Datastore row
of_getcurrent(ls_Win, li_CurrRow)

If li_CurrRow < 1 Then
	Return False
End If

// Determine if the current example has help
If ids_Examples.Object.exhelp[li_CurrRow] = 1 Then
	Return True
Else
	Return False
End If
end function

public function boolean of_set_cwd (string as_newdirectory);// Change the current working directory.
// Use the DirList ListBox function which changes the directory when it is run.

Return lb_CWD.DirList(as_NewDirectory + gu_ext_func.uf_get_separator() + "*.*", 0)
end function

public function integer of_getcurrent (ref string as_window, ref integer ai_row);Long					ll_Current
TreeView			ltv_Current
TreeViewItem	ltvi_Current

// Determine which tab is being displayed
If tab_examples.SelectedTab = 1 Then
	ltv_Current = tab_examples.tabpage_examples.tv_examples
Else
	ltv_Current = tab_examples.tabpage_search.tv_search
End If

ll_Current = ltv_Current.FindItem(CurrentTreeItem!, 0)
If ll_Current < 1 Then
	as_Window = ""
	ai_Row = 0
Else
	ltv_Current.GetItem(ll_Current, ltvi_Current)
	as_Window = ltvi_Current.Data
	If Left(as_Window, 2) <> "w_" Then
		as_Window = ""
		ai_Row = 0
	Else
		ai_Row = ids_Examples.Find("window = '" + as_Window + "'", 1, ids_Examples.RowCount())
	End If
End If

If as_Window = "" Then
	Return -1
Else
	Return 0
End If
end function

public function boolean of_has_children (ref datastore ads_data, string as_category);Integer		li_Rows

li_Rows = ads_Data.RowCount()

If ads_Data.Find("group_id LIKE '" + as_Category + "%'", 1, li_Rows) <= 0 Then
	Return False
Else
	Return True
End If
end function

public subroutine of_add_objects (string as_window);Long					ll_Rows, ll_Cnt
TreeViewItem	ltvi_New
	
ltvi_New.Label = as_Window
ltvi_New.Data = as_Window
ltvi_New.PictureIndex = ii_window_index
ltvi_New.SelectedPictureIndex = ii_window_index
ltvi_New.Children = True
tab_info.tabpage_usage.tv_usage.InsertItemLast(0, ltvi_New)

ids_Objects.SetFilter('object = "' + as_Window + '"')
ids_Objects.Filter()
ll_Rows = ids_Objects.RowCount()

For ll_Cnt = 1 To ll_Rows
	If ids_Objects.Object.object_ref[ll_Cnt] <> as_Window Then
		ltvi_New.Label = ids_Objects.Object.object_ref[ll_Cnt]
		ltvi_New.Data = ltvi_New.Label

		Choose Case Lower ( ids_Objects.Object.Ref_Type[ll_Cnt] )
			Case 'application'
				ltvi_New.PictureIndex = ii_appl_index
				ltvi_New.Children = True
			Case 'window'
				ltvi_New.PictureIndex = ii_window_index
				ltvi_New.Children = True
			Case 'datawindow object', 'query object'
				ltvi_New.PictureIndex = ii_datawindow_index
				ltvi_New.Children = False
			Case 'function'
				ltvi_New.PictureIndex = ii_function_index
				ltvi_New.Children = True
			Case 'pipeline'
				ltvi_New.PictureIndex = ii_pipeline_index
				ltvi_New.Children = False
			Case 'menu'
				ltvi_New.PictureIndex = ii_menu_index
				ltvi_New.Children = True
			Case 'userobject', 'nonvisualuserobject'
				ltvi_New.PictureIndex = ii_userobject_index
				ltvi_New.Children = True
			Case 'structure'
				ltvi_New.PictureIndex = ii_structure_index
				ltvi_New.Children = False
			Case Else
				ltvi_New.PictureIndex = 0
				ltvi_New.Children = False
		End Choose
		
		ltvi_New.SelectedPictureIndex = ltvi_New.PictureIndex
		tab_info.tabpage_usage.tv_usage.InsertItemLast(0, ltvi_New)
	End If
Next
end subroutine

public function string of_get_object_name (long al_current);String				ls_Object
Long					ll_Parent
Boolean				lb_First = True
TreeViewItem	ltvi_Item

ll_Parent = tab_info.tabpage_usage.tv_usage.FindItem(ParentTreeItem!, al_Current)
Do While ll_Parent > 0
	tab_info.tabpage_usage.tv_usage.GetItem(ll_Parent, ltvi_Item)
	If (ltvi_Item.Label <> "Events") And (ltvi_Item.Label <> "Functions") Then
		If lb_First Then
			ls_Object = ltvi_Item.Label
			lb_First = False
		Else
			ls_Object = ltvi_Item.Label + ":" + ls_Object
		End If
	End If
	ll_Parent = tab_info.tabpage_usage.tv_usage.FindItem(ParentTreeItem!, ll_Parent)
Loop

Return ls_Object
end function

public subroutine of_get_scripts (string as_object, ref ostr_script astr_events[], ref ostr_script astr_functions[]);ClassDefinition		lcd_Object
ScriptDefinition		lsd_Scripts[]
TypeDefinition		ltd_Returns
Integer					li_Events, li_Functions, li_Cnt, li_Limit, li_Cnt2, li_Args
String					ls_Returns, ls_ArgList

lcd_Object = FindClassDefinition(as_Object, is_LibraryList)
lsd_Scripts = lcd_Object.ScriptList
li_Events = 0
li_Functions = 0
li_Limit = UpperBound(lsd_Scripts)

For li_Cnt = 1 To li_Limit
	If (lsd_Scripts[li_Cnt].islocallyscripted) And ((lsd_Scripts[li_Cnt].name <> "create") And (lsd_Scripts[li_Cnt].name <> "destroy")) Then

		// Format function or event call
		ltd_Returns = lsd_Scripts[li_Cnt].returntype
		If  IsValid(ltd_Returns) Then
			ls_Returns = "returns " + ltd_Returns.name
		Else
			ls_Returns = ""
		End If
		
		li_Args = UpperBound(lsd_Scripts[li_Cnt].argumentlist)
		ls_ArgList = " ("
		For li_Cnt2 = 1 To li_Args
			If li_Cnt2 > 1 Then
				ls_ArgList += ", "
			End If
			
			ls_ArgList += lsd_Scripts[li_Cnt].argumentlist[li_Cnt2].typeinfo.name + " " + &
								lsd_Scripts[li_Cnt].argumentlist[li_Cnt2].name
		Next
		ls_ArgList += ") "
		
		If lsd_Scripts[li_Cnt].kind = ScriptEvent! Then
			li_Events ++
			astr_Events[li_Events].s_ScriptName = lsd_Scripts[li_Cnt].name + ls_ArgList + ls_Returns
			astr_Events[li_Events].s_Source = lsd_Scripts[li_Cnt].source
		Else
			li_Functions ++
			astr_Functions[li_Functions].s_ScriptName = lsd_Scripts[li_Cnt].name + ls_ArgList + ls_Returns
			astr_Functions[li_Functions].s_Source = lsd_Scripts[li_Cnt].source
		End If
	End If
Next
end subroutine

public function boolean of_exampleselected ();//  Determines if there is an example report to run
string			ls_window
treeviewitem	ltvi_current

If (tab_examples.tabpage_examples.tv_examples.GetItem(il_SelectedExample, ltvi_current) < 0) Then
	Return False
End If

ls_window = ltvi_current.data

Return ( Left(ls_window, 2) = "w_" )

end function

event open;Integer	li_ScreenH, li_ScreenW

// Create DataStores used
ids_Events = Create DataStore
ids_Events.DataObject = 'd_event_list'

ids_Funcs = Create DataStore
ids_Funcs.DataObject = 'd_function_list'

ids_Objects = Create DataStore
ids_Objects.DataObject = 'd_object_list'

ids_SearchResults = Create DataStore
ids_SearchResults.DataObject = "d_search_results"
ids_SearchResults.setTransObject(sqlca)

ids_Categories = Create DataStore
ids_Categories.DataObject = "d_example_categories"

ids_Examples = Create DataStore
ids_Examples.DataObject = "d_examples"

ids_SearchExamples = Create DataStore
ids_SearchExamples.DataObject = "d_examples"

// Set window title
This.Title = "PowerBuilder " + Left ( sVERSIONEX, 4 ) + " Code Examples"

This.Post Event ue_post_open()
end event

event close;Destroy ids_Events
Destroy ids_Funcs
Destroy ids_Objects
Destroy ids_SearchResults
end event

on w_main.create
if this.MenuName = "m_main" then this.MenuID = create m_main
this.tab_info=create tab_info
this.lb_cwd=create lb_cwd
this.tab_examples=create tab_examples
this.gb_current=create gb_current
this.Control[]={this.tab_info,&
this.lb_cwd,&
this.tab_examples,&
this.gb_current}
end on

event hide;Timer(0)
end event

event show;// This event is fired after every example is run.
// The example may have changed the current working directory, set it back.
of_set_cwd(gs_ExampleDir)
end event

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_info)
destroy(this.lb_cwd)
destroy(this.tab_examples)
destroy(this.gb_current)
end on

event resize;tab_examples.width = newwidth / 2
tab_examples.height = newheight - 40

gb_current.x = tab_examples.x + tab_examples.width + 30
gb_current.width = (newwidth - gb_current.x) - 10
gb_current.height = newheight - 15

tab_info.x = gb_current.x + 30
tab_info.width = gb_current.width - 60
tab_info.height = tab_examples.height - (tab_info.y - tab_examples.y)

tab_examples.tabpage_examples.tv_examples.width = tab_examples.width - 35
tab_examples.tabpage_examples.tv_examples.height = tab_examples.height - 225

tab_examples.tabpage_search.tv_search.width = tab_examples.tabpage_examples.tv_examples.width
tab_examples.tabpage_search.tv_search.height = tab_examples.tabpage_examples.tv_examples.height - &
																		(tab_examples.tabpage_search.tv_search.y - tab_examples.tabpage_examples.tv_examples.y)

tab_examples.tabpage_search.gb_search.x = tab_examples.width - 470
tab_examples.tabpage_search.rb_event.x = tab_examples.tabpage_search.gb_search.x + 15
tab_examples.tabpage_search.rb_powerscript.x = tab_examples.tabpage_search.rb_event.x
tab_examples.tabpage_search.st_1.x = tab_examples.tabpage_search.rb_powerscript.x + 80
tab_examples.tabpage_search.rb_user_func.x = tab_examples.tabpage_search.rb_event.x
tab_examples.tabpage_search.rb_objects.x = tab_examples.tabpage_search.rb_event.x
tab_examples.tabpage_search.cb_perform_search.x = tab_examples.tabpage_search.gb_search.x + 30
tab_examples.tabpage_search.cb_reset_query.x = tab_examples.tabpage_search.gb_search.x + 30
tab_examples.tabpage_search.dw_search.width = tab_examples.tabpage_search.gb_search.x

tab_info.tabpage_usage.tv_usage.width = tab_info.width - 35
tab_info.tabpage_usage.tv_usage.height = tab_examples.tabpage_examples.tv_examples.height + 45

tab_info.tabpage_desc.mle_desc.width = tab_info.tabpage_usage.tv_usage.width
tab_info.tabpage_desc.mle_tech.width = tab_info.tabpage_desc.mle_desc.width
tab_info.tabpage_desc.mle_desc.height = (tab_info.height - 300) / 2
tab_info.tabpage_desc.mle_tech.height = tab_info.tabpage_desc.mle_desc.height
tab_info.tabpage_desc.st_2.y = tab_info.tabpage_desc.mle_desc.y + tab_info.tabpage_desc.mle_desc.height + 15
tab_info.tabpage_desc.mle_tech.y = tab_info.tabpage_desc.st_2.y + 70
end event

type tab_info from tab within w_main
event create ( )
event destroy ( )
integer x = 1531
integer y = 64
integer width = 1339
integer height = 1560
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_desc tabpage_desc
tabpage_usage tabpage_usage
end type

on tab_info.create
this.tabpage_desc=create tabpage_desc
this.tabpage_usage=create tabpage_usage
this.Control[]={this.tabpage_desc,&
this.tabpage_usage}
end on

on tab_info.destroy
destroy(this.tabpage_desc)
destroy(this.tabpage_usage)
end on

type tabpage_desc from userobject within tab_info
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 1303
integer height = 1444
long backcolor = 79741120
string text = "Description/Techniques"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
st_3 st_3
st_2 st_2
mle_desc mle_desc
mle_tech mle_tech
end type

on tabpage_desc.create
this.st_3=create st_3
this.st_2=create st_2
this.mle_desc=create mle_desc
this.mle_tech=create mle_tech
this.Control[]={this.st_3,&
this.st_2,&
this.mle_desc,&
this.mle_tech}
end on

on tabpage_desc.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.mle_desc)
destroy(this.mle_tech)
end on

type st_3 from statictext within tabpage_desc
integer y = 16
integer width = 311
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Description"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_desc
integer y = 732
integer width = 366
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean enabled = false
string text = "Techniques"
boolean focusrectangle = false
end type

type mle_desc from multilineedit within tabpage_desc
integer y = 88
integer width = 1303
integer height = 628
integer taborder = 1
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type mle_tech from multilineedit within tabpage_desc
integer y = 800
integer width = 1303
integer height = 628
integer taborder = 53
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_usage from userobject within tab_info
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 1303
integer height = 1444
long backcolor = 73955432
string text = "Related Objects"
long tabtextcolor = 33554432
long tabbackcolor = 73955432
tv_usage tv_usage
end type

on tabpage_usage.create
this.tv_usage=create tv_usage
this.Control[]={this.tv_usage}
end on

on tabpage_usage.destroy
destroy(this.tv_usage)
end on

type tv_usage from treeview within tabpage_usage
integer y = 8
integer width = 1303
integer height = 1428
integer taborder = 1
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {""}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 553648127
end type

event constructor;ii_window_index = This.AddPicture('window!')
ii_event_index = This.AddPicture('scriptyes!')
ii_function_index = This.AddPicture('editfuncdeclare!!')
ii_objfunc_index = This.AddPicture('function!')
ii_datawindow_index = This.AddPicture('datawindow5!')
ii_pipeline_index = This.AddPicture('DataPipeline!')
ii_menu_index = This.AddPicture('menu5!')
ii_structure_index = This.AddPicture('structure5!')
ii_userobject_index = This.AddPicture('userobject5!')
ii_cb_index = This.AddPicture('commandbutton!')
ii_dw_index = This.AddPicture('datawindow5!')
ii_uo_index = This.AddPicture('userobject5!')
ii_gb_index = This.AddPicture('groupbox!')
ii_sb_index = This.AddPicture('hscrollbar!')
ii_lb_index = This.AddPicture('listbox!')
ii_ddlb_index = This.AddPicture('dropdownlistbox!')
ii_mle_index = This.AddPicture('multilineedit5!')
ii_pb_index = This.AddPicture('picturebutton!')
ii_rb_index = This.AddPicture('radiobutton!')
ii_sle_index = This.AddPicture('singlelineedit5!')
ii_st_index = This.AddPicture('statictext!')
ii_gr_index = This.AddPicture('graph!')
ii_p_index = This.AddPicture('picture5!')
ii_em_index = This.AddPicture('editmask5!')
ii_tc_index = This.AddPicture('tab!')
ii_rte_index = This.AddPicture('richtextedit!')
ii_plb_index = This.AddPicture('picturelistbox!')
ii_ddplb_index = This.AddPicture('picturedropdownlistbox!')
ii_lv_index = This.AddPicture('listview!')
ii_tv_index = This.AddPicture('treeview!')
ii_cbx_index = This.AddPicture('checkbox!')
ii_ln_index = This.AddPicture('line!')
ii_ov_index = This.AddPicture('oval!')
ii_rect_index = This.AddPicture('rectangle!')
ii_rr_index = This.AddPicture('roundrectangle!')
ii_mdi_index = This.AddPicture('layer!')
ii_vb_index = This.AddPicture('vscrollbar!')
ii_ole_index = This.AddPicture('ole5!')
ii_htrackbar_index = This.AddPicture('HTrackBar!')
ii_vtrackbar_index = This.AddPicture('VTrackBar!')
ii_hprogbar_index = This.AddPicture('HProgressBar!')
ii_vprogbar_index = This.AddPicture('VProgressBar!')
ii_sthyperlink = This.AddPicture('StaticHyperLink!')
ii_pichyperlink = This.AddPicture('PictureHyperLink!')
ii_appl_index = This.AddPicture('Application5!')
end event

event doubleclicked;TreeViewItem	ltvi_Item
String				ls_Script
w_script			lw_Script

This.GetItem(handle, ltvi_Item)

If (ltvi_Item.PictureIndex = ii_event_index) Or (ltvi_Item.PictureIndex = ii_objfunc_index) Then
	ls_Script = String(ltvi_Item.Data)
	If Trim(ls_Script) = "" Then Return
	OpenWithParm(lw_Script, of_get_object_name(handle) + "~t" + ls_Script)
End If
end event

event itempopulate;TreeViewItem	ltvi_Item, ltvi_New
String				ls_Window
Long					ll_Cnt, ll_Rows, ll_Events, ll_Functions, ll_NewHandle
Boolean				lb_Children
ostr_script		lstr_Events[], lstr_Functions[]
ClassDefinition	lcd_Object

SetPointer(HourGlass!)

This.GetItem(handle, ltvi_Item)

If (ltvi_Item.Label <> "Events") And (ltvi_Item.Label <> "Functions") Then
	//  List nested classes
	lcd_Object = FindClassDefinition(String(ltvi_Item.Data), is_LibraryList)
	If IsNull(lcd_Object) Then
		MessageBox("Error","Object Not Found.")
		Return
	End If
	
	ll_Rows = UpperBound(lcd_Object.nestedclasslist)
	
	If ll_Rows = 0 Then
		lb_Children = False
	Else
		lb_Children = True
	
		For ll_Cnt = 1 To ll_Rows
			ltvi_New.Data = lcd_Object.nestedclasslist[ll_Cnt].name
			ltvi_New.Label = Right(ltvi_New.Data, (Len(String(ltvi_New.Data)) - Pos(ltvi_New.Data, "`")))
		
			//  Set picture
			Choose Case lcd_Object.nestedclasslist[ll_Cnt].datatypeof
				Case "datawindow"
					ltvi_New.PictureIndex = ii_dw_index
				Case "userobject"
					ltvi_New.PictureIndex = ii_uo_index
				Case "commandbutton"
					ltvi_New.PictureIndex = ii_cb_index
				Case "groupbox"
					ltvi_New.PictureIndex = ii_gb_index
				Case "listbox"
					ltvi_New.PictureIndex = ii_lb_index
				Case "dropdownlistbox"
					ltvi_New.PictureIndex = ii_ddlb_index
				Case "multilineedit"
					ltvi_New.PictureIndex = ii_mle_index
				Case "picturebutton"
					ltvi_New.PictureIndex = ii_pb_index
				Case "radiobutton"
					ltvi_New.PictureIndex = ii_rb_index
				Case "singlelineedit"
					ltvi_New.PictureIndex = ii_sle_index
				Case "statictext"
					ltvi_New.PictureIndex = ii_st_index
				Case "graph"
					ltvi_New.PictureIndex = ii_gr_index
				Case "picture"
					ltvi_New.PictureIndex = ii_p_index
				Case "editmask"
					ltvi_New.PictureIndex = ii_em_index
				Case "tab"
					ltvi_New.PictureIndex = ii_tc_index
				Case "richtextedit"
					ltvi_New.PictureIndex = ii_rte_index
				Case "picturelistbox"
					ltvi_New.PictureIndex = ii_plb_index
				Case "dropdownpicturelistbox"
					ltvi_New.PictureIndex = ii_ddplb_index
				Case "listview"
					ltvi_New.PictureIndex = ii_lv_index
				Case "treeview"
					ltvi_New.PictureIndex = ii_tv_index
				Case "checkbox"
					ltvi_New.PictureIndex = ii_cbx_index
				Case "line"
					ltvi_New.PictureIndex = ii_ln_index
				Case "oval"
					ltvi_New.PictureIndex = ii_ov_index
				Case "rectangle"
					ltvi_New.PictureIndex = ii_rect_index
				Case "roundrectangle"
					ltvi_New.PictureIndex = ii_rr_index
				Case "structure"
					ltvi_New.PictureIndex = ii_structure_index
				Case "menu"
					ltvi_New.PictureIndex = ii_menu_index
				Case "hscrollbar"
					ltvi_New.PictureIndex = ii_sb_index
				Case "vscrollbar"
					ltvi_New.PictureIndex = ii_vb_index
				Case "mdiclient"
					ltvi_New.PictureIndex = ii_mdi_index
				Case "olecontrol"
					ltvi_New.PictureIndex = ii_ole_index
				Case "htrackbar"
					ltvi_New.PictureIndex = ii_htrackbar_index
				Case "vtrackbar"
					ltvi_New.PictureIndex = ii_vtrackbar_index
				Case "hprogressbar"
					ltvi_New.PictureIndex = ii_hprogbar_index
				Case "vprogressbar"
					ltvi_New.PictureIndex = ii_vprogbar_index
				Case "statichyperlink"
					ltvi_New.PictureIndex = ii_sthyperlink
				Case "picturehyperlink"
					ltvi_New.PictureIndex = ii_pichyperlink
				Case "application"
					ltvi_New.PictureIndex = ii_appl_index
				Case Else
					ltvi_New.PictureIndex = 0
			End Choose
		
			ltvi_New.SelectedPictureIndex = 	ltvi_New.PictureIndex
			If lcd_Object.nestedclasslist[ll_Cnt].datatypeof = "structure" Then
				ltvi_New.Children = False
			Else
				ltvi_New.Children = True
			End If
			This.InsertItemSort(handle, ltvi_New)
		Next
	End If

	//  List scripts
	of_get_scripts(String(ltvi_Item.Data), lstr_Events, lstr_Functions)
	ll_Events = UpperBound(lstr_Events)
	ll_Functions = UpperBound(lstr_Functions)

	If (ll_Events = 0) And (ll_Functions = 0) And (lb_Children = False) Then
		ltvi_Item.Children = False
		This.SetItem(handle, ltvi_Item)
	Else
		lb_Children = True
		
		// Add events
		If ll_Events > 0 Then
			ltvi_New.PictureIndex = ii_event_index
			ltvi_New.SelectedPictureIndex = ii_event_index
			ltvi_New.Label = "Events"
			ltvi_New.Children = True
			ll_NewHandle = This.InsertItemFirst(handle, ltvi_New)
			For ll_Cnt = 1 To ll_Events
				ltvi_New.Children = False
				ltvi_New.Label = lstr_Events[ll_Cnt].s_ScriptName
				ltvi_New.Data = lstr_Events[ll_Cnt].s_Source
				This.InsertItemLast(ll_NewHandle, ltvi_New)
			Next
		End If
			
		// Add functions
		If ll_Functions > 0 Then
			ltvi_New.PictureIndex = ii_objfunc_index
			ltvi_New.SelectedPictureIndex = ii_objfunc_index
			ltvi_New.Label = "Functions"
			ltvi_New.Children = True
			ll_NewHandle = This.InsertItemFirst(handle, ltvi_New)
			For ll_Cnt = 1 To ll_Functions
				ltvi_New.Children = False
				ltvi_New.Label = lstr_Functions[ll_Cnt].s_ScriptName
				ltvi_New.Data = lstr_Functions[ll_Cnt].s_Source
				This.InsertItemLast(ll_NewHandle, ltvi_New)
			Next
		End If
	End If
End If

SetPointer(Arrow!)
end event

type lb_cwd from listbox within w_main
boolean visible = false
integer x = 928
integer y = 4
integer width = 480
integer height = 356
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean vscrollbar = true
end type

type tab_examples from tab within w_main
event create ( )
event destroy ( )
integer x = 5
integer y = 8
integer width = 1472
integer height = 1636
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 74481808
boolean raggedright = true
boolean showpicture = false
integer selectedtab = 1
tabpage_examples tabpage_examples
tabpage_search tabpage_search
end type

on tab_examples.create
this.tabpage_examples=create tabpage_examples
this.tabpage_search=create tabpage_search
this.Control[]={this.tabpage_examples,&
this.tabpage_search}
end on

on tab_examples.destroy
destroy(this.tabpage_examples)
destroy(this.tabpage_search)
end on

event selectionchanged;If oldindex < 0 Then Return	// skip the initial window open

of_refresh_info()
end event

type tabpage_examples from userobject within tab_examples
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 1435
integer height = 1520
long backcolor = 73955432
string text = "Examples"
long tabtextcolor = 33554432
long tabbackcolor = 73955432
tv_examples tv_examples
ddplb_state ddplb_state
end type

on tabpage_examples.create
this.tv_examples=create tv_examples
this.ddplb_state=create ddplb_state
this.Control[]={this.tv_examples,&
this.ddplb_state}
end on

on tabpage_examples.destroy
destroy(this.tv_examples)
destroy(this.ddplb_state)
end on

type tv_examples from treeview within tabpage_examples
event ue_reset_categories ( )
event ue_expand_all ( )
event ue_collapse_all ( )
event rbuttonup pbm_rbuttonup
integer y = 108
integer width = 1435
integer height = 1404
integer taborder = 51
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"DataPipeline!","Query5!","DataWindow5!","DataWindow5!","DataWindow5!","DataWindow5!","PasteStatement!","MoveMode!","Function!","Function!","Function!","Graph!","Inherit!","Custom002!","Cascade!","Menu5!","Custom045!","Custom020!","Ole5!","Continue!","PasteSQL5!","PasteSQL5!","UserObject5!","Window!","DataWindow5!","Run!","Custom079!","CreateLibrary!","exam.bmp"}
integer picturewidth = 16
integer pictureheight = 16
long picturemaskcolor = 12632256
string statepicturename[] = {"Custom079!"}
integer statepicturewidth = 16
integer statepictureheight = 16
long statepicturemaskcolor = 12632256
end type

event ue_reset_categories;String				ls_Sub, ls_Super, ls_Category
Integer				li_Categories, li_Sub, li_Cnt
Long					ll_Super, ll_item
TreeViewItem	ltvi_Item

SetPointer(HourGlass!)

This.DeleteItem(0)

ltvi_Item.Label = "PowerBuilder Examples"
ltvi_Item.Data = ""
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = ltvi_Item.PictureIndex
ltvi_Item.Children = True
il_root = This.InsertItemLast (0, ltvi_Item)

li_Categories = ids_Categories.RowCount()
For li_Cnt = 1 To li_Categories
	ls_Category = ids_Categories.Object.group_id[li_Cnt]

	li_Sub = Pos(ls_Category, " - ")
	if li_Sub > 0 Then
		ls_Sub = Mid(ls_Category, (li_Sub + 3))
		If ll_Super = 0 Then
			ls_Super = Left(ls_Category, (li_Sub - 1))
			ltvi_Item.Label = ls_Super
			ltvi_Item.Data = ls_Super
			ltvi_Item.PictureIndex = li_Cnt
			ltvi_Item.SelectedPictureIndex = ltvi_Item.PictureIndex
			ltvi_Item.Children = True
			ll_Super = This.InsertItemLast(il_root, ltvi_Item)
		End If
		ltvi_Item.Label = ls_Sub
		ltvi_Item.Data = ls_Category
		
	Else
		ll_Super = 0
		ltvi_Item.Label = ls_Category
		ltvi_Item.Data = ls_Category
	End If
	
	ltvi_Item.PictureIndex = li_Cnt
	ltvi_Item.SelectedPictureIndex = ltvi_Item.PictureIndex
	If of_has_children(ids_Examples, ls_Category) Then
		ltvi_Item.Children = True
	Else
		ltvi_Item.Children = False
	End If
	
	If ll_super = 0 Then
		ll_item = This.InsertItemLast(il_root, ltvi_Item)
	Else
		ll_item = This.InsertItemLast(ll_Super, ltvi_Item)
	End If
	
Next

this.ExpandItem ( il_root ) 
end event

event ue_expand_all;SetPointer(HourGlass!)

this.SetReDraw ( False ) 

this.ExpandAll ( il_root ) 

this.SetFirstVisible ( il_root )

this.SetReDraw ( True ) 
end event

event ue_collapse_all;SetPointer(HourGlass!)

This.CollapseItem(il_root)
end event

event itempopulate;String				ls_Filter
Integer				li_Cnt, li_Examples
String				ls_Category
TreeViewItem	ltvi_New, ltvi_Parent

This.GetItem(handle, ltvi_Parent)
ls_Category = ltvi_Parent.Data

li_Examples = ids_Examples.RowCount()
li_Cnt = ids_examples.Find("group_id = '" + ls_Category + "'", 1, li_Examples)
Do While li_Cnt > 0
	ltvi_New.Label = ids_Examples.Object.title[li_Cnt]
	ltvi_New.Data = ids_Examples.Object.window[li_Cnt]
	ltvi_New.Children = False
	
	If ids_Examples.Object.version[li_Cnt] = "8.0" Then
		ltvi_New.PictureIndex = 29
	ElseIf ids_Examples.Object.new[li_Cnt] = 1 Then
		ltvi_New.PictureIndex = 27
	ElseIf ids_Examples.Object.enhanced[li_Cnt] = 1 Then
		ltvi_New.PictureIndex = 28
	Else
		ltvi_New.PictureIndex = 26
	End If
	
	ltvi_New.SelectedPictureIndex = ltvi_New.PictureIndex
	This.InsertItemLast(handle, ltvi_New)

	If li_Cnt < li_Examples Then
		li_Cnt = ids_examples.Find("group_id = '" + ls_Category + "'", (li_Cnt + 1), li_Examples)
	Else
		li_Cnt = 0
	End If
Loop
end event

event selectionchanged;il_SelectedExample = newhandle
Post of_refresh_info()
end event

event doubleclicked;string			ls_window
treeviewitem	ltvi_current

if GetItem(handle, ltvi_current) < 0 then return

ls_window = ltvi_current.data

if Left(ls_window, 2) = "w_" then
	of_Run_Window(ls_window)
end if
end event

event rightclicked;String				ls_Window
TreeViewItem	ltvi_Current
m_main_rmb		lm_RMB

If handle > 0 Then 
	if GetItem(handle, ltvi_Current) < 0 then return
	
	this.SelectItem ( handle ) 
	ls_Window = ltvi_Current.Data
	If Left(ls_Window, 2) <> "w_" Then
		Return
	End If
	
	lm_RMB = Create m_main_rmb
	If Not of_has_help() Then
		lm_RMB.m_rmb.m_helpforexample.enabled = False
	End If
	
	lm_RMB.m_rmb.PopMenu(w_main.PointerX(), w_main.PointerY())
End If
end event

type ddplb_state from dropdownpicturelistbox within tabpage_examples
integer y = 4
integer width = 722
integer height = 384
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "All"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"All","New since 5.0","Enhanced since 5.0","New since 8.0"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {1,2,3,4}
string picturename[] = {"all.bmp","newex.bmp","enhanced.bmp","exam.bmp"}
long picturemaskcolor = 16777215
end type

event selectionchanged;String	ls_Filter

Choose Case index
	Case 1
		ls_Filter = is_Filter
	Case 2
		ls_Filter = is_Filter + " And (new = 1)"
	Case 3
		ls_Filter = is_Filter + " And (enhanced = 1)"
	Case 4
		ls_Filter = is_Filter + " And (version = '8.0')"
End Choose

int rc
rc = ids_Examples.SetFilter(ls_Filter)
rc = ids_Examples.Filter()

tv_examples.Post Event ue_reset_categories()
end event

type tabpage_search from userobject within tab_examples
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 1435
integer height = 1520
long backcolor = 73955432
string text = "Search"
long tabtextcolor = 33554432
long tabbackcolor = 73955432
tv_search tv_search
dw_search dw_search
rb_event rb_event
rb_powerscript rb_powerscript
rb_user_func rb_user_func
rb_objects rb_objects
st_1 st_1
cb_perform_search cb_perform_search
cb_reset_query cb_reset_query
gb_search gb_search
end type

on tabpage_search.create
this.tv_search=create tv_search
this.dw_search=create dw_search
this.rb_event=create rb_event
this.rb_powerscript=create rb_powerscript
this.rb_user_func=create rb_user_func
this.rb_objects=create rb_objects
this.st_1=create st_1
this.cb_perform_search=create cb_perform_search
this.cb_reset_query=create cb_reset_query
this.gb_search=create gb_search
this.Control[]={this.tv_search,&
this.dw_search,&
this.rb_event,&
this.rb_powerscript,&
this.rb_user_func,&
this.rb_objects,&
this.st_1,&
this.cb_perform_search,&
this.cb_reset_query,&
this.gb_search}
end on

on tabpage_search.destroy
destroy(this.tv_search)
destroy(this.dw_search)
destroy(this.rb_event)
destroy(this.rb_powerscript)
destroy(this.rb_user_func)
destroy(this.rb_objects)
destroy(this.st_1)
destroy(this.cb_perform_search)
destroy(this.cb_reset_query)
destroy(this.gb_search)
end on

event constructor;cb_reset_query.Post Event Clicked()
end event

type tv_search from treeview within tabpage_search
event ue_reset_categories ( )
event ue_expand_all ( )
event ue_collapse_all ( )
event rbuttonup pbm_rbuttonup
integer y = 600
integer width = 1435
integer height = 924
integer taborder = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"DataPipeline!","Query5!","DataWindow5!","DataWindow5!","DataWindow5!","DataWindow5!","DataWindow5!","PasteStatement!","MoveMode!","Function!","Function!","Function!","Graph!","Inherit!","Custom002!","Cascade!","Menu5!","Custom045!","Custom020!","Ole5!","Continue!","PasteSQL5!","PasteSQL5!","UserObject5!","Window!","Run!","Custom079!","CreateLibrary!","exam.bmp"}
long picturemaskcolor = 12632256
string statepicturename[] = {"Custom079!"}
long statepicturemaskcolor = 12632256
end type

event ue_reset_categories;String				ls_Sub, ls_Super, ls_group, ls_lastgroup
Integer				li_Categories, li_Sub, li_Cnt, li_Pict
Long					ll_Super
TreeViewItem	ltvi_Item

SetPointer(HourGlass!)

This.DeleteItem(0)

ltvi_Item.Label = "Search Results"
ltvi_Item.Data = ""
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = ltvi_Item.PictureIndex
ltvi_Item.Children = True
il_searchroot = This.InsertItemLast (0, ltvi_Item)

li_Categories = ids_SearchExamples.RowCount()
For li_Cnt = 1 To li_Categories
	
	ls_group = ids_SearchExamples.Object.group_id[li_Cnt]
	If ls_group <> ls_lastgroup Then
		ls_lastgroup = ls_group
		li_Pict = ids_categories.Find ( "group_id='" + ls_group + "'", 1, ids_categories.RowCount ( ))

		li_Sub = Pos(ls_group, " - ")
		if li_Sub > 0 Then
			ls_Sub = Mid(ls_group, (li_Sub + 3))
			If ll_Super = 0 Then
				ls_Super = Left(ls_group, (li_Sub - 1))
				If of_has_children(ids_SearchExamples, ls_Super) Then
					ltvi_Item.Label = ls_Super
					ltvi_Item.Data = ls_Super
					ltvi_Item.PictureIndex = li_Pict
					ltvi_Item.SelectedPictureIndex = ltvi_Item.PictureIndex
					ltvi_Item.Children = True
					ll_Super = This.InsertItemLast(il_searchroot, ltvi_Item)
				End If
			End If
			ltvi_Item.Label = ls_Sub
			ltvi_Item.Data = ls_group
		
		Else
			ll_Super = 0
			ltvi_Item.Label = ls_group
			ltvi_Item.Data = ls_group
		End If
		
		ltvi_Item.PictureIndex = li_Pict
		ltvi_Item.SelectedPictureIndex = ltvi_Item.PictureIndex
		If of_has_children(ids_SearchExamples, ls_group) Then
			ltvi_Item.Children = True
			If ll_super = 0 Then
				This.InsertItemLast(il_root, ltvi_Item)
			Else
				This.InsertItemLast(ll_Super, ltvi_Item)
			End If
		End If
	End If
Next
end event

event ue_expand_all;SetPointer(HourGlass!)

This.ExpandAll(il_searchroot)
end event

event ue_collapse_all;SetPointer(HourGlass!)

This.CollapseItem(il_searchroot)
end event

event doubleclicked;String				ls_Window
TreeViewItem	ltvi_Current

if GetItem(handle, ltvi_Current) < 0 then return
ls_Window = ltvi_Current.Data
If Left(ls_Window, 2) = "w_" Then
	of_run_window(ls_Window)
End If
end event

event itempopulate;String				ls_Filter
Integer				li_Cnt, li_ExPict, li_Examples
String				ls_Category
TreeViewItem	ltvi_New, ltvi_Parent

This.GetItem(handle, ltvi_Parent)

ls_Category = ltvi_Parent.Data

ls_filter = is_searchfilter + " and (group_id = '" + ls_Category + "')"
ids_SearchExamples.SetFilter(ls_filter)
ids_SearchExamples.Filter()
li_Examples = ids_SearchExamples.RowCount()
For li_Cnt = 1 to li_Examples
	
	ltvi_New.Label = ids_SearchExamples.Object.title[li_Cnt]
	ltvi_New.Data = ids_SearchExamples.Object.window[li_Cnt]
	ltvi_New.Children = False
	
	If ids_SearchExamples.Object.version[li_Cnt] = "7.0" Then
		ltvi_New.PictureIndex = 29
	ElseIf ids_SearchExamples.Object.new[li_Cnt] = 1 Then
		ltvi_New.PictureIndex = 27
	ElseIf ids_SearchExamples.Object.enhanced[li_Cnt] = 1 Then
		ltvi_New.PictureIndex = 28
	Else
		ltvi_New.PictureIndex = 26
	End If
	
	ltvi_New.SelectedPictureIndex = ltvi_New.PictureIndex
	This.InsertItemLast(handle, ltvi_New)

Next
end event

event selectionchanged;Post of_refresh_info()
end event

event rightclicked;String				ls_Window
TreeViewItem	ltvi_Current
m_main_rmb		lm_RMB

If handle > 0 Then
	if GetItem( handle, ltvi_Current) < 0 then return
	this.SelectItem ( handle ) 
	ls_Window = ltvi_Current.Data
	If Left(ls_Window, 2) <> "w_" Then
		Return
	End If
	
	lm_RMB = Create m_main_rmb
	If Not of_has_help() Then
		lm_RMB.m_rmb.m_helpforexample.enabled = False
	End If
	
	lm_RMB.m_rmb.PopMenu(w_main.PointerX(), w_main.PointerY())
End If
end event

type dw_search from datawindow within tabpage_search
integer y = 4
integer width = 960
integer height = 588
integer taborder = 120
string dataobject = "d_search_events"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;is_search_sql = This.object.datawindow.table.select
This.SetTransObject(sqlca)
end event

event itemchanged;Long		ll_RowCount

ll_RowCount = This.RowCount()
If row = ll_RowCount Then This.InsertRow(0)
end event

type rb_event from radiobutton within tabpage_search
integer x = 983
integer y = 52
integer width = 256
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
string text = "&Events"
boolean checked = true
end type

event clicked;dw_search.DataObject = 'd_search_events'
dw_search.SetTransObject(sqlca)
Post of_show_col('event')
end event

type rb_powerscript from radiobutton within tabpage_search
integer x = 983
integer y = 116
integer width = 352
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
string text = "&Powerscript"
end type

event clicked;Post of_change_object('psfunc','PowerScript Functions')
end event

type rb_user_func from radiobutton within tabpage_search
integer x = 983
integer y = 232
integer width = 407
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
string text = "&User Functions"
end type

event clicked;Post of_change_object('userfunc','User Functions')
end event

type rb_objects from radiobutton within tabpage_search
integer x = 983
integer y = 304
integer width = 256
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
string text = "&Objects"
end type

event clicked;Post of_change_object('object','Objects')
end event

type st_1 from statictext within tabpage_search
integer x = 1065
integer y = 172
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
boolean enabled = false
string text = "Functions"
boolean focusrectangle = false
end type

type cb_perform_search from commandbutton within tabpage_search
integer x = 1047
integer y = 408
integer width = 384
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Perform Search"
end type

event clicked;String	ls_OrigSQL, ls_NewSQL, ls_Resp, ls_Command, ls_Filter, ls_Win, ls_Obj
Integer	li_Pos, li_Cnt, li_Row, li_Pos2, li_Rows
string ls_where

ls_OrigSQL = dw_search.Describe('datawindow.table.select')
If ls_OrigSQL = is_search_sql Then
	MessageBox('Search','Please make at least one query selection')
	Return
End If
li_Pos = Pos(Lower(ls_OrigSQL),'where')
ls_where = Mid ( ls_OrigSQL, li_pos + 6 ) 

ls_NewSQL = "SELECT distinct object from exam_xref_info, exam_xref_list " + &
			"WHERE ( exam_xref_info.referenced_in = exam_xref_list.refer ) " + &
			"AND " + ls_where

ls_Command  = 'datawindow.table.select = "' + ls_NewSQL + '"'
ls_Resp = ids_SearchResults.Modify(ls_Command)
If Len(ls_Resp) > 0 Then
	MessageBox(ls_Resp, ls_Command)
	Return
End If
li_Cnt = ids_SearchResults.Retrieve()

If li_Cnt > 0 Then 
	ls_Filter = '('

	For li_Row = 1 To li_Cnt
		ls_Win = ids_SearchResults.object.win_name[li_Row]
		If li_Row > 1 Then ls_Filter = ls_Filter + ' or '
		ls_Filter = ls_Filter + "window = '" + ls_Win + "' "
	Next

	ls_Filter = ls_Filter + ')'

	is_searchfilter = is_Filter + " and " + ls_Filter
	ids_SearchExamples.SetFilter(is_searchfilter)
	ids_SearchExamples.Filter()

	tv_search.Post Event ue_reset_categories()
	tv_search.Post Event ue_expand_all()
End If
end event

type cb_reset_query from commandbutton within tabpage_search
integer x = 1047
integer y = 496
integer width = 384
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Reset Search"
end type

event clicked;String	ls_Label

dw_search.DataObject = dw_search.DataObject
dw_search.SetTransObject(sqlca)
of_start_querymode(True)
dw_search.SetRedraw(False)

If rb_objects.Checked Then 
	ls_Label = 'Objects'
Elseif rb_powerscript.Checked Then
	ls_Label = 'PowerScript Functions'
Elseif  rb_user_func.Checked Then
	ls_Label = 'User Functions'
End If

If Len(ls_Label) > 0 Then dw_search.object.label_t.Text = ls_Label
dw_search.SetRedraw(True)

tv_Search.DeleteItem(0)
end event

type gb_search from groupbox within tabpage_search
integer x = 969
integer y = 4
integer width = 462
integer height = 384
integer taborder = 110
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 73955432
string text = "Search On"
end type

type gb_current from groupbox within w_main
integer x = 1499
integer width = 1403
integer height = 1644
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Current Example"
end type

