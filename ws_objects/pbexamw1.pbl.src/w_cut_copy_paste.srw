$PBExportHeader$w_cut_copy_paste.srw
$PBExportComments$Cut, copy, and paste example using metaclass calls
forward
global type w_cut_copy_paste from w_center
end type
type lv_1 from listview within w_cut_copy_paste
end type
type tv_1 from treeview within w_cut_copy_paste
end type
type st_5 from statictext within w_cut_copy_paste
end type
type st_4 from statictext within w_cut_copy_paste
end type
type st_3 from statictext within w_cut_copy_paste
end type
type ddlb_1 from dropdownlistbox within w_cut_copy_paste
end type
type mle_1 from multilineedit within w_cut_copy_paste
end type
type st_2 from statictext within w_cut_copy_paste
end type
type st_1 from statictext within w_cut_copy_paste
end type
type sle_1 from singlelineedit within w_cut_copy_paste
end type
type rb_2 from radiobutton within w_cut_copy_paste
end type
type rb_1 from radiobutton within w_cut_copy_paste
end type
type cbx_1 from checkbox within w_cut_copy_paste
end type
type gb_1 from groupbox within w_cut_copy_paste
end type
end forward

global type w_cut_copy_paste from w_center
int X=5
int Y=4
int Width=2162
int Height=1692
boolean TitleBar=true
string Title="Cut/Copy/Paste"
string MenuName="m_cut_copy_paste"
long BackColor=80242744
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_postopen ( )
lv_1 lv_1
tv_1 tv_1
st_5 st_5
st_4 st_4
st_3 st_3
ddlb_1 ddlb_1
mle_1 mle_1
st_2 st_2
st_1 st_1
sle_1 sle_1
rb_2 rb_2
rb_1 rb_1
cbx_1 cbx_1
gb_1 gb_1
end type
global w_cut_copy_paste w_cut_copy_paste

forward prototypes
public subroutine of_cut ()
public function boolean of_function_exists (string as_ControlName, string as_FunctionName)
public subroutine of_copy ()
public subroutine of_paste ()
end prototypes

event ue_postopen;TreeViewItem	ltvi_1
Long					ll_Folder[3]
Integer				li_Cnt

ltvi_1.PictureIndex = 1
ltvi_1.SelectedPictureIndex = 2
ltvi_1.Children = True
ltvi_1.Label = "Folder One"
ll_Folder[1] = tv_1.InsertItemLast(0, ltvi_1)

ltvi_1.Label = "Folder Two"
ll_Folder[2] = tv_1.InsertItemLast(0, ltvi_1)

ltvi_1.Label = "Folder Three"
ll_Folder[3] = tv_1.InsertItemLast(0, ltvi_1)

ltvi_1.PictureIndex = 3
ltvi_1.SelectedPictureIndex = 3
ltvi_1.Children = False

For li_Cnt = 1 To 3
	ltvi_1.Label = "Item One"
	tv_1.InsertItemlast(ll_Folder[li_Cnt], ltvi_1)
	ltvi_1.Label = "Item Two"
	tv_1.InsertItemlast(ll_Folder[li_Cnt], ltvi_1)
Next

end event

public subroutine of_cut ();GraphicObject	lgo_Current

lgo_Current = GetFocus()

// Find if the object has a 'cut' function
If of_function_exists(lgo_Current.ClassName(), "cut") Then
	lgo_Current.Dynamic Cut()
Else
	MessageBox("Error", "No Cut Function for this object.", Exclamation!)
End If

end subroutine

public function boolean of_function_exists (string as_ControlName, string as_FunctionName);ClassDefinition	lcd_Object
String				ls_ArgTypes[]

// Find class definition
lcd_Object = FindClassDefinition("w_cut_copy_paste`" + as_ControlName)

Return IsValid(lcd_Object.FindMatchingFunction(as_FunctionName, ls_ArgTypes[]))

end function

public subroutine of_copy ();GraphicObject	lgo_Current

lgo_Current = GetFocus()

// Find if the object has a 'copy' function
If of_function_exists(lgo_Current.ClassName(), "copy") Then
	lgo_Current.Dynamic Copy()
Else
	MessageBox("Error", "No Copy Function for this object.", Exclamation!)
