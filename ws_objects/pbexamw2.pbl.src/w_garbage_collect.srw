$PBExportHeader$w_garbage_collect.srw
$PBExportComments$Garbage Collection example window
forward
global type w_garbage_collect from w_center
end type
type cb_help from commandbutton within w_garbage_collect
end type
type cb_close from commandbutton within w_garbage_collect
end type
type st_1 from statictext within w_garbage_collect
end type
type cbx_gc from checkbox within w_garbage_collect
end type
type st_mem from statictext within w_garbage_collect
end type
type cb_ok from commandbutton within w_garbage_collect
end type
end forward

global type w_garbage_collect from w_center
integer x = 480
integer y = 348
integer width = 1275
integer height = 608
string title = "Garbage Collection Demonstration"
long backcolor = 80242744
event ue_createuo ( integer ai_number )
event ue_displayleak ( )
event ue_postopen ( )
cb_help cb_help
cb_close cb_close
st_1 st_1
cbx_gc cbx_gc
st_mem st_mem
cb_ok cb_ok
end type
global w_garbage_collect w_garbage_collect

type variables
Long	il_Current
String	is_OriginalMemory

end variables

forward prototypes
public subroutine of_display_mem ()
public function long of_long_mem (string as_Memory)
end prototypes

event ue_createuo;u_color_selection	luo_Object[]
Integer					li_Obj

For li_Obj = 1 To ai_Number
	luo_Object[li_Obj] = Create u_color_selection
Next

end event

event ue_displayleak;of_display_mem()

MessageBox("Memory Leakage", "Original:~t" + is_OriginalMemory + "~n~rNow:~t" + st_mem.Text + &
					"~n~r~n~rDiff:~t" + String(of_long_mem(is_OriginalMemory) - of_long_mem(st_mem.Text), "#,###,##0") + " bytes")

GarbageCollectSetTimeLimit(il_Current)

end event

event ue_postopen;of_display_mem()

end event

public subroutine of_display_mem ();LongLong		ll_Mem

ll_Mem = gu_ext_func.uf_GetFreeMemory()
st_mem.Text = String (ll_Mem, '###,###,###,###') + ' bytes'

end subroutine

public function long of_long_mem (string as_Memory);Long		ll_Memory

ll_Memory = Long(Left(as_Memory, (Pos(as_Memory, " ") - 1)))
Return ll_Memory

end function

on w_garbage_collect.create
int iCurrent
call super::create
this.cb_help=create cb_help
this.cb_close=create cb_close
this.st_1=create st_1
this.cbx_gc=create cbx_gc
this.st_mem=create st_mem
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_help
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cbx_gc
this.Control[iCurrent+5]=this.st_mem
this.Control[iCurrent+6]=this.cb_ok
end on

on w_garbage_collect.destroy
call super::destroy
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.cbx_gc)
destroy(this.st_mem)
destroy(this.cb_ok)
end on

event close;w_main.Show()

end event

event open;call super::open;Post Event ue_postopen()
end event

type cb_help from commandbutton within w_garbage_collect
integer x = 832
integer y = 380
integer width = 366
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Help"
end type

event clicked;string	ls_win
ls_win = parent.ClassName()

f_open_help(ls_win)
end event

type cb_close from commandbutton within w_garbage_collect
integer x = 434
integer y = 380
integer width = 366
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;Close(Parent)

end event

type st_1 from statictext within w_garbage_collect
integer x = 50
integer y = 36
integer width = 1147
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Available Memory"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_gc from checkbox within w_garbage_collect
integer x = 50
integer y = 248
integer width = 658
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Garbage Collection On"
end type

type st_mem from statictext within w_garbage_collect
integer x = 50
integer y = 112
integer width = 1147
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_garbage_collect
integer x = 37
integer y = 380
integer width = 366
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean default = true
end type

event clicked;Integer	li_Cnt

SetPointer(HourGlass!)

If cbx_gc.Checked Then
	il_Current = GarbageCollectSetTimeLimit(10)
Else
	il_Current = GarbageCollectSetTimeLimit(1000000)
End If

GarbageCollect()

of_display_mem()
is_OriginalMemory = st_mem.Text

For li_Cnt = 1 To 5
	Trigger Event ue_createuo(100)
Next

Post Event ue_displayleak()

end event

