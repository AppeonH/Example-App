$PBExportHeader$w_dw_html.srw
$PBExportComments$Example used to create an HTML table or form from a DataWindow
forward
global type w_dw_html from w_center
end type
type tab_1 from tab within w_dw_html
end type
type tabpage_dw from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_dw
end type
type tabpage_html from userobject within tab_1
end type
type mle_1 from multilineedit within tabpage_html
end type
type st_buffer from statictext within w_dw_html
end type
type rb_filter from radiobutton within w_dw_html
end type
type rb_delete from radiobutton within w_dw_html
end type
type rb_primary from radiobutton within w_dw_html
end type
type ddlb_endcol from dropdownlistbox within w_dw_html
end type
type st_endcol from statictext within w_dw_html
end type
type st_startcol from statictext within w_dw_html
end type
type ddlb_startcol from dropdownlistbox within w_dw_html
end type
type st_endrow from statictext within w_dw_html
end type
type sle_endrow from singlelineedit within w_dw_html
end type
type sle_startrow from singlelineedit within w_dw_html
end type
type st_startrow from statictext within w_dw_html
end type
type st_border from statictext within w_dw_html
end type
type sle_border from singlelineedit within w_dw_html
end type
type st_spacing from statictext within w_dw_html
end type
type sle_spacing from singlelineedit within w_dw_html
end type
type sle_padding from singlelineedit within w_dw_html
end type
type st_padding from statictext within w_dw_html
end type
type st_width from statictext within w_dw_html
end type
type sle_width from singlelineedit within w_dw_html
end type
type cbx_wrap from checkbox within w_dw_html
end type
type cbx_css from checkbox within w_dw_html
end type
type cb_html from commandbutton within w_dw_html
end type
type rb_form from radiobutton within w_dw_html
end type
type rb_table from radiobutton within w_dw_html
end type
type st_1 from statictext within w_dw_html
end type
type ddlb_1 from dropdownlistbox within w_dw_html
end type
type cb_browse from commandbutton within w_dw_html
end type
type cb_help from commandbutton within w_dw_html
end type
type cb_close from commandbutton within w_dw_html
end type
type gb_table from groupbox within w_dw_html
end type
type gb_1 from groupbox within w_dw_html
end type
type st_bufferb from statictext within w_dw_html
end type
type gb_form from groupbox within w_dw_html
end type
type tabpage_dw from userobject within tab_1
dw_1 dw_1
end type
type tabpage_html from userobject within tab_1
mle_1 mle_1
end type
type tab_1 from tab within w_dw_html
tabpage_dw tabpage_dw
tabpage_html tabpage_html
end type
end forward

global type w_dw_html from w_center
int X=0
int Y=4
int Width=2885
int Height=1800
boolean TitleBar=true
string Title="DataWindow HTML Table"
long BackColor=75530304
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
tab_1 tab_1
st_buffer st_buffer
rb_filter rb_filter
rb_delete rb_delete
rb_primary rb_primary
ddlb_endcol ddlb_endcol
st_endcol st_endcol
st_startcol st_startcol
ddlb_startcol ddlb_startcol
st_endrow st_endrow
sle_endrow sle_endrow
sle_startrow sle_startrow
st_startrow st_startrow
st_border st_border
sle_border sle_border
st_spacing st_spacing
sle_spacing sle_spacing
sle_padding sle_padding
st_padding st_padding
st_width st_width
sle_width sle_width
cbx_wrap cbx_wrap
cbx_css cbx_css
cb_html cb_html
rb_form rb_form
rb_table rb_table
st_1 st_1
ddlb_1 ddlb_1
cb_browse cb_browse
cb_help cb_help
cb_close cb_close
gb_table gb_table
gb_1 gb_1
st_bufferb st_bufferb
gb_form gb_form
end type
global w_dw_html w_dw_html

type prototypes

end prototypes

type variables
String	is_Browser, is_Files[]
Boolean	ib_LongFileNames
Inet	iin_Context
end variables

forward prototypes
public subroutine of_add_columns ()
public function string of_write_file (string as_html)
public subroutine of_generate_html ()
end prototypes

