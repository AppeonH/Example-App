$PBExportHeader$w_splash.srw
$PBExportComments$Splash screen displayed on startup
forward
global type w_splash from w_center
end type
type p_splash from picture within w_splash
end type
type st_dir from statictext within w_splash
end type
type lb_dir from listbox within w_splash
end type
end forward

global type w_splash from w_center
integer x = 457
integer y = 580
integer width = 2286
integer height = 1320
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
windowtype windowtype = popup!
long backcolor = 75530304
toolbaralignment toolbaralignment = alignatleft!
p_splash p_splash
st_dir st_dir
lb_dir lb_dir
end type
global w_splash w_splash

type prototypes
end prototypes

event open;call super::open;Integer			li_ScreenH, li_ScreenW
Environment	le_Env

//If Message.StringParm = "hide" Then
//	This.Hide()
//	Return
//End If
//
//p_splash.Hide()

p_splash.SetRedraw(True)
//p_splash.OriginalSize = True

//This.Height = p_splash.Height
//This.Width = p_splash.Width

p_splash.Show()

// Center window
GetEnvironment(le_Env)

//li_ScreenH = PixelsToUnits(le_Env.ScreenHeight, YPixelsToUnits!)
//li_ScreenW = PixelsToUnits(le_Env.ScreenWidth, XPixelsToUnits!)
//
//This.Y = (li_ScreenH - This.Height) / 2
//This.X = (li_ScreenW - This.Width) / 2
//This.SetPosition(Topmost!)
end event

on w_splash.destroy
call super::destroy
destroy(this.p_splash)
destroy(this.st_dir)
destroy(this.lb_dir)
end on

on w_splash.create
int iCurrent
call super::create
this.p_splash=create p_splash
this.st_dir=create st_dir
this.lb_dir=create lb_dir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_splash
this.Control[iCurrent+2]=this.st_dir
this.Control[iCurrent+3]=this.lb_dir
end on

type p_splash from picture within w_splash
integer width = 2286
integer height = 1320
string picturename = "example.bmp"
boolean focusrectangle = false
end type

type st_dir from statictext within w_splash
integer x = 690
integer y = 732
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "none"
long bordercolor = 8388608
boolean focusrectangle = false
end type

type lb_dir from listbox within w_splash
integer x = 101
integer y = 660
integer width = 384
integer height = 304
integer taborder = 1
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean vscrollbar = true
end type

