$PBExportHeader$w_puzzle.srw
$PBExportComments$Puzzle game
forward
global type w_puzzle from w_center
end type
type st_27 from statictext within w_puzzle
end type
type st_time from statictext within w_puzzle
end type
type st_26 from statictext within w_puzzle
end type
type cb_thumnail from commandbutton within w_puzzle
end type
type cb_help from commandbutton within w_puzzle
end type
type st_17 from u_st_puzzle within w_puzzle
end type
type st_16 from u_st_puzzle within w_puzzle
end type
type st_11 from u_st_puzzle within w_puzzle
end type
type st_12 from u_st_puzzle within w_puzzle
end type
type st_6 from u_st_puzzle within w_puzzle
end type
type st_7 from u_st_puzzle within w_puzzle
end type
type st_2 from u_st_puzzle within w_puzzle
end type
type st_1 from u_st_puzzle within w_puzzle
end type
type cb_solve from commandbutton within w_puzzle
end type
type st_inst from statictext within w_puzzle
end type
type cb_close from commandbutton within w_puzzle
end type
type cb_scramble from commandbutton within w_puzzle
end type
type st_22 from u_st_puzzle within w_puzzle
end type
type st_21 from u_st_puzzle within w_puzzle
end type
type mle_1 from multilineedit within w_puzzle
end type
type st_25 from u_st_puzzle within w_puzzle
end type
type st_20 from u_st_puzzle within w_puzzle
end type
type st_15 from u_st_puzzle within w_puzzle
end type
type st_10 from u_st_puzzle within w_puzzle
end type
type st_5 from u_st_puzzle within w_puzzle
end type
type st_4 from u_st_puzzle within w_puzzle
end type
type st_9 from u_st_puzzle within w_puzzle
end type
type st_14 from u_st_puzzle within w_puzzle
end type
type st_19 from u_st_puzzle within w_puzzle
end type
type st_24 from u_st_puzzle within w_puzzle
end type
type st_23 from u_st_puzzle within w_puzzle
end type
type st_18 from u_st_puzzle within w_puzzle
end type
type st_13 from u_st_puzzle within w_puzzle
end type
type st_8 from u_st_puzzle within w_puzzle
end type
type st_3 from u_st_puzzle within w_puzzle
end type
type p_logo from picture within w_puzzle
end type
type p_y from picture within w_puzzle
end type
type p_x from picture within w_puzzle
end type
type p_w from picture within w_puzzle
end type
type p_v from picture within w_puzzle
end type
type p_u from picture within w_puzzle
end type
type p_b from picture within w_puzzle
end type
type p_c from picture within w_puzzle
end type
type p_d from picture within w_puzzle
end type
type p_a from picture within w_puzzle
end type
type p_e from picture within w_puzzle
end type
type p_f from picture within w_puzzle
end type
type p_g from picture within w_puzzle
end type
type p_h from picture within w_puzzle
end type
type p_j from picture within w_puzzle
end type
type p_i from picture within w_puzzle
end type
type p_k from picture within w_puzzle
end type
type p_l from picture within w_puzzle
end type
type p_m from picture within w_puzzle
end type
type p_n from picture within w_puzzle
end type
type p_o from picture within w_puzzle
end type
type p_p from picture within w_puzzle
end type
type p_q from picture within w_puzzle
end type
type p_r from picture within w_puzzle
end type
type p_s from picture within w_puzzle
end type
type p_t from picture within w_puzzle
end type
end forward

global type w_puzzle from w_center
int X=5
int Y=316
int Width=2949
int Height=1512
boolean TitleBar=true
string Title="PowerPuzzle"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_checksolve ( )
st_27 st_27
st_time st_time
st_26 st_26
cb_thumnail cb_thumnail
cb_help cb_help
st_17 st_17
st_16 st_16
st_11 st_11
st_12 st_12
st_6 st_6
st_7 st_7
st_2 st_2
st_1 st_1
cb_solve cb_solve
st_inst st_inst
cb_close cb_close
cb_scramble cb_scramble
st_22 st_22
st_21 st_21
mle_1 mle_1
st_25 st_25
st_20 st_20
st_15 st_15