public subroutine of_add_columns ();String	ls_Column
Integer	li_Columns, li_Cnt

ddlb_startcol.Reset()
ddlb_endcol.Reset()
ddlb_startcol.AddItem("")
ddlb_endcol.AddItem("")

li_Columns = Integer(tab_1.tabpage_dw.dw_1.Describe("Datawindow.column.count"))
For li_Cnt = 1 To li_Columns
	ls_Column = tab_1.tabpage_dw.dw_1.Describe("#" + String(li_Cnt) + ".name")
	ddlb_startcol.AddItem(ls_Column)
	ddlb_endcol.AddItem(ls_Column)
Next

end subroutine

public function string of_write_file (string as_html);String	ls_FileName
Integer	li_FileNumber, li_Files
Long		ll_BytesWritten

If ib_LongFileNames Then
	ls_FileName = tab_1.tabpage_dw.dw_1.DataObject + ".htm"
Else
	ls_FileName = Left(tab_1.tabpage_dw.dw_1.DataObject, 8) + ".htm"
End If

li_FileNumber = FileOpen(ls_FileName, StreamMode!, Write!, LockReadWrite!, Replace! )

If (li_FileNumber >= 0) Then
	ll_BytesWritten = FileWrite(li_FileNumber, as_HTML)
	FileClose(li_FileNumber)
	
	If ll_BytesWritten = Len(as_HTML) Then
		//  Add file to list to be deleted
		li_Files = UpperBound(is_Files)
		is_Files[li_Files + 1] = gs_ExampleDir + "\" + ls_FileName
	Else
		MessageBox ("Write Error", "Only wrote " + String(ll_BytesWritten) + &
							" of " + String(Len(as_HTML)) + " bytes.", Exclamation!)
		Return ""
	End If

Else // File open error
	MessageBox ("FileOpen Error", "Could not open file: " + ls_FileName + &
						" (" + String( li_FileNumber ) + ")")
	Return ""
End If

Return ls_FileName

end function

public subroutine of_generate_html ();String	ls_HTML, ls_FileName, ls_Style, ls_Action, ls_Modify
Integer	li_StartCol, li_EndCol

// Don't proceed if there is no data object loaded in the DW
If (tab_1.tabpage_dw.dw_1.dataobject = "") Then Return

// Generate the HTML
If rb_table.Checked Then
	
	// HTML Table
	If cbx_css.Checked Then
		ls_Modify = "DataWindow.HTMLTable.GenerateCSS=~"yes~" "
		ls_Style = tab_1.tabpage_dw.dw_1.Object.DataWindow.HTMLTable.StyleSheet
	End If
	
	If cbx_wrap.Checked Then
		ls_Modify += "DataWindow.HTMLTable.NoWrap=~"no~" "
	End If
	
	If Integer(sle_border.Text) > 0 Then
		ls_Modify += "DataWindow.HTMLTable.Border=" + sle_border.Text + "  "
	End If
	
	If Integer(sle_width.Text) > 0 Then
		ls_Modify += "DataWindow.HTMLTable.Width=" + sle_width.Text + " "
	End If
	
	If Integer(sle_padding.Text) > 0 Then
		ls_Modify += "DataWindow.HTMLTable.CellPadding=" + sle_padding.Text + " "
	End If

	If Integer(sle_spacing.Text) > 0 Then
		ls_Modify += "DataWindow.HTMLTable.CellSpacing=" + sle_spacing.Text
	End If
	
	If Trim(ls_Modify) <> "" Then
		tab_1.tabpage_dw.dw_1.Modify(ls_Modify)
	End If
	
	ls_HTML = ls_Style + "~r~n" + tab_1.tabpage_dw.dw_1.Object.DataWindow.Data.HTMLTable
