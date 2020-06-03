$PBExportHeader$w_employee_xfer.srw
$PBExportComments$Example of updating a TreeView using drag and drop
forward
global type w_employee_xfer from w_center
end type
type cb_update from commandbutton within w_employee_xfer
end type
type cb_help from commandbutton within w_employee_xfer
end type
type tv_1 from treeview within w_employee_xfer
end type
type st_4 from statictext within w_employee_xfer
end type
type st_2 from statictext within w_employee_xfer
end type
type st_1 from statictext within w_employee_xfer
end type
type cb_cancel from commandbutton within w_employee_xfer
end type
type str_empxfers from structure within w_employee_xfer
end type
end forward

type str_empxfers from structure
	integer		i_empid
	integer		i_newdept
end type

global type w_employee_xfer from w_center
integer x = 146
integer y = 4
integer width = 1737
integer height = 1900
string title = "Employee Transfer"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
event ue_populate ( )
cb_update cb_update
cb_help cb_help
tv_1 tv_1
st_4 st_4
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
end type
global w_employee_xfer w_employee_xfer

type variables
Public:
Boolean	ib_Changed
Long	il_DragSource, il_DragParent, il_DropTarget
DataStore	ids_Source

Private:
/*  Object Structure references must be
     declared as private  */
str_empxfers	istr_PendingXfers[]

end variables

event ue_populate;TreeViewItem		ltvi_Item

SetPointer(HourGlass!)

// Add a root for each department
ltvi_Item.label = "R & D"
ltvi_Item.data = 100
ltvi_Item.pictureindex = 1
ltvi_Item.selectedpictureindex = 7
ltvi_Item.children = True
tv_1.InsertItemLast(0, ltvi_Item)

ltvi_Item.label = "Sales"
ltvi_Item.data = 200
ltvi_Item.pictureindex = 2
tv_1.InsertItemLast(0, ltvi_Item)

ltvi_Item.label = "Finance"
ltvi_Item.data = 300
ltvi_Item.pictureindex = 3
tv_1.InsertItemLast(0, ltvi_Item)

ltvi_Item.label = "Marketing"
ltvi_Item.data = 400
ltvi_Item.pictureindex = 4
tv_1.InsertItemLast(0, ltvi_Item)

ltvi_Item.label = "Shipping"
ltvi_Item.data = 500
ltvi_Item.pictureindex = 5
tv_1.InsertItemLast(0, ltvi_Item)

end event

on w_employee_xfer.create
int iCurrent
call super::create
this.cb_update=create cb_update
this.cb_help=create cb_help
this.tv_1=create tv_1
this.st_4=create st_4
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_update
this.Control[iCurrent+2]=this.cb_help
this.Control[iCurrent+3]=this.tv_1
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_cancel
end on

on w_employee_xfer.destroy
call super::destroy
destroy(this.cb_update)
destroy(this.cb_help)
destroy(this.tv_1)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
end on

event open;call super::open;ids_Source = Create DataStore

ids_Source.DataObject = "d_emp_by_dept"
ids_Source.SetTransObject(sqlca)

Post Event ue_populate()

end event

event close;Destroy ids_Source

Show(w_main)

end event

event resize;tv_1.Height = newheight - 25

end event

type cb_update from commandbutton within w_employee_xfer
integer x = 1152
integer y = 292
integer width = 338
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Update"
end type

event clicked;Integer	li_Cnt, li_Xfers

// Save all changes
li_Xfers = UpperBound(istr_PendingXfers)

For li_Cnt = 1 To li_Xfers
	UPDATE "employee"  
	      SET "dept_id" = :istr_PendingXfers[li_Cnt].i_NewDept  
	 WHERE "employee"."emp_id" = :istr_PendingXfers[li_Cnt].i_EmpID   ;
	If sqlca.sqlcode <> 0 Then
		MessageBox("Update Error", "Error updating employees:  " + String(sqlca.sqlcode) + &
							" - " + sqlca.sqlerrtext, Exclamation!)
		Rollback;
	End If
Next

Commit;

Close(Parent)

end event

type cb_help from commandbutton within w_employee_xfer
integer x = 1152
integer y = 580
integer width = 338
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Help"
end type

event clicked;f_open_help("w_employee_xfer")

end event

