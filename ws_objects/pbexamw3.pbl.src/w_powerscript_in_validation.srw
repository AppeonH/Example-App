$PBExportHeader$w_powerscript_in_validation.srw
$PBExportComments$DW that calls PowerScript function in a validation formula.  Also has examples of complex validation rules.
forward
global type w_powerscript_in_validation from w_center
end type
type st_8 from statictext within w_powerscript_in_validation
end type
type st_7 from statictext within w_powerscript_in_validation
end type
type st_6 from statictext within w_powerscript_in_validation
end type
type st_5 from statictext within w_powerscript_in_validation
end type
type st_4 from statictext within w_powerscript_in_validation
end type
type st_3 from statictext within w_powerscript_in_validation
end type
type cb_1 from commandbutton within w_powerscript_in_validation
end type
type dw_1 from datawindow within w_powerscript_in_validation
end type
type st_2 from statictext within w_powerscript_in_validation
end type
type st_1 from statictext within w_powerscript_in_validation
end type
end forward

global type w_powerscript_in_validation from w_center
int X=193
int Y=261
int Width=2551
int Height=1229
boolean TitleBar=true
string Title="DataWindow Validation Rules"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
cb_1 cb_1
dw_1 dw_1
st_2 st_2
st_1 st_1
end type
global w_powerscript_in_validation w_powerscript_in_validation

on open;//open event
//Set the tranasaction object and retrieve data into the datawindow.
//The validation rules that exist for this example are contained in the datawindow

dw_1.SetTransObject (sqlca)

dw_1.Retrieve ()

end on

on w_powerscript_in_validation.create
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={ this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.cb_1,&
this.dw_1,&
this.st_2,&
this.st_1}
end on

on w_powerscript_in_validation.destroy
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
end on

on close;w_main.show()
end on

type st_8 from statictext within w_powerscript_in_validation
int Y=809
int Width=462
int Height=69
boolean Enabled=false
string Text=" Other    < 90,000"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_powerscript_in_validation
int Y=753
int Width=462
int Height=69
boolean Enabled=false
string Text=" 200       < 60,000"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_powerscript_in_validation
int Y=693
int Width=462
int Height=77
boolean Enabled=false
string Text=" 100       < 65,000"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_powerscript_in_validation
int X=19
int Y=53
int Width=453
int Height=69
boolean Enabled=false
string Text="Validation Rule"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_powerscript_in_validation
int Y=625
int Width=449
int Height=69
boolean Enabled=false
string Text="Dept       Salary"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_powerscript_in_validation
int X=14
int Y=333
int Width=613
int Height=237
boolean Enabled=false
string Text="Name consists of alphabetic characters only.  The first character of Name must be uppercase."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_powerscript_in_validation
int X=1089
int Y=945
int Width=357
int Height=101
int TabOrder=20
string Text="&Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type dw_1 from datawindow within w_powerscript_in_validation
int X=645
int Y=117
int Width=1793
int Height=741
int TabOrder=10
string DataObject="d_powerscript_function_validation"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_2 from statictext within w_powerscript_in_validation
int X=14
int Y=221
int Width=449
int Height=101
boolean Enabled=false
string Text="ID is in the dept table"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_powerscript_in_validation
int X=14
int Y=133
int Width=449
int Height=69
boolean Enabled=false
string Text="ID is > 100"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