Else
	
	// HTML Form
	li_StartCol = ddlb_startcol.FindItem(ddlb_startcol.Text, 0) - 1
	li_EndCol = ddlb_endcol.FindItem(ddlb_endcol.Text, 0) - 1

	If (Integer(sle_startrow.Text) > 0) And (Integer(sle_endrow.Text) > 0) And &
		(li_StartCol > 0) And (li_EndCol > 0) Then
		
		If rb_primary.Checked Then
			tab_1.tabpage_dw.dw_1.GenerateHTMLForm(ls_HTML, ls_Style, ls_Action, Integer(sle_startrow.Text), Integer(sle_endrow.Text), &
													li_StartCol, li_EndCol)
		ElseIf rb_delete.Checked Then
			tab_1.tabpage_dw.dw_1.GenerateHTMLForm(ls_HTML, ls_Style, ls_Action, Integer(sle_startrow.Text), Integer(sle_endrow.Text), &
													li_StartCol, li_EndCol, Delete!)
		Else
			tab_1.tabpage_dw.dw_1.GenerateHTMLForm(ls_HTML, ls_Style, ls_Action, Integer(sle_startrow.Text), Integer(sle_endrow.Text), &
													li_StartCol, li_EndCol, Filter!)
		End If
	Else
		tab_1.tabpage_dw.dw_1.GenerateHTMLForm(ls_HTML, ls_Style, ls_Action)
	End If

	ls_HTML = ls_Style + "~r~n" + ls_HTML
End If

If IsNull(ls_HTML) Or Len(ls_HTML) <= 1 Then
	MessageBox ("Error", "Error generating HTML table.", Exclamation!)
	Return
Else
	ls_HTML = "<H1>PowerBuilder HTML Table Generated From DataWindow:  "  + &
					tab_1.tabpage_dw.dw_1.DataObject + "</H1><P>" + ls_HTML
End If

// Display the HTML source
tab_1.tabpage_html.mle_1.Text = ls_HTML

end subroutine

event close;Integer	li_Cnt, li_Files

// Delete all file created
li_Files = UpperBound(is_Files)
For li_Cnt = 1 To li_Files
	FileDelete(is_Files[li_Cnt])
Next

w_main.show()
end event

on w_dw_html.create
this.tab_1=create tab_1
this.st_buffer=create st_buffer
this.rb_filter=create rb_filter
this.rb_delete=create rb_delete
this.rb_primary=create rb_primary
this.ddlb_endcol=create ddlb_endcol
this.st_endcol=create st_endcol
this.st_startcol=create st_startcol
this.ddlb_startcol=create ddlb_startcol
this.st_endrow=create st_endrow
this.sle_endrow=create sle_endrow
this.sle_startrow=create sle_startrow
this.st_startrow=create st_startrow
this.st_border=create st_border
this.sle_border=create sle_border
this.st_spacing=create st_spacing
this.sle_spacing=create sle_spacing
this.sle_padding=create sle_padding
this.st_padding=create st_padding
this.st_width=create st_width
this.sle_width=create sle_width
this.cbx_wrap=create cbx_wrap
this.cbx_css=create cbx_css
this.cb_html=create cb_html
this.rb_form=create rb_form
this.rb_table=create rb_table
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_browse=create cb_browse
this.cb_help=create cb_help
this.cb_close=create cb_close
this.gb_table=create gb_table
this.gb_1=create gb_1
this.st_bufferb=create st_bufferb
this.gb_form=create gb_form
this.Control[]={this.tab_1,&
this.st_buffer,&
this.rb_filter,&
this.rb_delete,&
this.rb_primary,&
this.ddlb_endcol,&
this.st_endcol,&
this.st_startcol,&
this.ddlb_startcol,&
this.st_endrow,&
this.sle_endrow,&
this.sle_startrow,&
this.st_startrow,&
this.st_border,&
this.sle_border,&
this.st_spacing,&
this.sle_spacing,&
this.sle_padding,&
this.st_padding,&
this.st_width,&
this.sle_width,&
this.cbx_wrap,&
this.cbx_css,&
this.cb_html,&
this.rb_form,&
this.rb_table,&
this.st_1,&
this.ddlb_1,&
this.cb_browse,&
this.cb_help,&
this.cb_close,&
this.gb_table,&
this.gb_1,&
this.st_bufferb,&
this.gb_form}
end on

