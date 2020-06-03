$PBExportHeader$w_dutch.srw
$PBExportComments$Inheritance:  Dutch descendant
forward
global type w_dutch from w_ancestor
end type
type st_message from statictext within w_dutch
end type
end forward

global type w_dutch from w_ancestor
int Width=2088
int Height=909
boolean TitleBar=true
string Title="Dutch"
st_message st_message
end type
global w_dutch w_dutch

on w_dutch.create
int iCurrent
call w_ancestor::create
this.st_message=create st_message
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_message
end on

on w_dutch.destroy
call w_ancestor::destroy
destroy(this.st_message)
end on

type em_date from w_ancestor`em_date within w_dutch
long BackColor=74481808
end type

on em_date::modified;call w_ancestor`em_date::modified;st_message.text = ''
end on

type st_1 from w_ancestor`st_1 within w_dutch
int X=185
int Width=342
string Text="Hoeveelheid:"
end type

type st_2 from w_ancestor`st_2 within w_dutch
string Text="Prijs:"
end type

type sle_price from w_ancestor`sle_price within w_dutch
long BackColor=74481808
end type

on sle_price::modified;call w_ancestor`sle_price::modified;// extend ancestor script to erase thank-you message

st_message.text = ''
end on

type sle_qty from w_ancestor`sle_qty within w_dutch
long BackColor=74481808
end type

on sle_qty::modified;call w_ancestor`sle_qty::modified;// extend ancestor script to erase thank-you message

st_message.text = ''
end on

type cb_1 from w_ancestor`cb_1 within w_dutch
string Text="Bereken Totaal"
end type

on cb_1::clicked;call w_ancestor`cb_1::clicked;// extend ancestor script to display thank you message

st_message.text = 'Dank U!'
end on

type st_4 from w_ancestor`st_4 within w_dutch
string Text="Aankoop Datum:"
end type

type st_3 from w_ancestor`st_3 within w_dutch
int X=345
int Width=185
string Text="Totaal:"
end type

type st_message from statictext within w_dutch
int X=566
int Y=692
int Width=598
int Height=81
boolean Enabled=false
boolean BringToTop=true
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

