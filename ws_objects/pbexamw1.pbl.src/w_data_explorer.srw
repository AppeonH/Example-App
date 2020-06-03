$PBExportHeader$w_data_explorer.srw
$PBExportComments$Data Explorer (TreeView and ListView)
forward
global type w_data_explorer from w_center
end type
type lv_1 from listview within w_data_explorer
end type
type tv_1 from treeview within w_data_explorer
end type
type st_vertical from statictext within w_data_explorer
end type
end forward

global type w_data_explorer from w_center
int X=0
int Y=4
int Width=2953
int Height=1856
boolean TitleBar=true
string Title="Data Explorer"
string MenuName="m_data_explorer"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_populate ( )
event ue_chglistview ( listviewview alvv_newview )
event ue_edititem ( )
event ue_arrangeicons ( )
event ue_openitem ( )
event ue_refresh ( )
lv_1 lv_1
tv_1 tv_1
st_vertical st_vertical
end type
global w_data_explorer w_data_explorer

type variables
DataStore		ids_Data[4]
Integer		ii_Columns, ii_OpenPos

// The following are used for the resizing service
boolean		ib_debug=False	//Debug mode
long		il_hiddencolor=0	//Bar hidden color to match the window background
integer		ii_barthickness=11	//Bar Thickness
integer		ii_windowborder=25	//Window border to be used on all sides
dragobject	idrg_Vertical[2]	//Reference to the vertical controls on the window

end variables

forward prototypes
public function integer wf_refreshbars ()
public function integer wf_resizebars ()
public function integer wf_resizepanels ()
public subroutine of_set_tv_item (integer ai_level, integer ai_row, ref treeviewitem atvi_new)
public function integer of_retrieve_data (Long al_Handle)
public function integer of_add_tv_items (long al_parent, integer ai_level, integer ai_rows)
public function integer of_add_lv_items (integer ai_level, integer ai_rows)
public subroutine of_set_lv_item (integer ai_level, integer ai_row, ref listviewitem alvi_new)
public subroutine of_getcurrentstyle (ref listviewview alvv_Current)
end prototypes

event ue_populate;Long				ll_Root
TreeViewItem	ltvi_Root

// Add the root item
ltvi_Root.Label = "Sales Reps"
ltvi_Root.PictureIndex = 1
ltvi_Root.SelectedPictureIndex = 1
ltvi_Root.Children = True
ll_Root = tv_1.InsertItemLast(0, ltvi_Root)

tv_1.ExpandItem(ll_Root)
tv_1.SelectItem(ll_Root)

end event

event ue_chglistview;lv_1.View = alvv_NewView

end event

event ue_edititem;Integer			li_Index, li_Level
Long				ll_Parent
String			ls_Data
n_cst_parms	lnv_Parm
TreeViewItem	ltvi_Parent
ListViewItem	llvi_Current
GraphicObject	lgo_Current

// Get the currently selected TreeView item, it is this item's parent.
ll_Parent = tv_1.FindItem(CurrentTreeItem!, 0)
If tv_1.GetItem(ll_Parent, ltvi_Parent) = -1 Then Return

lgo_Current = GetFocus()

If lgo_Current.TypeOf() = treeview! Then
	ls_Data = String(ltvi_Parent.Data)
	ll_Parent = tv_1.FindItem(ParentTreeItem!, ll_Parent)
	If tv_1.GetItem(ll_Parent, ltvi_Parent) = -1 Then Return
Else
	li_Index = lv_1.SelectedIndex()
	If li_Index <= 0 Then Return
	If lv_1.GetItem(li_Index, llvi_Current) = -1 Then Return
	ls_Data = String(llvi_Current.Data)
End If

li_Level = ltvi_Parent.Level
lnv_Parm.ii_Parm1 = Integer(ltvi_Parent.Data)

If li_Level = 3 Then
	// The third level requires retrieval arguments from the 
	// two previous levels.
	ll_Parent = tv_1.FindItem(ParentTreeItem!, ll_Parent)
	If tv_1.GetItem(ll_Parent, ltvi_Parent) = -1 Then Return
	lnv_Parm.ii_Parm2 = Integer(ltvi_Parent.Data)
