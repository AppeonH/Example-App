$PBExportHeader$w_towers_hanoi.srw
$PBExportComments$Towers of Hanoi Example -- shows recursion visually
forward
global type w_towers_hanoi from w_center
end type
type st_1 from statictext within w_towers_hanoi
end type
type cb_help from commandbutton within w_towers_hanoi
end type
type cbx_sstep from checkbox within w_towers_hanoi
end type
type em_disks from editmask within w_towers_hanoi
end type
type cb_close from commandbutton within w_towers_hanoi
end type
type uo_peg_c from u_tower within w_towers_hanoi
end type
type uo_peg_b from u_tower within w_towers_hanoi
end type
type uo_peg_a from u_tower within w_towers_hanoi
end type
type cb_start from commandbutton within w_towers_hanoi
end type
type lb_step from listbox within w_towers_hanoi
end type
type gb_1 from groupbox within w_towers_hanoi
end type
type ln_1 from line within w_towers_hanoi
end type
type ln_2 from line within w_towers_hanoi
end type
end forward

global type w_towers_hanoi from w_center
integer x = 55
integer y = 124
integer width = 2825
integer height = 1744
string title = "Towers of Hanoi "
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
st_1 st_1
cb_help cb_help
cbx_sstep cbx_sstep
em_disks em_disks
cb_close cb_close
uo_peg_c uo_peg_c
uo_peg_b uo_peg_b
uo_peg_a uo_peg_a
cb_start cb_start
lb_step lb_step
gb_1 gb_1
ln_1 ln_1
ln_2 ln_2
end type
global w_towers_hanoi w_towers_hanoi

type prototypes


end prototypes

type variables
int ii_step
boolean ib_cancel

end variables

forward prototypes
public subroutine wf_movedisk (int ai_disk, u_tower auo_startpeg, u_tower auo_midpeg, u_tower auo_endpeg)
end prototypes

public subroutine wf_movedisk (int ai_disk, u_tower auo_startpeg, u_tower auo_midpeg, u_tower auo_endpeg);//wf_movedisk
//Recursive window function to move disk from first peg to last peg 

str_disk	 lstr_disk
int 		 li_currow

//Test if cancel button was hit
If ib_cancel Then Return

//if last disk of iteration
If ai_disk = 1 Then
	//debug(step) mode is active .. Wait for trigger to continue
	If cbx_sstep.checked Then 
		//open a response type window which will halt execution
		//if the window returns a 0 then single step is canceled.
		open(w_towers_single_step)
		If message.doubleparm = 0 Then cbx_sstep.checked = false
	End If

	//increment step #
	ii_step++

	//let any backed up processing continue
	Do while yield() 
	Loop

	//display  this step, in listbox
	li_currow = lb_step.Additem(string(ii_step) + ". Move disk from " +&
		 mid(auo_startpeg.classname(),4) + " to " + mid(auo_endpeg.classname(),4))
	lb_step.SetTop(li_currow)

	//visually show this move, by removing the disk from one peg and placing it on another
	auo_startpeg.removedisk(lstr_disk)
	auo_endpeg.adddisk(lstr_disk)
Else
	// move total disks - 1 from the start peg to middle peg
	wf_movedisk(ai_disk - 1, auo_startpeg, auo_endpeg, auo_midpeg)
	// move disk from start peg to end peg
	wf_movedisk(1, auo_startpeg, u_tower, auo_endpeg)
	// move total disks - 1 from middle peg to end peg
	wf_movedisk(ai_disk - 1, auo_midpeg, auo_startpeg, auo_endpeg)
End If
end subroutine

on close;

w_main.Show( )
end on

event open;call super::open;//open event

//simulates towers of hanoi problem using recursion

end event

on w_towers_hanoi.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_help=create cb_help
this.cbx_sstep=create cbx_sstep
this.em_disks=create em_disks
this.cb_close=create cb_close
this.uo_peg_c=create uo_peg_c
this.uo_peg_b=create uo_peg_b
this.uo_peg_a=create uo_peg_a
this.cb_start=create cb_start
this.lb_step=create lb_step
this.gb_1=create gb_1
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_help
this.Control[iCurrent+3]=this.cbx_sstep
this.Control[iCurrent+4]=this.em_disks
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.uo_peg_c
this.Control[iCurrent+7]=this.uo_peg_b
this.Control[iCurrent+8]=this.uo_peg_a
this.Control[iCurrent+9]=this.cb_start
this.Control[iCurrent+10]=this.lb_step
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.ln_1
this.Control[iCurrent+13]=this.ln_2
end on

on w_towers_hanoi.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_help)
destroy(this.cbx_sstep)
destroy(this.em_disks)
destroy(this.cb_close)
destroy(this.uo_peg_c)
destroy(this.uo_peg_b)
destroy(this.uo_peg_a)
destroy(this.cb_start)
destroy(this.lb_step)
destroy(this.gb_1)
destroy(this.ln_1)
destroy(this.ln_2)
end on

