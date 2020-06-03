$PBExportHeader$w_dir_tree.srw
$PBExportComments$Directory Tree example showing use of recursion and TreeView control
forward
global type w_dir_tree from w_center
end type
type dw_print from datawindow within w_dir_tree
end type
type cb_expand from commandbutton within w_dir_tree
end type
type cb_help from commandbutton within w_dir_tree
end type
type tab_dir from tab within w_dir_tree
end type
type tabpage_dw from userobject within tab_dir
end type
type dw_1 from datawindow within tabpage_dw
end type
type tabpage_tv from userobject within tab_dir
end type
type tv_1 from treeview within tabpage_tv
end type
type ddplb_drive from dropdownpicturelistbox within w_dir_tree
end type
type sle_drive from singlelineedit within w_dir_tree
end type
type st_curr_path from statictext within w_dir_tree
end type
type st_1 from statictext within w_dir_tree
end type
type cb_close from commandbutton within w_dir_tree
end type
type cb_print from commandbutton within w_dir_tree
end type
type cb_ok from commandbutton within w_dir_tree
end type
type lb_file from listbox within w_dir_tree
end type
type sle_dir from singlelineedit within w_dir_tree
end type
type gb_2 from groupbox within w_dir_tree
end type
type gb_1 from groupbox within w_dir_tree
end type
type tabpage_dw from userobject within tab_dir
dw_1 dw_1
end type
type tabpage_tv from userobject within tab_dir
tv_1 tv_1
end type
type tab_dir from tab within w_dir_tree
tabpage_dw tabpage_dw
tabpage_tv tabpage_tv
end type
end forward

global type w_dir_tree from w_center
int X=37
int Y=4
int Width=2656
int Height=1836
boolean TitleBar=true
string Title="Directory Tree"
long BackColor=74481808
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
int ColumnsPerPage=1
int LinesPerPage=1
int UnitsPerColumn=1
int UnitsPerLine=1
event ue_postopen pbm_custom01
dw_print dw_print
cb_expand cb_expand
cb_help cb_help
tab_dir tab_dir
ddplb_drive ddplb_drive
sle_drive sle_drive
st_curr_path st_curr_path
st_1 st_1
cb_close cb_close
cb_print cb_print
cb_ok cb_ok
lb_file lb_file
sle_dir sle_dir
gb_2 gb_2
gb_1 gb_1
end type
global w_dir_tree w_dir_tree

type variables
Long  il_Row, il_RootItem
Boolean  ib_Cancel 
end variables

forward prototypes
public function integer wf_collapse_rows (datawindow adw_datawindow, long al_startrow)
public function integer wf_expand_row (datawindow adw_datawindow, long al_startrow)
public function integer wf_get_drive_index (string as_drive)
public function long of_add_item (string as_path, string as_filename, long al_parent)
public function long of_recurse_dir_list (string as_path, long al_parent)
public function string of_build_dw_tree (long al_handle)
end prototypes

event ue_postopen;String	ls_Item
Integer	li_Index, li_Drives, li_DriveType
String	ls_Drive

// Get a listing of valid drives
// Store the current working directory in hiddent static text st_curr_path
lb_file.DirList("*.*",49152,st_curr_path)

