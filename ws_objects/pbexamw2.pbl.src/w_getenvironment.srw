$PBExportHeader$w_getenvironment.srw
$PBExportComments$Demonstrates the use of the getenvironment function
forward
global type w_getenvironment from w_center
end type
type st_4 from statictext within w_getenvironment
end type
type st_exe from statictext within w_getenvironment
end type
type cb_ok from commandbutton within w_getenvironment
end type
type st_width from statictext within w_getenvironment
end type
type st_height from statictext within w_getenvironment
end type
type st_colors from statictext within w_getenvironment
end type
type st_7 from statictext within w_getenvironment
end type
type st_6 from statictext within w_getenvironment
end type
type st_5 from statictext within w_getenvironment
end type
type st_pbver from statictext within w_getenvironment
end type
type st_3 from statictext within w_getenvironment
end type
type st_2 from statictext within w_getenvironment
end type
type st_1 from statictext within w_getenvironment
end type
type st_ostype from statictext within w_getenvironment
end type
type st_cpu_type from statictext within w_getenvironment
end type
end forward

global type w_getenvironment from w_center
int X=809
int Y=544
int Width=1303
int Height=900
boolean TitleBar=true
string Title="GetEnvironment"
long BackColor=74481808
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_4 st_4
st_exe st_exe
cb_ok cb_ok
st_width st_width
st_height st_height
st_colors st_colors
st_7 st_7
st_6 st_6
st_5 st_5
st_pbver st_pbver
st_3 st_3
st_2 st_2
st_1 st_1
st_ostype st_ostype
st_cpu_type st_cpu_type
end type
global w_getenvironment w_getenvironment

event open;call super::open;environment env
integer resp
string temp
resp = getenvironment(env)

choose case env.cputype
	case alpha!
		st_cpu_type.text = 'Alpha'
	case hppa!
		st_cpu_type.text = 'HPPA'
	case i286!
		st_cpu_type.text = '286'
	case i386!
		st_cpu_type.text = '386'
	case i486!
		st_cpu_type.text = '486'
	case m68000!
		st_cpu_type.text = '68000'
	case m68020!
		st_cpu_type.text = '68020'
	case m68030!
		st_cpu_type.text = '68030'
	case m68040!
		st_cpu_type.text = '68040'
	case mips!
		st_cpu_type.text = 'MIPS'
	case pentium!
		st_cpu_type.text = 'Pentium'
	case powerpc!
		st_cpu_type.text = 'PowerPC'
	case sparc!
		st_cpu_type.text = 'Sparc'
end choose

choose case env.ostype
	case aix!
		temp = 'AIX'
	case hpux!
		temp = 'HPUX'
	case osf1!
		temp = 'OSF1'
	case sol2!
		temp = 'Solaris 2'
	case Windows!
		temp = 'Windows'
	case Windowsnt!
		temp = 'Windows NT'
end choose
st_ostype.text = temp + ' '+string(env.osmajorrevision)+'.'+string(env.osminorrevision)+'.'+string(env.osfixesrevision)

choose case env.pbtype
	case enterprise!
		temp = 'Enterprise'
	case desktop!
		temp = 'Desktop'
end choose
If env.win16 Then
	temp = temp + "/16"
Else
	temp = temp + "/32"
End If

st_pbver.text = temp + ' '+string(env.pbmajorrevision)+'.'+string(env.pbminorrevision)+'.'+string(env.pbfixesrevision)

If env.machinecode Then
	st_exe.text = "Machine Code"
Else
	st_exe.text = "P-Code"
End If

st_colors.text =string(env.numberofcolors)
st_height.text = string(env.screenheight)
st_width.text = string(env.screenwidth)

end event

on w_getenvironment.create
this.st_4=create st_4
this.st_exe=create st_exe
this.cb_ok=create cb_ok
this.st_width=create st_width
this.st_height=create st_height
this.st_colors=create st_colors
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_pbver=create st_pbver
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_ostype=create st_ostype
this.st_cpu_type=create st_cpu_type
this.Control[]={this.st_4,&
this.st_exe,&
this.cb_ok,&
this.st_width,&
this.st_height,&
this.st_colors,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_pbver,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_ostype,&
this.st_cpu_type}
end on

on w_getenvironment.destroy
destroy(this.st_4)
destroy(this.st_exe)
destroy(this.cb_ok)
destroy(this.st_width)
destroy(this.st_height)
destroy(this.st_colors)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_pbver)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_ostype)
destroy(this.st_cpu_type)
end on

on close;w_main.Show()
end on

type st_4 from statictext within w_getenvironment
int X=23
int Y=276
int Width=645
int Height=72
boolean Enabled=false
string Text="Executable Type :"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_exe from statictext within w_getenvironment
int X=677
int Y=276
int Width=800
int Height=72
boolean Enabled=false
string Text="unknown"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_getenvironment
int X=535
int Y=676
int Width=247
int Height=88
int TabOrder=1
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type st_width from statictext within w_getenvironment
int X=677
int Y=572
int Width=247
int Height=72
boolean Enabled=false
string Text="?"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_height from statictext within w_getenvironment
int X=677
int Y=492
int Width=247
int Height=72
boolean Enabled=false
string Text="?"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_colors from statictext within w_getenvironment
int X=677
int Y=412
int Width=247
int Height=72
boolean Enabled=false
string Text="?"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_getenvironment
int X=256
int Y=572
int Width=416
int Height=72
boolean Enabled=false
string Text="Screen Width : "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_getenvironment
int X=247
int Y=492
int Width=421
int Height=72
boolean Enabled=false
string Text="Screen Height : "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_getenvironment
int X=169
int Y=412
int Width=503
int Height=72
boolean Enabled=false
string Text="Number of colors : "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_pbver from statictext within w_getenvironment
int X=677
int Y=196
int Width=800
int Height=72
boolean Enabled=false
string Text="version unkown"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_getenvironment
int X=23
int Y=196
int Width=645
int Height=72
boolean Enabled=false
string Text="PowerBuilder Version : "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_getenvironment
int X=402
int Y=116
int Width=265
int Height=72
boolean Enabled=false
string Text="OS Type : "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_getenvironment
int X=384
int Y=36
int Width=288
int Height=72
boolean Enabled=false
string Text="CPU Type : "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_ostype from statictext within w_getenvironment
int X=677
int Y=116
int Width=759
int Height=72
boolean Enabled=false
string Text="os type unknown"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_cpu_type from statictext within w_getenvironment
int X=677
int Y=36
int Width=759
int Height=72
boolean Enabled=false
string Text="cpu unkown"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