on w_dw_html.destroy
destroy(this.tab_1)
destroy(this.st_buffer)
destroy(this.rb_filter)
destroy(this.rb_delete)
destroy(this.rb_primary)
destroy(this.ddlb_endcol)
destroy(this.st_endcol)
destroy(this.st_startcol)
destroy(this.ddlb_startcol)
destroy(this.st_endrow)
destroy(this.sle_endrow)
destroy(this.sle_startrow)
destroy(this.st_startrow)
destroy(this.st_border)
destroy(this.sle_border)
destroy(this.st_spacing)
destroy(this.sle_spacing)
destroy(this.sle_padding)
destroy(this.st_padding)
destroy(this.st_width)
destroy(this.sle_width)
destroy(this.cbx_wrap)
destroy(this.cbx_css)
destroy(this.cb_html)
destroy(this.rb_form)
destroy(this.rb_table)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_browse)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.gb_table)
destroy(this.gb_1)
destroy(this.st_bufferb)
destroy(this.gb_form)
end on

event open;call super::open;// Determine if long file names are in use
If ge_Environment.OSType = Sol2! Then
	ib_LongFileNames = True
Elseif (ge_Environment.OSType = WindowsNT!) Or &
	(ge_Environment.OSType = Windows! And &
	(ge_Environment.OSMajorRevision = 4 Or ge_Environment.OSMinorRevision = 95)) Then
	ib_LongFileNames = True
Else
	ib_LongFileNames = False
End If

// Create Internet Context Service - this is used to open the default browser
If (ge_Environment.OSType = windows!) Or (ge_Environment.OSType = windowsNT!) Then
	// This service is only available on Win32
	This.GetContextService("Internet", iin_Context)
End If

end event

type tab_1 from tab within w_dw_html
event create ( )
event destroy ( )
int X=5
int Y=464
int Width=2866
int Height=1092
int TabOrder=130
boolean RaggedRight=true
int SelectedTab=1
TabPosition TabPosition=TabsOnBottom!
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_dw tabpage_dw
tabpage_html tabpage_html
end type

on tab_1.create
this.tabpage_dw=create tabpage_dw
this.tabpage_html=create tabpage_html
this.Control[]={this.tabpage_dw,&
this.tabpage_html}
end on

on tab_1.destroy
destroy(this.tabpage_dw)
destroy(this.tabpage_html)
end on

type tabpage_dw from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=16
int Width=2830
int Height=976
long BackColor=80242744
string Text="DataWindow Display"
long TabBackColor=80242744
long TabTextColor=33554432
long PictureMaskColor=536870912
dw_1 dw_1
end type

on tabpage_dw.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_dw.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within tabpage_dw
int Width=2821
int Height=972
int TabOrder=21
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type tabpage_html from userobject within tab_1
event create ( )
event destroy ( )
int X=18
int Y=16
int Width=2830
int Height=976
long BackColor=80242744
string Text="HTML Source"
long TabBackColor=80242744
long TabTextColor=33554432
long PictureMaskColor=536870912
mle_1 mle_1
end type

on tabpage_html.create
this.mle_1=create mle_1
this.Control[]={this.mle_1}
end on

on tabpage_html.destroy
destroy(this.mle_1)
end on

