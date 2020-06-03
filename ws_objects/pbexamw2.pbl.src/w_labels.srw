$PBExportHeader$w_labels.srw
$PBExportComments$Mailing labels for the contact table, uses Avery 5267 format.
forward
global type w_labels from w_center
end type
type cbx_rulers from checkbox within w_labels
end type
type st_1 from statictext within w_labels
end type
type rb_custom from radiobutton within w_labels
end type
type rb_200 from radiobutton within w_labels
end type
type rb_100 from radiobutton within w_labels
end type
type rb_65 from radiobutton within w_labels
end type
type rb_30 from radiobutton within w_labels
end type
type em_zoom from editmask within w_labels
end type
type ddlb_label_type from dropdownlistbox within w_labels
end type
type cb_print_dw1 from commandbutton within w_labels
end type
type cb_close from commandbutton within w_labels
end type
type dw_label from datawindow within w_labels
end type
type gb_1 from groupbox within w_labels
end type
end forward

global type w_labels from w_center
integer x = 64
integer y = 176
integer width = 3109
integer height = 1932
string title = "Labels"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
cbx_rulers cbx_rulers
st_1 st_1
rb_custom rb_custom
rb_200 rb_200
rb_100 rb_100
rb_65 rb_65
rb_30 rb_30
em_zoom em_zoom
ddlb_label_type ddlb_label_type
cb_print_dw1 cb_print_dw1
cb_close cb_close
dw_label dw_label
gb_1 gb_1
end type
global w_labels w_labels

type variables
string is_labelfile = "appeonpblab.ini"
end variables

forward prototypes
public function long wf_load_label_types (ref dropdownlistbox ax_ddlb)
end prototypes

public function long wf_load_label_types (ref dropdownlistbox ax_ddlb);// This function will load the passed drop down list box with the contents
// of the labels section in the pblabxxx ini file.
// The label section contains the names of all of the valid label types
int			li_file_rc 
string 		ls_item, ls_char, ls_path
boolean 	lb_propersection = false, lb_past_section = false
long		ll_length, ll_pos

String ls_keyword
Integer  li_return
ContextKeyword lcx_key
string is_values[]
string pathenv,path
string filename
long li_Pos

li_file_rc = FileOpen (is_labelfile)

//Search Path environment
If li_file_rc = -1 Then
	li_return = this.GetContextService &
	 ("ContextKeyword", lcx_key)
	ls_keyword = "PATH"
	lcx_key.GetContextKeywords &
		 (ls_keyword, is_values)
	 If  UpperBound(is_values) >=1 then
		pathenv=is_values[1]
		do
			li_Pos = Pos(pathenv, ";")
			if li_Pos=0 then
				filename=pathenv +"\"+is_labelfile
			else
				path=mid(pathenv,1,li_pos - 1)
				filename=path +"\"+is_labelfile
				pathenv=mid(pathenv,li_pos+1)
			end if
			li_file_rc=FileOpen(filename)
			 If not li_file_rc =-1 Then
				exit
			 end if
		loop UNTIL li_Pos=0
	end if 
end if

If li_file_rc = -1 Then
	If MessageBox ( "Label File", "Unable to '" + is_labelfile + "'." + &
						"~n~r~n~rYou can set the location of the file " + &
						"on the following screen.~n~r~n~rDo you want to find the file now?", Exclamation!, YesNo!, 2)  = 2 then
		Return -1
	Else
		// Allow the user to find the directory
		if GetFileOpenName("Find " + is_labelfile, ls_Path, is_labelfile, "INI", "Ini Files (*.INI),*.INI" ) = 1 then
			li_file_rc = FileOpen ( is_labelfile )
			If li_file_rc = -1 Then
				Messagebox("Cannot Find Label INI File","Ensure that the file '" + &
				is_labelfile + "' is in the PB Runtime directory.",Exclamation!)
				Return -1
			End If
		else
			Return -1
		end if
		
		
	end if
	
End If
	

//Read from file until end of file 
//or a section after the label section is hit
Do While FileRead(li_file_rc,ls_item) <> -100 
	ls_char = Left(ls_item,1)

	//test if this is a new section
	If ls_char = "[" Then

		//if in the label section, start loading ddlb
		If Lower(Left(ls_item,8)) = "[labels]" Then 

			lb_propersection = true

		Else

			//if not in the label section and was in the label section, stop
			If lb_propersection Then Exit
			lb_propersection = False

		End If

	ElseIf (ls_char <> ' ' and ls_char <> '' and ls_char <> ';') and lb_propersection Then	
		//Skip lines with ; or spaces starting and strip off ending = sign

		//First find the location of the last = sign in the string
		ll_length = Len(ls_item)
		ll_pos = Pos(ls_item,'=',ll_length)

		//try each character going from the back of the text till a 
		//equal sign is found
		do while ll_pos = 0 and ll_length > 1
			ll_length --
			ll_pos = Pos(ls_item,'=',ll_length)
		loop

		//Insert the label name less the equal sign into the listbox
		If ll_pos > 0 Then ax_ddlb.InsertItem(left(ls_item, ll_pos - 1),0)

	End If

