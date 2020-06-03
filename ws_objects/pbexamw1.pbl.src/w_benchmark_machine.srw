$PBExportHeader$w_benchmark_machine.srw
$PBExportComments$Window to enter type of test machine
forward
global type w_benchmark_machine from w_center
end type
type ddlb_cpu from dropdownlistbox within w_benchmark_machine
end type
type cb_cancel from commandbutton within w_benchmark_machine
end type
type cb_ok from commandbutton within w_benchmark_machine
end type
type st_7 from statictext within w_benchmark_machine
end type
type st_6 from statictext within w_benchmark_machine
end type
type sle_memory from singlelineedit within w_benchmark_machine
end type
type sle_speed from singlelineedit within w_benchmark_machine
end type
type st_4 from statictext within w_benchmark_machine
end type
type st_3 from statictext within w_benchmark_machine
end type
type st_2 from statictext within w_benchmark_machine
end type
type st_1 from statictext within w_benchmark_machine
end type
end forward

global type w_benchmark_machine from w_center
int X=797
int Y=788
int Width=1281
int Height=733
boolean TitleBar=true
string Title="Test Machine Identification"
long BackColor=73955432
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
ddlb_cpu ddlb_cpu
cb_cancel cb_cancel
cb_ok cb_ok
st_7 st_7
st_6 st_6
sle_memory sle_memory
sle_speed sle_speed
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_benchmark_machine w_benchmark_machine

on w_benchmark_machine.create
this.ddlb_cpu=create ddlb_cpu
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_7=create st_7
this.st_6=create st_6
this.sle_memory=create sle_memory
this.sle_speed=create sle_speed
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={ this.ddlb_cpu,&
this.cb_cancel,&
this.cb_ok,&
this.st_7,&
this.st_6,&
this.sle_memory,&
this.sle_speed,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_benchmark_machine.destroy
destroy(this.ddlb_cpu)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.sle_memory)
destroy(this.sle_speed)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;call super::open;If f_get_profile("Benchmark Machine", "CPU", ddlb_cpu.Text) = -1 Then
	Choose Case ge_Environment.cputype
		Case alpha!
			ddlb_cpu.Text = "Alpha"
		Case hppa!
			ddlb_cpu.Text = "HPPA"
		Case i286!
			ddlb_cpu.Text = "i286"
		Case i386!
			ddlb_cpu.Text = "i386"
		Case i486!
			ddlb_cpu.Text = "i486"
		Case m68000!
			ddlb_cpu.Text = "m68000"
		Case m68020!
			ddlb_cpu.Text = "m68020"
		Case m68030!
			ddlb_cpu.Text = "m68030"
		Case m68040!
			ddlb_cpu.Text = "m68040"
		Case mips!
			ddlb_cpu.Text = "Mips"
		Case pentium!
			ddlb_cpu.Text = "Pentium"
		Case powerpc!
			ddlb_cpu.Text = "PowerPC"
		Case sparc!
			ddlb_cpu.Text = "Sparc"
	End Choose
End If

f_get_profile("Benchmark Machine", "Speed", sle_speed.Text)
f_get_profile("Benchmark Machine", "Memory", sle_memory.Text)

end event

type ddlb_cpu from dropdownlistbox within w_benchmark_machine
int X=239
int Y=129
int Width=338
int Height=445
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Alpha",&
"HPPA",&
"i286",&
"i386",&
"i486",&
"m68000",&
"m68020",&
"m68030",&
"m68040",&
"Mips",&
"Pentium",&
"PowerPC",&
"Sparc"}
end type

type cb_cancel from commandbutton within w_benchmark_machine
int X=630
int Y=481
int Width=281
int Height=87
int TabOrder=40
string Text="Cancel"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_ok from commandbutton within w_benchmark_machine
int X=264
int Y=481
int Width=274
int Height=87
int TabOrder=30
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_set_profile("Benchmark Machine", "CPU", ddlb_cpu.Text)
f_set_profile("Benchmark Machine", "Speed", sle_speed.Text)
f_set_profile("Benchmark Machine", "Memory", sle_memory.Text)

Close(Parent)

end event

type st_7 from statictext within w_benchmark_machine
int X=438
int Y=337
int Width=136
int Height=61
boolean Enabled=false
string Text="Meg."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_benchmark_machine
int X=441
int Y=234
int Width=107
int Height=61
boolean Enabled=false
string Text="Mhz"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_memory from singlelineedit within w_benchmark_machine
int X=239
int Y=330
int Width=193
int Height=74
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_speed from singlelineedit within w_benchmark_machine
int X=239
int Y=228
int Width=193
int Height=74
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_benchmark_machine
int X=18
int Y=337
int Width=207
int Height=61
boolean Enabled=false
string Text="Memory:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_benchmark_machine
int X=33
int Y=234
int Width=193
int Height=61
boolean Enabled=false
string Text="Speed:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_benchmark_machine
int X=82
int Y=135
int Width=143
int Height=61
boolean Enabled=false
string Text="CPU:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_benchmark_machine
int X=29
int Y=20
int Width=939
int Height=61
boolean Enabled=false
string Text="Identify the machine used for testing:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

