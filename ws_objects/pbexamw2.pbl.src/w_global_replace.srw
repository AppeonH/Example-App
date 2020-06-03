$PBExportHeader$w_global_replace.srw
$PBExportComments$Window showing function overloading using a Global Replace function
forward
global type w_global_replace from w_center
end type
type cb_reset from commandbutton within w_global_replace
end type
type em_end from editmask within w_global_replace
end type
type em_start from editmask within w_global_replace
end type
type st_syntax from statictext within w_global_replace
end type
type st_6 from statictext within w_global_replace
end type
type cb_help from commandbutton within w_global_replace
end type
type sle_num from singlelineedit within w_global_replace
end type
type st_5 from statictext within w_global_replace
end type
type cbx_case from checkbox within w_global_replace
end type
type st_4 from statictext within w_global_replace
end type
type sle_new from singlelineedit within w_global_replace
end type
type sle_old from singlelineedit within w_global_replace
end type
type st_3 from statictext within w_global_replace
end type
type st_2 from statictext within w_global_replace
end type
type st_1 from statictext within w_global_replace
end type
type cb_close from commandbutton within w_global_replace
end type
type cb_ok from commandbutton within w_global_replace
end type
type mle_1 from multilineedit within w_global_replace
end type
end forward

global type w_global_replace from w_center
int X=453
int Y=53
int Width=1815
int Height=1437
boolean TitleBar=true
string Title="Global Replace"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_reset cb_reset
em_end em_end
em_start em_start
st_syntax st_syntax
st_6 st_6
cb_help cb_help
sle_num sle_num
st_5 st_5
cbx_case cbx_case
st_4 st_4
sle_new sle_new
sle_old sle_old
st_3 st_3
st_2 st_2
st_1 st_1
cb_close cb_close
cb_ok cb_ok
mle_1 mle_1
end type
global w_global_replace w_global_replace

type variables
String	is_Text
end variables

forward prototypes
public function integer of_global_replace (ref string as_source, string as_old, string as_new)
public function integer of_global_replace (ref string as_Source, string as_Old, string as_New, boolean ab_UseCase)
public function integer of_global_replace (ref string as_Source, string as_Old, string as_New, boolean ab_UseCase, integer ai_Start, integer ai_End)
public function string of_get_syntax ()
end prototypes

public function integer of_global_replace (ref string as_source, string as_old, string as_new);//  This function replaces all occurrences in as_Source of as_Old with as_New
//  it returns the number of replacements made.

Integer	li_Pos, li_OldLen, li_NewLen, li_Cnt

li_OldLen = Len(as_Old)
li_NewLen = Len(as_New)


//Find the first occurrence of as_Old
li_Pos = Pos(Upper(as_Source), Upper(as_Old), 1)

Do While li_Pos > 0
	as_Source = Replace(as_Source, li_Pos, li_OldLen, as_New)
	li_Pos = Pos(Upper(as_Source), Upper(as_Old), (li_Pos + li_NewLen))
	li_Cnt ++
Loop

Return li_Cnt

end function

public function integer of_global_replace (ref string as_Source, string as_Old, string as_New, boolean ab_UseCase);//  This function replaces all occurrences in as_Source of as_Old with as_New
//  it returns the number of replacements made.

Integer	li_Pos, li_OldLen, li_NewLen, li_Cnt

li_OldLen = Len(as_Old)
li_NewLen = Len(as_New)


//Find the first occurrence of as_Old
If ab_UseCase Then
	li_Pos = Pos(as_Source, as_Old, 1)
Else
	li_Pos = Pos(Upper(as_Source), Upper(as_Old), 1)
End if

Do While li_Pos > 0
	as_Source = Replace(as_Source, li_Pos, li_OldLen, as_New)
	
	If ab_UseCase Then
		li_Pos = Pos(as_Source, as_Old, (li_Pos + li_NewLen))
	Else
		li_Pos = Pos(Upper(as_Source), Upper(as_Old), (li_Pos + li_NewLen))
	End if

	li_Cnt ++
