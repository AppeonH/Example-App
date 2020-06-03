$PBExportHeader$w_data_manager.srw
$PBExportComments$Data Manager (Program Manager-style ListViews)
forward
global type w_data_manager from w_center
end type
type lv_1 from listview within w_data_manager
end type
end forward

global type w_data_manager from w_center
int X=41
int Y=20
int Width=2231
int Height=1248
boolean TitleBar=true
string MenuName="m_data_manager"
long BackColor=79416533
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
event ue_exit ( )
event ue_autoarrange ( boolean ab_autoarrange )
event ue_minimizeonuse ( boolean ab_minimize )
event ue_setdefaultstyle ( listviewview alvv_style )
event ue_refresh ( )
lv_1 lv_1
end type
global w_data_manager w_data_manager

type variables
integer                                 ii_columns
integer                                 ii_level
integer                                 ii_openpos
integer                                 ii_parm1
integer                                 ii_parm2
integer		            ii_sortcol = 2
// Window border to be used on all sides. (resize service)
integer		            ii_windowborder = 15	
string		            is_dataobject[4]
datastore		            ids_data
grsorttype		            igrs_sort = ascending!
w_data_manager_frame      iw_frame



end variables

forward prototypes
public function integer of_add_lv_items (integer ai_level, integer ai_rows)
public subroutine of_set_lv_item (integer ai_level, integer ai_row, ref listviewitem alvi_new)
public subroutine of_getcurrentstyle (ref listviewview alvv_Current)
end prototypes

event ue_populate;Integer		li_Rows

li_Rows = ids_Data.Retrieve(ii_Parm1, ii_Parm2)

of_add_lv_items(ii_Level, li_Rows)

end event

event ue_chglistview;lv_1.View = alvv_NewView

If iw_Frame.ib_AutoArrange Then
	lv_1.Arrange()
End If

end event

event ue_edititem;Integer			li_Index, li_Level
Long				ll_Parent
n_cst_parms	lnv_Parm
ListViewItem	llvi_Current

li_Index = lv_1.SelectedIndex()
If li_Index <= 0 Then Return
If lv_1.GetItem(li_Index, llvi_Current) = -1 Then Return

// Filter the DW to show only the proper row
Choose Case ii_Level
	Case 1
		lnv_Parm.is_Filter = "employee_emp_id = " + String(llvi_Current.Data)
	Case 2
		lnv_Parm.is_Filter = "customer_id = " + String(llvi_Current.Data)
	Case 3
		lnv_Parm.is_Filter = "id = " + String(llvi_Current.Data)
	Case 4
		lnv_Parm.is_Filter = "line_id = " + String(llvi_Current.Data)
End Choose

lnv_Parm.ii_Parm1 = ii_Parm1
lnv_Parm.ii_Parm2 = ii_Parm2
lnv_Parm.iw_Parent = This
lnv_Parm.is_DataObject = ids_Data.DataObject
ii_OpenPos = ii_OpenPos + 80
If ii_OpenPos > 1020 Then ii_OpenPos = 0
lnv_Parm.ii_OpenPos = ii_OpenPos
lnv_Parm.iw_Frame = iw_Frame

OpenWithParm(w_data_edit, lnv_Parm)

If iw_Frame.ib_MinimizeOnUse Then
	iw_Frame.WindowState = Minimized!
End If

end event

event ue_arrangeicons;lv_1.Arrange()

end event

event ue_openitem;Integer			li_Index
ListViewItem	llvi_Current

li_Index = lv_1.SelectedIndex()
If li_Index <= 0 Then Return

lv_1.Post Event DoubleClicked(li_Index)

end event

event ue_exit;If ii_Level > 1 Then
	Post Close(iw_Frame)
End If

Close(This)

end event

event ue_autoarrange;iw_Frame.ib_AutoArrange = ab_AutoArrange

If ab_AutoArrange Then
	lv_1.Arrange()
End If

end event

event ue_minimizeonuse;iw_Frame.ib_MinimizeOnUse = ab_Minimize

end event

event ue_setdefaultstyle;lv_1.View = alvv_style

end event

event ue_refresh;// Refresh the ListView

ids_Data.Reset()

lv_1.DeleteItems()

Trigger Event ue_populate()

end event

public function integer of_add_lv_items (integer ai_level, integer ai_rows);// Function to add the items to the ListView using the data in the DataStore

Integer				li_Cnt
ListViewItem		llvi_New

// Delete all existing columns from the ListView
lv_1.DeleteColumns()

