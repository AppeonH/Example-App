$PBExportHeader$w_customize_dw.srw
$PBExportComments$Window to customize a datawindow using describe/modify and direct object reference syntax
forward
global type w_customize_dw from w_center
end type
type tab_1 from tab within w_customize_dw
end type
type tabpage_mod from userobject within tab_1
end type
type st_14 from statictext within tabpage_mod
end type
type st_15 from statictext within tabpage_mod
end type
type sle_command from singlelineedit within tabpage_mod
end type
type st_16 from statictext within tabpage_mod
end type
type st_header from statictext within tabpage_mod
end type
type st_val_header from statictext within tabpage_mod
end type
type lb_objects from listbox within tabpage_mod
end type
type lb_attributes from listbox within tabpage_mod
end type
type lb_attrib_val from listbox within tabpage_mod
end type
type tabpage_object from userobject within tab_1
end type
type st_18 from statictext within tabpage_object
end type
type st_20 from statictext within tabpage_object
end type
type st_19 from statictext within tabpage_object
end type
type st_21 from statictext within tabpage_object
end type
type st_22 from statictext within tabpage_object
end type
type st_23 from statictext within tabpage_object
end type
type st_24 from statictext within tabpage_object
end type
type st_25 from statictext within tabpage_object
end type
type st_26 from statictext within tabpage_object
end type
type ddlb_nameborder from dropdownlistbox within tabpage_object
end type
type ddlb_namealign from dropdownlistbox within tabpage_object
end type
type ddlb_nameweight from dropdownlistbox within tabpage_object
end type
type sle_nameface from singlelineedit within tabpage_object
end type
type ddlb_nametweight from dropdownlistbox within tabpage_object
end type
type sle_nametface from singlelineedit within tabpage_object
end type
type ddlb_nametalign from dropdownlistbox within tabpage_object
end type
type ddlb_nametborder from dropdownlistbox within tabpage_object
end type
type st_1 from statictext within tabpage_object
end type
type st_2 from statictext within tabpage_object
end type
type st_3 from statictext within tabpage_object
end type
type st_4 from statictext within tabpage_object
end type
type cb_apply from commandbutton within w_customize_dw
end type
type cb_help from commandbutton within w_customize_dw
end type
type cb_close from commandbutton within w_customize_dw
end type
type dw_1 from datawindow within w_customize_dw
end type
type tabpage_mod from userobject within tab_1
st_14 st_14
st_15 st_15
sle_command sle_command
st_16 st_16
st_header st_header
st_val_header st_val_header
lb_objects lb_objects
lb_attributes lb_attributes
lb_attrib_val lb_attrib_val
end type
type tabpage_object from userobject within tab_1
st_18 st_18
st_20 st_20
st_19 st_19
st_21 st_21
st_22 st_22
st_23 st_23
st_24 st_24
st_25 st_25
st_26 st_26
ddlb_nameborder ddlb_nameborder
ddlb_namealign ddlb_namealign
ddlb_nameweight ddlb_nameweight
sle_nameface sle_nameface
ddlb_nametweight ddlb_nametweight
sle_nametface sle_nametface
ddlb_nametalign ddlb_nametalign
ddlb_nametborder ddlb_nametborder
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type
type tab_1 from tab within w_customize_dw
tabpage_mod tabpage_mod
tabpage_object tabpage_object
end type
end forward

shared variables

end variables

global type w_customize_dw from w_center
int X=87
int Y=4
int Width=2569
int Height=1784
boolean TitleBar=true
string Title="Modify a DataWindow Example"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
tab_1 tab_1
cb_apply cb_apply
cb_help cb_help
cb_close cb_close
dw_1 dw_1
end type
global w_customize_dw w_customize_dw

type variables
string   is_object_name
string   is_text_attr[]
string   is_column_attr[]

// determines if we are currently selecting a column or text
boolean   ib_column
end variables