st_10 st_10
st_5 st_5
st_4 st_4
st_9 st_9
st_14 st_14
st_19 st_19
st_24 st_24
st_23 st_23
st_18 st_18
st_13 st_13
st_8 st_8
st_3 st_3
p_logo p_logo
p_y p_y
p_x p_x
p_w p_w
p_v p_v
p_u p_u
p_b p_b
p_c p_c
p_d p_d
p_a p_a
p_e p_e
p_f p_f
p_g p_g
p_h p_h
p_j p_j
p_i p_i
p_k p_k
p_l p_l
p_m p_m
p_n p_n
p_o p_o
p_p p_p
p_q p_q
p_r p_r
p_s p_s
p_t p_t
end type
global w_puzzle w_puzzle

type variables
String	is_Solution[25]
u_st_puzzle  iu_Puzzle[25]
Boolean	ib_Solving
end variables

event ue_checksolve;Integer	li_Cnt
Boolean	lb_Wrong

If Not ib_Solving Then Return

// The tag value of each object contains the BMP name of the
// picture that was placed on it
lb_Wrong = False
For li_Cnt = 1 to 25
	If iu_Puzzle[li_Cnt].Tag <> is_Solution[li_Cnt] Then
		lb_Wrong = True
		li_Cnt = 25
	End if
Next

If Not lb_Wrong Then
	Timer(0)
	MessageBox("Congratulations","You did it in " + st_time.Text + " seconds!")
	ib_Solving = False
	st_inst.Text = "Click ~"Scramble~" to begin."
End if

end event

event open;call super::open;Integer	li_Cnt

// Initialize array containing solution
is_Solution[1] = "logo11.bmp"
is_Solution[2] = "logo12.bmp"
is_Solution[3] = "logo13.bmp"
is_Solution[4] = "logo14.bmp"
is_Solution[5] = "logo15.bmp"
is_Solution[6] = "logo21.bmp"
is_Solution[7] = "logo22.bmp"
is_Solution[8] = "logo23.bmp"
is_Solution[9] = "logo24.bmp"
is_Solution[10] = "logo25.bmp"
is_Solution[11] = "logo31.bmp"
is_Solution[12] = "logo32.bmp"
is_Solution[13] = "logo33.bmp"
is_Solution[14] = "logo34.bmp"
is_Solution[15] = "logo35.bmp"
is_Solution[16] = "logo41.bmp"
is_Solution[17] = "logo42.bmp"
is_Solution[18] = "logo43.bmp"
is_Solution[19] = "logo44.bmp"
is_Solution[20] = "logo45.bmp"
is_Solution[21] = "logo51.bmp"
is_Solution[22] = "logo52.bmp"
is_Solution[23] = "logo53.bmp"
is_Solution[24] = "logo54.bmp"
is_Solution[25] = "logo55.bmp"

// Register each StaticText User Object
// The array will be used to check for solution
iu_Puzzle[1] = st_1
iu_Puzzle[2] = st_2
iu_Puzzle[3] = st_3
iu_Puzzle[4] = st_4
iu_Puzzle[5] = st_5
iu_Puzzle[6] = st_6
iu_Puzzle[7] = st_7
iu_Puzzle[8] = st_8
iu_Puzzle[9] = st_9
iu_Puzzle[10] = st_10
iu_Puzzle[11] = st_11
iu_Puzzle[12] = st_12
iu_Puzzle[13] = st_13
iu_Puzzle[14] = st_14
iu_Puzzle[15] = st_15
iu_Puzzle[16] = st_16
iu_Puzzle[17] = st_17
iu_Puzzle[18] = st_18
iu_Puzzle[19] = st_19
iu_Puzzle[20] = st_20
iu_Puzzle[21] = st_21
iu_Puzzle[22] = st_22
iu_Puzzle[23] = st_23
iu_Puzzle[24] = st_24
iu_Puzzle[25] = st_25