// Add the columns to the ListView
Choose Case ai_Level
	Case 1
		lv_1.AddColumn("Name", Left!, 500)
		lv_1.AddColumn("ID", Left!, 150)
		lv_1.AddColumn("Dept", Left!, 150)
		lv_1.AddColumn("Manager", Left!, 235)
		lv_1.AddColumn("Status", Center!, 175)
		lv_1.AddColumn("Phone #", Left!, 350)
		lv_1.AddColumn("Salary", Right!, 280)
		ii_Columns = 7
	Case 2
		lv_1.AddColumn("Company Name", Left!, 700)
		lv_1.AddColumn("ID", Left!, 150)
		lv_1.AddColumn("Contact Name", Left!, 500)
		lv_1.AddColumn("Address", Left!, 1150)
		lv_1.AddColumn("Phone #", Left!, 350)
		ii_Columns = 5
	Case 3
		lv_1.AddColumn("Order ID", Left!, 225)
		lv_1.AddColumn("Date", Left!, 250)
		lv_1.AddColumn("Financial Code", Center!, 375)
		lv_1.AddColumn("Region", Left!, 250)
		ii_Columns = 4
	Case 4
		lv_1.AddColumn("Product Description", Left!, 500)
		lv_1.AddColumn("Line #", Right!, 175)
		lv_1.AddColumn("ID", Left!, 150)
		lv_1.AddColumn("Ship Date", Left!, 275)
		lv_1.AddColumn("Qty", Right!, 150)
		lv_1.AddColumn("Unit Price", Right!, 250)
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
	Case 1
		alvi_New.Label = ids_Data.Object.employee_emp_lname[ai_Row] + ", " + &
									ids_Data.Object.employee_emp_fname[ai_Row] + "~t" + &
									String(ids_Data.Object.employee_emp_id[ai_Row]) + "~t" + &
									String(ids_Data.Object.employee_dept_id[ai_Row]) + "~t" + &
									String(ids_Data.Object.employee_manager_id[ai_Row]) + "~t" + &
									ids_Data.Object.employee_status[ai_Row] + "~t"
		ls_Phone = ids_Data.Object.employee_phone[ai_Row]
		alvi_New.Label = alvi_New.Label + String(ls_Phone, "(@@@)@@@-@@@@") + "~t"
		ldb_Number = ids_Data.Object.employee_salary[ai_Row]
		alvi_New.Label = alvi_New.Label + String(ldb_Number, "$#0,000.00")
		
		alvi_New.Data = ids_Data.Object.employee_emp_id[ai_Row]
		
	Case 2
		alvi_New.Label = ids_Data.Object.customer_company_name[ai_Row] + "~t" + &
									String(ids_Data.Object.customer_id[ai_Row]) + "~t" + &
									ids_Data.Object.customer_lname[ai_Row] + ", " + &
									ids_Data.Object.customer_fname[ai_Row] + "~t" + &
									ids_Data.Object.customer_address[ai_Row] + ", " + &
									ids_Data.Object.customer_city[ai_Row] + ", " + &
									ids_Data.Object.customer_state[ai_Row] + "  " + &
									ids_Data.Object.customer_zip[ai_Row] + "~t"
		ls_Phone = ids_Data.Object.customer_phone[ai_Row]
		alvi_New.Label = alvi_New.Label + String(ls_Phone, "(@@@)@@@-@@@@")
									
		alvi_New.Data = ids_Data.Object.customer_id[ai_Row]
		
	Case 3
		alvi_New.Label = String(ids_Data.Object.id[ai_Row]) + "~t" + &
									String(ids_Data.Object.order_date[ai_Row], "mm/dd/yy") + "~t" + &
									ids_Data.Object.fin_code_id[ai_Row] + "~t" + &
									ids_Data.Object.region[ai_Row]
									
		alvi_New.data = ids_Data.Object.id[ai_Row]
		
	Case 4
		alvi_New.Label = ids_Data.Object.product_description[ai_Row] + "~t" + &
									String(ids_Data.Object.line_id[ai_Row]) + "~t" + &
									String(ids_Data.Object.prod_id[ai_Row]) + "~t" + &
									String(ids_Data.Object.ship_date[ai_Row], "mm/dd/yy") + "~t" + &
									String(ids_Data.Object.quantity[ai_Row]) + "~t"
		ldb_Number = ids_Data.Object.product_unit_price[ai_Row]
		alvi_New.Label = alvi_New.Label + String(ldb_Number, "$#0.00") + "~t"
		ldb_Number = ids_Data.Object.total_cost[ai_Row]
		alvi_New.Label = alvi_New.Label + String(ldb_Number, "$#,##0.00")

		alvi_New.Data = ids_Data.Object.line_id[ai_Row]
End Choose


If ai_Level < 4 Then
	alvi_New.PictureIndex = ai_Level
Else
	// Set the picture to be the product picture
	li_Picture = lv_1.AddLargePicture(ids_Data.Object.product_picture_name[ai_Row])
	lv_1.AddSmallPicture(ids_Data.Object.product_picture_name[ai_Row])
	alvi_New.PictureIndex = li_Picture
End If

end subroutine

public subroutine of_getcurrentstyle (ref listviewview alvv_Current);// Return the style of the ListView
alvv_Current = lv_1.View

end subroutine

on w_data_manager.create
if this.MenuName = "m_data_manager" then this.MenuID = create m_data_manager
this.lv_1=create lv_1
this.Control[]={this.lv_1}
end on

on w_data_manager.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lv_1)
end on

event open;call super::open;Integer			li_Cnt
String			ls_Label
n_cst_parms	lnv_Parm

