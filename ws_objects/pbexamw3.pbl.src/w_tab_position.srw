$PBExportHeader$w_tab_position.srw
$PBExportComments$Response window to change tab position - used by phone dir example
forward
global type w_tab_position from w_center
end type
type cb_apply from commandbutton within w_tab_position
end type
type cb_cancel from commandbutton within w_tab_position
end type
type cb_ok from commandbutton within w_tab_position
end type
type rb_bottomandtop from radiobutton within w_tab_position
end type
type rb_topandbottom from radiobutton within w_tab_position
end type
type rb_rightandleft from radiobutton within w_tab_position
end type
type rb_leftandright from radiobutton within w_tab_position
end type
type rb_bottom from radiobutton within w_tab_position
end type
type rb_right from radiobutton within w_tab_position
end type
type rb_top from radiobutton within w_tab_position
end type
type rb_left from radiobutton within w_tab_position
end type
type gb_1 from groupbox within w_tab_position
end type
end forward

global type w_tab_position from w_center
int X=822
int Y=263
int Width=1003
int Height=1012
boolean TitleBar=true
string Title="Change Tab Position"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_apply cb_apply
cb_cancel cb_cancel
cb_ok cb_ok
rb_bottomandtop rb_bottomandtop
rb_topandbottom rb_topandbottom
rb_rightandleft rb_rightandleft
rb_leftandright rb_leftandright
rb_bottom rb_bottom
rb_right rb_right
rb_top rb_top
rb_left rb_left
gb_1 gb_1
end type
global w_tab_position w_tab_position

type variables
w_phone_dir	iw_Parent
end variables

event open;call super::open;iw_Parent = Message.PowerObjectParm

Choose Case iw_Parent.tab_book.TabPosition
	Case TabsOnLeft!
		rb_left.Checked = True
	Case TabsOnRight!
		rb_right.Checked = True
	Case TabsOnLeftAndRight!
		rb_leftandright.Checked = True
	Case TabsOnRightAndLeft!
		rb_rightandleft.Checked = True
	Case TabsOnTop!
		rb_top.Checked = True
	Case TabsOnBottom!
		rb_bottom.Checked = True
	Case TabsOnTopAndBottom!
		rb_topandbottom.Checked = True
	Case TabsOnBottomAndTop!
		rb_bottomandtop.Checked = True
End Choose

end event

on w_tab_position.create
this.cb_apply=create cb_apply
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.rb_bottomandtop=create rb_bottomandtop
this.rb_topandbottom=create rb_topandbottom
this.rb_rightandleft=create rb_rightandleft
this.rb_leftandright=create rb_leftandright
this.rb_bottom=create rb_bottom
this.rb_right=create rb_right
this.rb_top=create rb_top
this.rb_left=create rb_left
this.gb_1=create gb_1
this.Control[]={ this.cb_apply,&
this.cb_cancel,&
this.cb_ok,&
this.rb_bottomandtop,&
this.rb_topandbottom,&
this.rb_rightandleft,&
this.rb_leftandright,&
this.rb_bottom,&
this.rb_right,&
this.rb_top,&
this.rb_left,&
this.gb_1}
end on

on w_tab_position.destroy
destroy(this.cb_apply)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.rb_bottomandtop)
destroy(this.rb_topandbottom)
destroy(this.rb_rightandleft)
destroy(this.rb_leftandright)
destroy(this.rb_bottom)
destroy(this.rb_right)
destroy(this.rb_top)
destroy(this.rb_left)
destroy(this.gb_1)
end on

type cb_apply from commandbutton within w_tab_position
int X=619
int Y=317
int Width=264
int Height=87
int TabOrder=31
string Text="Apply"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;TabPosition	ltb_Position

If rb_left.Checked Then
	ltb_Position = TabsOnLeft!
Elseif rb_right.Checked Then
	ltb_Position = TabsOnRight!
Elseif rb_leftandright.Checked Then
	ltb_Position = TabsOnLeftAndRight!
Elseif rb_rightandleft.Checked Then
	ltb_Position = TabsOnRightAndLeft!
Elseif rb_top.Checked Then
	ltb_Position = TabsOnTop!
Elseif rb_bottom.Checked Then
	ltb_Position = TabsOnBottom!
Elseif rb_topandbottom.Checked Then
	ltb_Position = TabsOnTopAndBottom!
Else
	ltb_Position = TabsOnBottomAndTop!
End if

iw_Parent.of_changetab(ltb_Position)

end event

type cb_cancel from commandbutton within w_tab_position
int X=619
int Y=193
int Width=264
int Height=84
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_ok from commandbutton within w_tab_position
int X=619
int Y=68
int Width=264
int Height=84
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;cb_apply.Trigger Event clicked()

Close(Parent)

end event

type rb_bottomandtop from radiobutton within w_tab_position
int X=54
int Y=724
int Width=456
int Height=61
string Text="Bottom and Top"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_topandbottom from radiobutton within w_tab_position
int X=54
int Y=631
int Width=456
int Height=61
string Text="Top and Bottom"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_rightandleft from radiobutton within w_tab_position
int X=54
int Y=365
int Width=417
int Height=61
string Text="Right and Left"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_leftandright from radiobutton within w_tab_position
int X=54
int Y=276
int Width=420
int Height=61
string Text="Left and Right"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_bottom from radiobutton within w_tab_position
int X=54
int Y=545
int Width=264
int Height=61
string Text="Bottom"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_right from radiobutton within w_tab_position
int X=54
int Y=183
int Width=232
int Height=61
string Text="Right"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_top from radiobutton within w_tab_position
int X=54
int Y=452
int Width=232
int Height=61
string Text="Top"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_left from radiobutton within w_tab_position
int X=54
int Y=97
int Width=232
int Height=61
string Text="Left"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_tab_position
int X=11
int Y=33
int Width=520
int Height=801
int TabOrder=10
string Text="Tab Postion"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