forward prototypes
protected subroutine of_fill_attributes (string as_Attribute, string as_Val)
end prototypes

protected subroutine of_fill_attributes (string as_Attribute, string as_Val);//////////////////////////////////////////////////////////////////////
//
// Function: of_fill_attributes
//
// Purpose: populates the attribute values listbox with the correct
//				values based on the attribute name that is passed.
//				Selects the item in the listbox with text equal to as_val
//
//	Scope: protected
//
//	Arguments: as_attribute		the attribute name that you want values for		
//				  as_val				the current value of attribute name that
//										you want to select in the listbox
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////


tab_1.tabpage_mod.lb_attrib_val.SetRedraw (False)
tab_1.tabpage_mod.lb_attrib_val.Reset()

Choose Case as_attribute

	Case 'border'
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('0 - None')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('1 - Shadow')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('2 - Rectangle')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('3 - Resize')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('4 - Line')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('5 - 3D Lowered')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('6 - 3D Raised')

	Case 'alignment'
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('0 - Left')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('1 - Right')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('2 - Center')

	Case 'font.italic', 'font.underline', 'visible', 'font.strikethrough', &
		  'moveable', 'resizeable'
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('0 - False (No)')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('1 - True (Yes)')

	Case 'font.family'
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('0 - AnyFont')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('1 - Roman')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('2 - Swiss')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('3 - Modern')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('4 - Script')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('5 - Decorative')

	Case 'font.pitch'
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('0 - System default')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('1 - Fixed')
		tab_1.tabpage_mod.lb_attrib_val.AddItem ('2 - Variable')
End Choose

tab_1.tabpage_mod.lb_attrib_val.SelectItem (as_val, 0)
tab_1.tabpage_mod.lb_attrib_val.SetRedraw (True)

end subroutine

event open;call super::open;String	ls_Names


// Retrieve Data into the Main Data Window
dw_1.setTransObject (sqlca)
dw_1.Retrieve()

// Populate listboxes on first tab
// Get list and number of columns from the datawindow
ls_Names = dw_1.Describe ("datawindow.objects")

// Get each object from the list and add it to the objects listbox
Do 
	is_object_name = f_get_token (ls_names, "~t")
	tab_1.tabpage_mod.lb_objects.AddItem (is_object_name)
Loop Until ls_Names = ""

// Initialize attributes for column object type
is_column_attr[1]  = "height"
is_column_attr[2]  = "width"
is_column_attr[3]  = "border"
is_column_attr[4]  = "alignment"
is_column_attr[5]  = "background.color"
is_column_attr[6]  = "color"
is_column_attr[7]  = "font.face"
is_column_attr[8]  = "font.height"
is_column_attr[9]  = "font.italic"
is_column_attr[10]  = "font.underline"
is_column_attr[11]  = "font.weight"
is_column_attr[12]  = "format"
is_column_attr[13]  = "visible"
is_column_attr[14] = "x"
is_column_attr[15] = "font.family"
is_column_attr[16] = "font.pitch"
is_column_attr[17] = "font.strikethrough"
is_column_attr[18] = "moveable"
is_column_attr[19] = "resizeable"
is_column_attr[20] = "tabsequence"
is_column_attr[21] = "y"

// Initialize attributes for text object type
is_text_attr[1]  = "height"
is_text_attr[2]  = "width"
is_text_attr[3]  = "border"
is_text_attr[4]  = "alignment"
is_text_attr[5]  = "background.color"
is_text_attr[6]  = "color"
is_text_attr[7]  = "font.face"
is_text_attr[8]  = "font.height"
is_text_attr[9]  = "font.italic"
is_text_attr[10]  = "font.underline"
is_text_attr[11]  = "font.weight"
is_text_attr[12]  = "text"
is_text_attr[13]  = "visible"
is_text_attr[14] = "x"
is_text_attr[15] = "font.family"
is_text_attr[16] = "font.pitch"
is_text_attr[17] = "font.strikethrough"
is_text_attr[18] = "moveable"
is_text_attr[19] = "resizeable"
is_text_attr[20] = "y"

