$PBExportHeader$w_dwbuffers_original.srw
$PBExportComments$Sheet to display the DataWindow Original buffer
forward
global type w_dwbuffers_original from w_dwbuffers_ancestor
end type
end forward

global type w_dwbuffers_original from w_dwbuffers_ancestor
int X=1756
int Y=1
int Width=1121
int Height=629
boolean TitleBar=true
string Title="Buffer:  Original"
long BackColor=79741120
end type
global w_dwbuffers_original w_dwbuffers_original

type variables
string i_dwbuffer_type
end variables

event open;call w_dwbuffers_ancestor::open;This.Move(1790, 860)
end event

event ue_refresh;call w_dwbuffers_ancestor::ue_refresh;String			ls_ModString, ls_Ret
Long				ll_MaxRow, ll_Cnt, ll_LoopCnt, ll_NewRow
DataWindow	ldw_1

// Column 4 is a dummy column used to hold the buffer the row is currently in 
ls_ModString = "#1.Color='0~tif(#4=~~~"delete~~~",255,if(#4=~~~"filter~~~",65280,0))'"
ls_Ret = dw_data.Modify(ls_ModString)
If ls_Ret <> "" Then
	MessageBox("Error", "Modify for Column 1 failed", Exclamation!)
End If 

ls_ModString = "#2.Color='0~tif(#4=~~~"delete~~~",255,if(#4=~~~"filter~~~",65280,0))'"
ls_Ret = dw_data.Modify(ls_ModString)
If ls_Ret <> "" Then
	MessageBox("Error", "Modify for Column 2 failed", Exclamation!)
End If 

ls_ModString = "#3.Color='0~tif(#4=~~~"delete~~~",255,if(#4=~~~"filter~~~",65280,0))'"
ls_Ret = dw_data.Modify(ls_ModString)
If ls_Ret <> "" Then
	MessageBox("Error", "Modify for Column 3 failed", Exclamation!)
End If 


// Populate from the primary buffer
ldw_1 = w_dwbuffers_primary.dw_data

ll_MaxRow = ldw_1.RowCount()
ll_LoopCnt = ll_MaxRow

dw_data.SetRedraw(False)
dw_data.Reset()

For ll_Cnt = 1 to ll_MaxRow
	Choose Case ldw_1.GetItemStatus(ll_Cnt, 0, primary!)
		Case New!, Newmodified!
			continue
	End Choose
	ll_NewRow = dw_data.InsertRow(0)
	dw_data.SetItem(ll_NewRow, 1, ldw_1.GetItemNumber 	(ll_Cnt, 1, primary!, True))
	dw_data.SetItem(ll_NewRow, 2, ldw_1.GetItemString	(ll_Cnt, 2, primary!, True))
	dw_data.SetItem(ll_NewRow, 3, ldw_1.GetItemNumber 	(ll_Cnt, 3, primary!, True))
	dw_data.SetItem(ll_NewRow, 4, "primary")
Next 

// populate from the delete buffer
ll_MaxRow =ldw_1.DeletedCount()
ll_LoopCnt += ll_MaxRow

For ll_Cnt = 1 to ll_MaxRow
	ll_NewRow = dw_data.InsertRow(0)
	dw_data.SetItem(ll_NewRow, 1, ldw_1.GetItemNumber(ll_Cnt, 1, delete!, False))
	dw_data.SetItem(ll_NewRow, 2, ldw_1.GetItemString(ll_Cnt, 2, delete!, False))
	dw_data.SetItem(ll_NewRow, 3, ldw_1.GetItemNumber(ll_Cnt, 3, delete!, False))
	dw_data.SetItem(ll_NewRow, 4, "delete")
Next 

// populate from the filter buffer
ll_MaxRow =ldw_1.FilteredCount()
ll_LoopCnt += ll_MaxRow

For ll_Cnt = 1 to ll_MaxRow
	Choose Case ldw_1.GetItemStatus(ll_Cnt, 0, filter!)
		Case New!, Newmodified!
			Continue
	End Choose
	ll_NewRow = dw_data.InsertRow(0)
	dw_data.SetItem(ll_NewRow, 1, ldw_1.GetItemNumber 	(ll_Cnt, 1, filter!, False))
	dw_data.SetItem(ll_NewRow, 2, ldw_1.GetItemString 	(ll_Cnt, 2, filter!, False))
	dw_data.SetItem(ll_NewRow, 3, ldw_1.GetItemNumber	(ll_Cnt, 3, filter!, False))
	dw_data.SetItem(ll_NewRow, 4, "filter")
Next 

dw_data.SetRedraw(True)

end event

on w_dwbuffers_original.create
call w_dwbuffers_ancestor::create
end on

on w_dwbuffers_original.destroy
call w_dwbuffers_ancestor::destroy
end on

type dw_data from w_dwbuffers_ancestor`dw_data within w_dwbuffers_original
int Width=1075
int Height=533
string DataObject="d_original"
end type

