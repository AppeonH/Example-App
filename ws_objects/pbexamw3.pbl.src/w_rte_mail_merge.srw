$PBExportHeader$w_rte_mail_merge.srw
$PBExportComments$Mail merge form letter using RTE style DataWindow
forward
global type w_rte_mail_merge from w_center
end type
type cb_printprev from commandbutton within w_rte_mail_merge
end type
type cb_prev from commandbutton within w_rte_mail_merge
end type
type cb_next from commandbutton within w_rte_mail_merge
end type
type cb_close from commandbutton within w_rte_mail_merge
end type
type cb_help from commandbutton within w_rte_mail_merge
end type
type cb_print from commandbutton within w_rte_mail_merge
end type
type cb_retrieve from commandbutton within w_rte_mail_merge
end type
type em_date from editmask within w_rte_mail_merge
end type
type st_1 from statictext within w_rte_mail_merge
end type
type dw_1 from datawindow within w_rte_mail_merge
end type
end forward

global type w_rte_mail_merge from w_center
integer y = 4
integer width = 2944
integer height = 1848
string title = "RTE DataWindow Mail Merge"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
cb_printprev cb_printprev
cb_prev cb_prev
cb_next cb_next
cb_close cb_close
cb_help cb_help
cb_print cb_print
cb_retrieve cb_retrieve
em_date em_date
st_1 st_1
dw_1 dw_1
end type
global w_rte_mail_merge w_rte_mail_merge

on w_rte_mail_merge.create
int iCurrent
call super::create
this.cb_printprev=create cb_printprev
this.cb_prev=create cb_prev
this.cb_next=create cb_next
this.cb_close=create cb_close
this.cb_help=create cb_help
this.cb_print=create cb_print
this.cb_retrieve=create cb_retrieve
this.em_date=create em_date
this.st_1=create st_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_printprev
this.Control[iCurrent+2]=this.cb_prev
this.Control[iCurrent+3]=this.cb_next
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_help
this.Control[iCurrent+6]=this.cb_print
this.Control[iCurrent+7]=this.cb_retrieve
this.Control[iCurrent+8]=this.em_date
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.dw_1
end on

on w_rte_mail_merge.destroy
call super::destroy
destroy(this.cb_printprev)
destroy(this.cb_prev)
destroy(this.cb_next)
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.cb_print)
destroy(this.cb_retrieve)
destroy(this.em_date)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.SetTransObject(sqlca)

end event

event close;Show(w_main)

end event

type cb_printprev from commandbutton within w_rte_mail_merge
integer x = 1097
integer y = 28
integer width = 334
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Print Preview"
end type

event clicked;If This.Text = "Print Preview" Then
	dw_1.Object.DataWindow.Print.Preview="yes"
	This.Text = "Display"
Else
	dw_1.Object.DataWindow.Print.Preview="no"
	This.Text = "Print Preview"
End If

end event

type cb_prev from commandbutton within w_rte_mail_merge
integer x = 2738
integer y = 28
integer width = 64
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "<"
end type

event clicked;dw_1.ScrollPriorPage()

end event

type cb_next from commandbutton within w_rte_mail_merge
integer x = 2825
integer y = 28
integer width = 64
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = ">"
end type

event clicked;dw_1.ScrollNextPage()

end event

type cb_close from commandbutton within w_rte_mail_merge
integer x = 2281
integer y = 28
integer width = 334
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
boolean cancel = true
end type

event clicked;Close(Parent)

end event

type cb_help from commandbutton within w_rte_mail_merge
integer x = 1888
integer y = 28
integer width = 334
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Help"
end type

event clicked;f_open_help("w_rte_mail_merge")

end event

type cb_print from commandbutton within w_rte_mail_merge
integer x = 1490
integer y = 28
integer width = 334
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Print"
end type

event clicked;dw_1.Print()

end event

type cb_retrieve from commandbutton within w_rte_mail_merge
integer x = 704
integer y = 28
integer width = 334
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Retrieve"
boolean default = true
end type

event clicked;Date		ld_LastDate

em_date.GetData(ld_LastDate)

dw_1.Reset()
dw_1.Retrieve(ld_LastDate)

cb_printprev.Enabled = True
cb_print.Enabled = True

end event

type em_date from editmask within w_rte_mail_merge
integer x = 416
integer y = 28
integer width = 256
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
string text = "09/01/06"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/dd/yy"
string displaydata = "~r"
end type

type st_1 from statictext within w_rte_mail_merge
integer x = 14
integer y = 36
integer width = 384
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Last Order Date:"
alignment alignment = right!
long bordercolor = 8388608
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_rte_mail_merge
integer x = 18
integer y = 164
integer width = 2880
integer height = 1572
integer taborder = 90
string dataobject = "d_rte_mail_merge"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

