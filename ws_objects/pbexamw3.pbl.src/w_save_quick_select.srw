$PBExportHeader$w_save_quick_select.srw
$PBExportComments$Response Dialog that is used to save Quick Selected DataWindow, Prompts for Library name, DataWindow name and comments to be applied to the Entry.
forward
global type w_save_quick_select from w_center
end type
type cb_1 from commandbutton within w_save_quick_select
end type
type sle_library from singlelineedit within w_save_quick_select
end type
type cb_cancel from commandbutton within w_save_quick_select
end type
type cb_save from commandbutton within w_save_quick_select
end type
type mle_comments from multilineedit within w_save_quick_select
end type
type st_3 from statictext within w_save_quick_select
end type
type st_2 from statictext within w_save_quick_select
end type
type sle_dwname from singlelineedit within w_save_quick_select
end type
type st_1 from statictext within w_save_quick_select
end type
end forward

global type w_save_quick_select from w_center
int X=421
int Y=308
int Width=1984
int Height=772
boolean TitleBar=true
string Title="Save Your DataWindow"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_1 cb_1
sle_library sle_library
cb_cancel cb_cancel
cb_save cb_save
mle_comments mle_comments
st_3 st_3
st_2 st_2
sle_dwname sle_dwname
st_1 st_1
end type
global w_save_quick_select w_save_quick_select

on w_save_quick_select.create
this.cb_1=create cb_1
this.sle_library=create sle_library
this.cb_cancel=create cb_cancel
this.cb_save=create cb_save
this.mle_comments=create mle_comments
this.st_3=create st_3
this.st_2=create st_2
this.sle_dwname=create sle_dwname
this.st_1=create st_1
this.Control[]={this.cb_1,&
this.sle_library,&
this.cb_cancel,&
this.cb_save,&
this.mle_comments,&
this.st_3,&
this.st_2,&
this.sle_dwname,&
this.st_1}
end on

on w_save_quick_select.destroy
destroy(this.cb_1)
destroy(this.sle_library)
destroy(this.cb_cancel)
destroy(this.cb_save)
destroy(this.mle_comments)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_dwname)
destroy(this.st_1)
end on

type cb_1 from commandbutton within w_save_quick_select
int X=1669
int Y=36
int Width=247
int Height=92
int TabOrder=20
string Text="&Browse"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_filename, ls_file
integer li_rc

li_rc = GetFileOpenName ( "Select Library", &
		+ ls_filename, ls_file, "PBL", &
		+ "PB Libraries (*.PBL),*.PBL" )

If li_rc = 1 Then sle_library.Text = ls_filename
end event

type sle_library from singlelineedit within w_save_quick_select
int X=443
int Y=40
int Width=1211
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_save_quick_select
int X=1093
int Y=528
int Width=297
int Height=92
int TabOrder=50
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_save
///////////////////////////////////////////////////////////////////////////////////////////////////////

close(parent)
end event

type cb_save from commandbutton within w_save_quick_select
int X=763
int Y=528
int Width=297
int Height=92
int TabOrder=40
string Text="&Save"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_save
///////////////////////////////////////////////////////////////////////////////////////////////////////


// this event will take the datawindow that was passed to it and request a pbl and 
// datawindow filename to save it under

string 	ls_libraryname,  &
			ls_dwsyntax,     &
			ls_importerrorbuffer
integer	li_returncode
datawindow ldw_passeddw

//get the datawindow passed to the window
ldw_passeddw = create datawindow
ldw_passeddw = message.powerobjectparm

//check for library (pbl) selection
ls_libraryname = sle_library.Text
if ls_libraryname = "" then
	messagebox("No Library Selected", "Please select a Library to receive the DataWindow")
	setFocus(sle_library)
	return
end if

//check for datawindow name
if sle_dwname.text = "" then 
	messagebox("No DataWindow Name given", "Please enter the name for your DataWindow")
	setFocus(sle_dwName)
	return
end if

//no spaces allowed
if  pos(sle_dwname.text, " ") > 0 then 
	messagebox("DataWindow Name must not have spaces", "Please reenter the name for your DataWindow")
	setFocus(sle_dwName)
	return
end if

//get the datawindow syntax in the form of a string
ls_dwsyntax = ldw_passeddw.Object.DataWindow.Syntax

//make sure no errors were found
if (pos(ls_dwsyntax, "!") > 0 or pos(ls_dwsyntax, "?") > 0) and len(ls_dwsyntax) = 1 Then
	messagebox("DataWindow Syntax Error", ls_dwsyntax)
	return
end if

//move the string into the pbl 
li_returncode =	LibraryImport(ls_libraryname, sle_dwName.text, ImportDataWindow!, &
						ls_dwsyntax, ls_importerrorbuffer, mle_comments.text)

If li_returncode < 1 then
	messagebox("Import of DataWindow to the PBL Failed", ls_importerrorbuffer)
	return
end if


close(Parent)
end event

type mle_comments from multilineedit within w_save_quick_select
int X=448
int Y=296
int Width=1467
int Height=188
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_save_quick_select
int X=87
int Y=348
int Width=306
int Height=116
boolean Enabled=false
string Text="Datawindow Comments:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_save_quick_select
int X=96
int Y=176
int Width=297
int Height=108
boolean Enabled=false
string Text="Datawindow Name:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_dwname from singlelineedit within w_save_quick_select
int X=448
int Y=168
int Width=1467
int Height=92
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=40
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_save_quick_select
int X=32
int Y=56
int Width=379
int Height=92
boolean Enabled=false
string Text="Choose Library:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

