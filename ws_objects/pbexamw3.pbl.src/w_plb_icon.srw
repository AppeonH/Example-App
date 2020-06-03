$PBExportHeader$w_plb_icon.srw
$PBExportComments$Window to display an icon
forward
global type w_plb_icon from w_center
end type
type lv_1 from listview within w_plb_icon
end type
type rb_small from radiobutton within w_plb_icon
end type
type rb_large from radiobutton within w_plb_icon
end type
type cb_close from commandbutton within w_plb_icon
end type
type gb_1 from groupbox within w_plb_icon
end type
end forward

global type w_plb_icon from w_center
int X=4
int Y=4
int Width=893
int Height=567
boolean TitleBar=true
string Title="View Icon"
long BackColor=74481808
boolean ControlMenu=true
boolean MaxBox=true
boolean Resizable=true
lv_1 lv_1
rb_small rb_small
rb_large rb_large
cb_close cb_close
gb_1 gb_1
end type
global w_plb_icon w_plb_icon

type variables

end variables

event open;call super::open;Integer			li_Pict
String			ls_PictName
ListViewItem	llvi_1

ls_PictName = Message.StringParm

li_Pict = lv_1.AddLargePicture(ls_PictName)
li_Pict = lv_1.AddSmallPicture(ls_PictName)

llvi_1.PictureIndex = li_Pict
lv_1.AddItem(llvi_1)
llvi_1.ItemX = -60
lv_1.SetItem(1, llvi_1)

end event

on w_plb_icon.create
this.lv_1=create lv_1
this.rb_small=create rb_small
this.rb_large=create rb_large
this.cb_close=create cb_close
this.gb_1=create gb_1
this.Control[]={ this.lv_1,&
this.rb_small,&
this.rb_large,&
this.cb_close,&
this.gb_1}
end on

on w_plb_icon.destroy
destroy(this.lv_1)
destroy(this.rb_small)
destroy(this.rb_large)
destroy(this.cb_close)
destroy(this.gb_1)
end on

type lv_1 from listview within w_plb_icon
int X=54
int Y=257
int Width=278
int Height=205
int TabOrder=11
boolean Enabled=false
boolean Border=false
boolean HideSelection=false
boolean ButtonHeader=false
boolean LabelWrap=false
boolean Scrolling=false
boolean ShowHeader=false
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=553648127
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=553648127
long StatePictureMaskColor=553648127
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_small from radiobutton within w_plb_icon
int X=43
int Y=129
int Width=413
int Height=65
string Text="Small (16 x 16)"
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ListViewItem	llvi_1

lv_1.View = ListViewSmallIcon!

lv_1.GetItem(1, llvi_1)
llvi_1.ItemX = 1
lv_1.SetItem(1, llvi_1)

end event

type rb_large from radiobutton within w_plb_icon
int X=43
int Y=58
int Width=417
int Height=65
string Text="Large (32 x 32)"
boolean Checked=true
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ListViewItem	llvi_1

lv_1.View = ListViewLargeIcon!

lv_1.GetItem(1, llvi_1)
llvi_1.ItemX = 0
lv_1.SetItem(1, llvi_1)

end event

type cb_close from commandbutton within w_plb_icon
int X=509
int Y=20
int Width=338
int Height=87
int TabOrder=10
string Text="Close"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type gb_1 from groupbox within w_plb_icon
int X=15
int Width=466
int Height=218
int TabOrder=20
string Text="Icon Size"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

