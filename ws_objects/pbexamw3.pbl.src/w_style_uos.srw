$PBExportHeader$w_style_uos.srw
$PBExportComments$This window contains 2 User Objects, one inherited from the other. It shows extending, overriding and calling ancestor scripts.
forward
global type w_style_uos from w_center
end type
type uo_2 from u_style_descendant within w_style_uos
end type
type cb_help from commandbutton within w_style_uos
end type
type cb_close from commandbutton within w_style_uos
end type
type uo_1 from u_style_ancestor within w_style_uos
end type
type gb_2 from groupbox within w_style_uos
end type
type gb_1 from groupbox within w_style_uos
end type
end forward

global type w_style_uos from w_center
int X=617
int Y=216
int Width=1687
int Height=948
boolean TitleBar=true
string Title="Text Style Changer"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
uo_2 uo_2
cb_help cb_help
cb_close cb_close
uo_1 uo_1
gb_2 gb_2
gb_1 gb_1
end type
global w_style_uos w_style_uos

on close;w_main.Show()
end on

on w_style_uos.create
this.uo_2=create uo_2
this.cb_help=create cb_help
this.cb_close=create cb_close
this.uo_1=create uo_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.uo_2,&
this.cb_help,&
this.cb_close,&
this.uo_1,&
this.gb_2,&
this.gb_1}
end on

on w_style_uos.destroy
destroy(this.uo_2)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.uo_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type uo_2 from u_style_descendant within w_style_uos
int X=128
int Y=524
int Height=120
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

on uo_2.destroy
call u_style_descendant::destroy
end on

type cb_help from commandbutton within w_style_uos
int X=1367
int Y=188
int Width=247
int Height=108
int TabOrder=50
string Text="&Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help ('w_style_uos')
end on

type cb_close from commandbutton within w_style_uos
int X=1367
int Y=44
int Width=247
int Height=108
int TabOrder=10
string Text="&Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type uo_1 from u_style_ancestor within w_style_uos
int X=128
int Y=160
int Width=978
int Height=128
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

on uo_1.destroy
call u_style_ancestor::destroy
end on

type gb_2 from groupbox within w_style_uos
int X=87
int Y=452
int Width=1047
int Height=224
int TabOrder=20
string Text="Inherited User Object"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_style_uos
int X=87
int Y=92
int Width=1047
int Height=224
int TabOrder=40
string Text="User Object"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