SetPointer(HourGlass!)

lnv_Parm = Message.PowerObjectParm

// Create DataStore used by this example
ids_Data = Create DataStore

// This window could display data from any of these objects
is_DataObject[1] = "d_sales_reps"
is_DataObject[2] = "d_sales_rep_customers"
is_DataObject[3] = "d_sales_rep_customer_orders"
is_DataObject[4] = "d_salesorder_items"

// Determine which set of data to display
For li_Cnt = 1 To 4
	If lnv_Parm.is_DataObject = is_DataObject[li_Cnt] Then
		ii_Level = li_Cnt
	End If
Next

iw_Frame = lnv_Parm.iw_Frame
ii_OpenPos = lnv_Parm.ii_OpenPos
ii_Parm1 = lnv_Parm.ii_Parm1
ii_Parm2 = lnv_Parm.ii_Parm2
ls_Label = lnv_Parm.is_Label
	
This.Move(This.X + ii_OpenPos, This.Y + ii_OpenPos)

ids_Data.DataObject = is_DataObject[ii_Level]
ids_Data.SetTransObject(sqlca)

Choose Case ii_Level
	Case 1
		This.Title = "Sales Reps"
	Case 2
		This.Title = "Customers For " + ls_Label
	Case 3
		This.Title = "Orders For " + ls_Label
	Case 4
		This.Title = "Items On Order:  " + ls_Label
End Choose

// Display the ListView in the default type
Event ue_chglistview(iw_Frame.ilvv_DefaultStyle)

// Populate the control
Post Event ue_populate()

end event

event resize;lv_1.X = ii_WindowBorder
lv_1.Y = ii_WindowBorder

lv_1.Resize(newwidth - (2 * ii_WindowBorder), newheight - (2 * ii_WindowBorder))

If iw_Frame.ib_AutoArrange Then
	lv_1.Arrange()
End If

end event

event close;// Destroy DataStore used by this example
Destroy ids_Data

If IsValid(w_data_edit) Then Close(w_data_edit)

If ii_Level = 1 Then
	Post Close(iw_Frame)
End If

end event

type lv_1 from listview within w_data_manager
int X=5
int Y=8
int Width=2094
int Height=976
int TabOrder=20
boolean DragAuto=true
BorderStyle BorderStyle=StyleLowered!
boolean HideSelection=false
string LargePictureName[]={"emp.ico",&
"Library!",&
"DosEdit!"}
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=12632256
string SmallPictureName[]={"emp.ico",&
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
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event rightclicked;m_lv_rmb	lm_PopMenu

lm_PopMenu = CREATE m_lv_rmb

// If an item was not clicked, disable the "Open Item" and
// "Edit Item" menu options.
If index <= 0 Then
	lm_PopMenu.m_action.m_openitem.Enabled = False
	lm_PopMenu.m_action.m_edititem.Enabled = False
Else
	// If this is displaying sales order items (level 4) then disable
	// the "Open Item" menu option.
	If ii_Level = 4 Then
		lm_PopMenu.m_action.m_openitem.Enabled = False
	End If
End If

// Only enable the "Arrange Icons" menu option if in one of the icon views
If This.View = ListViewList! Or This.View = ListViewReport! Then
	lm_PopMenu.m_action.m_lineupicons.Enabled = False
End If

lm_PopMenu.m_action.PopMenu(iw_Frame.PointerX(), iw_Frame.PointerY())
DESTROY lm_PopMenu

end event

event doubleclicked;Window				lw_Window
n_cst_parms		lnv_Parm
ListViewItem		llvi_Current

If index <= 0 Then Return

// Get the item that was double-clicked
If GetItem(index, llvi_Current) = -1 Then Return

If ii_Level = 4 Then
	// This is the bottom level, so edit this item instead
	Parent.Post Event ue_edititem()

Else
	lnv_Parm.ii_Parm1 = llvi_Current.Data
	
	// Parm 2 is only used for level 3
	lnv_Parm.ii_Parm2 = ii_Parm1
	
	ii_OpenPos = ii_OpenPos + 80
	If ii_OpenPos > 1020 Then ii_OpenPos = 0
	lnv_Parm.ii_OpenPos = ii_OpenPos
	lnv_Parm.is_DataObject = is_DataObject[ii_Level + 1]
	lnv_Parm.is_Label = llvi_Current.Label
	lnv_Parm.iw_Frame = iw_Frame
	
	OpenSheetWithParm(lw_Window, lnv_Parm, "w_data_manager", iw_Frame, 3, Original!)
End If

end event

event dragdrop;If source = This Then
	// Moving icons arround
	If iw_Frame.ib_AutoArrange Then
		This.Arrange()
	End If
End If

end event

event columnclick;If column <> ii_SortCol Then
	igrs_Sort = ascending!
	ii_SortCol = column
Else
	If igrs_Sort = ascending! Then
		igrs_Sort = descending!
	Else
		igrs_Sort = ascending!
	End if
End if

This.Sort(igrs_Sort, column)

end event