// Now select the first object
tab_1.tabpage_mod.lb_objects.SelectItem (1)
is_object_name = tab_1.tabpage_mod.lb_objects.SelectedItem()
tab_1.tabpage_mod.lb_objects.TriggerEvent (SelectionChanged!)

// Put pointer within SLE_COMMAND
tab_1.tabpage_mod.sle_command.SetFocus()

end event

on w_customize_dw.create
this.tab_1=create tab_1
this.cb_apply=create cb_apply
this.cb_help=create cb_help
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={ this.tab_1,&
this.cb_apply,&
this.cb_help,&
this.cb_close,&
this.dw_1}
end on

on w_customize_dw.destroy
destroy(this.tab_1)
destroy(this.cb_apply)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event close;w_main.Show()
end event

type tab_1 from tab within w_customize_dw
int X=23
int Y=4
int Width=2053
int Height=884
int TabOrder=10
boolean RaggedRight=true
int SelectedTab=1
long BackColor=73955432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_mod tabpage_mod
tabpage_object tabpage_object
end type

on tab_1.create
this.tabpage_mod=create tabpage_mod
this.tabpage_object=create tabpage_object
this.Control[]={ this.tabpage_mod,&
this.tabpage_object}
end on

on tab_1.destroy
destroy(this.tabpage_mod)
destroy(this.tabpage_object)
end on

event selectionchanged;If newindex = 2 Then
	// Use direct object reference syntax to set the current attribute values
	tab_1.tabpage_object.ddlb_nameborder.Text = String(dw_1.Object.name.border)
	tab_1.tabpage_object.ddlb_namealign.Text = String(dw_1.Object.name.alignment)
	tab_1.tabpage_object.sle_nameface.Text = dw_1.Object.name.font.face
	tab_1.tabpage_object.ddlb_nameweight.Text = String(dw_1.Object.name.font.weight)
	tab_1.tabpage_object.ddlb_nametborder.Text = String(dw_1.Object.name_t.border)
	tab_1.tabpage_object.ddlb_nametalign.Text = String(dw_1.Object.name_t.alignment)
	tab_1.tabpage_object.sle_nametface.Text = dw_1.Object.name_t.font.face
	tab_1.tabpage_object.ddlb_nametweight.Text = String(dw_1.Object.name_t.font.weight)
Else
	// Select the first item in the list
	tab_1.tabpage_mod.lb_objects.SelectItem (1)
	is_object_name = tab_1.tabpage_mod.lb_objects.SelectedItem()
	tab_1.tabpage_mod.lb_objects.TriggerEvent (SelectionChanged!)
End if

end event

type tabpage_mod from userobject within tab_1
int X=18
int Y=100
int Width=2016
int Height=768
long BackColor=74481808
string Text="Use Modify() and Describe()"
long TabBackColor=74481808
long TabTextColor=41943040
long PictureMaskColor=536870912
st_14 st_14
st_15 st_15
sle_command sle_command
st_16 st_16
st_header st_header
st_val_header st_val_header
lb_objects lb_objects
lb_attributes lb_attributes
lb_attrib_val lb_attrib_val
end type

on tabpage_mod.create
this.st_14=create st_14
this.st_15=create st_15
this.sle_command=create sle_command
this.st_16=create st_16
this.st_header=create st_header
this.st_val_header=create st_val_header
this.lb_objects=create lb_objects
this.lb_attributes=create lb_attributes
this.lb_attrib_val=create lb_attrib_val
this.Control[]={ this.st_14,&
this.st_15,&
this.sle_command,&
this.st_16,&
this.st_header,&
this.st_val_header,&
this.lb_objects,&
this.lb_attributes,&
this.lb_attrib_val}
end on

