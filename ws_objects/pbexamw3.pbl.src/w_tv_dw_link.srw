$PBExportHeader$w_tv_dw_link.srw
$PBExportComments$Window showing linking a TreeView and DataWindows
forward
global type w_tv_dw_link from w_center
end type
type st_horizontal3 from statictext within w_tv_dw_link
end type
type st_horizontal2 from statictext within w_tv_dw_link
end type
type st_horizontal1 from statictext within w_tv_dw_link
end type
type dw_4 from datawindow within w_tv_dw_link
end type
type dw_3 from datawindow within w_tv_dw_link
end type
type dw_2 from datawindow within w_tv_dw_link
end type
type tv_1 from treeview within w_tv_dw_link
end type
type dw_1 from datawindow within w_tv_dw_link
end type
type st_vertical from statictext within w_tv_dw_link
end type
end forward

global type w_tv_dw_link from w_center
int X=0
int Y=4
int Width=2930
int Height=1836
boolean TitleBar=true
string Title="TreeView / DataWindow Linking"
string MenuName="m_tv_dw_link"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_populate ( )
event ue_save ( )
event ue_delete ( )
st_horizontal3 st_horizontal3
st_horizontal2 st_horizontal2
st_horizontal1 st_horizontal1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
tv_1 tv_1
dw_1 dw_1
st_vertical st_vertical
end type
global w_tv_dw_link w_tv_dw_link

type variables
DataStore		ids_Data[4]
DataWindow	idw_Data[4]
Boolean		ib_Changed[4], ib_Retrieve
Long		il_ChangedItem[], il_CurrentItem[4]

// The following are used for the resizing service
boolean		ib_debug=False	//Debug mode
long		il_hiddencolor=0	//Bar hidden color to match the window background
long		il_OldHeight	//Save the height of the window
integer		ii_barthickness=11	//Bar Thickness
integer		ii_windowborder=15	//Window border to be used on all sides
dragobject	idrg_Vertical	//Reference to the vertical control on the left of the window
dragobject	idrg_Horizontal[4]	//Reference to the horizontal controls on the right of the window
statictext		ist_Horizontal[3]	//Reference to the horizontal bars
end variables

forward prototypes
public function integer wf_refreshbars ()
public function integer wf_resizebars ()
public subroutine of_set_item (integer ai_level, integer ai_row, ref treeviewitem atvi_new)
public function integer of_add_items (long al_parent, integer ai_Level, integer ai_Rows)
public function boolean of_display_item (long al_handle, ref integer ai_parm)
public function integer wf_resizepanels ()
public function integer of_savequery ()
public function boolean of_checkparent (long al_Item, long al_Parent)
end prototypes

event ue_populate;Integer	li_Rows

SetPointer(HourGlass!)
This.SetRedraw(False)

// Retrieve data for first level into DataStore and DataWindow.
idw_Data[1].Reset()
idw_Data[1].Retrieve()

ids_Data[1].Reset()
li_Rows = ids_Data[1].Retrieve()

// Filter out the DataWindow rows until an item is selected.
idw_Data[1].SetFilter("1 = 2")
idw_Data[1].Filter()

This.SetRedraw(True)

// Add the items to the TreeView
of_add_items(0, 1, li_Rows)

end event

event ue_save;Integer	li_Cnt

For li_Cnt = 1 To 4
	If ib_Changed[li_Cnt] Then idw_Data[li_Cnt].Update()
Next

tv_1.Post Event ue_clearupdateditems()

end event

public function integer wf_refreshbars ();Integer	li_Cnt

//Force appropriate order
st_vertical.SetPosition(ToTop!)

//Make sure the Width is not lost
st_vertical.Width = ii_BarThickness

For li_Cnt = 1 To 3
	ist_Horizontal[li_Cnt].SetPosition(ToTop!)
	ist_Horizontal[li_Cnt].Height = ii_BarThickness
Next

Return 1

end function

public function integer wf_resizebars ();//Resize Bars according to Bars themselves, WindowBorder, and BarThickness.

Integer	li_HX, li_HW, li_Cnt

st_vertical.Move(st_vertical.X, ii_WindowBorder)
st_vertical.Resize(ii_barthickness, 5 + This.WorkSpaceHeight() - (2 * ii_WindowBorder))