Choose Case ge_Environment.OSType
		
	Case Sol2!, HPUX!, AIX!
		ddplb_drive.Text = sle_drive.text
		
	Case Else
		// Add the Picture List Box pictures
		ddplb_drive.AddPicture("diskdriv.bmp")
		ddplb_drive.AddPicture("harddriv.bmp")
		ddplb_drive.AddPicture("netdriv.bmp")
		ddplb_drive.AddPicture("cdrom.bmp")
		
		// Copy the drive choices to the ddlb
		li_Drives = lb_file.TotalItems()
		For li_Index = 1 To li_Drives
	
			// The way the drives are displayed is dependent on the OS
			If ge_Environment.OSType = macintosh! Then
				// Mac drives are displayed in the form [-macintosh hd-]
				// strip off first and last two characters
				ddplb_drive.AddItem(Mid(lb_file.text(li_Index), 3, (Len(lb_file.text(li_index)) - 4))+":", 0)
			Else
				ls_Drive = mid(lb_file.text(li_index),3,1)
				li_DriveType = wf_get_drive_index(ls_Drive)
				ddplb_drive.AddItem(ls_Drive + ":\", li_DriveType)
			End if
		Next
	
		ddplb_drive.SelectItem(1)
	
End Choose

lb_file.Reset()

end event

public function integer wf_collapse_rows (datawindow adw_datawindow, long al_startrow);// This function is used for the DataWindow only
// Collapse all the rows that make up a level

Long		ll_Total, ll_Index, ll_EndRow
Integer	li_StartLevel

// Set the row open status back to closed
adw_DataWindow.object.open[al_StartRow] = 0

// Find out which level is being collapsed
li_StartLevel = adw_DataWindow.object.level[al_StartRow]

ll_Total = adw_DataWindow.RowCount()
If ll_Total = al_StartRow Then Return 0

SetPointer(hourglass!)

ll_EndRow = ll_Total

al_StartRow++
For ll_Index = al_StartRow  To ll_Total
	If adw_DataWindow.object.level[ll_Index] <= li_StartLevel Then
		ll_EndRow = ll_Index - 1
		Exit
	Else	
		adw_DataWindow.object.open[ll_Index] = 0
	End If
Next

adw_DataWindow.SetDetailHeight(al_StartRow, ll_EndRow, 0)

Return 0

end function

public function integer wf_expand_row (datawindow adw_datawindow, long al_startrow);// This function is used for the DataWindow only
// Expand all the rows for a level

Long		ll_Total, ll_EndRow, ll_Index
Integer	li_StartLevel

// Mark this row as open
adw_DataWindow.Object.open[al_StartRow] = 1

ll_Total = adw_DataWindow.RowCount()

If ll_Total = al_StartRow Then Return 0

SetPointer(hourglass!)

// Start with the row passed to begin exapanding
// Find out which level this is and search for the next level that is > = to this one

li_StartLevel = adw_DataWindow.Object.level[al_StartRow]

ll_EndRow = adw_DataWindow.Find("level <= " + String(li_StartLevel), al_StartRow + 1, ll_Total)
If ll_EndRow <=0 Then ll_EndRow = ll_Total

li_StartLevel ++

ll_Index = adw_DataWindow.Find("level = " + String(li_StartLevel), al_StartRow + 1, ll_EndRow)
// Set the rowheight to normal size for this selected range

Do While ll_Index > 0 
		adw_DataWindow.SetDetailHeight(ll_Index, ll_Index, 19)
		ll_Index++
		If ll_Index > ll_EndRow Then Exit
		ll_Index = adw_DataWindow.Find("level = " + String(li_StartLevel), ll_Index, ll_EndRow)
Loop	

adw_DataWindow.Sort()

Return 0

end function

public function integer wf_get_drive_index (string as_drive);// Determine drive description based on return value from external function.

UInt		lui_RC

lui_RC = gu_ext_func.uf_GetDriveType (Asc (as_drive) - 97)

Choose Case lui_RC
		Case 2
			Return 1

		Case 3
			Return 2

		Case 4
			Return 3

		Case 5
			Return 4

		Case Else
			Return 0
End Choose

end function

public function long of_add_item (string as_path, string as_filename, long al_parent);// Add a directory entry to the DataWindow or TreeView

Long					ll_NewItem
TreeViewItem		ltvi_Item

If tab_dir.SelectedTab = 1 Then
	// Add a row to the DataWindow
	ll_NewItem = tab_dir.tabpage_dw.dw_1.Insertrow(0)
	tab_dir.tabpage_dw.dw_1.Object.fullname[ll_NewItem] = as_Path
	tab_dir.tabpage_dw.dw_1.Object.name[ll_NewItem] = as_FileName
	tab_dir.tabpage_dw.dw_1.Object.bmpname[ll_NewItem] = "folder.bmp"
	tab_dir.tabpage_dw.dw_1.Object.selectedbmpname[ll_NewItem] = "foldopen.bmp"
	tab_dir.tabpage_dw.dw_1.Object.selected[ll_NewItem] = 0
	tab_dir.tabpage_dw.dw_1.Object.open[ll_NewItem] = 0
	tab_dir.tabpage_dw.dw_1.Object.children[ll_NewItem] = 0
	tab_dir.tabpage_dw.dw_1.Object.siblings[ll_NewItem] =  0
	tab_dir.tabpage_dw.dw_1.Object.level[ll_NewItem] = al_Parent

	Return al_Parent + 1

Else
	// Add an item to the TreeView
	ltvi_Item.Label = as_FileName
	ltvi_Item.PictureIndex = 1
	ltvi_Item.SelectedPictureIndex = 2
	ll_NewItem = tab_dir.tabpage_tv.tv_1.InsertItemLast(al_Parent, ltvi_Item)

	Return ll_NewItem
End if

end function

public function long of_recurse_dir_list (string as_path, long al_parent);// This is the recurrsive procedure
// Scan all subdirectories of the selected directory

Integer	li_NumDirectories, li_Index , li_Pos1 ,li_Pos2, li_Pos, li_Len, li_Items
Long		ll_New
String	ls_FileName, ls_DirName, ls_SubDirectory[], ls_Delimeter, ls_AllFiles

// Allow other windows processing to continue during this recursive process
Do While Yield()
Loop

// Test if the user has canceled the scan
If ib_cancel Then Return 0

//  Set directory delimeter based on OS type
Choose Case ge_Environment.OSType
	Case Sol2!, HPUX!, AIX!
		ls_Delimeter = "/"
		ls_AllFiles = "*"
	Case Else
		ls_Delimeter = "\"
		ls_AllFiles = "*.*"
End Choose

If Right(as_Path, 1) <> ls_Delimeter Then
	as_Path = as_Path + ls_Delimeter
End if

// Get a listing of  sub directories from the directory passed
lb_file.Reset()
lb_file.DirList(as_Path + ls_AllFiles, 32784)

// Show the current directory working on
sle_dir.text = as_Path

// Get just the last directory name ie skip the path
li_Pos = 1
li_Len = Len(as_Path) - 1
For li_Pos = li_Len to 1 Step -1
	If Mid(as_Path, li_Pos, 1) = ls_Delimeter Then Exit
Next

// Insert name, level. open is to allow collapsing of the structure			
ls_FileName = Mid(as_Path, li_Pos + 1, (Len(as_Path) - (li_Pos + 1)))

If ls_FileName = "" Then
	ls_FileName = as_Path
End if

// Insert the current directory working on into the datawindow. 
ll_New = of_add_item(as_Path, ls_FileName, al_Parent)

// Keep a local copy of the lb directories only
li_Items = lb_file.TotalItems()
li_NumDirectories = 0

Do While li_Index <= li_Items
	If left(lb_file.Text(li_Index), 1) = "[" Then
		li_NumDirectories++
		ls_SubDirectory[li_NumDirectories] = lb_file.Text(li_Index)
	End If
	li_Index++
Loop

// Call next level sub directories
li_Index = 1 
Do While  li_Index <=  li_NumDirectories
	If (ls_SubDirectory[li_Index] <> "[..]") And (ls_SubDirectory[li_Index] <> "[.]") Then
		ls_DirName = as_Path + ls_SubDirectory[li_Index] + ls_Delimeter

		// Strip the [ ] from the dir name	
		li_Pos1 = Pos(ls_dirname, "[")
		li_Pos2 = Pos(ls_dirname, "]")
		ls_DirName = Left(ls_DirName, li_Pos1 - 1) + &
						Mid(ls_DirName, li_Pos1 + 1, li_Pos2 - li_Pos1 - 1) + &
						Right (ls_DirName, Len(ls_DirName) - li_Pos2)
		
		// Here is the recurrsive call
		of_recurse_dir_list(ls_DirName, ll_New)
	End If
	li_Index++
Loop

Return 1

end function

public function string of_build_dw_tree (long al_handle);String				ls_Return
Long					ll_Next
TreeViewItem		ltvi_Item

If al_Handle <= 0 Then Return ""

tab_dir.tabpage_tv.tv_1.GetItem(al_Handle, ltvi_Item)

ls_Return = " ~t" + ltvi_Item.Label + "~t" + "folder.bmp" + "~t" + "foldopen.bmp"
If ltvi_Item.Selected Then
	ls_Return = ls_Return + "~t1"
Else
	ls_Return = ls_Return + "~t0"
End if
	
If ltvi_Item.Expanded Then
	ls_Return = ls_Return + "~t1"
Else
	ls_Return = ls_Return + "~t0"
End if

If ltvi_Item.Children Then
	ls_Return = ls_Return + "~t1~t0"
Else
	ls_Return = ls_Return + "~t0"
	If tab_dir.tabpage_tv.tv_1.FindItem(NextTreeItem!, al_Handle) > 0 Then
		ls_Return = ls_Return + "~t1"
	Else
		ls_Return = ls_Return + "~t0"
	End if
End if

ls_Return = ls_Return + "~t" + String(ltvi_Item.Level) + "~r~n"

If ltvi_Item.Expanded And ltvi_Item.Children Then
	ll_Next = tab_dir.tabpage_tv.tv_1.FindItem(ChildTreeItem!, al_Handle)
	ls_Return = ls_Return + of_build_dw_tree(ll_Next)
End if

ll_Next = tab_dir.tabpage_tv.tv_1.FindItem(NextTreeItem!, al_Handle)
ls_Return = ls_Return + of_build_dw_tree(ll_Next)

Return ls_Return

end function

event open;call super::open;Choose Case ge_Environment.OSType
		
	Case Sol2!, HPUX!, AIX!
		// Hide drives and allow user to enter a starting directory
		st_1.text = "Enter the starting directory to scan on.  Hit the scan button."
		ddplb_drive.visible = False
		gb_1.text = "Starting Directory"
		gb_1.width = 740
		sle_drive.visible = True
		
	Case Else
	
End Choose

//do all of the work in the post open event.
This.PostEvent("ue_postopen")

end event

event close;Show(w_main)

end event

on w_dir_tree.create
this.dw_print=create dw_print
this.cb_expand=create cb_expand
this.cb_help=create cb_help
this.tab_dir=create tab_dir
this.ddplb_drive=create ddplb_drive
this.sle_drive=create sle_drive
this.st_curr_path=create st_curr_path
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_ok=create cb_ok
this.lb_file=create lb_file
this.sle_dir=create sle_dir
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.dw_print,&
this.cb_expand,&
this.cb_help,&
this.tab_dir,&
this.ddplb_drive,&
this.sle_drive,&
this.st_curr_path,&
this.st_1,&
this.cb_close,&
this.cb_print,&
this.cb_ok,&
this.lb_file,&
this.sle_dir,&
this.gb_2,&
this.gb_1}
end on