End If

// Filter the DW to show only the proper row
Choose Case li_Level
	Case 1
		lnv_Parm.is_Filter = "employee_emp_id = " + ls_Data
	Case 2
		lnv_Parm.is_Filter = "customer_id = " + ls_Data
	Case 3
		lnv_Parm.is_Filter = "id = " + ls_Data
	Case 4
		lnv_Parm.is_Filter = "line_id = " + ls_Data
End Choose

lnv_Parm.iw_Parent = This
lnv_Parm.is_DataObject = ids_Data[li_Level].DataObject
lnv_Parm.ii_OpenPos = ii_OpenPos
ii_OpenPos = ii_OpenPos + 80
If ii_OpenPos > 1020 Then ii_OpenPos = 0

OpenWithParm(w_data_edit, lnv_Parm)

end event

event ue_arrangeicons;lv_1.Arrange()

end event

event ue_openitem;Integer				li_Index
Long					ll_Current
TreeViewItem		ltvi_Current
GraphicObject	lgo_Current

lgo_Current = GetFocus()

If lgo_Current.TypeOf() = treeview! Then
	// Expand or collapse the current item
	ll_Current = tv_1.FindItem(CurrentTreeItem!, 0)
	If ll_Current < 1 Then Return
	
	tv_1.GetItem(ll_Current, ltvi_Current)
	If ltvi_Current.Expanded Then
		tv_1.CollapseItem(ll_Current)
	Else
		tv_1.ExpandItem(ll_Current)
	End if
	
Else
	li_Index = lv_1.SelectedIndex()
	If li_Index < 1 Then Return
	
	lv_1.Post Event doubleclicked(li_Index)
End If

end event

event ue_refresh;// Refresh the ListView (after the data has been updated)

Long				ll_Current

// Get the currently selected TreeView item.
ll_Current = tv_1.FindItem(CurrentTreeItem!, 0)

// Trigger the SelectionChanged event, this will cause the ListView
// to be refreshed.
tv_1.Trigger Event SelectionChanged(ll_Current, ll_Current)

end event

public function integer wf_refreshbars ();Integer	li_Cnt

//Force appropriate order
st_vertical.SetPosition(ToTop!)

//Make sure the Width is not lost
st_vertical.Width = ii_BarThickness

Return 1

end function

public function integer wf_resizebars ();//Resize Bars according to Bars themselves, WindowBorder, and BarThickness.

Integer	li_HX, li_HW, li_Cnt

st_vertical.Move(st_vertical.X, ii_WindowBorder)
st_vertical.Resize(ii_barthickness, 5 + This.WorkSpaceHeight() - (2 * ii_WindowBorder))

wf_RefreshBars()

Return 1
end function

public function integer wf_resizepanels ();//Resize the panels according to the Lines, 
//BarThickness, and WindowBorder.

Integer	li_Cnt, li_X, li_Y, li_HHeight, li_HWidth
Long		ll_Width, ll_Height

ll_Width = this.WorkSpaceWidth()
ll_Height = this.WorkspaceHeight()

If ll_Width < idrg_Vertical[2].X + 150 Then
	ll_Width = idrg_Vertical[2].X + 150
End If

If ll_Height < idrg_Vertical[1].Y + 150 Then
	ll_Height = Idrg_Vertical[1].Y + 150
End If

// Left vertical object processing
idrg_Vertical[1].Move (ii_WindowBorder, ii_WindowBorder)
idrg_Vertical[1].Resize (st_vertical.X - idrg_Vertical[1].X, ll_Height - idrg_Vertical[1].Y - ii_WindowBorder)

// Right vertical object processing
idrg_Vertical[2].Move (st_vertical.X + ii_BarThickness, ii_WindowBorder)
idrg_Vertical[2].Resize (ll_Width - idrg_Vertical[2].X - ii_WindowBorder, ll_Height - idrg_Vertical[2].Y - ii_WindowBorder)

Return 1

end function