Loop

FileClose(li_file_rc)

return 0
end function

on close;
w_main.Show()
end on

event open;call super::open;//Open event for w_labels
//this window will show all of the valid label types
//visiually show a print preview of the types

//set transation for the datawindow preview
dw_label.settransobject(sqlca)
dw_label.retrieve()
	
//load the load selector listbox	
If wf_load_label_types(ddlb_label_type) = -1 Then
	Close ( this )
	Return 
End If

//select the first label
ddlb_label_type.selectitem(1)

end event

on w_labels.create
int iCurrent
call super::create
this.cbx_rulers=create cbx_rulers
this.st_1=create st_1
this.rb_custom=create rb_custom
this.rb_200=create rb_200
this.rb_100=create rb_100
this.rb_65=create rb_65
this.rb_30=create rb_30
this.em_zoom=create em_zoom
this.ddlb_label_type=create ddlb_label_type
this.cb_print_dw1=create cb_print_dw1
this.cb_close=create cb_close
this.dw_label=create dw_label
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_rulers
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.rb_custom
this.Control[iCurrent+4]=this.rb_200
this.Control[iCurrent+5]=this.rb_100
this.Control[iCurrent+6]=this.rb_65
this.Control[iCurrent+7]=this.rb_30
this.Control[iCurrent+8]=this.em_zoom
this.Control[iCurrent+9]=this.ddlb_label_type
this.Control[iCurrent+10]=this.cb_print_dw1
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.dw_label
this.Control[iCurrent+13]=this.gb_1
end on

on w_labels.destroy
call super::destroy
destroy(this.cbx_rulers)
destroy(this.st_1)
destroy(this.rb_custom)
destroy(this.rb_200)
destroy(this.rb_100)
destroy(this.rb_65)
destroy(this.rb_30)
destroy(this.em_zoom)
destroy(this.ddlb_label_type)
destroy(this.cb_print_dw1)
destroy(this.cb_close)
destroy(this.dw_label)
destroy(this.gb_1)
end on

type cbx_rulers from checkbox within w_labels
integer x = 2610
integer y = 68
integer width = 293
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Rulers"
end type

event clicked;// use the print preview rulers attribute

If cbx_rulers.checked = True then 
	dw_label.Object.datawindow.print.preview.rulers = 'yes'
Else
	dw_label.Object.datawindow.print.preview.rulers = 'no'
End If
	
	
	
end event

type st_1 from statictext within w_labels
integer x = 73
integer width = 352
integer height = 52
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Label Type:"
boolean focusrectangle = false
end type

type rb_custom from radiobutton within w_labels
integer x = 1445
integer y = 64
integer width = 256
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Cus&tom"
end type

type rb_200 from radiobutton within w_labels
integer x = 2345
integer y = 64
integer width = 224
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&200%"
end type

on clicked;//set zoom size to 200 %
em_zoom.text = "200"
em_zoom.triggerevent("ue_rezoom")
end on

type rb_100 from radiobutton within w_labels
integer x = 2130
integer y = 64
integer width = 215
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&100%"
boolean checked = true
end type

on clicked;//set zoom size to 100 %
em_zoom.text = "100"
em_zoom.triggerevent("ue_rezoom")
end on

type rb_65 from radiobutton within w_labels
integer x = 1920
integer y = 64
integer width = 210
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&65%"
end type

on clicked;//set zoom size to 65 %
em_zoom.text = "65"
em_zoom.triggerevent("ue_rezoom")
end on

type rb_30 from radiobutton within w_labels
integer x = 1701
integer y = 64
integer width = 192
integer height = 68
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&30%"
end type

on clicked;//set zoom size to 30 %
em_zoom.text = "30"
em_zoom.triggerevent("ue_rezoom")
end on

type em_zoom from editmask within w_labels
event ue_change pbm_enchange
event ue_rezoom pbm_custom01
integer x = 1225
integer y = 76
integer width = 197
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
string text = "100"
borderstyle borderstyle = stylelowered!
string mask = "##0"
boolean spin = true
string minmax = "1~~200"
end type

event ue_change;//This ue_change event will be called any time another radio button is pressed. This is 
//a common area the zoom size is adjusted each time.

//When viewing a datawindow w/labels, the datawindow is automatically placed in print
//preview mode.  This will change the zoom size of the datawindow in print preiew mode.

If Integer(This.Text) > 0 and Integer(This.Text) <= 200 Then
	dw_label.Object.Datawindow.print.preview.zoom = Integer(this.text)
End If

rb_custom.checked = true

end event

event ue_rezoom;If Integer(This.Text) > 0 and Integer(This.Text) <= 200 Then
	dw_label.Object.datawindow.print.preview.zoom = Integer(this.text)
