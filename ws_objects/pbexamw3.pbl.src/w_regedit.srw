$PBExportHeader$w_regedit.srw
$PBExportComments$Registry Editor
forward
global type w_regedit from w_center
end type
type lv_vals from listview within w_regedit
end type
type tv_reg from treeview within w_regedit
end type
end forward

global type w_regedit from w_center
integer width = 2930
integer height = 1820
string title = "Registry Editor"
string menuname = "m_regedit"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event ue_addroots ( )
event ue_addkey ( )
event ue_addvalue ( )
event ue_refresh ( )
lv_vals lv_vals
tv_reg tv_reg
end type
global w_regedit w_regedit

type variables
Long il_Bad, il_Good, il_Root[6]
end variables

forward prototypes
public function string of_get_key (long al_handle)
public subroutine of_copy_registry_entries (string as_sourcekey, string as_newkey)
end prototypes

event ue_addroots;// Add Root keys to the TreeView control

String				ls_Keys[]
Long					ll_Handle
TreeViewItem		ltvi_Item

SetPointer(HourGlass!)

// Add columns to the ListView control
lv_vals.AddColumn("Name", Left!, 600)
lv_vals.AddColumn("Name", Left!, 1500)

// There is always at least one entry in the Registry
// Windows 3.1 will have only this root
ltvi_Item.Label = "HKEY_CLASSES_ROOT"
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = 2
ltvi_Item.Children = True
il_Root[1] = tv_reg.InsertItemLast(0, ltvi_Item)

// Windows 95 and Windows NT will have these four
// additional roots
If (ge_Environment.OSType = Windowsnt!) Or &
	(ge_Environment.OSType = Windows! And &
	(ge_Environment.OSMajorRevision = 4 Or ge_Environment.OSMinorRevision = 95)) Then

	ltvi_Item.Label = "HKEY_CURRENT_USER"
	il_Root[2] = tv_reg.InsertItemLast(0, ltvi_Item)

	ltvi_Item.Label = "HKEY_LOCAL_MACHINE"
	il_Root[3] = tv_reg.InsertItemLast(0, ltvi_Item)

	ltvi_Item.Label = "HKEY_USERS"
	il_Root[4] = tv_reg.InsertItemLast(0, ltvi_Item)

	ltvi_Item.Label = "HKEY_CURRENT_CONFIG"
	il_Root[5] = tv_reg.InsertItemLast(0, ltvi_Item)

	ltvi_Item.Label = "HKEY_DYN_DATA"
	il_Root[6] = tv_reg.InsertItemLast(0, ltvi_Item)
	
	// expand branches to get to Code Examples entries
	tv_reg.ExpandItem(il_Root[2])
	ll_Handle = tv_reg.FindItem(ChildTreeItem!, il_Root[2])
	Do
		tv_reg.GetItem(ll_Handle, ltvi_Item)
		If Lower(ltvi_Item.Label) <> "software" Then
			ll_Handle = tv_reg.FindItem(NextTreeItem!, ll_Handle)
		End if
	Loop Until Lower(ltvi_Item.Label) = "software"
	
	tv_reg.ExpandItem(ll_Handle)
	ll_Handle = tv_reg.FindItem(ChildTreeItem!, ll_Handle)
	Do
		tv_reg.GetItem(ll_Handle, ltvi_Item)
		If Lower(ltvi_Item.Label) <> "sybase" Then
			ll_Handle = tv_reg.FindItem(NextTreeItem!, ll_Handle)
		End if
	Loop Until Lower(ltvi_Item.Label) = "sybase"
	tv_reg.SelectItem(ll_Handle)
	tv_reg.ExpandItem(ll_Handle)
		
End if

end event

event ue_addkey;// Add a key to the registry

Long					ll_Parent, ll_New
TreeViewItem		ltvi_Parent, ltvi_New

// Add the sub-key under the current key
ll_Parent = tv_reg.FindItem(CurrentTreeItem!, 0)
tv_reg.GetItem(ll_Parent, ltvi_Parent)

If Not ltvi_Parent.Children Then
	ltvi_Parent.Children = True
	tv_reg.SetItem(ll_Parent, ltvi_Parent)
End If

// The default name is "New Key 1", put the treeview in
// label edit mode to allow the user to change it.
ltvi_New.Label = "New Key 1"
ltvi_New.PictureIndex = 1
ltvi_New.SelectedPictureIndex = 2
ltvi_New.Children = False
ll_New = tv_reg.InsertItemLast(ll_Parent, ltvi_New)

tv_reg.ExpandItem(ll_Parent)

tv_reg.EditLabel(ll_New)

// The key will be actually added to the registry in the
// EndLabelEdit event of the TreeView

end event

event ue_addvalue;// Add a new value to the registry

Integer	li_Index