// The borders are only on so the objects can be seen in the painter
For li_Cnt = 1 To 25
	iu_Puzzle[li_Cnt].Border = False
Next

ib_Solving = False

Randomize(0)

end event

event dragdrop;Picture		lp_Piece

//lp_Piece = source
lp_Piece = DraggedObject()

lp_Piece.x = This.PointerX()
lp_Piece.y = This.PointerY()

end event

on w_puzzle.destroy
destroy(this.st_27)
destroy(this.st_time)
destroy(this.st_26)
destroy(this.cb_thumnail)
destroy(this.cb_help)
destroy(this.st_17)
destroy(this.st_16)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_solve)
destroy(this.st_inst)
destroy(this.cb_close)
destroy(this.cb_scramble)
destroy(this.st_22)
destroy(this.st_21)
destroy(this.mle_1)
destroy(this.st_25)
destroy(this.st_20)
destroy(this.st_15)
destroy(this.st_10)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_9)
destroy(this.st_14)
destroy(this.st_19)
destroy(this.st_24)
destroy(this.st_23)
destroy(this.st_18)
destroy(this.st_13)
destroy(this.st_8)
destroy(this.st_3)
destroy(this.p_logo)
destroy(this.p_y)
destroy(this.p_x)
destroy(this.p_w)
destroy(this.p_v)
destroy(this.p_u)
destroy(this.p_b)
destroy(this.p_c)
destroy(this.p_d)
destroy(this.p_a)
destroy(this.p_e)
destroy(this.p_f)
destroy(this.p_g)
destroy(this.p_h)
destroy(this.p_j)
destroy(this.p_i)
destroy(this.p_k)
destroy(this.p_l)
destroy(this.p_m)
destroy(this.p_n)
destroy(this.p_o)
destroy(this.p_p)
destroy(this.p_q)
destroy(this.p_r)
destroy(this.p_s)
destroy(this.p_t)
end on

on w_puzzle.create
this.st_27=create st_27
this.st_time=create st_time
this.st_26=create st_26
this.cb_thumnail=create cb_thumnail
this.cb_help=create cb_help
this.st_17=create st_17
this.st_16=create st_16
this.st_11=create st_11
this.st_12=create st_12
this.st_6=create st_6
this.st_7=create st_7
this.st_2=create st_2
this.st_1=create st_1
this.cb_solve=create cb_solve
this.st_inst=create st_inst
this.cb_close=create cb_close
this.cb_scramble=create cb_scramble
this.st_22=create st_22
this.st_21=create st_21
this.mle_1=create mle_1
this.st_25=create st_25
this.st_20=create st_20
this.st_15=create st_15
this.st_10=create st_10
this.st_5=create st_5
this.st_4=create st_4
this.st_9=create st_9
this.st_14=create st_14
this.st_19=create st_19
this.st_24=create st_24
this.st_23=create st_23
this.st_18=create st_18
this.st_13=create st_13
this.st_8=create st_8
this.st_3=create st_3
this.p_logo=create p_logo
this.p_y=create p_y
this.p_x=create p_x
this.p_w=create p_w
this.p_v=create p_v
this.p_u=create p_u
this.p_b=create p_b
this.p_c=create p_c
this.p_d=create p_d
this.p_a=create p_a
this.p_e=create p_e
this.p_f=create p_f
this.p_g=create p_g
this.p_h=create p_h
this.p_j=create p_j
this.p_i=create p_i
this.p_k=create p_k
this.p_l=create p_l
this.p_m=create p_m
this.p_n=create p_n
this.p_o=create p_o
this.p_p=create p_p
this.p_q=create p_q
this.p_r=create p_r
this.p_s=create p_s
this.p_t=create p_t
this.Control[]={this.st_27,&
this.st_time,&
this.st_26,&
this.cb_thumnail,&
this.cb_help,&
this.st_17,&
this.st_16,&
this.st_11,&
this.st_12,&
this.st_6,&
this.st_7,&
this.st_2,&
this.st_1,&
this.cb_solve,&
this.st_inst,&
this.cb_close,&
this.cb_scramble,&
this.st_22,&
this.st_21,&
this.mle_1,&
this.st_25,&
this.st_20,&
this.st_15,&
this.st_10,&
this.st_5,&
this.st_4,&
this.st_9,&
this.st_14,&
this.st_19,&
this.st_24,&
this.st_23,&
this.st_18,&
this.st_13,&
this.st_8,&
this.st_3,&
this.p_logo,&
this.p_y,&
this.p_x,&
this.p_w,&
this.p_v,&
this.p_u,&
this.p_b,&
this.p_c,&
this.p_d,&
this.p_a,&
this.p_e,&
this.p_f,&
this.p_g,&
this.p_h,&
this.p_j,&
this.p_i,&
this.p_k,&
this.p_l,&
this.p_m,&
this.p_n,&
this.p_o,&
this.p_p,&
this.p_q,&
this.p_r,&
this.p_s,&
this.p_t}
end on