End If
end event

type ddlb_label_type from dropdownlistbox within w_labels
integer x = 73
integer y = 64
integer width = 1097
integer height = 396
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//This will perform a dwmodify statement of the main datwindow based on the
//label type you have chosen. All of the attributes of the label are loaded 
//based on the pblab150.ini file.
//This will build a large string containing all of the dwmodify attribute adjustments
//and then dwmodify this one string.
//crm

string ls_rc
string ls_newlabel
string ls_labelname
string ls_shape, ls_digits
int li_pos, li_pos_end

SetPointer (HourGlass!)

//get the label anme
ls_labelname = ddlb_label_type.text

//set label name attribute
ls_newlabel = "datawindow.label.name = '" + ddlb_label_type.Text + "' "

//set # of columns per sheet
ls_newlabel = ls_newlabel + " Datawindow.Label.Columns = " + &
	ProfileString (is_labelfile, ls_labelname, "columns", "")

//set space between columns
ls_newlabel = ls_newlabel + " Datawindow.Label.Columns.Spacing = " + &
	ProfileString (is_labelfile, ls_labelname, "columns.spacing", "")

//set height of the label
ls_newlabel = ls_newlabel + " Datawindow.Label.Height = " + &
	ProfileString (is_labelfile, ls_labelname, "height", "")

//set # or rows on a sheet
ls_newlabel = ls_newlabel + " Datawindow.Label.Rows = " + &
	ProfileString (is_labelfile, ls_labelname, "rows", "")

//set spaces between labels
ls_newlabel = ls_newlabel + " Datawindow.Label.Rows.Spacing = " + &
	ProfileString (is_labelfile, ls_labelname, "rows.spacing", "")

//Set the shape of the label
ls_shape = ProfileString (is_labelfile, ls_labelname, "shape", "")
li_pos = Pos (ls_shape, "(")

//If the label is roundrectange, the pablab.ini file contains the ellipse width and height
//is contained on the same line as the shape. This rountine will break out those elements
//and set thier attributes.
If li_pos > 0 Then
	//set elispse height
	li_pos_end = Pos (ls_shape, ",", li_pos)	
	ls_digits = Mid (ls_shape,li_pos + 1, li_pos_end  - li_pos - 1 )
	ls_newlabel = ls_newlabel + " Datawindow.Label.Ellipse_Width = " + ls_digits
	li_pos = li_pos_end 
	li_pos_end = Pos (ls_shape, ")", li_pos)
	ls_digits = Mid (ls_shape,li_pos + 1, li_pos_end  - li_pos - 1)
	ls_newlabel = ls_newlabel + " Datawindow.Label.Ellipse_Height = " + ls_digits
	li_pos = Pos (ls_shape,"(")
	ls_shape = Left (ProfileString (is_labelfile, ls_labelname, "shape", ""), li_pos - 1)
Else
	ls_shape = ProfileString (is_labelfile, ls_labelname, "shape", "")
End If

ls_newlabel = ls_newlabel + " Datawindow.Label.Shape = " + ls_shape

//set the width of the label
ls_newlabel = ls_newlabel + " Datawindow.Label.Width = " + &
	ProfileString (is_labelfile, ls_labelname, "width", "")

//set the page bottom margin
ls_newlabel = ls_newlabel + " Datawindow.Print.Margin.Bottom = " + &
	ProfileString (is_labelfile, ls_labelname, "bottom_margin", "")

//set the page left margin
ls_newlabel = ls_newlabel + " Datawindow.Print.Margin.Left = " + &
	ProfileString (is_labelfile, ls_labelname, "left_margin", "")

//set the page right margin
ls_newlabel = ls_newlabel + " Datawindow.Print.Margin.right = " + &
	ProfileString (is_labelfile, ls_labelname, "right_margin", "")

//set the page top margin
ls_newlabel = ls_newlabel + " Datawindow.Print.Margin.Top = " + &
	ProfileString (is_labelfile, ls_labelname, "top_margin", "")

//dwmodify the entire string
ls_rc = dw_label.Modify (ls_newlabel)

If ls_rc <> "" Then
	 Messagebox ("Label Change Error", ls_rc)
	 Messagebox ("dwm", ls_newlabel)
End If

end event

type cb_print_dw1 from commandbutton within w_labels
integer x = 937
integer y = 1640
integer width = 370
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Print"
end type

on clicked;
	dw_label.print()
end on

type cb_close from commandbutton within w_labels
integer x = 1504
integer y = 1640
integer width = 370
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

on clicked;
	close(parent)
end on

type dw_label from datawindow within w_labels
integer x = 50
integer y = 192
integer width = 2825
integer height = 1380
string dataobject = "d_label_preview"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_labels
integer x = 1193
integer y = 16
integer width = 1385
integer height = 1112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Display Zoom"
end type