public subroutine of_set_tv_item (integer ai_level, integer ai_row, ref treeviewitem atvi_new);// Set the Lable and Data attributes for the new item from the data in the DataStore

Integer	li_Picture

Choose Case ai_Level
	Case 2
		atvi_New.Label = ids_Data[1].Object.employee_emp_lname[ai_Row] + ", " + &
									ids_Data[1].Object.employee_emp_fname[ai_Row]
		atvi_New.Data = ids_Data[1].Object.employee_emp_id[ai_Row]
	Case 3
		atvi_New.Label = ids_Data[2].Object.customer_company_name[ai_Row]
		atvi_New.Data = ids_Data[2].Object.customer_id[ai_Row]
	Case 4
		atvi_New.Label = String(ids_Data[3].Object.id[ai_Row])
		atvi_New.Data = ids_Data[3].Object.id[ai_Row]
End Choose


atvi_New.PictureIndex = ai_Level
atvi_New.SelectedPictureIndex = 5

If ai_Level < 4 Then
	atvi_New.Children = True
Else
	atvi_New.Children = False
End If

end subroutine

public function integer of_retrieve_data (Long al_Handle);// Function to retrieve an item's children into the
// appropriate DataStore.

Integer				li_Level, li_Parm, li_RepID
Long					ll_Parent
TreeViewItem		ltvi_Current, ltvi_Parent

// Determine the level
tv_1.GetItem(al_Handle, ltvi_Current)
li_Level = ltvi_Current.Level

// Determine the Retrieval arguments for the new data
li_Parm = Integer(ltvi_Current.Data)

If li_Level = 3 Then
	// This levels need a second parameter (the sales rep id),
	// get it from this item's parent
	ll_Parent = tv_1.FindItem(ParentTreeItem!, al_Handle)
	tv_1.GetItem(ll_Parent, ltvi_Parent)
	li_RepID = Integer(ltvi_Parent.Data)
End If

// Retrieve the data
ids_Data[li_Level].Reset()
Return ids_Data[li_Level].Retrieve(li_Parm, li_RepID)

end function

public function integer of_add_tv_items (long al_parent, integer ai_level, integer ai_rows);// Function to add the items to the TreeView using the data in the DataStore

Integer				li_Cnt
TreeViewItem		ltvi_New

// Add each item to the TreeView
For li_Cnt = 1 To ai_Rows
	// Call a function to set the values of the TreeView item from 
	// the DataStore data
	of_set_tv_item(ai_Level, li_Cnt, ltvi_New)
	
	// Add the item after the last child
	If tv_1.InsertItemLast(al_Parent, ltvi_New) < 1 Then
		// Error
		MessageBox("Error", "Error inserting item", Exclamation!)
		Return -1
	End If
Next

Return ai_Rows

end function

public function integer of_add_lv_items (integer ai_level, integer ai_rows);// Function to add the items to the ListView using the data in the DataStore

Integer				li_Cnt
ListViewItem		llvi_New

// Delete all existing columns from the ListView
For li_Cnt = 1 To ii_Columns
	lv_1.DeleteColumn(1)
Next

// Add the columns to the ListView
Choose Case ai_Level
	Case 2
		lv_1.AddColumn("Name", Left!, 500)
		lv_1.AddColumn("ID", Left!, 150)
		lv_1.AddColumn("Dept", Left!, 160)
		lv_1.AddColumn("Manager", Left!, 250)
		lv_1.AddColumn("Status", Center!, 195)
		lv_1.AddColumn("Phone #", Left!, 350)
		lv_1.AddColumn("Salary", Right!, 280)
		ii_Columns = 7
	Case 3
		lv_1.AddColumn("Company Name", Left!, 700)
		lv_1.AddColumn("ID", Left!, 150)
		lv_1.AddColumn("Contact Name", Left!, 500)
		lv_1.AddColumn("Address", Left!, 1150)
		lv_1.AddColumn("Phone #", Left!, 350)
		ii_Columns = 5
	Case 4
		lv_1.AddColumn("Order ID", Left!, 250)
		lv_1.AddColumn("Date", Left!, 250)
		lv_1.AddColumn("Financial Code", Center!, 375)
		lv_1.AddColumn("Region", Left!, 250)
		ii_Columns = 4
	Case 5
		lv_1.AddColumn("Product Description", Left!, 500)
		lv_1.AddColumn("Line #", Right!, 195)
		lv_1.AddColumn("ID", Left!, 150)
		lv_1.AddColumn("Ship Date", Left!, 275)
		lv_1.AddColumn("Qty", Right!, 150)
		lv_1.AddColumn("Unit Price", Right!, 270)
		lv_1.AddColumn("Total", Right!, 250)
		ii_Columns = 7