on closequery;//All Stacks in recursive process must be unloaded before window can gracefully close

If  cb_start.text <> "&Start" Then 
	Messagebox("Process is still Running","Hit Cancel to Stop Process Before Closing Window")
	Message.ReturnValue = 1
End If
end on

type st_1 from statictext within w_towers_hanoi
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Solution:"
alignment alignment = right!
boolean focusrectangle = false
integer x = 18
integer y = 1216
integer width = 247
integer height = 72
end type

type cb_help from commandbutton within w_towers_hanoi
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Help"
integer x = 2423
integer y = 1460
integer width = 297
integer height = 92
integer taborder = 50
end type

on clicked;f_open_help(parent.classname())
end on

type cbx_sstep from checkbox within w_towers_hanoi
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Single Step"
borderstyle borderstyle = stylelowered!
integer x = 1687
integer y = 1416
integer width = 425
integer height = 72
end type

type em_disks from editmask within w_towers_hanoi
string mask = "###,###"
boolean spin = true
string displaydata = "1~t1/2~t2/3~t3/4~t4/5~t5/6~t6/7~t7/8~t8/9~t9/10~t10/"
string minmax = "1~~14"
boolean usecodetable = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
string text = "4"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
integer x = 1733
integer y = 1280
integer width = 215
integer height = 92
integer taborder = 30
end type

type cb_close from commandbutton within w_towers_hanoi
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
integer x = 2423
integer y = 1340
integer width = 297
integer height = 92
integer taborder = 40
end type

on clicked;close(parent)
end on

type uo_peg_c from u_tower within w_towers_hanoi
long backcolor = 74481808
integer x = 1792
integer y = 160
integer width = 997
integer height = 964
integer taborder = 10
end type

on uo_peg_c.destroy
call u_tower::destroy
end on

type uo_peg_b from u_tower within w_towers_hanoi
long backcolor = 74481808
integer x = 914
integer y = 160
integer width = 997
integer height = 964
integer taborder = 70
end type

on uo_peg_b.destroy
call u_tower::destroy
end on

type uo_peg_a from u_tower within w_towers_hanoi
long backcolor = 74481808
integer x = 23
integer y = 160
integer width = 997
integer height = 968
end type

on uo_peg_a.destroy
call u_tower::destroy
end on

type cb_start from commandbutton within w_towers_hanoi
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Start"
integer x = 2423
integer y = 1220
integer width = 297
integer height = 92
integer taborder = 80
end type

event clicked;int li_disk, li_index, li_size
str_disk lstr_disk 
long ll_rc

//how many disk used in this example
li_disk = Integer(em_disks.text)
If li_disk > 14 Or li_Disk < 1 Then
	MessageBox("Peg Error", "Error!  Only 14 disks are allowed.", Exclamation!)
	Return
End If

//test if this is a start or cancel button
If this.text = "C&ancel" Then
	ib_cancel = True
	return
Else
	ib_cancel = False
	this.text = "C&ancel"
End If	

//reset all 3 pegs
uo_peg_c.resetpeg()
uo_peg_b.resetpeg()
uo_peg_a.resetpeg()

//clear out result set
lb_step.reset()
ii_step = 0

//set up the first peg with the # of disks requested. Add the disk with a random
//color and the largest disk on the botton
For li_index = li_disk to 1 step - 1
	lstr_disk.size = 170 + li_index * 60   //disk size
	lstr_disk.color = Rgb(rand(255),rand(255),rand(255)) //random disk color
	uo_peg_a.adddisk(lstr_disk)  //place the disk on the peg
Next

//disable buttons during the execution
//cb_start.enabled = false
cb_close.enabled = false

//This starts the recursive routine
wf_movedisk(li_disk,uo_peg_a,uo_peg_b,uo_peg_c)

//cb_start.enabled = true
cb_close.enabled = true

//yeah! we made it to the end....
//play tune if supported on platform
gu_ext_func.uf_PlaySound("tada.wav",1)

//reset text back to "start"
this.text = "&Start"
end event

type lb_step from listbox within w_towers_hanoi
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
integer x = 288
integer y = 1216
integer width = 1266
integer height = 292
integer taborder = 60
end type

type gb_1 from groupbox within w_towers_hanoi
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Disks"
borderstyle borderstyle = stylelowered!
integer x = 1682
integer y = 1216
integer width = 320
integer height = 172
integer taborder = 20
end type

type ln_1 from line within w_towers_hanoi
integer beginx = 37
integer beginy = 1168
integer endx = 2706
integer endy = 1168
long linecolor = 41943040
integer linethickness = 4
end type

type ln_2 from line within w_towers_hanoi
integer beginx = 37
integer beginy = 1172
integer endx = 2706
integer endy = 1172
long linecolor = 41943040
integer linethickness = 4
end type

