$PBExportHeader$w_mle_scroll.srw
$PBExportComments$MultiLineEdits text behavior with various scrollbar and autoscroll attributes
forward
global type w_mle_scroll from w_center
end type
type st_3 from statictext within w_mle_scroll
end type
type st_2 from statictext within w_mle_scroll
end type
type st_1 from statictext within w_mle_scroll
end type
type mle_ahorizontal from multilineedit within w_mle_scroll
end type
type mle_avertical from multilineedit within w_mle_scroll
end type
type cbx_horizontal from checkbox within w_mle_scroll
end type
type cbx_vertical from checkbox within w_mle_scroll
end type
type cb_close from commandbutton within w_mle_scroll
end type
type mle_scroll from multilineedit within w_mle_scroll
end type
type gb_scrollbars from groupbox within w_mle_scroll
end type
end forward

global type w_mle_scroll from w_center
int X=402
int Y=49
int Width=1945
int Height=1815
boolean TitleBar=true
string Title="MultiLineEdit Scrolling Attributes"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_3 st_3
st_2 st_2
st_1 st_1
mle_ahorizontal mle_ahorizontal
mle_avertical mle_avertical
cbx_horizontal cbx_horizontal
cbx_vertical cbx_vertical
cb_close cb_close
mle_scroll mle_scroll
gb_scrollbars gb_scrollbars
end type
global w_mle_scroll w_mle_scroll

type variables
string is_mletext
end variables

on open;// Open script for w_mletest

//use this to reset the mle after attributes have been changed
is_mletext = "This is MultiLineEdit Box. You can change the attributes of this " + &
"box by checking and unchecking the boxes at right. Notice the different effects "+ &
"the attributes have on the MLE. Notice the effects of the scroll bars, and the auto "+ &
"scrolling."


mle_scroll.text = is_mletext
mle_avertical.text = is_mletext
mle_ahorizontal.text = is_mletext
end on

on w_mle_scroll.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.mle_ahorizontal=create mle_ahorizontal
this.mle_avertical=create mle_avertical
this.cbx_horizontal=create cbx_horizontal
this.cbx_vertical=create cbx_vertical
this.cb_close=create cb_close
this.mle_scroll=create mle_scroll
this.gb_scrollbars=create gb_scrollbars
this.Control[]={ this.st_3,&
this.st_2,&
this.st_1,&
this.mle_ahorizontal,&
this.mle_avertical,&
this.cbx_horizontal,&
this.cbx_vertical,&
this.cb_close,&
this.mle_scroll,&
this.gb_scrollbars}
end on

on w_mle_scroll.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.mle_ahorizontal)
destroy(this.mle_avertical)
destroy(this.cbx_horizontal)
destroy(this.cbx_vertical)
destroy(this.cb_close)
destroy(this.mle_scroll)
destroy(this.gb_scrollbars)
end on

on close;w_main.show()
end on

type st_3 from statictext within w_mle_scroll
int X=25
int Y=17
int Width=1867
int Height=71
boolean Enabled=false
string Text="Try typing in each of the MLE's and notice the effects each attribute has."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_mle_scroll
int X=939
int Y=1121
int Width=854
int Height=71
boolean Enabled=false
string Text="Auto Horizontal Scroll Turned On"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_mle_scroll
int X=939
int Y=653
int Width=793
int Height=71
boolean Enabled=false
string Text="Auto Vertical Scroll Turned On"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_ahorizontal from multilineedit within w_mle_scroll
int X=86
int Y=1105
int Width=779
int Height=423
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_avertical from multilineedit within w_mle_scroll
int X=86
int Y=631
int Width=779
int Height=423
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoVScroll=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_horizontal from checkbox within w_mle_scroll
int X=971
int Y=305
int Width=385
int Height=71
string Text="&Horizontal"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Add or Remove a horizontal scroll bar to the MLE
If this.checked Then 
	mle_scroll.hscrollbar = True
Else
	mle_scroll.hscrollbar = False
End If
end on

type cbx_vertical from checkbox within w_mle_scroll
int X=971
int Y=215
int Width=324
int Height=71
string Text="&Vertical"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Add or Remove a vertical scroll bar to the MLE
If this.checked Then 
	mle_scroll.vscrollbar = True
Else
	mle_scroll.vscrollbar = False
End If
end on

type cb_close from commandbutton within w_mle_scroll
int X=776
int Y=1575
int Width=374
int Height=87
int TabOrder=50
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Clicked script for cb_done

Close (Parent)

end on

type mle_scroll from multilineedit within w_mle_scroll
int X=86
int Y=161
int Width=779
int Height=423
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_scrollbars from groupbox within w_mle_scroll
int X=939
int Y=141
int Width=491
int Height=276
int TabOrder=30
string Text="Scroll Bars"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