End Choose

// Add each item to the ListView
For li_Cnt = 1 To ai_Rows
	// Call a function to set the values of the ListView item from 
	// the DataStore data
	of_set_lv_item(ai_Level, li_Cnt, llvi_New)
	
	// Add the item after the last child
	If lv_1.AddItem(llvi_New) < 1 Then
		// Error
		MessageBox("Error", "Error adding item to the ListView", Exclamation!)
		Return -1
	End If
Next

Return ai_Rows

end function

public subroutine of_set_lv_item (integer ai_level, integer ai_row, ref listviewitem alvi_new);// Set the Lable and Data attributes for the new item from the data in the DataStore

Integer	li_Picture
String	ls_Phone
Double	ldb_Number

Choose Case ai_Level
	Case 2
		alvi_New.Label = ids_Data[1].Object.employee_emp_lname[ai_Row] + ", " + &
									ids_Data[1].Object.employee_emp_fname[ai_Row] + "~t" + &
									String(ids_Data[1].Object.employee_emp_id[ai_Row]) + "~t" + &
									String(ids_Data[1].Object.employee_dept_id[ai_Row]) + "~t" + &
									String(ids_Data[1].Object.employee_manager_id[ai_Row]) + "~t" + &
									ids_Data[1].Object.employee_status[ai_Row] + "~t"
		ls_Phone = ids_Data[1].Object.employee_phone[ai_Row]
		alvi_New.Label = alvi_New.Label + "(" + Left(ls_Phone, 3) + ")" + Mid(ls_Phone, 4, 3) + &
									"-" + Right(ls_Phone, 4) + "~t"
		ldb_Number = ids_Data[1].Object.employee_salary[ai_Row]
		alvi_New.Label = alvi_New.Label + String(ldb_Number, "$#0,000.00")
		
		alvi_New.Data = ids_Data[1].Object.employee_emp_id[ai_Row]
		
	Case 3
		alvi_New.Label = ids_Data[2].Object.customer_company_name[ai_Row] + "~t" + &
									String(ids_Data[2].Object.customer_id[ai_Row]) + "~t" + &
									ids_Data[2].Object.customer_lname[ai_Row] + ", " + &
									ids_Data[2].Object.customer_fname[ai_Row] + "~t" + &
									ids_Data[2].Object.customer_address[ai_Row] + ", " + &
									ids_Data[2].Object.customer_city[ai_Row] + ", " + &
									ids_Data[2].Object.customer_state[ai_Row] + "  " + &
									ids_Data[2].Object.customer_zip[ai_Row] + "~t"
		ls_Phone = ids_Data[2].Object.customer_phone[ai_Row]
		alvi_New.Label = alvi_New.Label + "(" + Left(ls_Phone, 3) + ")" + Mid(ls_Phone, 4, 3) + &
									"-" + Right(ls_Phone, 4)
									
		alvi_New.Data = ids_Data[2].Object.customer_id[ai_Row]
		
	Case 4
		alvi_New.Label = String(ids_Data[3].Object.id[ai_Row]) + "~t" + &
									String(ids_Data[3].Object.order_date[ai_Row]) + "~t" + &
									ids_Data[3].Object.fin_code_id[ai_Row] + "~t" + &
									ids_Data[3].Object.region[ai_Row]
									
		alvi_New.data = ids_Data[3].Object.id[ai_Row]
		
	Case 5
		alvi_New.Label = ids_Data[4].Object.product_description[ai_Row] + "~t" + &
									String(ids_Data[4].Object.line_id[ai_Row]) + "~t" + &
									String(ids_Data[4].Object.prod_id[ai_Row]) + "~t" + &
									String(ids_Data[4].Object.ship_date[ai_Row]) + "~t" + &
									String(ids_Data[4].Object.quantity[ai_Row]) + "~t"
		ldb_Number = ids_Data[4].Object.product_unit_price[ai_Row]
		alvi_New.Label = alvi_New.Label + String(ldb_Number, "$#0.00") + "~t"
		ldb_Number = ids_Data[4].Object.total_cost[ai_Row]
		alvi_New.Label = alvi_New.Label + String(ldb_Number, "$#,##0.00")

		alvi_New.Data = ids_Data[4].Object.line_id[ai_Row]