on tabpage_mod.destroy
destroy(this.st_14)
destroy(this.st_15)
destroy(this.sle_command)
destroy(this.st_16)
destroy(this.st_header)
destroy(this.st_val_header)
destroy(this.lb_objects)
destroy(this.lb_attributes)
destroy(this.lb_attrib_val)
end on

type st_14 from statictext within tabpage_mod
int X=5
int Y=36
int Width=206
int Height=64
boolean Enabled=false
string Text="Modify ("
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_15 from statictext within tabpage_mod
int X=1920
int Y=32
int Width=64
int Height=64
boolean Enabled=false
string Text=")"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_command from singlelineedit within tabpage_mod
int X=233
int Y=20
int Width=1664
int Height=80
int TabOrder=11
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_16 from statictext within tabpage_mod
int X=23
int Y=140
int Width=581
int Height=64
boolean Enabled=false
string Text="DataWindow Objects"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_header from statictext within tabpage_mod
int X=709
int Y=144
int Width=594
int Height=64
boolean Enabled=false
string Text="Object Attributes"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_val_header from statictext within tabpage_mod
int X=1385
int Y=144
int Width=562
int Height=64
boolean Enabled=false
string Text="Attribute Values"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_objects from listbox within tabpage_mod
int X=23
int Y=212
int Width=608
int Height=548
int TabOrder=81
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
long BackColor=73955432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;// Build Modify syntax based on the object selected.

// Depending on the type of object select (text or column), populate
// the attributes listbox with valid choices.

Integer	li_Cnt, li_Text, li_Col
Long		ll_Gray


// Get the dark grey RGB value
ll_Gray = RGB (128, 128, 128)


// Get the selected object and begin building Modify syntax
is_object_name = This.SelectedItem()
tab_1.tabpage_mod.sle_command.Text = "~"" + is_object_name + "=~""

// Depending on the type of datawindow object, show the appropriate
// list of attributes.

If dw_1.Describe (is_object_name + ".type") = "text" Then
	// If column attributes are being displayed, display text attributes
	If ib_Column Then
		tab_1.tabpage_mod.lb_attributes.Reset()
		tab_1.tabpage_mod.lb_attributes.SetRedraw (False)

		li_Text = UpperBound(is_text_attr)
		For li_Cnt = 1 To li_Text
			tab_1.tabpage_mod.lb_attributes.AddItem(is_text_attr[li_Cnt])
		Next

		tab_1.tabpage_mod.st_header.Text = 'DW Text attributes'
		ib_Column = False
		tab_1.tabpage_mod.lb_attributes.SetRedraw(True)
	Else
		// Deselect attributes
		tab_1.tabpage_mod.lb_attributes.SelectItem (0)
	End If
Else
	// If column attributes are not being displayed, display them
	If Not ib_Column Then
		tab_1.tabpage_mod.lb_attributes.Reset()
		tab_1.tabpage_mod.lb_attributes.SetRedraw (False)

		li_Col = UpperBound(is_column_attr)
		For li_Cnt = 1 To li_Col
			tab_1.tabpage_mod.lb_attributes.AddItem (is_column_attr[li_Cnt])
		Next

		tab_1.tabpage_mod.st_header.Text = 'DW Column attributes'
		ib_Column = True
		tab_1.tabpage_mod.lb_attributes.SetRedraw (True)
	Else
		// Deselect attributes
		tab_1.tabpage_mod.lb_attributes.SelectItem (0)
	End If
End If

// Reset the attribute values listbox
tab_1.tabpage_mod.lb_attrib_val.Reset()
tab_1.tabpage_mod.st_val_header.Text = 'Attribute values'
tab_1.tabpage_mod.st_val_header.textcolor = ll_Gray
tab_1.tabpage_mod.lb_attrib_val.Enabled = False

end event

type lb_attributes from listbox within tabpage_mod
int X=709
int Y=212
int Width=608
int Height=548
int TabOrder=82
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
long BackColor=73955432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;// Once an attribute has been selected, get the value of the attribute
// from the datawindow and build the rest of the Modify syntax.

