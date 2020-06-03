$PBExportHeader$u_st_puzzle.sru
$PBExportComments$Subclassed Standard Text UO, used by the PowerPuzzle
forward
global type u_st_puzzle from statictext
end type
end forward

global type u_st_puzzle from statictext
int Width=168
int Height=170
boolean Border=true
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_st_puzzle u_st_puzzle

type variables

end variables

event dragdrop;Picture		lp_Piece

lp_Piece = source

lp_Piece.x = This.x
lp_Piece.y = This.y

This.Tag = lp_Piece.PictureName

gu_ext_func.uf_playsound("clicktp.wav", 1)

Parent.Post Dynamic Event ue_checksolve()

end event