on w_dir_tree.destroy
destroy(this.dw_print)
destroy(this.cb_expand)
destroy(this.cb_help)
destroy(this.tab_dir)
destroy(this.ddplb_drive)
destroy(this.sle_drive)
destroy(this.st_curr_path)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_ok)
destroy(this.lb_file)
destroy(this.sle_dir)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type dw_print from datawindow within w_dir_tree
int X=2277
int Y=1004
int Width=105
int Height=500
int TabOrder=30
boolean Visible=false
string DataObject="d_dir_tree"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_expand from commandbutton within w_dir_tree
int X=2231
int Y=532
int Width=329
int Height=84
int TabOrder=10
string Text="&Expand All"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Long		ll_Rows, ll_Cnt

SetPointer(HourGlass!)

If tab_dir.SelectedTab = 1 Then
	// Expand all datawindow rows
	tab_dir.tabpage_dw.dw_1.SetRedraw(False)
	ll_Rows = tab_dir.tabpage_dw.dw_1.RowCount()
	For ll_Cnt = 1 To ll_Rows
		tab_dir.tabpage_dw.dw_1.Object.open[ll_Cnt] = 1
		tab_dir.tabpage_dw.dw_1.SetDetailHeight(ll_Cnt, ll_Cnt, 19)
	Next
	tab_dir.tabpage_dw.dw_1.SetRedraw(True)
