$PBExportHeader$w_plb_picture.srw
$PBExportComments$Window to display a picture object
forward
global type w_plb_picture from w_center
end type
type rb_sizetofit from radiobutton within w_plb_picture
end type
type rb_original from radiobutton within w_plb_picture
end type
type p_display from picture within w_plb_picture
end type
type cb_close from commandbutton within w_plb_picture
end type
type gb_1 from groupbox within w_plb_picture
end type
end forward

global type w_plb_picture from w_center
int X=4
int Y=4
int Width=893
int Height=567
boolean TitleBar=true
string Title="Picture Zoom"
long BackColor=74481808
boolean ControlMenu=true
boolean MaxBox=true
boolean Resizable=true
rb_sizetofit rb_sizetofit
rb_original rb_original
p_display p_display
cb_close cb_close
gb_1 gb_1
end type
global w_plb_picture w_plb_picture

type variables
Double	idb_Ratio
end variables

forward prototypes
public subroutine of_resizepicture (integer ai_newwidth, integer ai_newheight)
end prototypes

public subroutine of_resizepicture (integer ai_newwidth, integer ai_newheight);p_display.Height = This.Height - (p_display.Y + 100)
p_display.Width = p_display.Height * idb_Ratio

If This.WindowState <> Maximized! And &
	This.Width < (p_display.Width + 60) Then
	This.Width = p_display.Width + 60
End If

end subroutine

event open;call super::open;p_display.PictureName = Message.StringParm
p_display.OriginalSize = True

idb_Ratio = Double(p_display.Width) / Double(p_display.Height)

If This.Width < (p_display.Width + 60) Then
	This.Width = p_display.Width + 60
End If

If This.Height < (p_display.Y + p_display.Height + 100) Then
	This.Height = p_display.Y + p_display.Height + 100
End If

end event

on w_plb_picture.create
this.rb_sizetofit=create rb_sizetofit
this.rb_original=create rb_original
this.p_display=create p_display
this.cb_close=create cb_close
this.gb_1=create gb_1
this.Control[]={ this.rb_sizetofit,&
this.rb_original,&
this.p_display,&
this.cb_close,&
this.gb_1}
end on

on w_plb_picture.destroy
destroy(this.rb_sizetofit)
destroy(this.rb_original)
destroy(this.p_display)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event resize;If rb_sizetofit.Checked Then
	of_resizepicture(newwidth, newheight)
End If

end event

type rb_sizetofit from radiobutton within w_plb_picture
int X=43
int Y=129
int Width=331
int Height=65
string Text="Size to Fit"
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;p_display.OriginalSize = False
of_resizepicture(Parent.Width, Parent.Height)

end event

type rb_original from radiobutton within w_plb_picture
int X=43
int Y=58
int Width=321
int Height=65
string Text="Original"
boolean Checked=true
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;p_display.OriginalSize = True

end event

type p_display from picture within w_plb_picture
int X=18
int Y=250
int Width=132
int Height=122
boolean FocusRectangle=false
end type

type cb_close from commandbutton within w_plb_picture
int X=498
int Y=20
int Width=338
int Height=87
int TabOrder=1
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

type gb_1 from groupbox within w_plb_picture
int X=15
int Width=381
int Height=218
int TabOrder=2
string Text="Picture Size"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

