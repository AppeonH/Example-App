$PBExportHeader$w_rte_replace.srw
$PBExportComments$Replace Dialog for RTE Example
forward
global type w_rte_replace from w_center
end type
type sle_replace from singlelineedit within w_rte_replace
end type
type sle_find from singlelineedit within w_rte_replace
end type
type cbx_matchcase from checkbox within w_rte_replace
end type
type cbx_wholeword from checkbox within w_rte_replace
end type
type st_2 from statictext within w_rte_replace
end type
type st_1 from statictext within w_rte_replace
end type
type cb_4 from commandbutton within w_rte_replace
end type
type cb_replaceall from commandbutton within w_rte_replace
end type
type cb_replace from commandbutton within w_rte_replace
end type
type cb_find from commandbutton within w_rte_replace
end type
end forward

shared variables
String	ss_SaveFind
end variables

global type w_rte_replace from w_center
integer x = 1074
integer y = 484
integer width = 1687
integer height = 688
string title = "Replace"
windowtype windowtype = popup!
long backcolor = 79741120
toolbaralignment toolbaralignment = alignatleft!
sle_replace sle_replace
sle_find sle_find
cbx_matchcase cbx_matchcase
cbx_wholeword cbx_wholeword
st_2 st_2
st_1 st_1
cb_4 cb_4
cb_replaceall cb_replaceall
cb_replace cb_replace
cb_find cb_find
end type
global w_rte_replace w_rte_replace

type variables
richtextedit		irte_1
Boolean		ib_FindNext
end variables

on w_rte_replace.create
int iCurrent
call super::create
this.sle_replace=create sle_replace
this.sle_find=create sle_find
this.cbx_matchcase=create cbx_matchcase
this.cbx_wholeword=create cbx_wholeword
this.st_2=create st_2
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_replaceall=create cb_replaceall
this.cb_replace=create cb_replace
this.cb_find=create cb_find
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_replace
this.Control[iCurrent+2]=this.sle_find
this.Control[iCurrent+3]=this.cbx_matchcase
this.Control[iCurrent+4]=this.cbx_wholeword
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_replaceall
this.Control[iCurrent+9]=this.cb_replace
this.Control[iCurrent+10]=this.cb_find
end on

on w_rte_replace.destroy
call super::destroy
destroy(this.sle_replace)
destroy(this.sle_find)
destroy(this.cbx_matchcase)
destroy(this.cbx_wholeword)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_replaceall)
destroy(this.cb_replace)
destroy(this.cb_find)
end on

event open;call super::open;irte_1 = message.PowerObjectParm

sle_find.Text = ss_SaveFind

end event

type sle_replace from singlelineedit within w_rte_replace
integer x = 361
integer y = 164
integer width = 809
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_find from singlelineedit within w_rte_replace
event enupdate pbm_enupdate
integer x = 361
integer y = 48
integer width = 809
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
	cb_replace.Enabled = False
	cb_replaceall.Enabled = False
Else
	cb_find.Enabled = True
	cb_replace.Enabled = True
	cb_replaceall.Enabled = True
End If

ss_SaveFind = sle_find.Text

ib_FindNext = False

end event

type cbx_matchcase from checkbox within w_rte_replace
integer x = 23
integer y = 388
integer width = 594
integer height = 76
integer taborder = 40
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

type cbx_wholeword from checkbox within w_rte_replace
integer x = 23
integer y = 288
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
string text = "Match &whole word only"
end type

event clicked;ib_FindNext = False

end event

type st_2 from statictext within w_rte_replace
integer y = 176
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Re&place with:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_rte_replace
integer x = 73
integer y = 68
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

type cb_4 from commandbutton within w_rte_replace
integer x = 1216
integer y = 348
integer width = 352
integer height = 88
integer taborder = 80
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

type cb_replaceall from commandbutton within w_rte_replace
integer x = 1216
integer y = 244
integer width = 352
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Replace &All"
end type

event clicked;Integer	li_Loc, li_Changes

irte_1.SetRedraw(False)

If ib_FindNext Then
	li_Loc = irte_1.findnext()
Else
	li_Loc = irte_1.Find(sle_find.text, True, Not cbx_matchcase.Checked, cbx_wholeword.Checked, True )
	ib_FindNext = False
End If

Do While li_Loc > 0
	If irte_1.SelectedLength() > 0 And &
		((cbx_matchcase.Checked And irte_1.SelectedText() = sle_find.Text) Or &
		 ((Not cbx_matchcase.Checked) And Lower(irte_1.SelectedText()) = Lower(sle_find.Text))) Then
		irte_1.ReplaceText(sle_replace.Text )
		li_Changes++
	Else
		MessageBox("Replace", "This is The Exit.   The Find must have failed!!!!")
		Exit
	End If
	li_Loc = irte_1.findnext()
Loop

irte_1.SetRedraw(True)

If li_Changes > 0 Then
	MessageBox("Replace", String(li_Changes) + " replacements made.")
Else
	MessageBox("Replace", "No replacements made.")
End If

end event

type cb_replace from commandbutton within w_rte_replace
integer x = 1216
integer y = 140
integer width = 352
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "&Replace"
end type

event clicked;If ib_FindNext Then
	irte_1.findnext()
Else
	irte_1.Find(sle_find.Text, True, Not cbx_matchcase.Checked, cbx_wholeword.Checked, True)
End If

If irte_1.SelectedLength() > 0 And &
	((cbx_matchcase.Checked And irte_1.SelectedText() = sle_find.Text) Or &
	 ((Not cbx_matchcase.Checked) And Lower(irte_1.SelectedText()) = Lower(sle_find.Text))) Then
	irte_1.ReplaceText(sle_replace.Text )
End If

irte_1.SetRedraw(True)

end event

type cb_find from commandbutton within w_rte_replace
integer x = 1216
integer y = 36
integer width = 352
integer height = 88
integer taborder = 50
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
	irte_1.findnext()
Else
	irte_1.Find(sle_find.Text, True, Not cbx_matchcase.Checked, cbx_wholeword.Checked, True)
	irte_1.GetParent(). dynamic of_setfind(sle_find.Text)		// tell window what we're finding
	ib_FindNext = True
End If

end event