String	ls_Attr, ls_Value
Long		ll_Gray
Integer	li_Pos


// Get the RGB value for dark gray
ll_Gray = RGB (128, 128, 128)

ls_Attr = This.SelectedItem()
ls_Value = dw_1.Describe (is_object_name + "." + ls_attr)


// Populate attribute values listbox
of_fill_attributes (ls_attr, ls_value)
If tab_1.tabpage_mod.lb_attrib_val.TotalItems() > 0 Then
	tab_1.tabpage_mod.st_val_header.Text = ls_attr + ' values'
	tab_1.tabpage_mod.st_val_header.TextColor = tab_1.tabpage_mod.st_header.TextColor
	tab_1.tabpage_mod.lb_attrib_val.Enabled = True
Else
	tab_1.tabpage_mod.st_val_header.Text = 'Attribute values'
	tab_1.tabpage_mod.st_val_header.TextColor = ll_gray
	tab_1.tabpage_mod.lb_attrib_val.Enabled = False
End If

//////////////////////////////////////////////////////////////////////
// We now have complete syntax in the SLE. It's ready to modify and
// execute, by hitting the Apply button.
//////////////////////////////////////////////////////////////////////

// If the attribute selected is moveable or resizeable, the Modify
// syntax after the equal sign does not need quotes
If ls_Attr = 'moveable' or ls_Attr = 'resizeable' Then
	tab_1.tabpage_mod.sle_command.Text = is_object_name + "." + ls_attr + '=' + ls_value 
Else
	tab_1.tabpage_mod.sle_command.Text = is_object_name + "." + ls_attr + '="' + ls_value + '"'
End If

// If attribute values listbox contains values, select the value portion
// of the Modify syntax to make it easy for the user to paste a selection
// from the values listbox

If tab_1.tabpage_mod.lb_attrib_val.TotalItems() > 0 Then
	tab_1.tabpage_mod.sle_command.SetFocus()
	li_Pos = Pos (tab_1.tabpage_mod.sle_command.text, '"')
	If li_Pos = 0 Then
		li_Pos = Pos (tab_1.tabpage_mod.sle_command.text, '=')
	End If
	If li_Pos > 0 Then
		tab_1.tabpage_mod.sle_command.SelectText (li_pos + 1, 1)
	End If
End If

end event

type lb_attrib_val from listbox within tabpage_mod
int X=1385
int Y=212
int Width=608
int Height=548
int TabOrder=81
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
long BackColor=73955432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;// If there is text selected in the dwModify syntax, replace it with
// the new selection from the user

Integer	li_Length, li_Pos

li_Length = tab_1.tabpage_mod.sle_command.SelectedLength() 
If li_Length > 0 Then
	tab_1.tabpage_mod.sle_command.ReplaceText(Left(This.SelectedItem(), 1))

	// Text has been replaced, set focus back to the single line edit
	// and reselect the attribute value.
	tab_1.tabpage_mod.sle_command.SetFocus()
	li_Pos = Pos(tab_1.tabpage_mod.sle_command.text, '"', 1)
	If li_Pos = 0 Then
		li_Pos = Pos(tab_1.tabpage_mod.sle_command.text, '=', 1)
	End If
	tab_1.tabpage_mod.sle_command.SelectText (li_Pos + 1, 1)
End If

end event

type tabpage_object from userobject within tab_1
int X=18
int Y=100
int Width=2016
int Height=768
long BackColor=74481808
string Text="Use Direct Object Reference Syntax"
long TabBackColor=74481808
long TabTextColor=41943040
long PictureMaskColor=536870912
st_18 st_18
st_20 st_20
st_19 st_19
st_21 st_21
st_22 st_22
st_23 st_23
st_24 st_24
st_25 st_25
st_26 st_26
ddlb_nameborder ddlb_nameborder
ddlb_namealign ddlb_namealign
ddlb_nameweight ddlb_nameweight
sle_nameface sle_nameface
ddlb_nametweight ddlb_nametweight
sle_nametface sle_nametface
ddlb_nametalign ddlb_nametalign
ddlb_nametborder ddlb_nametborder
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type

