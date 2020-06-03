$PBExportHeader$w_multilingual.srw
$PBExportComments$Select a language for the multilingual example
forward
global type w_multilingual from w_center
end type
type st_1 from statictext within w_multilingual
end type
type lb_1 from listbox within w_multilingual
end type
type cb_ok from commandbutton within w_multilingual
end type
type cb_cancel from commandbutton within w_multilingual
end type
end forward

global type w_multilingual from w_center
int X=882
int Y=487
int Width=1160
int Height=951
boolean TitleBar=true
string Title="Multi-Lingual Example"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_1 st_1
lb_1 lb_1
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_multilingual w_multilingual

forward prototypes
protected subroutine wf_open_language (int ai_index)
end prototypes

protected subroutine wf_open_language (int ai_index);//////////////////////////////////////////////////////////////////////
//
// Function: wf_open_language
//
// Purpose: opens the correct multi-lingual window based on the index
//				that is passed to this function
//
//	Scope: protected
//
//	Arguments: ai_index	the index selection from the listbox of language choices.
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

choose case ai_index

	case 1
		Open (w_ancestor)

	case 2
		Open (w_french)

	case 3
		Open (w_dutch)

	case 4
		Open (w_spanish)

end choose
end subroutine

on open;// select the first item in the language choices listbox

lb_1.SelectItem (1)
end on

on w_multilingual.create
this.st_1=create st_1
this.lb_1=create lb_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.Control[]={ this.st_1,&
this.lb_1,&
this.cb_ok,&
this.cb_cancel}
end on

on w_multilingual.destroy
destroy(this.st_1)
destroy(this.lb_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

on close;w_main.Show()
end on

type st_1 from statictext within w_multilingual
int X=22
int Y=20
int Width=982
int Height=71
boolean Enabled=false
string Text="Select a window to open"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lb_1 from listbox within w_multilingual
int X=150
int Y=161
int Width=808
int Height=445
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean Sorted=false
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"English - (ancestor window)",&
"French - (inherited)",&
"Dutch - (inherited)",&
"Spanish - (inherited)"}
end type

on doubleclicked;cb_ok.TriggerEvent (clicked!)
end on

type cb_ok from commandbutton within w_multilingual
int X=289
int Y=695
int Width=246
int Height=109
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;wf_open_language (lb_1.SelectedIndex())
end on

type cb_cancel from commandbutton within w_multilingual
int X=562
int Y=695
int Width=246
int Height=109
int TabOrder=10
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

