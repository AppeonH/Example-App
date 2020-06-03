$PBExportHeader$w_dw_print_options.srw
$PBExportComments$Print Options Dialog
forward
global type w_dw_print_options from w_center
end type
type ddlb_range from dropdownlistbox within w_dw_print_options
end type
type st_4 from statictext within w_dw_print_options
end type
type cb_printer from commandbutton within w_dw_print_options
end type
type cb_cancel from commandbutton within w_dw_print_options
end type
type cbx_collate from checkbox within w_dw_print_options
end type
type cbx_print_to_file from checkbox within w_dw_print_options
end type
type st_3 from statictext within w_dw_print_options
end type
type sle_page_range from singlelineedit within w_dw_print_options
end type
type rb_pages from radiobutton within w_dw_print_options
end type
type rb_current_page from radiobutton within w_dw_print_options
end type
type rb_all from radiobutton within w_dw_print_options
end type
type em_copies from editmask within w_dw_print_options
end type
type st_2 from statictext within w_dw_print_options
end type
type sle_printer from singlelineedit within w_dw_print_options
end type
type st_1 from statictext within w_dw_print_options
end type
type cb_ok from commandbutton within w_dw_print_options
end type
type gb_1 from groupbox within w_dw_print_options
end type
end forward

global type w_dw_print_options from w_center
int X=673
int Y=269
int Width=1857
int Height=1105
boolean TitleBar=true
string Title="Datawindow Print Options"
long BackColor=78748035
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
ddlb_range ddlb_range
st_4 st_4
cb_printer cb_printer
cb_cancel cb_cancel
cbx_collate cbx_collate
cbx_print_to_file cbx_print_to_file
st_3 st_3
sle_page_range sle_page_range
rb_pages rb_pages
rb_current_page rb_current_page
rb_all rb_all
em_copies em_copies
st_2 st_2
sle_printer sle_printer
st_1 st_1
cb_ok cb_ok
gb_1 gb_1
end type
global w_dw_print_options w_dw_print_options

type variables
string is_page_range
datawindow idw_dw
end variables

forward prototypes
private subroutine wf_page_range (radiobutton who)
end prototypes

private subroutine wf_page_range (radiobutton who);choose case who
	case rb_all
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'a'
	case rb_current_page
		sle_page_range.text = ''
		sle_page_range.enabled = false
		is_page_range = 'c'
	case rb_pages		
		sle_page_range.enabled = true
		is_page_range = 'p'
end choose
end subroutine

on open;call super::open;// we assume that this window will be opened using openwitparm and that
// a datawindow control will be passed to it

idw_dw = message.powerobjectparm
sle_printer.text = idw_dw.describe('datawindow.printer')
is_page_range = 'a'
end on

on w_dw_print_options.create
this.ddlb_range=create ddlb_range
this.st_4=create st_4
this.cb_printer=create cb_printer
this.cb_cancel=create cb_cancel
this.cbx_collate=create cbx_collate
this.cbx_print_to_file=create cbx_print_to_file
this.st_3=create st_3
this.sle_page_range=create sle_page_range
this.rb_pages=create rb_pages
this.rb_current_page=create rb_current_page
this.rb_all=create rb_all
this.em_copies=create em_copies
this.st_2=create st_2
this.sle_printer=create sle_printer
this.st_1=create st_1
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.Control[]={ this.ddlb_range,&
this.st_4,&
this.cb_printer,&
this.cb_cancel,&
this.cbx_collate,&
this.cbx_print_to_file,&
this.st_3,&
this.sle_page_range,&
this.rb_pages,&
this.rb_current_page,&
this.rb_all,&
this.em_copies,&
this.st_2,&
this.sle_printer,&
this.st_1,&
this.cb_ok,&
this.gb_1}
end on

on w_dw_print_options.destroy
destroy(this.ddlb_range)
destroy(this.st_4)
destroy(this.cb_printer)
destroy(this.cb_cancel)
destroy(this.cbx_collate)
destroy(this.cbx_print_to_file)
destroy(this.st_3)
destroy(this.sle_page_range)
destroy(this.rb_pages)
destroy(this.rb_current_page)
destroy(this.rb_all)
destroy(this.em_copies)
destroy(this.st_2)
destroy(this.sle_printer)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

type ddlb_range from dropdownlistbox within w_dw_print_options
int X=293
int Y=697
int Width=1066
int Height=289
int TabOrder=120
string Text="All Pages In Range"
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"All Pages in Range",&
"Even Numbered Pages",&
"Odd Numbered Pages"}
end type

