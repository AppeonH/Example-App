$PBExportHeader$w_prod_listview.srw
$PBExportComments$Listview of products, used by the w_add_sales_order
forward
global type w_prod_listview from w_center
end type
type st_1 from statictext within w_prod_listview
end type
type lv_prod from listview within w_prod_listview
end type
end forward

global type w_prod_listview from w_center
int X=494
int Y=988
int Width=2341
int Height=804
boolean TitleBar=true
string Title="Products"
long BackColor=78168256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_refresh_items ( )
event ue_postopen ( )
event ue_arrangeicons ( )
event ue_chglistview ( listviewview alvv_newview )
event ue_edititem ( )
st_1 st_1
lv_prod lv_prod
end type
global w_prod_listview w_prod_listview

type variables
DataStore		ids_Products
Integer		ii_SortCol = 1, ii_WindowBorder = 15
grsorttype		igrs_Sort = ascending!
m_lv_rmb_prod	im_PopMenu


end variables

forward prototypes
public subroutine of_getcurrentstyle (ref listviewview alvv_Current)
public function string of_set_label (integer ai_row)
end prototypes

event ue_refresh_items;Integer			li_Rows, li_Cnt
ListViewItem	llvi_Item

SetPointer(Hourglass!)

lv_prod.DeleteItems()

// Retrieve data into the datastore
ids_Products.SetTransObject(sqlca)
li_Rows = ids_Products.Retrieve()

// Get all rows from the datastore and add as items to the listview
For li_Cnt = 1 To li_Rows
	llvi_Item.PictureIndex = lv_prod.AddLargePicture(ids_Products.Object.picture_name[li_Cnt])
	lv_prod.AddSmallPicture(ids_Products.Object.picture_name[li_Cnt])

	// Save the picture name in the data attribute so it can be referenced when the item is dropped.
	llvi_Item.Data = ids_Products.Object.picture_name[li_Cnt]
	
	// The label is comprised of all the data displayed in the Report view
	llvi_Item.Label = of_set_label(li_Cnt)
	
	lv_prod.AddItem(llvi_Item)
Next

end event

event ue_postopen;Integer		li_Columns, li_Cnt, li_Width
String		ls_Column, ls_Label, ls_ColType
Alignment	lal_Align

SetPointer(Hourglass!)

// Using a datastore to retrieve data from the database
ids_Products = Create DataStore
ids_Products.DataObject = "d_products"

// Set the large and small picture sizes
lv_prod.LargePictureWidth = 48
lv_prod.LargePictureHeight = 48
lv_prod.SmallPictureWidth = 24
lv_prod.SmallPictureHeight = 24

// Add the columns for report view.
li_Columns = Integer(ids_Products.Object.DataWindow.Column.Count)

For li_Cnt = 1 To li_Columns
	ls_Column = ids_Products.Describe("#" + String(li_Cnt) + ".Name")

	// Do not add any columns with 'Display as BitMap' checked
	If ids_Products.Describe(ls_Column + ".BitMapName")	= "no" Then

		ls_Label = ids_Products.Describe(ls_Column + "_t.Text")
		li_Width = Integer(ids_Products.Describe(ls_Column + ".Width"))
		If Lower(Left(ids_Products.Describe(ls_Column + ".Coltype"), 4)) = "char" Then
			lal_Align = Left!
		Else
			lal_Align = Right!
		End If
	
		lv_prod.AddColumn(ls_Label, lal_Align, li_Width)
	End If
Next

Post Event ue_refresh_items()

end event

event ue_arrangeicons;lv_prod.Arrange()

end event

event ue_chglistview;lv_prod.View = alvv_NewView

end event

event ue_edititem;Integer			li_Index
ListViewItem	llvi_Current

li_Index = lv_prod.SelectedIndex()
If li_Index <= 0 Then Return

lv_prod.Post Event DoubleClicked(li_Index)

end event

public subroutine of_getcurrentstyle (ref listviewview alvv_Current);// Return the style of the ListView
alvv_Current = lv_prod.View

end subroutine

public function string of_set_label (integer ai_row);// The label attribute of a ListView item contains the "data" displayed in the report view.
// Multiple columns separated by a tab ("~t") are displayed as the columns in the report
// view.  The first is displayed as the label on the icon in icon view.

Integer		li_Columns, li_Cnt
String		ls_Column, ls_Label
Long			ll_Value
Double		ldb_Value
Date			ldt_Value

li_Columns = Integer(ids_Products.Object.DataWindow.Column.Count)

