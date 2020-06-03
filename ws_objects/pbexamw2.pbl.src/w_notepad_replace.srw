$PBExportHeader$w_notepad_replace.srw
$PBExportComments$Prompts for strings to search and replace; Used in notepad
forward
global type w_notepad_replace from w_center
end type
type cb_search_and_verify from commandbutton within w_notepad_replace
end type
type cb_cancel from commandbutton within w_notepad_replace
end type
type cb_change_all from commandbutton within w_notepad_replace
end type
type cbx_uplow from checkbox within w_notepad_replace
end type
type sle_replace from singlelineedit within w_notepad_replace
end type
type sle_find_text from singlelineedit within w_notepad_replace
end type
type st_2 from statictext within w_notepad_replace
end type
type st_1 from statictext within w_notepad_replace
end type
end forward

global type w_notepad_replace from w_center
int X=626
int Y=580
int Width=1672
int Height=775
boolean TitleBar=true
string Title="Replace Text"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_search_and_verify cb_search_and_verify
cb_cancel cb_cancel
cb_change_all cb_change_all
cbx_uplow cbx_uplow
sle_replace sle_replace
sle_find_text sle_find_text
st_2 st_2
st_1 st_1
end type
global w_notepad_replace w_notepad_replace

type variables
s_notepad_parms   istr_parm
end variables

forward prototypes
private subroutine wf_start_search (string as_parm)
end prototypes

private subroutine wf_start_search (string as_parm);//////////////////////////////////////////////////////////////////////
//
// Function: wf_start_search
//
// Purpose: Load the structure to return with the users specifications
//				for search string, replace string, and match upper/lower case
//
//	Scope: private
//
//	Arguments: as_parm
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

// Check if user wants to match upper/lower case
if cbx_uplow.checked then
	istr_parm.uplow = true
else
	istr_parm.uplow = false
end if

istr_parm.find_string    = sle_find_text.text
istr_parm.replace_string = sle_replace.text
istr_parm.replace_event  = as_parm

CloseWithReturn (this, istr_parm)

end subroutine

on w_notepad_replace.create
this.cb_search_and_verify=create cb_search_and_verify
this.cb_cancel=create cb_cancel
this.cb_change_all=create cb_change_all
this.cbx_uplow=create cbx_uplow
this.sle_replace=create sle_replace
this.sle_find_text=create sle_find_text
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={ this.cb_search_and_verify,&
this.cb_cancel,&
this.cb_change_all,&
this.cbx_uplow,&
this.sle_replace,&
this.sle_find_text,&
this.st_2,&
this.st_1}
end on

on w_notepad_replace.destroy
destroy(this.cb_search_and_verify)
destroy(this.cb_cancel)
destroy(this.cb_change_all)
destroy(this.cbx_uplow)
destroy(this.sle_replace)
destroy(this.sle_find_text)
destroy(this.st_2)
destroy(this.st_1)
end on

type cb_search_and_verify from commandbutton within w_notepad_replace
int X=161
int Y=532
int Width=552
int Height=87
int TabOrder=40
boolean Enabled=false
string Text="Search and &Verify"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Search and Verify based on user specifications

wf_start_search ("search_and_verify")

end on

type cb_cancel from commandbutton within w_notepad_replace
int X=1110
int Y=532
int Width=331
int Height=87
int TabOrder=60
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Close with a parm saying that the cancel button was hit

istr_parm.replace_event = "Cancel"
CloseWithReturn (parent, istr_parm)
end on

type cb_change_all from commandbutton within w_notepad_replace
int X=744
int Y=532
int Width=331
int Height=87
int TabOrder=50
boolean Enabled=false
string Text="Change &All"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Change all ocurrences of text based on user specifications

wf_start_search ("change_all")


end on

type cbx_uplow from checkbox within w_notepad_replace
int X=424
int Y=353
int Width=758
int Height=71
int TabOrder=30
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

type sle_replace from singlelineedit within w_notepad_replace
int X=424
int Y=215
int Width=1153
int Height=87
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Pointer="arrow!"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_find_text from singlelineedit within w_notepad_replace
event char_modified pbm_char
int X=424
int Y=81
int Width=1153
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

on char_modified;// Enable the search buttons when a character has been entered

cb_search_and_verify.enabled = true
cb_change_all.enabled = true
end on

type st_2 from statictext within w_notepad_replace
int X=36
int Y=225
int Width=353
int Height=71
string Text="Change &To:"
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

type st_1 from statictext within w_notepad_replace
int X=36
int Y=87
int Width=353
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