End Choose


If ai_Level < 5 Then
	alvi_New.PictureIndex = ai_Level
Else
	// Set the picture to be the product picture
	li_Picture = lv_1.AddLargePicture(ids_Data[4].Object.product_picture_name[ai_Row])
	lv_1.AddSmallPicture(ids_Data[4].Object.product_picture_name[ai_Row])
	alvi_New.PictureIndex = li_Picture
End If

end subroutine

public subroutine of_getcurrentstyle (ref listviewview alvv_Current);// Return the style of the ListView
alvv_Current = lv_1.View

end subroutine

on w_data_explorer.create
if this.MenuName = "m_data_explorer" then this.MenuID = create m_data_explorer
this.lv_1=create lv_1
this.tv_1=create tv_1
this.st_vertical=create st_vertical
this.Control[]={this.lv_1,&
this.tv_1,&
this.st_vertical}
end on

on w_data_explorer.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lv_1)
destroy(this.tv_1)
destroy(this.st_vertical)
end on

event open;call super::open;Integer	li_Cnt

SetPointer(HourGlass!)

// Create DataStores used by this example
ids_Data[1] = Create DataStore
ids_Data[1].DataObject = "d_sales_reps"

ids_Data[2] = Create DataStore
ids_Data[2].DataObject = "d_sales_rep_customers"

ids_Data[3] = Create DataStore
ids_Data[3].DataObject = "d_sales_rep_customer_orders"

ids_Data[4] = Create DataStore
ids_Data[4].DataObject = "d_salesorder_items"

For li_Cnt = 1 To 4
	ids_Data[li_Cnt].SetTransObject(sqlca)
Next

// Populate first level
Post Event ue_populate()

// The following lines are for setting up the resizing service
idrg_Vertical[1] = tv_1
idrg_Vertical[2] = lv_1

// Set the color of the bars to make them invisible
il_HiddenColor = This.BackColor
st_Vertical.BackColor = il_HiddenColor

//Resize Bars
wf_ResizeBars()

//Resize the panels
wf_ResizePanels()

end event

event resize;// Do not run the first time the window is opened.
If IsValid(idrg_Vertical[1]) Then
	//Resize Bars
	wf_ResizeBars()

	//Resize the panels
	wf_ResizePanels()
End If

end event

event close;Integer	li_Cnt

// Destroy DataStores used by this example
For li_Cnt = 1 To 4
	Destroy ids_Data[li_Cnt]
Next

If IsValid(w_data_edit) Then Close(w_data_edit)

Show(w_main)

end event

type lv_1 from listview within w_data_explorer
int X=1015
int Y=20
int Width=1824
int Height=1620
int TabOrder=20
boolean DragAuto=true
BorderStyle BorderStyle=StyleLowered!
ListViewView View=ListViewReport!
string LargePictureName[]={"Globals!",&
"emp.ico",&
"Library!",&
"DosEdit!"}
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=12632256
string SmallPictureName[]={"Globals!",&
"emp.ico",&
"Library!",&
"DosEdit!"}
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=12632256
long StatePictureMaskColor=553648127
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event rightclicked;Long					ll_Parent
m_lv_rmb			lm_PopMenu
TreeViewItem		ltvi_Parent

lm_PopMenu = CREATE m_lv_rmb