on tabpage_object.create
this.st_18=create st_18
this.st_20=create st_20
this.st_19=create st_19
this.st_21=create st_21
this.st_22=create st_22
this.st_23=create st_23
this.st_24=create st_24
this.st_25=create st_25
this.st_26=create st_26
this.ddlb_nameborder=create ddlb_nameborder
this.ddlb_namealign=create ddlb_namealign
this.ddlb_nameweight=create ddlb_nameweight
this.sle_nameface=create sle_nameface
this.ddlb_nametweight=create ddlb_nametweight
this.sle_nametface=create sle_nametface
this.ddlb_nametalign=create ddlb_nametalign
this.ddlb_nametborder=create ddlb_nametborder
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.Control[]={ this.st_18,&
this.st_20,&
this.st_19,&
this.st_21,&
this.st_22,&
this.st_23,&
this.st_24,&
this.st_25,&
this.st_26,&
this.ddlb_nameborder,&
this.ddlb_namealign,&
this.ddlb_nameweight,&
this.sle_nameface,&
this.ddlb_nametweight,&
this.sle_nametface,&
this.ddlb_nametalign,&
this.ddlb_nametborder,&
this.st_1,&
this.st_2,&
this.st_3,&
this.st_4}
end on

on tabpage_object.destroy
destroy(this.st_18)
destroy(this.st_20)
destroy(this.st_19)
destroy(this.st_21)
destroy(this.st_22)
destroy(this.st_23)
destroy(this.st_24)
destroy(this.st_25)
destroy(this.st_26)
destroy(this.ddlb_nameborder)
destroy(this.ddlb_namealign)
destroy(this.ddlb_nameweight)
destroy(this.sle_nameface)
destroy(this.ddlb_nametweight)
destroy(this.sle_nametface)
destroy(this.ddlb_nametalign)
destroy(this.ddlb_nametborder)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

type st_18 from statictext within tabpage_object
int X=41
int Y=4
int Width=471
int Height=64
boolean Enabled=false
string Text="DataWindow Object"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_20 from statictext within tabpage_object
int X=1029
int Y=4
int Width=357
int Height=64
boolean Enabled=false
string Text="Attribute Value"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_19 from statictext within tabpage_object
int X=576
int Y=4
int Width=370
int Height=64
boolean Enabled=false
string Text="Object Attribute"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
boolean Underline=true
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_21 from statictext within tabpage_object
int X=41
int Y=72
int Width=192
int Height=64
boolean Enabled=false
string Text="name"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_22 from statictext within tabpage_object
int X=41
int Y=436
int Width=192
int Height=64
boolean Enabled=false
string Text="name_t"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_23 from statictext within tabpage_object
int X=576
int Y=72
int Width=206
int Height=64
boolean Enabled=false
string Text="border"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_24 from statictext within tabpage_object
int X=576
int Y=164
int Width=233
int Height=64
boolean Enabled=false
string Text="alignment"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_25 from statictext within tabpage_object
int X=576
int Y=244
int Width=206
int Height=64
boolean Enabled=false
string Text="font.face"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_26 from statictext within tabpage_object
int X=576
int Y=344
int Width=256
int Height=64
boolean Enabled=false
string Text="font.weight"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_nameborder from dropdownlistbox within tabpage_object
int X=1029
int Y=68
int Width=448
int Height=468
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"0 - None",&
"1- Shadow",&
"2 - Rectangle",&
"3 - Resize",&
"4 - Line",&
"5 - 3D Lowered",&
"6 - 3D Raised"}
end type

