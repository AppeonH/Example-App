$PBExportHeader$w_plb.srw
$PBExportComments$PictureListBox Picture Browser
forward
global type w_plb from w_center
end type
type rb_ico from radiobutton within w_plb
end type
type rb_bmp from radiobutton within w_plb
end type
type cb_view from commandbutton within w_plb
end type
type cb_close from commandbutton within w_plb
end type
type cb_help from commandbutton within w_plb
end type
type cb_browse from commandbutton within w_plb
end type
type lb_files from listbox within w_plb
end type
type cb_fill from commandbutton within w_plb
end type
type st_1 from statictext within w_plb
end type
type sle_path from singlelineedit within w_plb
end type
type plb_1 from picturelistbox within w_plb
end type
type gb_1 from groupbox within w_plb
end type
end forward

global type w_plb from w_center
integer x = 594
integer y = 4
integer width = 1541
integer height = 1820
string title = "PictureListBox Picture Browser"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
rb_ico rb_ico
rb_bmp rb_bmp
cb_view cb_view
cb_close cb_close
cb_help cb_help
cb_browse cb_browse
lb_files lb_files
cb_fill cb_fill
st_1 st_1
sle_path sle_path
plb_1 plb_1
gb_1 gb_1
end type
global w_plb w_plb

type variables
integer ic
end variables

on w_plb.create
int iCurrent
call super::create
this.rb_ico=create rb_ico
this.rb_bmp=create rb_bmp
this.cb_view=create cb_view
this.cb_close=create cb_close
this.cb_help=create cb_help
this.cb_browse=create cb_browse
this.lb_files=create lb_files
this.cb_fill=create cb_fill
this.st_1=create st_1
this.sle_path=create sle_path
this.plb_1=create plb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_ico
this.Control[iCurrent+2]=this.rb_bmp
this.Control[iCurrent+3]=this.cb_view
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_help
this.Control[iCurrent+6]=this.cb_browse
this.Control[iCurrent+7]=this.lb_files
this.Control[iCurrent+8]=this.cb_fill
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.sle_path
this.Control[iCurrent+11]=this.plb_1
this.Control[iCurrent+12]=this.gb_1
end on

on w_plb.destroy
call super::destroy
destroy(this.rb_ico)
destroy(this.rb_bmp)
destroy(this.cb_view)
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.cb_browse)
destroy(this.lb_files)
destroy(this.cb_fill)
destroy(this.st_1)
destroy(this.sle_path)
destroy(this.plb_1)
destroy(this.gb_1)
end on

event open;call super::open;If (ge_Environment.OSType = windows!) Or (ge_Environment.OSType = windowsnt!) Then
	sle_path.Text = gs_exampledir
End If

end event

event close;Show(w_main)

end event

type rb_ico from radiobutton within w_plb
integer x = 41
integer y = 280
integer width = 352
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 74481808
string text = "Icons (.ico)"
end type

event clicked;plb_1.Reset()
cb_view.Text = "View Icon"

end event

type rb_bmp from radiobutton within w_plb
integer x = 41
integer y = 216
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 74481808
string text = "Bitmaps (.bmp)"
boolean checked = true
end type

event clicked;plb_1.Reset()
cb_view.Text = "View Picture"

end event

type cb_view from commandbutton within w_plb
integer x = 1033
integer y = 348
integer width = 457
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "View Picture"
end type

event clicked;String	ls_FileName

ls_FileName = plb_1.SelectedItem()
If ls_FileName = "" Then Return

If rb_bmp.Checked Then
	OpenWithParm(w_plb_picture, ls_FileName)
Else
	OpenWithParm(w_plb_icon, ls_FileName)
End If

end event

type cb_close from commandbutton within w_plb
integer x = 1033
integer y = 636
integer width = 457
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;Close(Parent)

end event

type cb_help from commandbutton within w_plb
integer x = 1033
integer y = 532
integer width = 457
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Help"
end type

event clicked;f_open_help(Parent.ClassName())

end event

type cb_browse from commandbutton within w_plb
integer x = 1033
integer y = 60
integer width = 457
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Browse..."
end type

event clicked;String	ls_Path, ls_File, ls_Type, ls_Mask
Integer	li_Pos

If rb_bmp.Checked Then
	ls_Type = "*.bmp"
	ls_Mask = "Bitmap Files (*.bmp), *.bmp"
Else
	ls_Type = "*.ico"
	ls_Mask = "Icon Files (*.ico), *.ico"
End If

If GetFileOpenName("Select Any File in the Directory to Select It", ls_Path, ls_File, &
								ls_Type, ls_Mask) = 1 Then
	
	// Remove the file from the path that was returned.
	li_Pos = Pos(ls_Path, ls_File)
	ls_Path = Left(ls_Path, (li_Pos - 1))
	sle_path.Text = ls_Path
End If

end event

type lb_files from listbox within w_plb
boolean visible = false
integer x = 855
integer y = 316
integer width = 384
integer height = 304
integer taborder = 80
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
end type

type cb_fill from commandbutton within w_plb
integer x = 1033
integer y = 244
integer width = 457
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Fill PictureListBox"
end type

event clicked;Integer	li_Files, li_Cnt, li_Index
String	ls_File, ls_Type

plb_1.Reset()

If Right(sle_path.Text, 1) <> "\" Then
	sle_path.Text = sle_path.Text + "\"
End If

If rb_bmp.Checked Then
	ls_Type = "*.bmp"
Else
	ls_Type = "*.ico"
End If

If Not lb_files.DirList(sle_path.Text + ls_Type, 0) Then
	MessageBox("Error", "Invalid Picture Directory.  Please select another one.", &
						Exclamation!)
	Return
End If

li_Files = lb_files.TotalItems()

For li_Cnt = 1 To li_Files
	ls_File = lb_files.Text(li_Cnt)
	
	li_Index = plb_1.AddPicture(sle_path.Text + ls_File)
	plb_1.AddItem(ls_File, li_Index)
Next

end event

type st_1 from statictext within w_plb
integer x = 9
integer width = 489
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 74481808
boolean enabled = false
string text = "Picture Directory:"
boolean focusrectangle = false
end type

type sle_path from singlelineedit within w_plb
integer x = 9
integer y = 64
integer width = 997
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type plb_1 from picturelistbox within w_plb
integer x = 9
integer y = 388
integer width = 997
integer height = 1316
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 12632256
end type

event doubleclicked;cb_view.Post Event Clicked()

end event

type gb_1 from groupbox within w_plb
integer x = 9
integer y = 160
integer width = 489
integer height = 204
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 74481808
string text = "Picture Type"
borderstyle borderstyle = stylelowered!
end type