type tv_1 from treeview within w_employee_xfer
integer y = 4
integer width = 937
integer height = 1776
integer taborder = 30
boolean dragauto = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean disabledragdrop = false
string picturename[] = {"Custom041!","Custom067!","Custom048!","Custom075!","Custom085!","Custom076!","Custom050!"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 553648127
end type

event begindrag;TreeViewItem		ltvi_Source

GetItem(handle, ltvi_Source)

// Make sure only employees are being dragged
If ltvi_Source.Level <> 2 Then
	This.Drag(Cancel!)
Else
	// Save the handle of the item that is being dragged and its parent (department)
	il_DragSource = handle
	il_DragParent = FindItem(ParentTreeItem!, handle)
End If

end event

event dragwithin;TreeViewItem		ltvi_Over

If GetItem(handle, ltvi_Over) = -1 Then
	SetDropHighlight(0)
	il_DropTarget = 0
	Return
End If

If ltvi_Over.level = 1 Then
	// Highlight the department to be dropped on, if not the employee's current dept.
	If handle <> il_DragParent Then
		SetDropHighlight(handle)
		il_DropTarget = handle
	Else
		SetDropHighlight(0)
		il_DropTarget = 0
	End If
Else
	// Drop target is this item's parent
	il_DropTarget = FindItem(ParentTreeItem!, handle)
	If il_DropTarget <> il_DragParent Then
		SetDropHighlight(il_DropTarget)
	Else
		SetDropHighlight(0)
		il_DropTarget = 0
	End If
End If

end event

event dragdrop;Integer				li_Pending
Long					ll_NewItem
TreeViewItem		ltvi_Target, ltvi_Source, ltvi_Parent, ltvi_New

If GetItem(il_DropTarget, ltvi_Target) = -1 Then Return
If GetItem(il_DragSource, ltvi_Source) = -1 Then Return

// Only allow dropping an employee on a department
//If ltvi_Target.Level <> 1 Or ltvi_Source.Level <> 2 Then Return

// Verify move
GetItem(il_DragParent, ltvi_Parent)
If MessageBox("Transfer Employee", "Are you sure you want to transfer " + &
						ltvi_Source.Label + " from " + ltvi_Parent.label + " to " + ltvi_Target.label + &
						"?", Question!, YesNo!) = 2 Then Return

// Update the employee's department
li_Pending = UpperBound(istr_PendingXfers) + 1
istr_PendingXfers[li_Pending].i_EmpID = ltvi_Source.Data
istr_PendingXfers[li_Pending].i_NewDept = ltvi_Target.Data

// Move the item
// First delete the first item from the TreeView
DeleteItem(il_DragSource)

// Insert the item under the proper parent
SetNull(ltvi_Source.ItemHandle)
ll_NewItem = InsertItemSort(il_DropTarget, ltvi_Source)

/*  Turn off drop highlighting  */
this.SetDropHighlight (0)

// Select the new item
SelectItem(ll_NewItem)

end event

event itempopulate;Integer				li_Rows, li_Cnt
TreeViewItem		ltvi_Dept, ltvi_Emp

If GetItem(handle, ltvi_Dept) = -1 Then Return

SetPointer(HourGlass!)

// Populate the department with its employees
ids_Source.Reset()
li_Rows = ids_Source.Retrieve(Integer(ltvi_Dept.data))

ltvi_Emp.pictureindex = 6
ltvi_Emp.selectedpictureindex = 6
ltvi_Emp.children = false

For li_Cnt = 1 To li_Rows
	ltvi_Emp.label = ids_Source.Object.emp_name[li_Cnt]
	ltvi_Emp.data = ids_Source.Object.emp_id[li_Cnt]
	InsertItemSort(handle, ltvi_Emp)
Next

end event

type st_4 from statictext within w_employee_xfer
integer x = 1024
integer y = 164
integer width = 425
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 67109072
boolean enabled = false
string text = "new department."
boolean focusrectangle = false
end type

type st_2 from statictext within w_employee_xfer
integer x = 1024
integer y = 96
integer width = 695
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 67109072
boolean enabled = false
string text = "and drop an employee on the"
boolean focusrectangle = false
end type

type st_1 from statictext within w_employee_xfer
integer x = 1024
integer y = 20
integer width = 645
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 67109072
boolean enabled = false
string text = "To perform a transfer, drag"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_employee_xfer
integer x = 1152
integer y = 404
integer width = 338
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)

end event