// The defalut value name is "New Value", put the listview in
// label edit mode to allow the user to change it.
li_Index = lv_vals.AddItem("New Value" + "~t~"" + "~"", 0)
lv_vals.SetFocus()
lv_vals.EditLabel(li_Index)

// The value will be actually added to the registry in the
// EndLabelEdit event of the ListView

end event

event ue_refresh;// Refresh the display

Integer	li_Cnt

tv_reg.SelectItem(0)

For li_Cnt = 1 To 6
	tv_reg.DeleteItem(il_Root[li_Cnt])
Next

Post Event ue_addroots()

end event

public function string of_get_key (long al_handle);String				ls_Key
Long					ll_Parent
TreeViewItem		ltvi_Item

tv_reg.GetItem(al_Handle, ltvi_Item)

ls_Key = ltvi_Item.Label

If ltvi_Item.Level >= 2 Then
	ll_Parent = tv_reg.FindItem(ParentTreeItem!, al_Handle)
	ls_Key = of_get_key(ll_Parent) + "\" + ls_Key
End if

Return ls_Key

end function

public subroutine of_copy_registry_entries (string as_sourcekey, string as_newkey);Integer	li_Cnt, li_Entries, li_Keys
String	ls_Entries[], ls_Keys[], ls_Value

// Copy all the Registry entries and values for this key
RegistryValues(as_SourceKey, ls_Entries)
li_Entries = UpperBound(ls_Entries)
If li_Entries > 0 Then
	// The new key is added when the first entry is added
	For li_Cnt = 1 To li_Entries
		RegistryGet(as_SourceKey, ls_Entries[li_Cnt], ls_Value)
		RegistrySet(as_NewKey, ls_Entries[li_Cnt], ls_Value)
	Next

Else
	// Add the new key
	// PowerBuilder requires an entry and value be added when a
	// key is added.  So add a dummy entry, the delete it.
	RegistrySet(as_NewKey, "Dummy", "")
	RegistryDelete(as_NewKey, "Dummy")
End if

// Get all the keys under this one
RegistryKeys(as_SourceKey, ls_Keys)

li_Keys = UpperBound(ls_Keys)
For li_Cnt = 1 To li_Keys
	// Call this function recurrsively for each sub-key
	of_copy_registry_entries(as_SourceKey + "\" + ls_Keys[li_Cnt], &
										as_NewKey + "\" + ls_Keys[li_Cnt])
Next

end subroutine

event open;call super::open;this.PostEvent ( "ue_addroots" )
end event

on w_regedit.create
int iCurrent
call super::create
if this.MenuName = "m_regedit" then this.MenuID = create m_regedit
this.lv_vals=create lv_vals
this.tv_reg=create tv_reg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_vals
this.Control[iCurrent+2]=this.tv_reg
end on

on w_regedit.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lv_vals)
destroy(this.tv_reg)
end on

event close;Show(w_main)

end event

type lv_vals from listview within w_regedit
event ue_delete ( )
event ue_rename ( )
integer x = 1129
integer y = 8
integer width = 1719
integer height = 1620
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean buttonheader = false
boolean editlabels = true
listviewview view = listviewreport!
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 12632256
integer smallpicturewidth = 16
integer smallpictureheight = 16
long smallpicturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event ue_delete;// Delete a registry entry

Integer			li_Index
String			ls_Key
ListViewItem	llvi_Item

li_Index = This.SelectedIndex()
If li_Index < 1 Then Return

This.GetItem(li_Index, llvi_Item)

// Get the fully-qualified key for this entry
ls_Key = tv_reg.Trigger Event ue_get_current_key()

If MessageBox("Delete Entry", "Are you sure you want to delete the Registry Entry for:  " + llvi_Item.Label, &
						Question!, YesNo!, 2) = 2 Then Return

// Delete the entry
RegistryDelete(ls_Key, llvi_Item.Label)

// Delete the ListView item
This.DeleteItem(li_Index)

end event

event ue_rename;// Rename a registry entry

Integer	li_Index

li_Index = This.SelectedIndex()
If li_Index < 1 Then Return

This.EditLabel(li_Index)

end event

event endlabeledit;// Change Registry Entry

String	ls_OldLabel, ls_Key, ls_Value

// Check if label was changed
If IsNull(newlabel) Then Return

// Get the old label and value
This.GetItem(index, 1, ls_OldLabel)

If ls_OldLabel = newlabel Then Return

ls_Key = tv_reg.Trigger Event ue_get_current_key()

RegistryGet(ls_Key, ls_OldLabel, ls_Value)

// Add the new label
RegistrySet(ls_Key, newlabel, ls_Value)

// Delete the old label
RegistryDelete(ls_Key, ls_OldLabel)

end event

event doubleclicked;// Modify the value for this entry

String		ls_Label, ls_Data, ls_Key

If index <= 0 Then Return

This.GetItem(index, 1, ls_Label)
This.GetItem(index, 2, ls_Data)

