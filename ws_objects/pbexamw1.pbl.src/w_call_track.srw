$PBExportHeader$w_call_track.srw
$PBExportComments$Call Tracking example showing use of autoincrement
forward
global type w_call_track from w_center
end type
type cb_help from commandbutton within w_call_track
end type
type cb_cancel from commandbutton within w_call_track
end type
type cb_update from commandbutton within w_call_track
end type
type cb_delete from commandbutton within w_call_track
end type
type cb_add from commandbutton within w_call_track
end type
type dw_calls from datawindow within w_call_track
end type
type dw_add from datawindow within w_call_track
end type
end forward

global type w_call_track from w_center
integer x = 5
integer y = 4
integer width = 2949
integer height = 1852
string title = "AutoIncrement - Call Track"
long backcolor = 74481808
cb_help cb_help
cb_cancel cb_cancel
cb_update cb_update
cb_delete cb_delete
cb_add cb_add
dw_calls dw_calls
dw_add dw_add
end type
global w_call_track w_call_track

type variables
Boolean	ib_Changed
end variables

event open;call super::open;dw_add.SetTransObject(sqlca)
dw_calls.SetTransObject(sqlca)

dw_calls.Retrieve()

end event

on w_call_track.create
int iCurrent
call super::create
this.cb_help=create cb_help
this.cb_cancel=create cb_cancel
this.cb_update=create cb_update
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_calls=create dw_calls
this.dw_add=create dw_add
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_help
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_update
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.dw_calls
this.Control[iCurrent+7]=this.dw_add
end on

on w_call_track.destroy
call super::destroy
destroy(this.cb_help)
destroy(this.cb_cancel)
destroy(this.cb_update)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_calls)
destroy(this.dw_add)
end on

event close;w_main.Show()

end event

type cb_help from commandbutton within w_call_track
integer x = 2130
integer y = 1636
integer width = 407
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Help"
end type

event clicked;f_open_help(Parent.ClassName( ))

end event

type cb_cancel from commandbutton within w_call_track
integer x = 1687
integer y = 1636
integer width = 407
integer height = 88
integer taborder = 60
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

type cb_update from commandbutton within w_call_track
integer x = 1248
integer y = 1636
integer width = 407
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save Updates"
end type

event clicked;SetPointer(HourGlass!)

dw_add.Update()
//dw_calls.Update()
commit;

dw_calls.Reset()
dw_calls.Retrieve()

If dw_calls.GetSelectedRow(0) = 0 Then
	dw_calls.SelectRow(1, True)
	if(dw_calls.rowcount()>0) then
		dw_add.retrieve(dw_calls.object.id[1])
	end if 
End If

ib_Changed = False

end event

type cb_delete from commandbutton within w_call_track
integer x = 809
integer y = 1636
integer width = 407
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Delete Record"
end type

event clicked;Integer	li_Row

dw_add.DeleteRow(1)

li_Row = dw_calls.GetSelectedRow(0)
If li_Row > 0 Then
	dw_calls.DeleteRow(li_Row)

End If
	
end event

type cb_add from commandbutton within w_call_track
integer x = 366
integer y = 1636
integer width = 407
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Add Record"
end type

event clicked;If ib_Changed Then
	If MessageBox("Add New Call", "Do you want to save this call record first?", Question!, &
							YesNo!) = 1 Then cb_update.Trigger Event Clicked()
End If

dw_add.Reset()
dw_add.InsertRow(0)

dw_calls.SelectRow(0, False)

dw_add.SetFocus()

end event

type dw_calls from datawindow within w_call_track
integer x = 23
integer y = 676
integer width = 2848
integer height = 908
integer taborder = 20
string dataobject = "d_list_calls"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If row > 0 Then
	If ib_Changed Then
		If MessageBox("Update a Call Record", "Do you want to save your changes first?", Question!, &
								YesNo!) = 1 Then cb_update.Trigger Event Clicked()
	End If

	This.SelectRow(0, False)
	This.SelectRow(row, True)

	dw_add.Retrieve(This.Object.id[row])
End If

end event

type dw_add from datawindow within w_call_track
integer x = 343
integer y = 12
integer width = 2203
integer height = 648
integer taborder = 10
string dataobject = "d_add_call"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ib_Changed = True

end event