li_HX = st_vertical.X + ii_BarThickness
li_HW = This.WorkSpaceWidth() - li_HX - ii_WindowBorder
For li_Cnt = 1 To 3
	ist_Horizontal[li_Cnt].Move(li_HX, ist_Horizontal[li_Cnt].Y)
	ist_Horizontal[li_Cnt].Resize(li_HW, ii_BarThickness)
Next

wf_RefreshBars()

Return 1
end function

public subroutine of_set_item (integer ai_level, integer ai_row, ref treeviewitem atvi_new);// Set the Lable and Data attributes for the new item from the data in the DataStore

Integer	li_Picture

Choose Case ai_Level
	Case 1
		atvi_New.Label = ids_Data[1].Object.employee_emp_lname[ai_Row] + ", " + &
									ids_Data[1].Object.employee_emp_fname[ai_Row]
		atvi_New.Data = ids_Data[1].Object.employee_emp_id[ai_Row]
	Case 2
		atvi_New.Label = ids_Data[2].Object.customer_company_name[ai_Row]
		atvi_New.Data = ids_Data[2].Object.customer_id[ai_Row]
	Case 3
		atvi_New.Label = String(ids_Data[3].Object.id[ai_Row])
		atvi_New.Data = ids_Data[3].Object.id[ai_Row]
	Case 4
		atvi_New.Label = String(ids_Data[4].Object.line_id[ai_Row])
		atvi_New.Data = ids_Data[4].Object.line_id[ai_Row]
End Choose


If ai_Level < 4 Then
	atvi_New.Children = True
	atvi_New.PictureIndex = ai_Level
	atvi_New.SelectedPictureIndex = 4
Else
	atvi_New.Children = False
	
	// Set the picture to be the product picture
	li_Picture = tv_1.AddPicture(ids_Data[4].Object.product_picture_name[ai_Row])
	atvi_New.PictureIndex = li_Picture
	atvi_New.SelectedPictureIndex = 4
End If

end subroutine

public function integer of_add_items (long al_parent, integer ai_Level, integer ai_Rows);// Function to add the items to the TreeView using the data in the DataStore

Integer				li_Cnt
TreeViewItem		ltvi_New

// Add each item to the TreeView
For li_Cnt = 1 To ai_Rows
	// Call a function to set the values of the TreeView item from 
	// the DataStore data
	of_set_item(ai_Level, li_Cnt, ltvi_New)
	
	// Add the item after the last child
	If tv_1.InsertItemLast(al_Parent, ltvi_New) < 1 Then
		// Error
		MessageBox("Error", "Error inserting item", Exclamation!)
		Return -1
	End If
Next

Return ai_Rows

end function

public function boolean of_display_item (long al_handle, ref integer ai_parm);// Function to display the data for the record selected in the 
// appropriate DataWindow.

Integer				li_ParentParm, li_SalesRep
Long					ll_Parent
String				ls_Filter
TreeViewItem		ltvi_Current, ltvi_Parent

tv_1.GetItem(al_Handle, ltvi_Current)

If ib_Retrieve Then
	If al_Handle = il_CurrentItem[ltvi_Current.Level] Then
		// This item is already displayed, True return code indicates
		// that the item was already set.
		ai_Parm = ltvi_Current.Data
		Return True
	End If

	If ltvi_Current.Level > 1 Then
		// Get the retrieval argument from the Parent item
		ll_Parent = tv_1.FindItem(ParentTreeItem!, al_Handle)
		of_display_item(ll_Parent, li_ParentParm)
		
		If ltvi_Current.Level = 3 Then
			// The third level requires retrieval arguments from the 
			// two previous levels.
			ll_Parent = tv_1.FindItem(ParentTreeItem!, ll_Parent)
			tv_1.GetItem(ll_Parent, ltvi_Parent)
			li_SalesRep = Integer(ltvi_Parent.Data)
		End If

		// Retrieve the data
		idw_Data[ltvi_Current.Level].Reset()
		idw_Data[ltvi_Current.Level].Retrieve(li_ParentParm, li_SalesRep)
	End If
End If