event close;If IsValid(w_puzzle_thumnail) Then
	Close(w_puzzle_thumnail)
End If

Show(w_main)

end event

event timer;Integer	li_Seconds

li_Seconds = Integer(st_time.Text) + 1
st_Time.Text = String(li_Seconds)

end event

type st_27 from statictext within w_puzzle
int X=2738
int Y=12
int Width=187
int Height=68
boolean Enabled=false
string Text="seconds"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time from statictext within w_puzzle
int X=2629
int Y=8
int Width=105
int Height=68
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_26 from statictext within w_puzzle
int X=2295
int Y=12
int Width=315
int Height=68
boolean Enabled=false
string Text="Elapsed Time:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=79741120
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_thumnail from commandbutton within w_puzzle
event clicked pbm_bnclicked
int X=667
int Y=1312
int Width=434
int Height=84
int TabOrder=30
string Text="Show &Thumbnail"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Open(w_puzzle_thumnail)

end event

type cb_help from commandbutton within w_puzzle
int X=1435
int Y=1312
int Width=315
int Height=84
int TabOrder=50
string Text="&Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_puzzle")

end event

type st_17 from u_st_puzzle within w_puzzle
int X=315
int Y=776
int Width=297
int Height=252
end type

type st_16 from u_st_puzzle within w_puzzle
int X=32
int Y=776
int Width=288
int Height=252
end type

type st_11 from u_st_puzzle within w_puzzle
int X=32
int Y=528
int Width=288
int Height=252
end type

type st_12 from u_st_puzzle within w_puzzle
int X=315
int Y=528
int Width=297
int Height=252
end type

type st_6 from u_st_puzzle within w_puzzle
int X=32
int Y=280
int Width=288
int Height=252
end type

type st_7 from u_st_puzzle within w_puzzle
int X=315
int Y=280
int Width=297
int Height=252
end type

type st_2 from u_st_puzzle within w_puzzle
int X=315
int Y=32
int Width=297
int Height=252
end type

type st_1 from u_st_puzzle within w_puzzle
int X=32
int Y=32
int Width=288
int Height=252
end type

type cb_solve from commandbutton within w_puzzle
int X=343
int Y=1312
int Width=315
int Height=84
int TabOrder=20
boolean Enabled=false
string Text="S&olve"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Timer(0)
st_time.Text = "0"

