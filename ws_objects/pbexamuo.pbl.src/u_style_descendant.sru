$PBExportHeader$u_style_descendant.sru
$PBExportComments$Descendant of u_style_ancestor, which shows extending, overiding and dynamically calling ancestor script for the various pictures.
forward
global type u_style_descendant from u_style_ancestor
end type
end forward

global type u_style_descendant from u_style_ancestor
end type
global u_style_descendant u_style_descendant

type variables
string    is_prev_text
end variables

on u_style_descendant.create
call u_style_ancestor::create
end on

on u_style_descendant.destroy
call u_style_ancestor::destroy
end on

on p_underline::clicked;call u_style_ancestor`p_underline::clicked;//////////////////////////////////////////////////////////////////////
// Example of extending an ancestor script.
//////////////////////////////////////////////////////////////////////

long	ll_color

ll_color = sle_text.backcolor

sle_text.backcolor = sle_text.textcolor
sle_text.textcolor = ll_color


end on

on p_italic::clicked;//////////////////////////////////////////////////////////////////////
// Example of CALLING an ancestor script.
//////////////////////////////////////////////////////////////////////

if Upper (sle_text.text) <> 'PLEASE' then
	MessageBox ('', 'Change the text to "please" first.')
	sle_text.SetFocus()
	sle_text.SelectText (1, Len (sle_text.text))
else
	call u_style_ancestor`p_italic::clicked
end if


end on

on p_bold::clicked;//////////////////////////////////////////////////////////////////////
// Example of overriding an ancestor script.
// (This script will be executed instead of the ancestor script)
//////////////////////////////////////////////////////////////////////

if this.picturename = "pb_b_up.bmp" then
	is_prev_text = sle_text.text
	this.picturename = "pb_b_dn.bmp"
	sle_text.text = 'Bold not allowed'
else
	this.picturename = "pb_b_up.bmp"
	sle_text.text = is_prev_text
end if



end on

type sle_text from u_style_ancestor`sle_text within u_style_descendant
string Text="u_style_descendant"
end type