type mle_1 from multilineedit within tabpage_html
int Width=2821
int Height=972
int TabOrder=22
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_buffer from statictext within w_dw_html
int X=2103
int Y=172
int Width=261
int Height=48
boolean Visible=false
boolean Enabled=false
string Text="Buffer:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_filter from radiobutton within w_dw_html
int X=2117
int Y=352
int Width=283
int Height=76
boolean Visible=false
string Text="Filter"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_delete from radiobutton within w_dw_html
int X=2117
int Y=288
int Width=283
int Height=76
boolean Visible=false
string Text="Delete"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_primary from radiobutton within w_dw_html
int X=2117
int Y=228
int Width=283
int Height=76
boolean Visible=false
string Text="Primary"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_endcol from dropdownlistbox within w_dw_html
int X=1179
int Y=332
int Width=850
int Height=308
int TabOrder=120
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_endcol from statictext within w_dw_html
int X=846
int Y=340
int Width=334
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="End Column:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_startcol from statictext within w_dw_html
int X=846
int Y=236
int Width=334
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Start Column:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_startcol from dropdownlistbox within w_dw_html
int X=1179
int Y=224
int Width=850
int Height=308
int TabOrder=110
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_endrow from statictext within w_dw_html
int X=370
int Y=340
int Width=265
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="End Row:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_endrow from singlelineedit within w_dw_html
int X=635
int Y=332
int Width=187
int Height=92
int TabOrder=100
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
int Limit=4
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_startrow from singlelineedit within w_dw_html
int X=635
int Y=224
int Width=187
int Height=92
int TabOrder=90
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
int Limit=4
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_startrow from statictext within w_dw_html
int X=370
int Y=236
int Width=265
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Start Row:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_border from statictext within w_dw_html
int X=1193
int Y=332
int Width=338
int Height=76
boolean Enabled=false
string Text="Border Width:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_border from singlelineedit within w_dw_html
int X=1531
int Y=324
int Width=187
int Height=92
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
int Limit=4
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_spacing from statictext within w_dw_html
int X=1847
int Y=332
int Width=325
int Height=76
boolean Enabled=false
string Text="Cell Spacing:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_spacing from singlelineedit within w_dw_html
int X=2176
int Y=324
int Width=187
int Height=92
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
int Limit=4
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_padding from singlelineedit within w_dw_html
int X=2176
int Y=220
int Width=187
int Height=92
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
int Limit=4
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_padding from statictext within w_dw_html
int X=1847
int Y=224
int Width=325
int Height=76
boolean Enabled=false
string Text="Cell Padding:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_width from statictext within w_dw_html
int X=1207
int Y=224
int Width=325
int Height=76
boolean Enabled=false
string Text="Table Width:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_width from singlelineedit within w_dw_html
int X=1531
int Y=220
int Width=187
int Height=92
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
int Limit=4
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_wrap from checkbox within w_dw_html
int X=434
int Y=332
int Width=622
int Height=76
int TabOrder=40
string Text="Wrap Text Within Cells"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_css from checkbox within w_dw_html
int X=434
int Y=224
int Width=553
int Height=76
int TabOrder=30
string Text="Create Style Sheet"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_html from commandbutton within w_dw_html
int X=896
int Y=1596
int Width=539
int Height=84
int TabOrder=150
string Text="Update HTML Source"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_generate_html()

end event

type rb_form from radiobutton within w_dw_html
int X=2578
int Y=52
int Width=233
int Height=64
string Text="Form"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=75530304
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.SetRedraw(False)

gb_table.Hide()
cbx_css.Hide()
cbx_wrap.Hide()
st_width.Hide()
sle_width.Hide()
st_border.Hide()
sle_border.Hide()
st_spacing.Hide()
sle_spacing.Hide()
st_padding.Hide()
sle_padding.Hide()

gb_form.Show()
st_startrow.Show()
sle_startrow.Show()
st_endrow.Show()
sle_endrow.Show()
st_startcol.Show()
ddlb_startcol.Show()
st_endcol.Show()
ddlb_endcol.Show()
st_buffer.Show()
st_bufferb.Show()
rb_primary.Show()
rb_delete.Show()
rb_filter.Show()

Parent.SetRedraw(True)

end event

type rb_table from radiobutton within w_dw_html
int X=2258
int Y=52
int Width=242
int Height=64
string Text="Table"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=75530304
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Parent.SetRedraw(False)

gb_form.Hide()
st_startrow.Hide()
sle_startrow.Hide()
st_endrow.Hide()
sle_endrow.Hide()
st_startcol.Hide()
ddlb_startcol.Hide()
st_endcol.Hide()
ddlb_endcol.Hide()
st_buffer.Hide()
st_bufferb.Hide()
rb_primary.Hide()
rb_delete.Hide()
rb_filter.Hide()

gb_table.Show()
cbx_css.Show()
cbx_wrap.Show()
st_width.Show()
sle_width.Show()
st_border.Show()
sle_border.Show()
st_spacing.Show()
sle_spacing.Show()
st_padding.Show()
sle_padding.Show()