// Solve the puzzle
p_a.Move(st_1.x, st_1.y)
p_b.Move(st_2.x, st_2.y)
p_c.Move(st_3.x, st_3.y)
p_d.Move(st_4.x, st_4.y)
p_e.Move(st_5.x, st_5.y)
p_f.Move(st_6.x, st_6.y)
p_g.Move(st_7.x, st_7.y)
p_h.Move(st_8.x, st_8.y)
p_i.Move(st_9.x, st_9.y)
p_j.Move(st_10.x, st_10.y)
p_k.Move(st_11.x, st_11.y)
p_l.Move(st_12.x, st_12.y)
p_m.Move(st_13.x, st_13.y)
p_n.Move(st_14.x, st_14.y)
p_o.Move(st_15.x, st_15.y)
p_p.Move(st_16.x, st_16.y)
p_q.Move(st_17.x, st_17.y)
p_r.Move(st_18.x, st_18.y)
p_s.Move(st_19.x, st_19.y)
p_t.Move(st_20.x, st_20.y)
p_u.Move(st_21.x, st_21.y)
p_v.Move(st_22.x, st_22.y)
p_w.Move(st_23.x, st_23.y)
p_x.Move(st_24.x, st_24.y)
p_y.Move(st_25.x, st_25.y)

ib_Solving = False
This.Enabled = False
st_inst.Text = "Click ~"Scramble~" to begin."

end event

type st_inst from statictext within w_puzzle
int X=1545
int Y=12
int Width=654
int Height=68
boolean Enabled=false
string Text="Click ~"Scramble~" to begin."
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

type cb_close from commandbutton within w_puzzle
int X=1111
int Y=1312
int Width=315
int Height=84
int TabOrder=40
string Text="&Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(Parent)

end on

type cb_scramble from commandbutton within w_puzzle
int X=18
int Y=1312
int Width=315
int Height=84
int TabOrder=10
string Text="&Scramble"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer		li_Cnt

Hide(p_logo)
st_inst.Text = "Drag and drop puzzle pieces."

// Scatter the pieces
p_a.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_b.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_c.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_d.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_e.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_f.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_g.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_h.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_i.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_j.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_k.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_l.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_m.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_n.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_o.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_p.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_q.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_r.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_s.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_t.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_u.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_v.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_w.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_x.Move(Rand(1100) + 1500,   Rand(1000) + 50)
p_y.Move(Rand(1100) + 1500,   Rand(1000) + 50)

// Clear tag values
For li_Cnt = 1 to 25
	iu_Puzzle[li_Cnt].Tag = ""
Next

ib_Solving = True

cb_solve.enabled = True

st_time.Text = "0"
Timer(1)

end event

type st_22 from u_st_puzzle within w_puzzle
int X=315
int Y=1024
int Width=297
int Height=252
end type

type st_21 from u_st_puzzle within w_puzzle
int X=32
int Y=1024
int Width=288
int Height=252
end type

type mle_1 from multilineedit within w_puzzle
int X=18
int Y=16
int Width=1458
int Height=1276
BorderStyle BorderStyle=StyleLowered!
long TextColor=74481808
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_25 from u_st_puzzle within w_puzzle
int X=1170
int Y=1024
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_20 from u_st_puzzle within w_puzzle
int X=1170
int Y=776
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_15 from u_st_puzzle within w_puzzle
int X=1170
int Y=528
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_10 from u_st_puzzle within w_puzzle
int X=1170
int Y=280
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_5 from u_st_puzzle within w_puzzle
int X=1170
int Y=32
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_4 from u_st_puzzle within w_puzzle
int X=887
int Y=32
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_9 from u_st_puzzle within w_puzzle
int X=887
int Y=280
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_14 from u_st_puzzle within w_puzzle
int X=887
int Y=528
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_19 from u_st_puzzle within w_puzzle
int X=887
int Y=776
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_24 from u_st_puzzle within w_puzzle
int X=887
int Y=1024
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_23 from u_st_puzzle within w_puzzle
int X=603
int Y=1024
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_18 from u_st_puzzle within w_puzzle
int X=603
int Y=776
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_13 from u_st_puzzle within w_puzzle
int X=603
int Y=528
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_8 from u_st_puzzle within w_puzzle
int X=603
int Y=280
int Width=288
int Height=252
boolean BringToTop=true
end type