// Filter the DW to show only this row
Choose Case ltvi_Current.Level
	Case 1
		ls_Filter = "employee_emp_id = " + String(ltvi_Current.Data)
	Case 2
		ls_Filter = "customer_id = " + String(ltvi_Current.Data)
	Case 3
		ls_Filter = "id = " + String(ltvi_Current.Data)
	Case 4
		ls_Filter = "line_id = " + String(ltvi_Current.Data)
End Choose

idw_Data[ltvi_Current.Level].SetFilter(ls_Filter)
idw_Data[ltvi_Current.Level].Filter()

// Set this item as the current item for this level
il_CurrentItem[ltvi_Current.Level] = al_Handle

// Return this item's data attribute (for recurrsion).
ai_Parm = ltvi_Current.Data
Return False

end function

public function integer wf_resizepanels ();//Resize the panels according to the Lines, 
//BarThickness, and WindowBorder.

Integer	li_Cnt, li_X, li_Y, li_HHeight, li_HWidth
Long		ll_Width, ll_Height

ll_Width = this.WorkSpaceWidth()
ll_Height = this.WorkspaceHeight()

If ll_Width < idrg_Vertical.X + 150 Then
	ll_Width = idrg_Vertical.X + 150
End If

If ll_Height < idrg_Vertical.Y + 150 Then
	ll_Height = Idrg_Vertical.Y + 150
End If

// Left vertical object processing
idrg_Vertical.Move (ii_WindowBorder, ii_WindowBorder)
idrg_Vertical.Resize (st_vertical.X - idrg_Vertical.X, ll_Height - idrg_Vertical.Y - ii_WindowBorder)

// Horizontal object processing
For li_Cnt = 1 To 4
	li_X = st_vertical.X + ii_BarThickness
	If li_Cnt = 1 Then
		li_Y = ii_WindowBorder
	Else
		li_Y = ist_Horizontal[li_Cnt - 1].Y + ii_BarThickness
	End If
	
	idrg_Horizontal[li_Cnt].Move (li_X, li_Y)
	
	li_HWidth = ist_Horizontal[1].Width
	If li_Cnt = 1 Then
		li_HHeight = ist_Horizontal[1].Y - ii_WindowBorder
	ElseIf li_Cnt = 4 Then
		li_HHeight = ll_Height - (ist_Horizontal[3].Y + ii_BarThickness) - ii_WindowBorder
	Else		
		li_HHeight = ist_Horizontal[li_Cnt].Y - (ist_Horizontal[li_Cnt - 1].Y + ii_BarThickness)
	End If

	idrg_Horizontal[li_Cnt].Resize (li_HWidth, li_HHeight)
Next

Return 1

end function

public function integer of_savequery ();Integer	li_Ret

li_Ret = MessageBox("Warning", "If you select another item in the TreeView, you changes " + &
								"will be lost.  Do you wish to save now?", Question!, YesNoCancel!)

If li_Ret = 3 Then
	Return 1
Else
	If li_Ret = 1 Then
		Trigger Event ue_save()
	Else
		tv_1.Trigger Event ue_clearupdateditems()
	End If
	
	Return 0
End If

end function

public function boolean of_checkparent (long al_Item, long al_Parent);//	Determine whether one item is a parent of another

Do
	al_Item = tv_1.FindItem(ParentTreeItem!, al_Item)
	If al_Item = al_Parent Then Return True
Loop Until al_Item <= 0

Return False

end function

on w_tv_dw_link.create
if this.MenuName = "m_tv_dw_link" then this.MenuID = create m_tv_dw_link
this.st_horizontal3=create st_horizontal3
this.st_horizontal2=create st_horizontal2
this.st_horizontal1=create st_horizontal1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.tv_1=create tv_1
this.dw_1=create dw_1
this.st_vertical=create st_vertical
this.Control[]={this.st_horizontal3,&
this.st_horizontal2,&
this.st_horizontal1,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.tv_1,&
this.dw_1,&
this.st_vertical}
end on

on w_tv_dw_link.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_horizontal3)
destroy(this.st_horizontal2)
destroy(this.st_horizontal1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.tv_1)
destroy(this.dw_1)
destroy(this.st_vertical)
end on

event open;call super::open;Integer	li_Cnt

SetPointer(HourGlass!)

