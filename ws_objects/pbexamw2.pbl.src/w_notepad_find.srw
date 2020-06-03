$PBExportHeader$w_notepad_find.srw
$PBExportComments$Prompts for string to find; Used by notepad
forward
global type w_notepad_find from w_center
end type
type cb_ok from commandbutton within w_notepad_find
end type
type cbx_uplow from checkbox within w_notepad_find
end type
type sle_find_text from singlelineedit within w_notepad_find
end type
type cb_cancel from commandbutton within w_notepad_find
end type
type st_1 from statictext within w_notepad_find
end type
end forward

global type w_notepad_find from w_center
int X=761
int Y=641
int Width=1405
int Height=660
boolean TitleBar=true
string Title="Find Text"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_ok cb_ok
cbx_uplow cbx_uplow
sle_find_text sle_find_text
cb_cancel cb_cancel
st_1 st_1
end type
global w_notepad_find w_notepad_find

type variables
s_notepad_parms   istr_parm
multilineedit   imle_parm
end variables

on open;imle_parm = message.powerobjectparm
end on

on w_notepad_find.create
this.cb_ok=create cb_ok
this.cbx_uplow=create cbx_uplow
this.sle_find_text=create sle_find_text
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.Control[]={ this.cb_ok,&
this.cbx_uplow,&
this.sle_find_text,&
this.cb_cancel,&
this.st_1}
end on

on w_notepad_find.destroy
destroy(this.cb_ok)
destroy(this.cbx_uplow)
destroy(this.sle_find_text)
destroy(this.cb_cancel)
destroy(this.st_1)
end on

type cb_ok from commandbutton within w_notepad_find
int X=385
int Y=407
int Width=278
int Height=87
int TabOrder=30
boolean Enabled=false
string Text="&OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//////////////////////////////////////////////////////////////////////
//
// Find the text that was specified in the multilineedit that was
// passed to this window.
//
//////////////////////////////////////////////////////////////////////

int		li_loc
string	ls_source


// Check for matching upper/lower case

if cbx_uplow.checked then
	istr_parm.uplow = true
	li_loc = Pos (imle_parm.text, sle_find_text.text)
else
	istr_parm.uplow = false
	ls_source = Lower (imle_parm.text)
	li_loc = Pos (ls_source, Lower (sle_find_text.text))
end if

if li_loc = 0 then
	MessageBox (parent.title, "String " + sle_find_text.text + " not found", StopSign!)
	Disable (m_notepad.m_search.m_findnexttext)
else
	imle_parm.SelectText (li_loc, Len (sle_find_text.text))
	Enable (m_notepad.m_search.m_findnexttext)
	istr_parm.find_string = sle_find_text.text
end if

istr_parm.find_loc = li_loc
CloseWithReturn (parent, istr_parm)
end on

type cbx_uplow from checkbox within w_notepad_find
int X=406
int Y=221
int Width=758
int Height=71
int TabOrder=20
string Text="&Match Upper/Lowercase"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_find_text from singlelineedit within w_notepad_find
event char_modified pbm_char
int X=406
int Y=61
int Width=868
int Height=87
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Pointer="arrow!"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on char_modified;// Enable the OK button when a character is entered

cb_ok.enabled = true
end on

type cb_cancel from commandbutton within w_notepad_find
int X=712
int Y=407
int Width=278
int Height=87
int TabOrder=40
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close (parent)
end on

type st_1 from statictext within w_notepad_find
int X=65
int Y=68
int Width=324
int Height=71
string Text="&Search For:"
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