// If an item was not clicked, disable the "Open Item" and
// "Edit Item" menu options.
If index <= 0 Then
	lm_PopMenu.m_action.m_openitem.Enabled = False
	lm_PopMenu.m_action.m_edititem.Enabled = False
Else
	// If this is displaying sales order items (level 4) then disable
	// the "Open Item" menu option.
	ll_Parent = tv_1.FindItem(CurrentTreeItem!, 0)
	tv_1.GetItem(ll_Parent, ltvi_Parent)
	If ltvi_Parent.Level = 4 Then
		lm_PopMenu.m_action.m_openitem.Enabled = False
	End If
End If

// Only enable the "Line Up Icons" menu option if in one of the icon views
If This.View = ListViewList! Or This.View = ListViewReport! Then
	lm_PopMenu.m_action.m_lineupicons.Enabled = False
End If

lm_PopMenu.m_action.PopMenu( Parent.PointerX(), Parent.PointerY())

end event

event doubleclicked;Long					ll_Parent, ll_Item
Boolean				lb_Found
TreeViewItem		ltvi_Item
ListViewItem		llvi_Current

If index <= 0 Then Return

// Get the item that was double-clicked
If GetItem(index, llvi_Current) = -1 Then Return

// Get the currently selected TreeView item.  It is
// the parent of this item.
ll_Parent = tv_1.FindItem(CurrentTreeItem!, 0)
tv_1.GetItem(ll_Parent, ltvi_Item)

If ltvi_Item.Level = 4 Then
	// This is the bottom level, so edit this item instead
	Parent.Post Event ue_edititem()

Else
	// If the parent is not already expanded, expand it
	tv_1.ExpandItem(ll_Parent)
	
	// Find this ListView item in the Tree
	lb_Found = False
	ll_Item = tv_1.FindItem(ChildTreeItem!, ll_Parent)
	Do Until (lb_Found Or ll_Item < 1)
		tv_1.GetItem(ll_Item, ltvi_Item)
		If Pos(ltvi_Item.Label, llvi_Current.Label) > 0 Then
			// Found the item
			lb_Found = True
		Else
			// Check the next item
			ll_Item = tv_1.FindItem(NextTreeItem!, ll_Item)
		End If
	Loop
	
	If lb_Found Then
		tv_1.SelectItem(ll_Item)
	End If
End If

end event

type tv_1 from treeview within w_data_explorer
int Y=20
int Width=969
int Height=1620
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LinesAtRoot=true
string PictureName[]={"Globals!",&
"emp.ico",&
"Library!",&
"DosEdit!",&
"Custom050!"}
long PictureMaskColor=12632256
long StatePictureMaskColor=12632256
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event itempopulate;// Populate the tree with this item's children

Integer				li_Rows, li_Level
TreeViewItem		ltvi_Current

SetPointer(HourGlass!)

// Determine the level
GetItem(handle, ltvi_Current)
li_Level = ltvi_Current.Level

// Retrieve the data
li_Rows = of_retrieve_data(handle)

of_add_tv_items(handle, li_Level + 1, li_Rows)

end event

event selectionchanged;// Populate the ListView with this item's children

Integer				li_Rows, li_Level
TreeViewItem		ltvi_Current

SetPointer(HourGlass!)

// Determine the level
GetItem(newhandle, ltvi_Current)
li_Level = ltvi_Current.Level

// Retrieve the data
li_Rows = of_retrieve_data(newhandle)

lv_1.DeleteItems()
of_add_lv_items(li_Level + 1, li_Rows)

end event

type st_vertical from statictext within w_data_explorer
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
int X=978
int Y=20
int Width=32
int Height=532
string DragIcon="Exclamation!"
boolean FocusRectangle=false
long TextColor=255
long BackColor=0
long BorderColor=273962025
string Pointer="SizeWE!"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	This.x = Parent.PointerX()
End If




end event

event mouseup;//Hide the bar
If Not ib_debug Then This.BackColor = il_hiddencolor

//Resize the panels
wf_ResizePanels()

end event

event mousedown;If Not ib_debug Then this.BackColor = 0  //show Bar in Black

end event