// Set DataWindow objects in array
idw_Data[1] = dw_1
idw_Data[2] = dw_2
idw_Data[3] = dw_3
idw_Data[4] = dw_4

// Create DataStores used by this example
For li_Cnt = 1 To 4
	ids_Data[li_Cnt] = Create DataStore
	ids_Data[li_Cnt].DataObject = idw_Data[li_Cnt].DataObject
	ids_Data[li_Cnt].SetTransObject(sqlca)
	idw_Data[li_Cnt].SetTransObject(sqlca)
Next

// Populate first level
Post Event ue_populate()

// The following lines are for setting up the resizing service
il_OldHeight = This.WorkspaceHeight()

idrg_Vertical = tv_1

For li_Cnt = 1 To 4
	idrg_Horizontal[li_Cnt] = idw_Data[li_Cnt]
Next

ist_Horizontal[1] = st_horizontal1
ist_Horizontal[2] = st_horizontal2
ist_Horizontal[3] = st_horizontal3

// Set the color of the bars to make them invisible
il_HiddenColor = This.BackColor
st_Vertical.BackColor = il_HiddenColor
For li_Cnt = 1 To 3
	ist_Horizontal[li_Cnt].BackColor = il_HiddenColor
Next

//Resize Bars
wf_ResizeBars()

//Resize the panels
wf_ResizePanels()

end event

event resize;Integer		li_Delta, li_Cnt

// Do not run the first time the window is opened.
If IsValid(idrg_Vertical) Then
	// Move the horizontal bars porportionally
	li_Delta = newheight - il_OldHeight
	il_OldHeight = newheight
	
	For li_Cnt = 1 To 3
		ist_Horizontal[li_Cnt].Y = ist_Horizontal[li_Cnt].Y + (li_Cnt * (li_Delta / 4))
	Next
	
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

Show(w_main)

end event

type st_horizontal3 from statictext within w_tv_dw_link
event mousedown pbm_lbuttondown
event mouseup pbm_lbuttonup
event mousemove pbm_mousemove
int X=1088
int Y=1360
int Width=741
int Height=28
boolean FocusRectangle=false
long TextColor=255
long BackColor=0
long BorderColor=8388608
string Pointer="SizeNS!"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousedown;If Not ib_Debug Then This.BackColor = 0  //show Bar in Black

end event

event mouseup;//Hide the bar
If Not ib_Debug Then This.BackColor = il_HiddenColor

//Resize Bars
wf_ResizeBars()

//Resize the panels
wf_ResizePanels()

end event

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	This.Y = Parent.PointerY()
End If

end event

type st_horizontal2 from statictext within w_tv_dw_link
event mousedown pbm_lbuttondown
event mouseup pbm_lbuttonup
event mousemove pbm_mousemove
int X=1074
int Y=1124
int Width=741
int Height=28
boolean FocusRectangle=false
long TextColor=255
long BackColor=0
long BorderColor=8388608
string Pointer="SizeNS!"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousedown;If Not ib_Debug Then This.BackColor = 0  //show Bar in Black

end event

event mouseup;//Hide the bar
If Not ib_Debug Then This.BackColor = il_HiddenColor

//Resize Bars
wf_ResizeBars()

//Resize the panels
wf_ResizePanels()

end event

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	This.Y = Parent.PointerY()
End If

end event

type st_horizontal1 from statictext within w_tv_dw_link
event mousedown pbm_lbuttondown
event mouseup pbm_lbuttonup
event mousemove pbm_mousemove
int X=1079
int Y=592
int Width=741
int Height=28
boolean FocusRectangle=false
long TextColor=255
long BackColor=0
long BorderColor=8388608
string Pointer="SizeNS!"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event mousedown;If Not ib_Debug Then This.BackColor = 0  //show Bar in Black

end event

event mouseup;//Hide the bar
If Not ib_Debug Then This.BackColor = il_HiddenColor

//Resize Bars
wf_ResizeBars()

//Resize the panels
wf_ResizePanels()

end event

event mousemove;//Check for move in progess
If KeyDown(keyLeftButton!) Then
	If Not ib_debug Then This.BackColor = 0  //show Bar in Black
	This.Y = Parent.PointerY()
End If

end event

