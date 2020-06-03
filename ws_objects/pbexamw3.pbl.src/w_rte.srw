$PBExportHeader$w_rte.srw
$PBExportComments$RichPad RTE control
forward
global type w_rte from w_center
end type
type rte_1 from richtextedit within w_rte
end type
end forward

global type w_rte from w_center
int X=1
int Y=5
int Width=2894
int Height=1797
boolean TitleBar=true
string Title="untitled - Richpad"
string MenuName="m_rte"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
rte_1 rte_1
end type
global w_rte w_rte

type variables
String	is_FindNext, is_FileName = "Untitled"
Boolean	ib_HeadFoot, ib_DataSource
DataStore ids_Customer
end variables

forward prototypes
public function integer of_open ()
public function integer of_print ()
public function integer of_save ()
public function integer of_saveas ()
public function integer of_cut ()
public function integer of_copy ()
public function integer of_paste ()
public function integer of_delete ()
public function integer of_selectall ()
public function integer of_find ()
public function integer of_findnext ()
public function integer of_timedate ()
public function boolean of_canundo ()
public function integer of_undo ()
public function integer of_printpreview ()
public function boolean of_isprintpreview ()
public function integer of_replace ()
public function integer of_send ()
public subroutine of_insert_datafield (string as_Column)
public function integer of_setfind (string as_find)
public function boolean of_showhf (boolean ab_query)
public function integer of_new ()
end prototypes

public function integer of_open ();String	ls_File, ls_Path
Integer	li_RC

If rte_1.modified Then
	li_RC = MessageBox("Richpad", "The Text in " + is_FileName + &
								" has changed.~r~nDo you want to save the changes?", &
								Question!, YesNoCancel!)

	Choose Case li_RC
		Case 1
			This.of_save()
		Case 3
			Return 0
	End Choose
End If

If GetFileOpenName("Select File", ls_Path, ls_File, "rtf", "Rich Text (*.rtF), *.rtf") = 1 Then
	is_FileName = ls_Path
	rte_1.insertdocument(is_FileName, True, FileTypeRichText!)
	This.Title = ls_File + " - Richpad"
	rte_1.modified = False
	Return 1
Else
	Return 0
End If

end function

public function integer of_print ();Return rte_1.print(1, "", True, True)

end function

public function integer of_save ();If is_FileName = "Untitled" Then
	Return of_saveas()
Else
	rte_1.modified = False
	Return rte_1.savedocument(is_FileName, FileTypeRichText!)
End If
end function

public function integer of_saveas ();String	ls_File, ls_Path

ls_Path = is_FileName

If GetFileSaveName("Select File", ls_Path, ls_File, "rtf", "Rich Text (*.rtf), *.rtf") = 1 Then
	is_FileName = ls_Path
	This.Title = ls_File + " - Richpad"
	
	Return This.of_save()
Else
	Return 0
End If

end function

public function integer of_cut ();Return rte_1.cut()

end function

public function integer of_copy ();Return rte_1.copy()

end function

public function integer of_paste ();Return rte_1.paste()

end function

public function integer of_delete ();Return rte_1.clear()

end function

public function integer of_selectall ();Return rte_1.selecttextall()

end function

public function integer of_find ();OpenWithParm(w_rte_find, rte_1)

Return 1

end function

public function integer of_findnext ();If is_FindNext = "" Then
	of_find()
Else
	rte_1.findnext()
End If

Return 0

end function

public function integer of_timedate ();DateTime	ldt_Now

ldt_Now = DateTime(Today(), Now())

rte_1.replacetext(String(ldt_Now, "mm/dd/yy hh:mm:ss"))

Return 1

end function

public function boolean of_canundo ();Return rte_1.canundo()

end function

public function integer of_undo ();Return rte_1.Undo()

end function

public function integer of_printpreview ();Boolean		lb_Preview

if rte_1.ispreview() Then 
	lb_Preview = False
Else
	lb_Preview = True
End If

Return rte_1.preview(lb_Preview)

