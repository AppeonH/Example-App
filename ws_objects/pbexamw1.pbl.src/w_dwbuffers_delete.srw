$PBExportHeader$w_dwbuffers_delete.srw
$PBExportComments$Sheet to display the DataWindow Delete buffer
forward
global type w_dwbuffers_delete from w_dwbuffers_ancestor
end type
end forward

global type w_dwbuffers_delete from w_dwbuffers_ancestor
int X=1756
int Y=733
int Width=1121
int Height=429
boolean TitleBar=true
string Title="Buffer:  Delete"
long BackColor=79741120
end type
global w_dwbuffers_delete w_dwbuffers_delete

event open;call w_dwbuffers_ancestor::open;// Position this window appropriately on the frame window.
This.Move(1790,430)
end event

event ue_refresh;call w_dwbuffers_ancestor::ue_refresh;Long				ll_MaxRow
Integer			li_RC
DataWindow	ldw_1

// Set a local pointer to the DataWindow 
// that exists on the primary DataWindow.
ldw_1 = w_dwbuffers_primary.dw_data

// Set the number of deleted rows in the delete buffer
// for the primary DataWindow.  Set the redraw for the DataWindow
// False to avoid flicker and reset the DataWindow that exists on 
// this window.
ll_MaxRow =ldw_1.DeletedCount()
dw_data.SetRedraw(False)
dw_data.Reset()

// Use the RowsCopy function to copy the rows from the
// deleted buffer in the primary DataWindow into the DataWindow
// on this window.
If ll_MaxRow > 0 Then
	li_RC= ldw_1.RowsCopy(1, ldw_1.DeletedCount(), Delete!, This.dw_data, 1, Primary!)
End If

// Set redraw back to True so that the DataWindow repaints.
dw_data.SetRedraw(True)

end event

on w_dwbuffers_delete.create
call w_dwbuffers_ancestor::create
end on

on w_dwbuffers_delete.destroy
call w_dwbuffers_ancestor::destroy
end on

type dw_data from w_dwbuffers_ancestor`dw_data within w_dwbuffers_delete
int Width=1079
int Height=333
string DataObject="d_delete"
end type