Loop

Return li_Cnt

end function

public function integer of_global_replace (ref string as_Source, string as_Old, string as_New, boolean ab_UseCase, integer ai_Start, integer ai_End);//  This function replaces all occurrences in as_Source of as_Old with as_New
//  it returns the number of replacements made.

Integer		li_Pos, li_OldLen, li_NewLen, li_Cnt
Boolean		lb_GetLen

li_OldLen = Len(as_Old)
li_NewLen = Len(as_New)

// If ai_End is 0 then replace to the end of as_Source
If ai_End = 0 Then
	ai_End = Len(as_Source)
	lb_GetLen = True
Else
	lb_GetLen = False
End if

//Find the first occurrence of as_Old
If ab_UseCase Then
	li_Pos = Pos(as_Source, as_Old, ai_Start)
Else
	li_Pos = Pos(Upper(as_Source), Upper(as_Old), ai_Start)
End if

Do While (li_Pos > 0) And (li_Pos < ai_End)
	as_Source = Replace(as_Source, li_Pos, li_OldLen, as_New)
	
	If ab_UseCase Then
		li_Pos = Pos(as_Source, as_Old, (li_Pos + li_NewLen))
	Else
		li_Pos = Pos(Upper(as_Source), Upper(as_Old), (li_Pos + li_NewLen))
	End if

	// Because the length of as_Source may have changed, get it again
	If lb_GetLen Then
		ai_End = Len(as_Source)
	End if

	li_Cnt ++
Loop

Return li_Cnt

end function

public function string of_get_syntax ();String	ls_Syntax
Double	ldb_Start, ldb_End

ls_Syntax = "of_global_replace(mle_1.Text, ~"" + sle_old.Text + "~", ~"" + sle_new.Text + "~""

If cbx_case.Checked Then
	ls_Syntax = ls_Syntax + ", True"
End if

em_start.GetData(ldb_Start)
em_end.GetData(ldb_End)

If ldb_Start > 0 Then
	If Not cbx_case.Checked Then
		ls_Syntax = ls_Syntax + ", False"
	End if
	
	ls_Syntax = ls_Syntax + ", " + String(ldb_Start) + ", " + String(ldb_End)
End if

ls_Syntax = ls_Syntax + ")"

Return ls_Syntax

end function

on w_global_replace.destroy
destroy(this.cb_reset)
destroy(this.em_end)
destroy(this.em_start)
destroy(this.st_syntax)
destroy(this.st_6)
destroy(this.cb_help)
destroy(this.sle_num)
destroy(this.st_5)
destroy(this.cbx_case)
destroy(this.st_4)
destroy(this.sle_new)
destroy(this.sle_old)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.mle_1)
end on

event open;call super::open;is_Text = "The Code Examples provide a demonstration of the functionality of PowerBuilder.  " + &
			"Each example highlights one or more features while providing examples of ways in " + &
			"which the features may be used.  The Code Examples are grouped by topics indicating " + &
			"their primary focus.  However, many examples may use several PowerBuilder features.  " + &
			"Each example is also an example of proper coding techniques for the features.  " + &
			"Developers may copy example code from the Code Examples and paste it into their own " + &
			"application."

mle_1.Text = is_Text

end event

on w_global_replace.create
this.cb_reset=create cb_reset
this.em_end=create em_end
this.em_start=create em_start
this.st_syntax=create st_syntax
this.st_6=create st_6
this.cb_help=create cb_help
this.sle_num=create sle_num
this.st_5=create st_5
this.cbx_case=create cbx_case
this.st_4=create st_4
this.sle_new=create sle_new
this.sle_old=create sle_old
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.mle_1=create mle_1
this.Control[]={ this.cb_reset,&
this.em_end,&
this.em_start,&
this.st_syntax,&
this.st_6,&
this.cb_help,&
this.sle_num,&
this.st_5,&
this.cbx_case,&
this.st_4,&
this.sle_new,&
this.sle_old,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_close,&
this.cb_ok,&
this.mle_1}
end on