end function

public function boolean of_isprintpreview ();Return rte_1.ispreview() 

end function

public function integer of_replace ();OpenWithParm(w_rte_replace, rte_1)

Return 1

end function

public function integer of_send ();mailSession mSes
mailMessage mMsg
mailReturnCode mRet
mailFileDescription mAttach

// Create a mail session.
This.Enabled = False

mSes = CREATE mailSession

// Log on to the session
mRet = mSes.mailLogon(mailNewSession!)
If mRet <> mailReturnSuccess! Then
	This.Enabled = True
	MessageBox("RichPad", "Logon to mail failed.")
	Return 0
End If

mAttach.filename = is_FileName

mMsg.AttachmentFile[1] = mAttach
mRet = mSes.mailAddress(mMsg)
If mRet <> mailReturnSuccess! Then
	MessageBox("RichPad", "Mail addressing failed.")
Else
	// Send the mail
	mRet = mSes.mailSend(mMsg)
End If

mSes.mailLogoff()

DESTROY mSes

This.Enabled = True

Return 1

end function

public subroutine of_insert_datafield (string as_Column);// This function will insert a datafield into the current document.

// Determine if the DataStore has already been retrieved.
If ids_Customer.RowCount() <= 0 Then
	ids_Customer.SetTransObject(sqlca)
	
	If ids_Customer.Retrieve() <= 0 Then
		Return
	End If
End If

// Insert the data field.
rte_1.inputfieldinsert(as_Column)

// Set the DataStore as the RTE's data source if not already done.
If Not ib_DataSource Then
	rte_1.datasource(ids_Customer)
	ib_DataSource = True
End If

end subroutine

public function integer of_setfind (string as_find);is_FindNext = as_Find

Return 1

end function

public function boolean of_showhf (boolean ab_query);If ab_Query Then Return ib_HeadFoot

If ib_HeadFoot Then
	ib_HeadFoot = False
Else
	ib_HeadFoot = True
End If

rte_1.showheadfoot(ib_HeadFoot)

Return ib_HeadFoot

end function

public function integer of_new ();String	ls_File, ls_Path
Integer	li_RC

If rte_1.modified Then
	li_RC = MessageBox("Richpad", "The Text in " + is_FileName + &
								" has changed.~r~nDo you want to save the changes?", &
								Question!, YesNoCancel!)

	Choose Case li_RC
		Case 1
			This.of_save()
		Case 3
			Return 0
	End Choose
End If

// Display empty rte
rte_1.SetRedraw(False)

of_selectall()
of_delete()
is_FileName = "Untitled"
This.Title = "Untitled - Richpad"
rte_1.modified = False

rte_1.SetRedraw(True)

Return 1

end function

on w_rte.create
if this.MenuName = "m_rte" then this.MenuID = create m_rte
this.rte_1=create rte_1
this.Control[]={ this.rte_1}
end on

on w_rte.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rte_1)
end on

event resize;rte_1.Resize(newwidth - (rte_1.X * 2), newheight - (rte_1.Y * 2))

end event

event open;call super::open;ids_Customer = CREATE DataStore
ids_Customer.DataObject = "d_cust"

end event

event close;Show(w_main)

end event

event closequery;Integer	li_RC

If rte_1.modified Then
	li_RC = MessageBox("Richpad", "The Text in " + is_FileName + &
								" has changed.~r~nDo you want to save the changes?", &
								Question!, YesNoCancel!)

	Choose Case li_RC
		Case 1
			This.of_save()
			Return 0
		Case 2
			Return 0
		Case 3
			Return 1
	End Choose
End If

end event

type rte_1 from richtextedit within w_rte
int Width=2433
int Height=1061
int TabOrder=10
end type

on rte_1.create
HScrollBar=true
VScrollBar=true
HeaderFooter=true
PopMenu=true
RulerBar=true
TabBar=true
ToolBar=true
WordWrap=true
UndoDepth=100
BackColor=16777215
InputFieldBackColor=16777215
end on