type dw_4 from datawindow within w_tv_dw_link
int X=1079
int Y=1388
int Width=1792
int Height=276
int TabOrder=40
string DataObject="d_salesorder_items"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;ib_Changed[4] = True
tv_1.Post Event ue_markitemupdated()

end event

event getfocus;tv_1.Post Event ue_changeselection(4)

end event

type dw_3 from datawindow within w_tv_dw_link
int X=1079
int Y=1156
int Width=1792
int Height=196
int TabOrder=30
string DataObject="d_sales_rep_customer_orders"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;ib_Changed[3] = True
tv_1.Post Event ue_markitemupdated()

end event

event getfocus;tv_1.Post Event ue_changeselection(3)

end event

type dw_2 from datawindow within w_tv_dw_link
int X=1079
int Y=624
int Width=1792
int Height=500
int TabOrder=20
string DataObject="d_sales_rep_customers"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;ib_Changed[2] = True
tv_1.Post Event ue_markitemupdated()

end event

event getfocus;tv_1.Post Event ue_changeselection(2)

end event

type tv_1 from treeview within w_tv_dw_link
event ue_markitemupdated ( )
event ue_clearupdateditems ( )
event ue_changeselection ( integer ai_dwlevel )
int Y=28
int Width=1047
int Height=1616
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean LinesAtRoot=true
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

event ue_markitemupdated;Integer				li_Index
Long					ll_CurrentItem
TreeViewItem		ltvi_Current

// The currently selected item was updated, so set it's state picture

ll_CurrentItem = FindItem(CurrentTreeItem!, 0)

GetItem(ll_CurrentItem, ltvi_Current)
ltvi_Current.StatePictureIndex = 1
SetItem(ll_CurrentItem, ltvi_Current)

li_Index = UpperBound(il_ChangedItem) + 1
il_ChangedItem[li_Index] = ll_CurrentItem

end event

event ue_clearupdateditems;Long					ll_Empty[]
Integer				li_Cnt, li_Limit
TreeViewItem		ltvi_Item

// Clear the state pictures from all items

li_Limit = UpperBound(il_ChangedItem)

For li_Cnt = 1 To li_Limit
	GetItem(il_ChangedItem[li_Cnt], ltvi_Item)
	ltvi_Item.StatePictureIndex = 0
	SetItem(il_ChangedItem[li_Cnt], ltvi_Item)
Next

il_ChangedItem = ll_Empty
For li_Cnt = 1 To 4
	ib_Changed[li_Cnt] = False
Next

end event

event ue_changeselection;// Select the TreeView item that matches the DataWindow
// that just got focus

Integer				li_Cnt, li_Parent
Long					ll_CurrentItem
TreeViewItem		ltvi_Current

ll_CurrentItem = FindItem(CurrentTreeItem!, 0)

If GetItem(ll_CurrentItem, ltvi_Current) = -1 Then Return

If ltvi_Current.Level = ai_DWLevel Then Return

li_Parent = ltvi_Current.Level - ai_DWLevel

For li_Cnt = 1 To li_Parent
	ll_CurrentItem = FindItem(ParentTreeItem!, ll_CurrentItem)
	If ll_CurrentItem <= 0 Then Return
Next

SelectItem(ll_CurrentItem)

end event

event itempopulate;// Populate the tree with this item's children

Integer				li_Level, li_Parm, li_RepID, li_Rows
Long					ll_Parent
TreeViewItem		ltvi_Current, ltvi_Parent

SetPointer(HourGlass!)

// Determine the level
GetItem(handle, ltvi_Current)
li_Level = ltvi_Current.Level + 1

// Determine the Retrieval arguments for the new data
li_Parm = Integer(ltvi_Current.Data)

If li_Level = 3 Then
	// This levels need a second parameter (the sales rep id),
	// get it from this item's parent
	ll_Parent = FindItem(ParentTreeItem!, handle)
	GetItem(ll_Parent, ltvi_Parent)
	li_RepID = Integer(ltvi_Parent.Data)
End If

// Retrieve the data
ids_Data[li_Level].Reset()
li_Rows = ids_Data[li_Level].Retrieve(li_Parm, li_RepID)

of_add_items(handle, li_Level, li_Rows)

end event

event selectionchanged;// Display the data for the record selected in the DataWindows

Integer				li_Cnt, li_Parm
TreeViewItem		ltvi_New

