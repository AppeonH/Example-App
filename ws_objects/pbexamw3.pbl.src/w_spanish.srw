$PBExportHeader$w_spanish.srw
$PBExportComments$Inheritance:  Spanish descendant
forward
global type w_spanish from w_ancestor
end type
type st_message from statictext within w_spanish
end type
end forward

global type w_spanish from w_ancestor
int Width=2095
int Height=964
boolean TitleBar=true
string Title="Spanish"
st_message st_message
end type
global w_spanish w_spanish

on w_spanish.create
int iCurrent
call w_ancestor::create
this.st_message=create st_message
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=st_message
end on

on w_spanish.destroy
call w_ancestor::destroy
destroy(this.st_message)
end on

type em_date from w_ancestor`em_date within w_spanish
int X=676
end type

on em_date::modified;call w_ancestor`em_date::modified;st_message.text = ''
end on

type st_1 from w_ancestor`st_1 within w_spanish
int X=388
int Width=260
string Text="Cantidad:"
end type

type st_2 from w_ancestor`st_2 within w_spanish
int X=441
int Width=203
string Text="Precio:"
end type

type sle_price from w_ancestor`sle_price within w_spanish
int X=676
end type

on sle_price::modified;call w_ancestor`sle_price::modified;// ancestor script is extended so that thank you message can be erased

st_message.text = ''
end on

type sle_qty from w_ancestor`sle_qty within w_spanish
int X=676
end type

on sle_qty::modified;call w_ancestor`sle_qty::modified;// ancestor script is extended so that thank you message can be erased

st_message.text = ''
end on

type cb_1 from w_ancestor`cb_1 within w_spanish
string Text="Calcular Total"
end type

on cb_1::clicked;call w_ancestor`cb_1::clicked;// extend ancestor script so we can display a message

st_message.text = "Muchas Gracias!"
end on

type cb_2 from w_ancestor`cb_2 within w_spanish
string Text="&Aceptar"
end type

type st_4 from w_ancestor`st_4 within w_spanish
int X=153
int Width=491
string Text="Fecha de compra:"
end type

type st_3 from w_ancestor`st_3 within w_spanish
int X=481
end type

type sle_total from w_ancestor`sle_total within w_spanish
int X=676
end type

type st_message from statictext within w_spanish
int X=676
int Y=701
int Width=598
int Height=71
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

