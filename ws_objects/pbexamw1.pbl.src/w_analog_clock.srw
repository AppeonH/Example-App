$PBExportHeader$w_analog_clock.srw
$PBExportComments$Uses Analog clock User Object
forward
global type w_analog_clock from w_center
end type
type uo_clock from u_analog_clock within w_analog_clock
end type
end forward

global type w_analog_clock from w_center
int X=969
int Y=564
int Width=1001
int Height=812
boolean TitleBar=true
string Title="Analog Clock"
long BackColor=78682240
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
uo_clock uo_clock
end type
global w_analog_clock w_analog_clock

event open;call super::open;// call the uf_start_ticking user object function to start the clock
uo_clock.uf_start_ticking()


end event

on timer;uo_clock.TriggerEvent("timer")

end on

event close;// call the uf_stop_ticking user object function to stop the clock
uo_clock.uf_stop_ticking()

w_main.Show()
end event

on w_analog_clock.create
this.uo_clock=create uo_clock
this.Control[]={this.uo_clock}
end on

on w_analog_clock.destroy
destroy(this.uo_clock)
end on

type uo_clock from u_analog_clock within w_analog_clock
int X=41
int Y=8
int Width=887
int Height=692
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

on uo_clock.destroy
call u_analog_clock::destroy
end on