SetPointer(HourGlass!)
Parent.SetRedraw(False)

// Display this item in the proper DataWindow
of_display_item(newhandle, li_Parm)

// Reset all lower-level DataWindows
GetItem(newhandle, ltvi_New)

For li_Cnt = (ltvi_New.Level + 1) To 4
	idw_Data[li_Cnt].Reset()
	il_CurrentItem[li_Cnt] = 0
Next

Parent.SetRedraw(True)

end event

event constructor;// Add the pictures to be used.
// This is done in this script rather than the painter to allow the
// picture size to be set.  Otherwise it gets set to be equal to the
// size of the first picture added.

This.PictureHeight = 15
This.PictureWidth = 16

This.AddPicture("emp.ico")
This.AddPicture("Library!")
This.AddPicture("DosEdit!")
This.AddPicture("Custom050!")
This.AddStatePicture("Save!")

end event

event selectionchanging;// Determine whether to allow the user to change selection, and
// whether to re-retrieve the new item's DataWindow, based on
// the item selected and the items updated.  Returning 0 from
// this event will allow the selection to change.  Returning 1 will not.

Integer				li_Cnt, li_Start
Long					ll_OldParent, ll_NewParent
Boolean				lb_Changed
TreeViewItem		ltvi_Old, ltvi_New

ib_Retrieve = True

If GetItem(oldhandle, ltvi_Old) = -1 Or &
	GetItem(newhandle, ltvi_New) = -1 Then Return 0

If ltvi_Old.Level = ltvi_New.Level Then
	// Changing selection to another item on the same level.
	// First determine if the DW will need to be re-retrieved.  If the
	// new item has the same parent as the old, it does not.
	If FindItem(ParentTreeItem!, oldhandle) = FindItem(ParentTreeItem!, newhandle) Then
		ib_Retrieve = False
		Return 0

	Else
		// If nothing below the old item has been changed, do not need to save.
		For li_Cnt = ltvi_Old.Level To 4
			If ib_Changed[li_Cnt] Then
				Return of_savequery()
			Else
				Return 0
			End If
		Next
	End If

ElseIf ltvi_Old.Level < ltvi_New.Level Then
	// Selecting an item lower down the tree.
	// If a record below the old item has been changed, and
	// the old item is not a parent of the new item, must save.
	For li_Cnt = (ltvi_Old.Level) To 4
		If ib_Changed[li_Cnt] Then
			lb_Changed = True
		End If
	Next
	If lb_Changed Then
		If Not of_checkparent(newhandle, oldhandle) Then Return of_savequery()
	Else
		Return 0
	End If

Else
	// Selecting an item higher in the tree.
	// If the parent of new is also the parent of old, then do not have to retrieve.
	ll_NewParent = FindItem(ParentTreeItem!, newhandle)
	If of_checkparent(oldhandle, ll_NewParent) Then
		ib_Retrieve = False
		li_Start = ltvi_New.Level + 1
	Else
		li_Start = ltvi_New.Level
	End If
	
	// If a record below the new one has been changed, must save.
	For li_Cnt = li_Start To 4
		If ib_Changed[li_Cnt] Then
			lb_Changed = True
		End If
	Next
	If lb_Changed Then
		Return of_savequery()
	Else
		Return 0
	End If
End If

end event

type dw_1 from datawindow within w_tv_dw_link
int X=1079
int Y=20
int Width=1792
int Height=564
int TabOrder=10
string DataObject="d_sales_reps"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemchanged;ib_Changed[1] = True
tv_1.Post Event ue_markitemupdated()

end event

event getfocus;tv_1.Post Event ue_changeselection(1)

end event

type st_vertical from statictext within w_tv_dw_link
event mousemove pbm_mousemove
event mouseup pbm_lbuttonup
event mousedown pbm_lbuttondown
int X=1056
int Y=20
int Width=23
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
	This.x = Parent.Pointerx()
End If




end event

event mouseup;//Hide the bar
If Not ib_debug Then This.BackColor = il_HiddenColor

//Resize Bars
wf_ResizeBars()

//Resize the panels
wf_ResizePanels()

end event

event mousedown;If Not ib_Debug Then This.BackColor = 0  //show Bar in Black

end event

