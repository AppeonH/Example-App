$PBExportHeader$w_dwbuffers_filter.srw
$PBExportComments$Sheet to display the DataWindow Filter buffer
forward
global type w_dwbuffers_filter from w_dwbuffers_ancestor
end type
end forward

global type w_dwbuffers_filter from w_dwbuffers_ancestor
int X=1756
int Y=1
int Width=1121
int Height=429
boolean TitleBar=true
string Title="Buffer:  Filter"
long BackColor=79741120
end type
global w_dwbuffers_filter w_dwbuffers_filter

event ue_refresh;call w_dwbuffers_ancestor::ue_refresh;Long				ll_MaxRow
Integer			li_RC
DataWindow	ldw_1

// Set a local pointer to the primary DataWindow.
ldw_1 = w_dwbuffers_primary.dw_data

// Obtain the current count of rows in the filter buffer of the primary
// DataWindow.
ll_MaxRow = ldw_1.FilteredCount()

// Set the redraw of our DataWindow to false to avoid repainting
// and reset the DataWindow
dw_data.SetRedraw(False)
dw_data.Reset()

// If there are any rows in the filter buffer copy them into the
// DataWindow on this window.
If ll_MaxRow > 0 Then
	li_RC = ldw_1.RowsCopy(1, ldw_1.FilteredCount(), filter!, dw_data , 1, Primary!) 
End If

// Set the redraw back to true to force the datwindow to repaint.
dw_data.SetRedraw(True)
end event

event open;call w_dwbuffers_ancestor::open;This.Move(1790, 1)

end event

on w_dwbuffers_filter.create
call w_dwbuffers_ancestor::create
end on

on w_dwbuffers_filter.destroy
call w_dwbuffers_ancestor::destroy
end on

type dw_data from w_dwbuffers_ancestor`dw_data within w_dwbuffers_filter
int Width=1079
int Height=341
string DataObject="d_filter"
end type

