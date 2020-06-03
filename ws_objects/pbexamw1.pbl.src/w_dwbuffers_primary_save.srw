$PBExportHeader$w_dwbuffers_primary_save.srw
$PBExportComments$Sheet to display the DataWindow (represents the Primary buffer)
forward
global type w_dwbuffers_primary_save from w_dwbuffers_ancestor
end type
end forward

global type w_dwbuffers_primary_save from w_dwbuffers_ancestor
int X=0
int Y=0
int Width=1783
int Height=652
boolean TitleBar=true
string Title="Buffer:  Primary"
long BackColor=79741120
event ue_filter ( )
end type
global w_dwbuffers_primary_save w_dwbuffers_primary_save

type variables
long i_rowcount = 0
end variables

forward prototypes
public subroutine of_refreshdeletewindow ()
public subroutine of_refreshfilterwindow ()
public subroutine of_refreshoriginalwindow ()
public subroutine of_refreshstatuswindow ()
end prototypes

event ue_filter;call w_dwbuffers_ancestor::ue_filter;String	ls_Null

SetNull(ls_Null)

dw_data.SetFilter(ls_Null)
dw_data.Filter()

// Refresh all the windows
of_refreshdeletewindow()
of_refreshfilterwindow()
of_refreshoriginalwindow()
of_refreshstatuswindow()

end event

public subroutine of_refreshdeletewindow ();// Refresh the delete buffer window
If IsValid(w_dwbuffers_delete) Then
	w_dwbuffers_delete.Post Event ue_refresh()
End If

end subroutine

public subroutine of_refreshfilterwindow ();// Refresh the filter buffer window
If IsValid(w_dwbuffers_filter) Then
	w_dwbuffers_filter.Post Event ue_refresh()
End If

end subroutine

public subroutine of_refreshoriginalwindow ();// Refresh the original window
If IsValid(w_dwbuffers_original) Then
	w_dwbuffers_original.Post Event ue_refresh()
End If

end subroutine

public subroutine of_refreshstatuswindow ();// Refresh the status window
If IsValid(w_dwbuffers_status) Then
	w_dwbuffers_status.Post Event ue_refresh()
End If

end subroutine

event ue_retrieve;call super::ue_retrieve;dw_data.Reset()
dw_data.Retrieve()

// Refresh all the windows
of_refreshdeletewindow()
of_refreshfilterwindow()
of_refreshoriginalwindow()
of_refreshstatuswindow()

end event

event ue_insert;call w_dwbuffers_ancestor::ue_insert;Long		ll_Row

ll_Row = dw_data.InsertRow(0)
dw_data.ScrollToRow(ll_Row)

of_refreshstatuswindow()

end event

event ue_delete;call w_dwbuffers_ancestor::ue_delete;dw_data.DeleteRow(0)

// Refresh all the windows
of_refreshdeletewindow()
of_refreshfilterwindow()
of_refreshoriginalwindow()
of_refreshstatuswindow()

end event

event ue_update;call w_dwbuffers_ancestor::ue_update;If dw_data.Update(true, False) = 1 Then
	
	// Refresh all the windows
	of_refreshdeletewindow()
	of_refreshfilterwindow()
	of_refreshoriginalwindow()
	of_refreshstatuswindow()
	If m_dwbuffers.m_options.m_resetflags.Checked Then
		dw_data.ResetUpdate()
	End If
	
	Commit;

Else
	Rollback;
End If

end event

event open;call w_dwbuffers_ancestor::open;This.Move(1, 1)

dw_data.SetTransObject(sqlca)

end event

event ue_undo;call w_dwbuffers_ancestor::ue_undo;If MessageBox("Rollback changes",  "Are you sure you want to Rollback the database changes?", &
						question!, yesno! ) = 1 Then
	rollback using sqlca ;
	m_dwbuffers.m_options.m_showsqlpreview.Checked = False
	Trigger Event ue_retrieve()
	m_dwbuffers.m_options.m_showsqlpreview.Checked = True
End If

end event

on ue_refresh;call w_dwbuffers_ancestor::ue_refresh;dw_data.reset ()
end on

on w_dwbuffers_primary_save.create
call w_dwbuffers_ancestor::create
end on

on w_dwbuffers_primary_save.destroy
call w_dwbuffers_ancestor::destroy
end on

type dw_data from w_dwbuffers_ancestor`dw_data within w_dwbuffers_primary_save
int Width=1737
int Height=560
string DataObject="d_departments"
end type

event dw_data::itemchanged;call w_dwbuffers_ancestor`dw_data::itemchanged;of_refreshstatuswindow()
end event

event dw_data::sqlpreview;call super::sqlpreview;String	ls_RowBufferTitle, ls_BufferUsed

If m_dwbuffers.m_options.m_showsqlpreview.Checked Then
	
	Choose Case buffer
		Case primary!
			ls_BufferUsed = "Primary!"
		Case filter!
			ls_BufferUsed = "Filter!"
		Case delete!
			ls_BufferUsed = "Delete!"
	End Choose

	ls_RowBufferTitle = "SQLPreview:  Row: " + String (row) + "  Buffer:  " + ls_BufferUsed

	MessageBox(ls_RowBufferTitle, sqlsyntax, Information!)
	Return 0
End If

end event

