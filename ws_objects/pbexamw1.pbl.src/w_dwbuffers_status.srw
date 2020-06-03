$PBExportHeader$w_dwbuffers_status.srw
$PBExportComments$Sheet to display the DataWindow Row/Column status
forward
global type w_dwbuffers_status from w_dwbuffers_ancestor
end type
end forward

global type w_dwbuffers_status from w_dwbuffers_ancestor
int X=1
int Y=981
int Width=1788
int Height=837
boolean TitleBar=true
string Title="Row/Column Status"
long BackColor=79741120
end type
global w_dwbuffers_status w_dwbuffers_status

type variables
long maxrow
end variables

forward prototypes
public function string of_rowstatus (datawindow adw_arg, long al_row, long al_col, string as_buffer)
end prototypes

public function string of_rowstatus (datawindow adw_arg, long al_row, long al_col, string as_buffer);dwItemStatus		ldis_Status

Choose Case Lower(as_buffer)
	Case "primary"
		ldis_Status = adw_Arg.GetItemStatus(al_Row, al_Col, PRIMARY!)
	Case "filter"
		ldis_Status = adw_Arg.GetItemStatus(al_Row, al_Col, FILTER!)
	Case "delete"
		ldis_Status = adw_Arg.GetItemStatus(al_Row, al_Col, DELETE!)
	Case Else
		Return "Error!"
End Choose

Choose Case ldis_Status
	Case notmodified!
		Return "NotModified!"

	Case datamodified!
		Return "DataModified!"

	Case new!
		Return "New!"

	Case newmodified!
		Return "NewModified!"

	Case Else
		Return "Error!"
End Choose

end function

event open;call w_dwbuffers_ancestor::open;This.Move(1, 650)
Post Event ue_refresh()

end event

event ue_refresh;call w_dwbuffers_ancestor::ue_refresh;Long		ll_RowCnt,  ll_ColCnt, ll_NewRow , ll_MaxRow
Integer	li_Start
String	ls_Ret, ls_ModString

dw_data.SetRedraw(False)
dw_data.Reset()

// Set row/column status from the Primary Buffer
ll_MaxRow  = w_dwbuffers_primary.dw_data.RowCount()

For ll_RowCnt = 1 To ll_MaxRow				// ll_RowCnt represents the rows in the filter buffer
	ll_NewRow = dw_data.InsertRow(0)		// ll_NewRow represents newly inserted rows in the status dw
	For ll_ColCnt = 0 To 3							// for each column, 0 = row status
		dw_data.SetItem(ll_NewRow, ll_ColCnt + 1, of_rowstatus(w_dwbuffers_primary.dw_data, ll_NewRow, ll_ColCnt, "primary"))
	Next
	
	// Attach the row id so the status window is easier to read.
	dw_data.SetItem(ll_NewRow, "row_id", w_dwbuffers_primary.dw_data.GetItemNumber(ll_RowCnt, 1))
Next

li_Start = ll_RowCnt

// Set row/column status from the Filter Buffer.  Append To Primary Buffer statuses
ll_MaxRow  =w_dwbuffers_filter.dw_data.RowCount()

For ll_RowCnt = 1 To ll_MaxRow				// ll_RowCnt represents the rows in the filter buffer
	ll_NewRow = dw_data.InsertRow(0)		// ll_NewRow represents newly inserted rows in the status dw
	For ll_ColCnt = 0 To 3							// for each column, 0 = row status
		dw_data.SetItem(ll_NewRow, ll_ColCnt + 1, of_rowstatus(w_dwbuffers_primary.dw_data, ll_RowCnt, ll_ColCnt, "filter"))
	Next
	dw_data.SetItem(ll_NewRow, "row_id", w_dwbuffers_filter.dw_data.GetItemNumber(ll_RowCnt, 1))
Next

// Change color of changed status
ls_ModString = "#1.Color=~"0~tif(#1=~~~"DataModified!~~~" or #1=~~~"NewModified!~~~", 255,0)~""
ls_Ret = dw_data.Modify(ls_ModString)
If ls_Ret <> "" Then
	MessageBox("Modify Error #1", ls_Ret)
End If

ls_ModString = "#2.Color=~"0~tif(#2=~~~"DataModified!~~~" or #2=~~~"NewModified!~~~", 255,0)~""
ls_Ret = dw_data.Modify(ls_ModString)
If ls_Ret <> "" Then
	MessageBox("Modify Error #2", ls_Ret)
End If

ls_ModString = "#3.Color=~"0~tif(#3=~~~"DataModified!~~~" or #3=~~~"NewModified!~~~", 255,0)~""
ls_Ret = dw_data.Modify(ls_ModString)
If ls_Ret <> "" Then
	MessageBox("Modify Error #3", ls_Ret)
End If

ls_ModString = "#4.Color=~"0~tif(#4=~~~"DataModified!~~~" or #4=~~~"NewModified!~~~", 255,0)~""
ls_Ret = dw_data.Modify(ls_ModString)
If ls_Ret <> "" Then
	MessageBox("Modify Error #4", ls_Ret)
End If

dw_data.SetRedraw(True)

end event

on w_dwbuffers_status.create
call w_dwbuffers_ancestor::create
end on

on w_dwbuffers_status.destroy
call w_dwbuffers_ancestor::destroy
end on

type dw_data from w_dwbuffers_ancestor`dw_data within w_dwbuffers_status
int Width=1751
int Height=745
string DataObject="d_statuses"
end type