type ddlb_namealign from dropdownlistbox within tabpage_object
int X=1029
int Y=152
int Width=329
int Height=308
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"0 - Left",&
"1 - Right",&
"2 - Center"}
end type

type ddlb_nameweight from dropdownlistbox within tabpage_object
int X=1029
int Y=332
int Width=389
int Height=260
int TabOrder=110
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"400 - Normal",&
"700 - Bold"}
end type

type sle_nameface from singlelineedit within tabpage_object
int X=1029
int Y=240
int Width=384
int Height=84
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_nametweight from dropdownlistbox within tabpage_object
int X=1029
int Y=692
int Width=389
int Height=260
int TabOrder=120
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"400 - Normal",&
"700 - Bold"}
end type

type sle_nametface from singlelineedit within tabpage_object
int X=1029
int Y=600
int Width=384
int Height=84
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_nametalign from dropdownlistbox within tabpage_object
int X=1029
int Y=512
int Width=329
int Height=308
int TabOrder=100
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"0 - Left",&
"1 - Right",&
"2 - Center"}
end type

type ddlb_nametborder from dropdownlistbox within tabpage_object
int X=1029
int Y=424
int Width=448
int Height=468
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"0 - None",&
"1- Shadow",&
"2 - Rectangle",&
"3 - Resize",&
"4 - Line",&
"5 - 3D Lowered",&
"6 - 3D Raised"}
end type

type st_1 from statictext within tabpage_object
int X=576
int Y=436
int Width=206
int Height=64
boolean Enabled=false
string Text="border"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within tabpage_object
int X=576
int Y=516
int Width=233
int Height=64
boolean Enabled=false
string Text="alignment"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within tabpage_object
int X=576
int Y=612
int Width=206
int Height=64
boolean Enabled=false
string Text="font.face"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within tabpage_object
int X=576
int Y=696
int Width=256
int Height=64
boolean Enabled=false
string Text="font.weight"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=73955432
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_apply from commandbutton within w_customize_dw
int X=2158
int Y=52
int Width=279
int Height=84
int TabOrder=30
string Text="Apply"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Err

If tab_1.SelectedTab = 1 Then
	// Execute the dwModify syntax in the single line edit
	ls_Err = dw_1.Modify (tab_1.tabpage_mod.sle_command.Text)

	If Len (ls_Err) > 0 Then
		MessageBox ("Modify failed", ls_Err)
	End If
Else
	// Use direct object reference syntax to modify the objects as entered
	dw_1.Object.name.border = Integer(Left(tab_1.tabpage_object.ddlb_nameborder.Text, 1))
	dw_1.Object.name.alignment = Integer(Left(tab_1.tabpage_object.ddlb_namealign.Text, 1))
	dw_1.Object.name.font.face = tab_1.tabpage_object.sle_nameface.Text
	dw_1.Object.name.font.weight = Integer(Left(tab_1.tabpage_object.ddlb_nameweight.Text, 3))
	dw_1.Object.name_t.border = Integer(Left(tab_1.tabpage_object.ddlb_nametborder.Text, 1))
	dw_1.Object.name_t.alignment = Integer(Left(tab_1.tabpage_object.ddlb_nametalign.Text, 1))
	dw_1.Object.name_t.font.face = tab_1.tabpage_object.sle_nametface.Text
	dw_1.Object.name_t.font.weight = Integer(Left(tab_1.tabpage_object.ddlb_nametweight.Text, 3))
End if

end event

type cb_help from commandbutton within w_customize_dw
int X=2158
int Y=332
int Width=279
int Height=84
int TabOrder=130
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ('w_customize_dw')
end event

type cb_close from commandbutton within w_customize_dw
int X=2158
int Y=192
int Width=279
int Height=84
int TabOrder=60
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close (Parent)
end event

type dw_1 from datawindow within w_customize_dw
int X=46
int Y=912
int Width=2437
int Height=736
int TabOrder=20
string DataObject="d_emp_for_modify"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event error;integer i
i = 1

end event