End If

end subroutine

public subroutine of_paste ();GraphicObject	lgo_Current

lgo_Current = GetFocus()

// Find if the object has a 'paste' function
If of_function_exists(lgo_Current.ClassName(), "paste") Then
	lgo_Current.Dynamic Paste()
Else
	MessageBox("Error", "No Paste Function for this object.", Exclamation!)
End If

end subroutine

on w_cut_copy_paste.create
if this.MenuName = "m_cut_copy_paste" then this.MenuID = create m_cut_copy_paste
this.lv_1=create lv_1
this.tv_1=create tv_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.ddlb_1=create ddlb_1
this.mle_1=create mle_1
this.st_2=create st_2
this.st_1=create st_1
this.sle_1=create sle_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cbx_1=create cbx_1
this.gb_1=create gb_1
this.Control[]={this.lv_1,&
this.tv_1,&
this.st_5,&
this.st_4,&
this.st_3,&
this.ddlb_1,&
this.mle_1,&
this.st_2,&
this.st_1,&
this.sle_1,&
this.rb_2,&
this.rb_1,&
this.cbx_1,&
this.gb_1}
end on

on w_cut_copy_paste.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lv_1)
destroy(this.tv_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.ddlb_1)
destroy(this.mle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cbx_1)
destroy(this.gb_1)
end on

event open;call super::open;Post Event ue_postopen()

end event

event close;w_main.Show()

end event

type lv_1 from listview within w_cut_copy_paste
int X=1097
int Y=876
int Width=969
int Height=592
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoArrange=true
string Item[]={"Item One",&
"Item Two",&
"Item Three",&
"Item Four",&
"Item Five",&
"Item Six",&
"Item Seven",&
"Item Eight"}
int ItemPictureIndex[]={1,&
1,&
1,&
1,&
1,&
1,&
1,&
1}
string LargePictureName[]={"UserObject5!"}
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=12632256
string SmallPictureName[]={"UserObject5!"}
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=12632256
long StatePictureMaskColor=536870912
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type tv_1 from treeview within w_cut_copy_paste
int X=46
int Y=876
int Width=969
int Height=592
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean LinesAtRoot=true
string PictureName[]={"Custom039!",&
"Custom050!",&
"UserObject5!"}
long PictureMaskColor=12632256
long StatePictureMaskColor=536870912
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_cut_copy_paste
int X=46
int Y=804
int Width=261
int Height=76
boolean Enabled=false
string Text="TreeView:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_cut_copy_paste
int X=1097
int Y=804
int Width=261
int Height=76
boolean Enabled=false
string Text="ListView:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_cut_copy_paste
int Y=600
int Width=430
int Height=76
boolean Enabled=false
string Text="DropDownListBox:"
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

type ddlb_1 from dropdownlistbox within w_cut_copy_paste
int X=439
int Y=592
int Width=521
int Height=384
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Item One",&
"Item Two",&
"Item Three",&
"Item Four",&
"Item Five"}
end type

type mle_1 from multilineedit within w_cut_copy_paste
int X=439
int Y=180
int Width=983
int Height=368
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean AutoHScroll=true
boolean AutoVScroll=true
string Text="This is a MultiLineEditControl."
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_cut_copy_paste
int X=87
int Y=192
int Width=343
int Height=76
boolean Enabled=false
string Text="MultiLineEdit:"
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

type st_1 from statictext within w_cut_copy_paste
int X=69
int Y=52
int Width=361
int Height=76
boolean Enabled=false
string Text="SingleLineEdit:"
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

type sle_1 from singlelineedit within w_cut_copy_paste
int X=439
int Y=44
int Width=997
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Text="This is a SingleLineEdit control."
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_cut_copy_paste
int X=1627
int Y=352
int Width=375
int Height=76
string Text="Button Two"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_cut_copy_paste
int X=1627
int Y=268
int Width=361
int Height=76
string Text="Button One"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_1 from checkbox within w_cut_copy_paste
int X=1623
int Y=64
int Width=343
int Height=76
int TabOrder=40
string Text="Checkbox"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_cut_copy_paste
int X=1591
int Y=216
int Width=457
int Height=236
int TabOrder=50
string Text="Radio Buttons:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