// Remove " from the data (used for display only)
ls_Data = Mid(ls_Data, 2, (Len(ls_Data) - 2))

OpenWithParm(w_reg_update_value, ls_Label + "~t" + ls_Data)
ls_Data = Message.StringParm

If Not IsNull(ls_Data) Then
	ls_Key = tv_reg.Trigger Event ue_get_current_key()
	RegistrySet(ls_Key, ls_Label, ls_Data)
	
	// Place " around the data for display
	This.SetItem(index, 2, "~"" + ls_Data + "~"")
End if

end event

type tv_reg from treeview within w_regedit
event ue_delete ( )
event ue_rename ( )
event type string ue_get_current_key ( )
integer x = 5
integer y = 8
integer width = 1097
integer height = 1620
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean editlabels = true
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"Custom039!","Custom050!"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event ue_delete;// Delete a registry key

String				ls_Key
Long					ll_Item
TreeViewItem		ltvi_Item

ll_Item = This.FindItem(CurrentTreeItem!, 0)
If This.GetItem(ll_Item, ltvi_Item) <> 1 Then Return

If Not ltvi_Item.Selected Then This.SelectItem(ll_Item)

ls_Key = of_get_key(ll_Item)

If MessageBox("Delete Key", "Are you sure you want to delete the Registry Key:  " + ls_Key, &
						Question!, YesNo!, 2) = 2 Then Return

// Delete the key
RegistryDelete(ls_Key, "")

// Delete the TreeViewItem
This.DeleteItem(ll_Item)

end event

event ue_rename;// Rename a registry key

Long					ll_Item

ll_Item = This.FindItem(CurrentTreeItem!, 0)
If ll_Item = -1 Then Return

This.EditLabel(ll_Item)

end event

event ue_get_current_key;// Find the current selected key

Long					ll_Item

ll_Item = This.FindItem(CurrentTreeItem!, 0)
If ll_Item =  -1 Then Return ""

Return of_get_key(ll_Item)

end event

event itempopulate;String				ls_Values[], ls_Value
String				ls_SubKeys[], ls_Key
Integer				li_Cnt, li_Keys
Integer				li_Vals, li_CntV
TreeViewItem		ltvi_Item, ltvi_New

// Get the fully-qualified key for the item being populated
ls_Key = of_get_key(handle)

// Get all the sub-keys for this key
RegistryKeys(ls_Key, ls_SubKeys)
li_Keys = UpperBound(ls_SubKeys)

If li_Keys = 0 Then
	This.GetItem(handle, ltvi_Item)
	ltvi_Item.Children = False
	This.SetItem(handle, ltvi_Item)

Else
	// Add all the sub-keys to the TreeView
	For li_Cnt = 1 To li_Keys
		ltvi_New.Label = ls_SubKeys[li_Cnt]
		ltvi_New.PictureIndex = 1
		ltvi_New.SelectedPictureIndex = 2
		ltvi_New.Children = True
		This.InsertItemSort(handle, ltvi_New)
	Next
End if

end event

event selectionchanged;// Fill the ListView control with the entries for this key

String				ls_Values[], ls_Key, ls_Value
Integer				li_Cnt, li_Vals

SetPointer(Hourglass!)

// Empty the ListView
lv_vals.DeleteItems()

// Get the fully-qualified key for this TreeView item
ls_Key = of_get_key(newhandle)

// Get all registry entries
RegistryValues(ls_Key, ls_Values)
li_Vals = UpperBound(ls_Values)

For li_Cnt = 1 To li_Vals
	// For each entry, get its value
	// Windows allows String, Double-Word and Binary
	// values in the registy.  But PowerBuilder only supports 
	// String values, so skip all but Strings.
	ls_Value = "*"
	RegistryGet(ls_Key, ls_Values[li_Cnt], ls_Value)
	If ls_Value <> "*" Then
		// Add the value to the ListView
		// Place " around the value for display
		lv_vals.AddItem(ls_Values[li_Cnt] + "~t~"" + ls_Value + "~"", 0)
	End if
Next

lv_vals.Sort(ascending!)

end event

event endlabeledit;// Rename a registry key

String	ls_OldKey, ls_NewKey
Long		ll_Parent

// Check if label was changed
If IsNull(newtext) Then Return

// Build the fully-qualified old and new keys
ls_OldKey = of_get_key(handle)

ll_Parent = This.FindItem(ParentTreeitem!, handle)
ls_NewKey = of_get_key(ll_Parent) + "\" + newtext

If ls_OldKey = ls_NewKey Then Return

// Copy all entries for the old key to the new key
of_copy_registry_entries(ls_OldKey, ls_NewKey)

// Delete the old key
RegistryDelete(ls_OldKey, "")

tv_reg.SelectItem(handle)
Post Event SelectionChanged(0, handle)

end event