Else
	// Expand the treeview
	tab_dir.tabpage_tv.tv_1.ExpandAll(il_RootItem)
End If

end event

type cb_help from commandbutton within w_dir_tree
int X=2231
int Y=884
int Width=329
int Height=84
int TabOrder=20
string Text="&Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_dir_tree")

end event

type tab_dir from tab within w_dir_tree
int X=18
int Y=308
int Width=2130
int Height=1364
int TabOrder=60
boolean RaggedRight=true
int SelectedTab=1
long BackColor=77643992
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_dw tabpage_dw
tabpage_tv tabpage_tv
end type

on tab_dir.create
this.tabpage_dw=create tabpage_dw
this.tabpage_tv=create tabpage_tv
this.Control[]={this.tabpage_dw,&
this.tabpage_tv}
end on

on tab_dir.destroy
destroy(this.tabpage_dw)
destroy(this.tabpage_tv)
end on

type tabpage_dw from userobject within tab_dir
event create ( )
event destroy ( )
int X=18
int Y=112
int Width=2094
int Height=1236
long BackColor=74481808
string Text="Using DataWindow"
long TabBackColor=74481808
long TabTextColor=41943040
long PictureMaskColor=12632256
string PictureName="DataWindow!"
dw_1 dw_1
end type

on tabpage_dw.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_dw.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_dw
int X=5
int Y=16
int Width=2085
int Height=1220
int TabOrder=1
string DataObject="d_dir_tree"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;// Used for drill down