Parent.SetRedraw(True)

end event

type st_1 from statictext within w_dw_html
int X=41
int Y=28
int Width=297
int Height=64
boolean Enabled=false
string Text="DataWindow:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=75530304
long BorderColor=8388608
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_1 from dropdownlistbox within w_dw_html
int X=361
int Y=28
int Width=1115
int Height=576
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"d_dwexample_crosstab  (Crosstab)",&
"d_dwexample_grid  (Grid)",&
"d_dwexample_tabular  (Tabular)",&
"d_dwexample_group  (Tabular with Groups)",&
"d_button_report  (Tabular with Buttons)",&
"d_sales_reps  (Freeform)",&
"d_contact_maintenance  (Freeform with Buttons)"}
end type

event selectionchanged;Integer	li_Pos
String	ls_DW

li_Pos = Pos(This.Text, "(")
ls_DW = Left(This.Text, (li_Pos - 3))

// Change the DataWindow to the selected one.
tab_1.tabpage_dw.dw_1.DataObject = ls_DW
tab_1.tabpage_dw.dw_1.SetTransObject(sqlca)
tab_1.tabpage_dw.dw_1.Retrieve()

of_add_columns()

end event

type cb_browse from commandbutton within w_dw_html
int X=297
int Y=1596
int Width=539
int Height=84
int TabOrder=140
string Text="Browse"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_FileName, ls_Browser, ls_BrowserName
Integer	li_Result


SetPointer(HourGlass!)

// Update the HTML source
cb_html.Trigger Event Clicked()

// Write the HTML to a file
ls_FileName = of_write_file(tab_1.tabpage_html.mle_1.Text)
If ls_FileName <> "" Then

	// Run browser with the HTML file
	// First, determine the browser to use
	If (ge_Environment.OSType = windows!) Or (ge_Environment.OSType = windowsNT!) Then

		// Use Context Object function to display the file in the default browser.
		If iin_Context.HyperlinkToURL("file://" + gs_ExampleDir + "\" +  ls_FileName) <> 1 Then
			MessageBox("Error", "Error running default browser.", StopSign!)
		End If	
	Else
		// The Context Object Internet service is only available on Win32, so have the user find the browser.
		If is_Browser = "" Then

			// Open dialog to select a browser.
			li_Result = GetFileOpenName("Select Browser", ls_Browser,  ls_BrowserName, &
														"exe", "Executable Files (*.exe),*.exe")
			If li_Result <> -1 Then
				is_Browser = ls_Browser
			Else
				MessageBox("DataWindow to HTML", "You must select the browser to use by selecting its executable.", Information!)
				Return
			End If
		End If
		
		// Run browser with the HTML file
		li_Result = Run(is_Browser + " file:\\" + gs_ExampleDir + "\" + ls_FileName)
		If li_Result = -1 Then
			MessageBox("Error", "Error running browser: " + is_Browser + " " + ls_FileName, Exclamation!)
		End If	

		// Executing this dialog resets the current working directory, set it back.
		w_main.of_set_cwd(gs_ExampleDir)
	End If
End If

end event

type cb_help from commandbutton within w_dw_html
int X=2098
int Y=1596
int Width=539
int Height=84
int TabOrder=170
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_dw_html")

end event

type cb_close from commandbutton within w_dw_html
int X=1495
int Y=1596
int Width=539
int Height=84
int TabOrder=160
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for cb_close
///////////////////////////////////////////////////////////////////////////////////////////////////////

// Close window
close(parent)
end event

type gb_table from groupbox within w_dw_html
int X=366
int Y=156
int Width=2089
int Height=288
string Text="Table Options:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_dw_html
int X=2217
int Width=603
int Height=132
int TabOrder=20
string Text="HTML Options"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=75530304
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_bufferb from statictext within w_dw_html
int X=2098
int Y=220
int Width=311
int Height=212
boolean Visible=false
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_form from groupbox within w_dw_html
int X=361
int Y=140
int Width=2089
int Height=308
boolean Visible=false
string Text="Form Options:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