type st_3 from u_st_puzzle within w_puzzle
int X=603
int Y=32
int Width=288
int Height=252
boolean BringToTop=true
end type

type p_logo from picture within w_puzzle
int X=27
int Y=24
int Width=1440
int Height=1260
boolean BringToTop=true
string PictureName="logo.bmp"
boolean FocusRectangle=false
end type

type p_y from picture within w_puzzle
int X=4201
int Y=1068
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo55.bmp"
boolean FocusRectangle=false
end type

type p_x from picture within w_puzzle
int X=3913
int Y=1068
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo54.bmp"
boolean FocusRectangle=false
end type

type p_w from picture within w_puzzle
int X=3625
int Y=1068
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo53.bmp"
boolean FocusRectangle=false
end type

type p_v from picture within w_puzzle
int X=3337
int Y=1068
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo52.bmp"
boolean FocusRectangle=false
end type

type p_u from picture within w_puzzle
int X=3049
int Y=1068
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo51.bmp"
boolean FocusRectangle=false
end type

type p_b from picture within w_puzzle
int X=3337
int Y=60
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo12.bmp"
boolean FocusRectangle=false
end type

type p_c from picture within w_puzzle
int X=3625
int Y=60
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo13.bmp"
boolean FocusRectangle=false
end type

type p_d from picture within w_puzzle
int X=3913
int Y=60
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo14.bmp"
boolean FocusRectangle=false
end type

type p_a from picture within w_puzzle
int X=3049
int Y=60
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo11.bmp"
boolean FocusRectangle=false
end type

type p_e from picture within w_puzzle
int X=4201
int Y=60
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo15.bmp"
boolean FocusRectangle=false
end type

type p_f from picture within w_puzzle
int X=3049
int Y=312
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo21.bmp"
boolean FocusRectangle=false
end type

type p_g from picture within w_puzzle
int X=3337
int Y=312
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo22.bmp"
boolean FocusRectangle=false
end type

type p_h from picture within w_puzzle
int X=3625
int Y=312
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo23.bmp"
boolean FocusRectangle=false
end type

type p_j from picture within w_puzzle
int X=4201
int Y=312
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo25.bmp"
boolean FocusRectangle=false
end type

type p_i from picture within w_puzzle
int X=3913
int Y=312
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo24.bmp"
boolean FocusRectangle=false
end type

type p_k from picture within w_puzzle
int X=3049
int Y=564
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo31.bmp"
boolean FocusRectangle=false
end type

type p_l from picture within w_puzzle
int X=3337
int Y=564
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo32.bmp"
boolean FocusRectangle=false
end type

type p_m from picture within w_puzzle
int X=3625
int Y=564
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo33.bmp"
boolean FocusRectangle=false
end type

type p_n from picture within w_puzzle
int X=3913
int Y=564
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo34.bmp"
boolean FocusRectangle=false
end type

type p_o from picture within w_puzzle
int X=4201
int Y=564
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo35.bmp"
boolean FocusRectangle=false
end type

type p_p from picture within w_puzzle
int X=3049
int Y=816
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo41.bmp"
boolean FocusRectangle=false
end type

type p_q from picture within w_puzzle
int X=3337
int Y=816
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo42.bmp"
boolean FocusRectangle=false
end type

type p_r from picture within w_puzzle
int X=3625
int Y=816
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo43.bmp"
boolean FocusRectangle=false
end type

type p_s from picture within w_puzzle
int X=3913
int Y=816
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo44.bmp"
boolean FocusRectangle=false
end type

type p_t from picture within w_puzzle
int X=4201
int Y=816
int Width=288
int Height=252
boolean DragAuto=true
boolean BringToTop=true
string PictureName="logo45.bmp"
boolean FocusRectangle=false
end type