if row <= 0 then return

This.SetRedraw(False)

If il_Row > 0 And il_Row <> row Then
	This.Object.selected[il_Row] = 0
End If

If Not IsNull(dwo) Then
	This.Object.selected[row] = 1
	il_Row = row

	If dwo.name = "clickbox" Then
		If This.Object.showbox[row] = 1 Then
			
			If This.Object.open[row] = 1 Then
				wf_collapse_rows(This, row)
			Else
				wf_expand_row(This, row)
			End if
		End if
	End if
End If
			
This.SetRedraw(True)

end event

event doubleclicked;//used for drill down

If row > 0 And Not IsNull(dwo) Then
	This.SetRedraw(False)
	
	If This.Object.open[row] = 1 Then
		wf_collapse_rows(This, row)
	Else
		wf_expand_row(This, row)
	End If
	
	This.SetRedraw(True)
End If

end event

type tabpage_tv from userobject within tab_dir
int X=18
int Y=112
int Width=2094
int Height=1236
long BackColor=74481808
string Text="Using TreeView"
long TabBackColor=74481808
long TabTextColor=41943040
long PictureMaskColor=12632256
string PictureName="TreeView!"
tv_1 tv_1
end type

on tabpage_tv.create
this.tv_1=create tv_1
this.Control[]={this.tv_1}
end on

on tabpage_tv.destroy
destroy(this.tv_1)
end on

type tv_1 from treeview within tabpage_tv
int X=5
int Y=16
int Width=2066
int Height=1228
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
string PictureName[]={"Custom039!",&
"Custom050!"}
long PictureMaskColor=12632256
long StatePictureMaskColor=553648127
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddplb_drive from dropdownpicturelistbox within w_dir_tree
int X=1829
int Y=172
int Width=297
int Height=612
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
long PictureMaskColor=553648127
end type