For li_Cnt = 1 To li_Columns
	ls_Column = ids_Products.Describe("#" + String(li_Cnt) + ".Name")
	
	// Do not add any columns with 'Display as BitMap' checked
	If ids_Products.Describe(ls_Column + ".BitMapName")	= "no" Then
		If li_Cnt > 1 Then ls_Label += "~t"
	
		Choose Case Lower(Left(ids_Products.Describe(ls_Column + ".Coltype"), 3))
			Case "dec"
				ldb_Value = ids_Products.GetItemDecimal(ai_Row, ls_Column)
				ls_Label += String(ldb_Value, "$#0.00")
			Case "cha"
				ls_Label += ids_Products.GetItemString(ai_Row, ls_Column)
			Case "dat"
				ldt_Value = ids_Products.GetItemDate(ai_Row, ls_Column)
				ls_Label += String(ldt_Value)
			Case Else
				ll_Value = ids_Products.GetItemNumber(ai_Row, ls_Column)
				ls_Label += String(ll_Value)
		End Choose
	End If
Next

Return ls_Label

end function

on w_prod_listview.destroy
destroy(this.st_1)
destroy(this.lv_prod)
end on

event open;call super::open;Post Event ue_postopen()

end event

event resize;lv_prod.Resize(newwidth - (2 * ii_WindowBorder), newheight - (lv_prod.Y + ii_WindowBorder))

end event

event close;Destroy ids_Products

If IsValid(im_PopMenu) Then
	Destroy im_PopMenu
End If

If IsValid(w_update_prod) Then Close(w_update_prod)

end event

on w_prod_listview.create
this.st_1=create st_1
this.lv_prod=create lv_prod
this.Control[]={ this.st_1,&
this.lv_prod}
end on

type st_1 from statictext within w_prod_listview
int X=14
int Y=8
int Width=2286
int Height=64
boolean Enabled=false
string Text="Drag/Drop a product onto the order to add it.  Double-click a product to view it.  RMB to change the view."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=75530304
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lv_prod from listview within w_prod_listview
int X=14
int Y=72
int Width=2263
int Height=608
int TabOrder=10
boolean DragAuto=true
BorderStyle BorderStyle=StyleLowered!
boolean EditLabels=true
boolean HideSelection=false
boolean ExtendedSelect=true
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=12632256
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=12632256
long StatePictureMaskColor=553648127
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event doubleclicked;String			ls_ID
ListViewItem	llvi_Item

GetItem(index, 3, ls_ID)

If Trim(ls_ID) <> "" Then
	OpenWithParm(w_update_prod, Integer(ls_ID))
	If Message.DoubleParm = 1 Then
		Parent.Post Event ue_refresh_items()
	End if
End if

end event

event rightclicked;If Not IsValid(im_PopMenu) Then
	im_PopMenu = Create m_lv_rmb_prod
End If

If index < 1 Then
	im_PopMenu.m_action.m_edititem.Enabled = False
Else
	im_PopMenu.m_action.m_edititem.Enabled = True
End If

If This.View = ListViewList! Or This.View = ListViewReport! Then
	im_PopMenu.m_action.m_lineupicons.Enabled = False
Else
	im_PopMenu.m_action.m_lineupicons.Enabled = True
End If

im_PopMenu.m_action.PopMenu(Parent.PointerX(), Parent.PointerY())

end event

event columnclick;// Sort the list based on the column clicked.
// If the same column is clicked twice, sort descending.

If column <> ii_SortCol Then
	igrs_Sort = ascending!
	ii_SortCol = column
Else
	If igrs_Sort = ascending! Then
		igrs_Sort = descending!
	Else
		igrs_Sort = ascending!
	End if
End if

// Since all columns are strings, numeric values will not sort
// properly.  So call userdefined sort for Quantity and Unit Price.
// This will execute the "sort" event for each item comparison.

If column < 6 Then
	This.Sort(igrs_Sort, column)
Else
	This.Sort(userdefinedsort!, column)
End If

end event

event sort;// Sort by Quantity or Unit Price.  Convert the data
// to numbers before comparing.

String	ls_Item1, ls_Item2
Double	ldb_Item1, ldb_Item2

GetItem(index1, column, ls_Item1)
GetItem(index2, column, ls_Item2)

If column = 7 Then
	// Strip off the "$"
	ls_Item1 = Right(ls_Item1, (Len(ls_Item1) - 1))
	ls_Item2 = Right(ls_Item2, (Len(ls_Item2) - 1))
End If	

ldb_Item1 = Double(ls_Item1)
ldb_Item2 = Double(ls_Item2)

// This event returns:
// 0 - the two items are equal
// -1 - Item1 should be placed before Item2
// 1 - Item2 should be placed before Item1

If ldb_Item1 = ldb_Item2 Then Return 0

If igrs_Sort = ascending! Then
	If ldb_Item1 < ldb_Item2 Then
		Return -1
	Else
		Return 1
	End If
Else
	If ldb_Item1 < ldb_Item2 Then
		Return 1
	Else
		Return -1
	End If
End if

end event