type st_4 from statictext within w_dw_print_options
int X=65
int Y=709
int Width=174
int Height=69
boolean Enabled=false
string Text="P&rint:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_printer from commandbutton within w_dw_print_options
int X=1409
int Y=305
int Width=339
int Height=89
int TabOrder=110
string Text="Prin&ter..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;printsetup()
sle_printer.text = idw_dw.describe('datawindow.printer')
end on

type cb_cancel from commandbutton within w_dw_print_options
int X=1409
int Y=197
int Width=339
int Height=89
int TabOrder=100
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;closewithreturn(parent,-1)
end on

type cbx_collate from checkbox within w_dw_print_options
int X=1390
int Y=577
int Width=490
int Height=69
int TabOrder=80
string Text="Collate Cop&ies"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_print_to_file from checkbox within w_dw_print_options
int X=1390
int Y=485
int Width=435
int Height=69
int TabOrder=70
string Text="Print to Fi&le"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_dw_print_options
int X=106
int Y=549
int Width=1185
int Height=113
boolean Enabled=false
string Text="Enter page numbers and/or page ranges separated by commas. For example, 2,5,8-10"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_page_range from singlelineedit within w_dw_print_options
int X=417
int Y=449
int Width=883
int Height=85
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_pages from radiobutton within w_dw_print_options
int X=147
int Y=461
int Width=298
int Height=69
int TabOrder=50
string Text="Pa&ges:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_page_range(this)
end on

type rb_current_page from radiobutton within w_dw_print_options
int X=147
int Y=393
int Width=462
int Height=69
int TabOrder=40
string Text="Curr&ent Page"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_page_range(this)
end on

type rb_all from radiobutton within w_dw_print_options
int X=147
int Y=325
int Width=243
int Height=69
int TabOrder=30
string Text="&All"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_page_range(this)
end on

type em_copies from editmask within w_dw_print_options
int X=307
int Y=149
int Width=243
int Height=89
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
string Text="1"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_dw_print_options
int X=65
int Y=165
int Width=211
int Height=69
boolean Enabled=false
string Text="Copies:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_printer from singlelineedit within w_dw_print_options
int X=307
int Y=53
int Width=865
int Height=85
boolean Enabled=false
boolean Border=false
boolean AutoHScroll=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_dw_print_options
int X=65
int Y=53
int Width=211
int Height=69
boolean Enabled=false
string Text="Printer:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_dw_print_options
int X=1409
int Y=85
int Width=339
int Height=89
int TabOrder=90
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;string tmp, command
long row 
string	docname, named
int	value

choose case lower(left(ddlb_range.text,1)) // determine rangeinclude (all,even,odd)
	case 'a' // all
		tmp = '0'
	case 'e' // even
		tmp = '1'
	case 'o' //odd
		tmp = '2'
end choose
command = 'datawindow.print.page.rangeinclude = '+tmp
if cbx_collate.checked then // collate output ?
	command = command +  " datawindow.print.collate = yes"
else
	command = command +  " datawindow.print.collate = no"
end if
choose case is_page_range // did they pick a page range?
	case 'a'  // all
		tmp = ''
	case 'c' // current page?
		row = idw_dw.getrow()
		tmp = idw_dw.describe("evaluate('page()',"+string(row)+")")
	case 'p' // a range?
		tmp = sle_page_range.text
end choose		
if len(tmp) > 0 then command = command +  " datawindow.print.page.range = '"+tmp+"'"

// number of copies ?
if len(em_copies.text) > 0 then command = command +  " datawindow.print.copies = "+em_copies.text

if cbx_print_to_file.checked then // print to file ?
	value = GetFileSaveName("Print To File", docname, named, "PRN", "Print (*.PRN),*.PRN")
	if value = 1 then 
		command = command + " datawindow.print.filename = '"+docname+"'"
	else // they canceled out of the dialog so quit completely
		return
	end if
end if

// now alter the datawindow
tmp = idw_dw.modify(command)
if len(tmp) > 0 then // if error the display the 
	messagebox('Error Setting Print Options','Error message = ' + tmp + '~r~nCommand = ' + command)
	return
end if
closewithreturn(parent,1)
end on

type gb_1 from groupbox within w_dw_print_options
int X=69
int Y=265
int Width=1299
int Height=409
int TabOrder=20
string Text="Page Range"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

