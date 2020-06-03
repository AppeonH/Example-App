$PBExportHeader$w_train.srw
$PBExportComments$Graphic train chugging along; shows use of animation
forward
global type w_train from w_center
end type
type st_timer_interval from statictext within w_train
end type
type cb_close from commandbutton within w_train
end type
type cb_slower from commandbutton within w_train
end type
type cb_faster from commandbutton within w_train
end type
type cb_stop from commandbutton within w_train
end type
type cb_start from commandbutton within w_train
end type
type train4 from picture within w_train
end type
type train3 from picture within w_train
end type
type train2 from picture within w_train
end type
type train1 from picture within w_train
end type
end forward

shared variables
end variables

global type w_train from w_center
int X=726
int Y=573
int Width=1729
int Height=916
boolean TitleBar=true
string Title="Draw() - Train Example"
long BackColor=16777215
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
st_timer_interval st_timer_interval
cb_close cb_close
cb_slower cb_slower
cb_faster cb_faster
cb_stop cb_stop
cb_start cb_start
train4 train4
train3 train3
train2 train2
train1 train1
end type
global w_train w_train

type prototypes

end prototypes

type variables
 real   ir_timer_interval
 integer ii_pos
 integer ii_sound
 integer ii_index

end variables

on close;//Close script for w_train
w_main.Show( )
end on

on timer;//Timer script for w_train

picture lp_train

	// set ii_index between 1 and 4 to rotate between 
	// 4 bitmaps, producing animation effect. Train 1 thru 4 are picture
	// objects outside of the visible boundaries of the window. To see
	// them, make the window wider. These are assign to the picture object
	// train, which is drawn and moved across the visible window. 

	ii_index = ii_index + 1
	if (ii_index > 4) then
		ii_index = 1
	end if

	if (ii_index = 1)     then
		lp_train = train1
	elseif (ii_index = 2) then
		lp_train = train2
	elseif (ii_index = 3) then
		lp_train = train3
	elseif (ii_index = 4) then
		lp_train = train4
 	end if

	/*** move train to left by decrementing pos. When ***/
	/*** pos is less than minus train width, train is ***/
	/*** off window. Reset pos to window width (right ***/
	/*** side of window. Then draw tain.              ***/

	if (ii_pos <= -train1.width) then
		ii_pos = this.width
	else
		ii_pos = ii_pos - 5
	end if

	lp_train.Draw(ii_pos, 10)
	



end on

on open;//Open script for w_train

// Initially, position the train at the right boundary of the window.

ii_pos = this.width
ir_timer_interval =  0.1
end on

on w_train.create
this.st_timer_interval=create st_timer_interval
this.cb_close=create cb_close
this.cb_slower=create cb_slower
this.cb_faster=create cb_faster
this.cb_stop=create cb_stop
this.cb_start=create cb_start
this.train4=create train4
this.train3=create train3
this.train2=create train2
this.train1=create train1
this.Control[]={ this.st_timer_interval,&
this.cb_close,&
this.cb_slower,&
this.cb_faster,&
this.cb_stop,&
this.cb_start,&
this.train4,&
this.train3,&
this.train2,&
this.train1}
end on

on w_train.destroy
destroy(this.st_timer_interval)
destroy(this.cb_close)
destroy(this.cb_slower)
destroy(this.cb_faster)
destroy(this.cb_stop)
destroy(this.cb_start)
destroy(this.train4)
destroy(this.train3)
destroy(this.train2)
destroy(this.train1)
end on

type st_timer_interval from statictext within w_train
int X=164
int Y=551
int Width=1017
int Height=116
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_train
int X=1305
int Y=685
int Width=264
int Height=109
int TabOrder=10
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_5

Close(parent)
end on

type cb_slower from commandbutton within w_train
int X=1000
int Y=685
int Width=264
int Height=109
int TabOrder=50
string Text="&Slower"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_4
long ll_rc

// Increment timer interval to slow train down.
// Put a 2second limit on how slow it can go
	If (ir_timer_interval <= .091 ) Then
		ir_timer_interval = ir_timer_interval + .01
		Timer(0)
		Timer(ir_timer_interval)
		st_timer_interval.text = "Timer Event Every "+String(ir_timer_interval,"0.00") + " Seconds"
	Else
		 //This is a external function that is handled by a global user object
		 //aware of different operating systems
		gu_ext_func.uf_PlaySound("trainslo.wav",1)
	End If 

end on

type cb_faster from commandbutton within w_train
int X=694
int Y=685
int Width=264
int Height=109
int TabOrder=40
string Text="&Faster"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_faster

long	ll_rc
// Make timer interval smaller so that train goes faster. Restrict
// how small the timer can get and notify the user.

	If (ir_timer_interval >= 0.011) Then
		ir_timer_interval = ir_timer_interval - .01
		Timer(0)
		Timer(ir_timer_interval)		
		st_timer_interval.text = "Timer Event Every "+String(ir_timer_interval,"0.00") + " Seconds"
	Else
		 //This is a external function that is handled by a global user object
		 //aware of different operating systems
		gu_ext_func.uf_PlaySound("trainfas.wav",1)
	End If // timer
end on

type cb_stop from commandbutton within w_train
int X=388
int Y=685
int Width=264
int Height=109
int TabOrder=30
string Text="Sto&p"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_stop

// Turn off timer

Timer(0)

st_timer_interval.text = "Timer Is Off"

end on

type cb_start from commandbutton within w_train
int X=82
int Y=685
int Width=264
int Height=109
int TabOrder=20
string Text="S&tart"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_start


// See script for timer event on window to see how train is drawn and moved.
// This will restart the timer to whatever value is set in the value instance variable timer_interval

Timer(ir_timer_interval)
st_timer_interval.text = "Timer Event Every "+String(ir_timer_interval,"0.00") + " Seconds"


end on

type train4 from picture within w_train
int X=1387
int Y=833
int Width=274
int Height=161
boolean Visible=false
string PictureName="train4.bmp"
end type

type train3 from picture within w_train
int X=1387
int Y=596
int Width=274
int Height=161
boolean Visible=false
string PictureName="train3.bmp"
end type

type train2 from picture within w_train
int X=1387
int Y=385
int Width=274
int Height=161
boolean Visible=false
string PictureName="train2.bmp"
end type

type train1 from picture within w_train
int X=1387
int Y=167
int Width=274
int Height=161
boolean Visible=false
string PictureName="train1.bmp"
end type

