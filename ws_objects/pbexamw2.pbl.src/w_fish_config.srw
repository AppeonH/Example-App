$PBExportHeader$w_fish_config.srw
$PBExportComments$Window to configure the aquarium
forward
global type w_fish_config from w_center
end type
type st_speed from statictext within w_fish_config
end type
type lv_1 from listview within w_fish_config
end type
type st_2 from statictext within w_fish_config
end type
type cb_close from commandbutton within w_fish_config
end type
type hsb_speed from hscrollbar within w_fish_config
end type
type st_4 from statictext within w_fish_config
end type
type st_1 from statictext within w_fish_config
end type
end forward

type s_fish from structure
	picture		p_pict
	integer		i_pos
	integer		i_dist
	boolean		b_right
	boolean		b_visible
end type

global type w_fish_config from w_center
int X=2098
int Y=20
int Width=841
int Height=1404
boolean TitleBar=true
string Title="Configure Aquarium"
long BackColor=81838264
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_speed st_speed
lv_1 lv_1
st_2 st_2
cb_close cb_close
hsb_speed hsb_speed
st_4 st_4
st_1 st_1
end type
global w_fish_config w_fish_config

type variables
w_fish w_aquarium
end variables

forward prototypes
public subroutine of_change_speed (integer ai_position)
end prototypes

public subroutine of_change_speed (integer ai_position);// Function to change the speed of the fish.

ai_Position = ai_Position - 4

Choose Case ai_Position
	Case -4, -3
		st_speed.Text = "Drifting"
	Case -2 To -1
		st_speed.Text = "Pokey"
	Case 0
		st_speed.Text = "Normal"
	Case 1, 2
		st_speed.Text = "Zippy"
	Case 3, 4
		st_speed.Text = "Flying"
End Choose

w_aquarium.ii_Delta = ai_Position * 2

end subroutine

on w_fish_config.create
this.st_speed=create st_speed
this.lv_1=create lv_1
this.st_2=create st_2
this.cb_close=create cb_close
this.hsb_speed=create hsb_speed
this.st_4=create st_4
this.st_1=create st_1
this.Control[]={this.st_speed,&
this.lv_1,&
this.st_2,&
this.cb_close,&
this.hsb_speed,&
this.st_4,&
this.st_1}
end on

on w_fish_config.destroy
destroy(this.st_speed)
destroy(this.lv_1)
destroy(this.st_2)
destroy(this.cb_close)
destroy(this.hsb_speed)
destroy(this.st_4)
destroy(this.st_1)
end on

event open;call super::open;Integer	li_1, li_2, li_3, li_4, li_5, li_Overlay, li_Position
ListViewItem	llvi_Item

w_aquarium = Message.PowerObjectParm 

// Add the fish pictures to the ListView
lv_1.SmallPictureWidth = 57
lv_1.SmallPictureHeight = 39

li_1 = lv_1.AddSmallPicture("fish1r.bmp")
li_2 = lv_1.AddSmallPicture("fish2r.bmp")
li_3 = lv_1.AddSmallPicture("fish3r.bmp")
li_4 = lv_1.AddSmallPicture("fish4r.bmp")
li_5 = lv_1.AddSmallPicture("fish5r.bmp")
li_Overlay = lv_1.AddSmallPicture("NotFound!")

lv_1.SetOverlayPicture(1, li_Overlay)

lv_1.AddColumn("fish", Left!, 700)

llvi_item.Label = "Clownfish"
llvi_item.PictureIndex = li_1
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_1 ) 
lv_1.AddItem ( llvi_item ) 

llvi_item.Label = "Clown Triggerfish"
llvi_item.PictureIndex = li_2
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_2 ) 
lv_1.AddItem ( llvi_item ) 

llvi_item.Label = "Emperor Anglefish"
llvi_item.PictureIndex = li_3
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_3 ) 
lv_1.AddItem ( llvi_item ) 

llvi_item.Label = "Moorish Idol"
llvi_item.PictureIndex = li_4
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_4 ) 
lv_1.AddItem ( llvi_item ) 

llvi_item.Label = "Palette Tang"
llvi_item.PictureIndex = li_5
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_5 ) 
lv_1.AddItem ( llvi_item ) 

li_Position = ( w_aquarium.ii_Delta / 2 ) 

Choose Case li_Position
	Case -4, -3
		st_speed.Text = "Drifting"
	Case -2 To -1
		st_speed.Text = "Pokey"
	Case 0
		st_speed.Text = "Normal"
	Case 1, 2
		st_speed.Text = "Zippy"
	Case 3, 4
		st_speed.Text = "Flying"
End Choose

hsb_speed.Position = li_Position + 4


end event

type st_speed from statictext within w_fish_config
int X=439
int Y=1000
int Width=265
int Height=64
boolean Enabled=false
string Text="Normal"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=75530304
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type lv_1 from listview within w_fish_config
int X=37
int Y=148
int Width=722
int Height=828
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean ButtonHeader=false
boolean Scrolling=false
boolean ShowHeader=false
ListViewView View=ListViewReport!
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=553648127
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=12632256
long StatePictureMaskColor=536870912
long TextColor=16777215
long BackColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event doubleclicked;// Remove or add a fish to/from the aquarium

ListViewItem	llvi_Item

If index <=0 Then Return
If GetItem(index, llvi_Item) = -1 Then Return

If llvi_Item.OverlayPictureIndex = 0 Then
	llvi_Item.OverlayPictureIndex = 1
	
	// Remove the fish from the aquarium
	w_aquarium.of_AddRemoveFish ( index, False ) 
	
Else
	llvi_Item.OverlayPictureIndex = 0
	
	// Add the fish back to the aquarium
	w_aquarium.of_AddRemoveFish ( index, True ) 
End If

llvi_Item.Selected = False

SetItem(index, llvi_Item)

end event

type st_2 from statictext within w_fish_config
int X=37
int Y=76
int Width=425
int Height=64
boolean Enabled=false
string Text="include/exclude it:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=75530304
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_fish_config
int X=279
int Y=1172
int Width=215
int Height=84
int TabOrder=20
string Text="Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type hsb_speed from hscrollbar within w_fish_config
int X=37
int Y=1064
int Width=722
int Height=52
boolean Enabled=false
int MaxPosition=8
int Position=4
end type

event moved;of_change_speed(position)

end event

event lineleft;If This.Position > 0 Then
	This.Position = This.Position - 1
End If

of_change_speed(This.Position)

end event

event lineright;If This.Position < 8 Then
	This.Position = This.Position + 1
End If

of_change_speed(This.Position)

end event

event pageright;If This.Position < 7 Then
	This.Position = This.Position + 2
End If

of_change_speed(This.Position)

end event

event pageleft;If This.Position > 1 Then
	This.Position = This.Position - 2
End If

of_change_speed(This.Position)

end event

type st_4 from statictext within w_fish_config
int X=37
int Y=1000
int Width=416
int Height=64
boolean Enabled=false
string Text="Swimming Speed:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=75530304
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_fish_config
int X=37
int Y=20
int Width=498
int Height=64
boolean Enabled=false
string Text="Double-click a fish to"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=75530304
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