type sle_drive from singlelineedit within w_dir_tree
int X=1856
int Y=164
int Width=480
int Height=84
int TabOrder=40
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
string Text="/"
long BackColor=12632256
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;ddplb_drive.text = This.text

end event

type st_curr_path from statictext within w_dir_tree
int X=1769
int Y=12
int Width=704
int Height=68
boolean Visible=false
boolean Enabled=false
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=12632256
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_dir_tree
int X=41
int Y=8
int Width=1760
int Height=68
boolean Enabled=false
string Text="Select the ~"Drive Letter~" of the drive to be scanned, and click the Scan button."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=77643992
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_dir_tree
int X=2231
int Y=784
int Width=329
int Height=84
int TabOrder=80
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_print from commandbutton within w_dir_tree
int X=2231
int Y=636
int Width=329
int Height=84
int TabOrder=70
string Text="&Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_temp

SetPointer(HourGlass!)

If tab_dir.SelectedTab = 1 Then
	// Print the DataWindow
	tab_dir.tabpage_dw.dw_1.Print()
	
Else
	// Print the TreeView, use a hidden datawindow and copy the
	// treeview entries into it
	dw_print.Reset()
	dw_print.ImportString(of_build_dw_tree(il_RootItem))
	dw_print.Print()
End if

end event

type cb_ok from commandbutton within w_dir_tree
int X=2231
int Y=388
int Width=329
int Height=84
int TabOrder=50
string Text="&Scan"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// This button will display Scan normally.. 
// During a scan, the text changes to Cancel.

String	ls_CurPath

// Test if this is a scan or cancel button
If This.text = "C&ancel" Then
	ib_Cancel = True
	Return
End If	

// Here down is Scan button only

// Get selected drive
ls_CurPath = ddplb_drive.Text

// Can't click any other buttons once the process is started
cb_close.Enabled=False
cb_expand.Enabled=False
cb_print.Enabled=False
cb_help.Enabled=False

tab_dir.tabpage_dw.dw_1.SetRedraw(False)
tab_dir.tabpage_tv.tv_1.SetRedraw(False)

// Allow cancel out of recursive process
This.Text = "C&ancel"
ib_Cancel = False

// Reset the datawindow or treeview and start the recursion process
// by calling the local window function.
If tab_dir.SelectedTab = 1 Then
	// Use DataWindow
	tab_dir.tabpage_dw.dw_1.Reset( )
	of_recurse_dir_list(ls_CurPath, 1)
	wf_collapse_rows(tab_dir.tabpage_dw.dw_1, 1)
	wf_expand_row(tab_dir.tabpage_dw.dw_1,1)
Else
	// Use TreeView
	tab_dir.tabpage_tv.tv_1.DeleteItem(il_RootItem)
	il_RootItem = of_recurse_dir_list(ls_CurPath, 0)
	tab_dir.tabpage_tv.tv_1.ExpandItem(il_RootItem)
End if

sle_dir.Text = ""

cb_close.Enabled=True
cb_expand.Enabled=True
cb_print.Enabled=True
cb_help.Enabled=True

This.Text = "&Scan"

// Reset the current working directory
lb_file.DirList(st_curr_path.Text + "\*.*",0)

tab_dir.tabpage_dw.dw_1.SetRedraw(True)
tab_dir.tabpage_tv.tv_1.SetRedraw(True)

end event

type lb_file from listbox within w_dir_tree
int X=1856
int Y=4
int Width=544
int Height=112
boolean Visible=false
boolean Border=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_dir from singlelineedit within w_dir_tree
int X=32
int Y=172
int Width=1714
int Height=92
boolean Border=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=77643992
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_dir_tree
int X=18
int Y=108
int Width=1769
int Height=172
string Text="Scanning Directory:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77643992
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_dir_tree
int X=1801
int Y=108
int Width=352
int Height=172
string Text="Drive:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=77643992
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

