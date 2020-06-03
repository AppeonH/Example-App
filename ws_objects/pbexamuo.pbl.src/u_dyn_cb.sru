$PBExportHeader$u_dyn_cb.sru
$PBExportComments$User Object command button that is opened dynamically
forward
global type u_dyn_cb from UserObject
end type
type cb_button from commandbutton within u_dyn_cb
end type
end forward

global type u_dyn_cb from UserObject
int Width=407
int Height=148
long BackColor=79416533
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event lbuttondown pbm_lbuttondown
cb_button cb_button
end type
global u_dyn_cb u_dyn_cb

type variables
w_dynamic_uo_open_uo_frame iw_frame
w_dynamic_uo_work_area iw_parent
string is_clicked_event
integer ii_object_number
end variables

on lbuttondown;
//put my self into drag mode
iw_parent.ii_UDO_nmbr	=	ii_object_number
iw_parent.iu_being_dragged = this
Drag(Begin!)





end on

on rbuttondown;string txt
int posi
// see if there is a '&' in the text string and remove it
txt = cb_button.text
posi = pos(txt,'&')
if posi > 0 then txt = replace(txt,posi,1,'')
// ask user if ok to delete
if messagebox(txt+' Control',"Ok to delete?",question!,yesno!,1) = 2 then return
iw_parent.iu_being_dragged = this
iw_parent.Postevent("ue_close_udo")
end on

on constructor;// get the information about what kind a button we are supposed to be
u_dyn_struct parm
parm = message.powerobjectparm
ii_object_number = parm.code // set the object code
iw_frame = parentwindow(parm.win) // who's my frame
iw_parent = parm.win  // who's my sheet
is_clicked_event = parm.clicked  // when clicked what event do I trigger
cb_button.width = parm.size  // how big am I
cb_button.text = parm.label  // what my name
this.width = cb_button.width + 2.5*cb_button.x

end on

on u_dyn_cb.create
this.cb_button=create cb_button
this.Control[]={this.cb_button}
end on

on u_dyn_cb.destroy
destroy(this.cb_button)
end on

type cb_button from commandbutton within u_dyn_cb
int X=41
int Y=24
int Width=334
int Height=80
int TabOrder=10
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// tell my sheet to run the event named in is_clicked_event
iw_parent.triggerevent(is_clicked_event)
end on