event close;Show(w_main)

end event

type cb_reset from commandbutton within w_global_replace
int X=1386
int Y=757
int Width=261
int Height=85
int TabOrder=70
string Text="&Reset"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;mle_1.Text = is_Text

end event

type em_end from editmask within w_global_replace
int X=645
int Y=809
int Width=193
int Height=85
int TabOrder=50
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
string DisplayData=""
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;st_syntax.Text = of_get_syntax()

end event

type em_start from editmask within w_global_replace
int X=225
int Y=809
int Width=193
int Height=85
int TabOrder=40
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
string DisplayData=""
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;st_syntax.Text = of_get_syntax()

end event

type st_syntax from statictext within w_global_replace
int X=14
int Y=1085
int Width=1687
int Height=69
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="of_global_replace(mle_1.Text, ~"example~", ~"fragment~")"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=73955432
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_global_replace
int X=10
int Y=1009
int Width=453
int Height=65
boolean Enabled=false
string Text="Function Call Syntax:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=73955432
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_help from commandbutton within w_global_replace
event clicked pbm_bnclicked
int X=1386
int Y=973
int Width=261
int Height=85
int TabOrder=90
string Text="&Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_global_replace")

end event

type sle_num from singlelineedit within w_global_replace
int X=951
int Y=1201
int Width=193
int Height=69
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_global_replace
int X=211
int Y=1205
int Width=714
int Height=61
boolean Enabled=false
string Text="Number of occurrences replaced:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_case from checkbox within w_global_replace
int X=225
int Y=693
int Width=362
int Height=61
int TabOrder=30
string Text="Match Case"
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;st_syntax.Text = of_get_syntax()

end event

type st_4 from statictext within w_global_replace
int X=490
int Y=821
int Width=147
int Height=61
boolean Enabled=false
string Text="End:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_new from singlelineedit within w_global_replace
int X=1029
int Y=541
int Width=618
int Height=77
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="fragment"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;st_syntax.Text = of_get_syntax()

end event

type sle_old from singlelineedit within w_global_replace
int X=225
int Y=541
int Width=618
int Height=77
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="example"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;st_syntax.Text = of_get_syntax()

end event

type st_3 from statictext within w_global_replace
int X=83
int Y=821
int Width=129
int Height=61
boolean Enabled=false
string Text="Start:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_global_replace
int X=897
int Y=549
int Width=129
int Height=61
boolean Enabled=false
string Text="With:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_global_replace
int X=5
int Y=549
int Width=211
int Height=61
boolean Enabled=false
string Text="Replace:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=73955432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_global_replace
int X=1386
int Y=865
int Width=261
int Height=85
int TabOrder=80
string Text="&Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_ok from commandbutton within w_global_replace
int X=1386
int Y=645
int Width=261
int Height=85
int TabOrder=60
string Text="&OK"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer	li_Cnt
Double	ldb_Start, ldb_End

em_start.GetData(ldb_Start)
em_end.GetData(ldb_End)
If ldb_Start > 0 Then
	li_Cnt = of_global_replace(mle_1.Text, sle_old.Text, sle_new.Text, cbx_case.Checked, &
											ldb_Start, ldb_End)

Elseif cbx_case.Checked Then
	li_Cnt = of_global_replace(mle_1.Text, sle_old.Text, sle_new.Text, cbx_case.Checked)

Else
	li_Cnt = of_global_replace(mle_1.Text, sle_old.Text, sle_new.Text)
End If

sle_num.Text = String(li_Cnt)

end event

type mle_1 from multilineedit within w_global_replace
int X=14
int Y=17
int Width=1637
int Height=453
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

