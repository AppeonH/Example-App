$PBExportHeader$w_rte_find.srw
$PBExportComments$Find Dialog for RTE Example
forward
global type w_rte_find from w_center
end type
type cbx_matchcase from checkbox within w_rte_find
end type
type cbx_wholeword from checkbox within w_rte_find
end type
type sle_find from singlelineedit within w_rte_find
end type
type st_1 from statictext within w_rte_find
end type
type cb_2 from commandbutton within w_rte_find
end type
type cb_find from commandbutton within w_rte_find
end type
end forward

shared variables
String	ss_SaveFind
end variables

global type w_rte_find from w_center
integer x = 1074
integer y = 484
integer width = 1673
integer height = 528
string title = "Find"
windowtype windowtype = popup!
long backcolor = 79741120
toolbaralignment toolbaralignment = alignatleft!
cbx_matchcase cbx_matchcase
cbx_wholeword cbx_wholeword
sle_find sle_find
st_1 st_1
cb_2 cb_2
cb_find cb_find
end type
global w_rte_find w_rte_find

type variables
richtextedit		irte_1
Boolean		ib_FindNext
end variables

on w_rte_find.create
int iCurrent
call super::create
this.cbx_matchcase=create cbx_matchcase
this.cbx_wholeword=create cbx_wholeword
this.sle_find=create sle_find
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_find=create cb_find
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_matchcase
this.Control[iCurrent+2]=this.cbx_wholeword
this.Control[iCurrent+3]=this.sle_find
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_find
end on

on w_rte_find.destroy
call super::destroy
destroy(this.cbx_matchcase)
destroy(this.cbx_wholeword)
destroy(this.sle_find)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_find)
end on

event open;call super::open;irte_1 = message.PowerObjectParm
sle_find.text = ss_SaveFind

end event

type cbx_matchcase from checkbox within w_rte_find
integer x = 55
integer y = 284
integer width = 594
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Match &case"
end type

event clicked;ib_FindNext = False

end event

type cbx_wholeword from checkbox within w_rte_find
integer x = 55
integer y = 192
integer width = 594
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Match &whole word only"
end type

event clicked;ib_FindNext = False

end event

type sle_find from singlelineedit within w_rte_find
event enupdate pbm_enupdate
integer x = 329
integer y = 44
integer width = 855
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event enupdate;If sle_find.Text = "" Then
	cb_find.Enabled = False
Else
	cb_find.Enabled = True
End If

ss_SaveFind = sle_find.Text
ib_FindNext = False

end event

type st_1 from statictext within w_rte_find
integer x = 55
integer y = 56
integer width = 261
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fi&nd what:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_rte_find
integer x = 1248
integer y = 156
integer width = 311
integer height = 92
integer taborder = 50
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

type cb_find from commandbutton within w_rte_find
integer x = 1248
integer y = 44
integer width = 311
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Find Next"
boolean default = true
end type

event clicked;If ib_FindNext Then
	irte_1.FindNext()
Else
	irte_1.Find(sle_find.Text, True, Not cbx_matchcase.Checked, cbx_wholeword.Checked, True )
	irte_1.GetParent().dynamic of_setfind(sle_find.Text)	
	ib_FindNext = True
End If

end event

