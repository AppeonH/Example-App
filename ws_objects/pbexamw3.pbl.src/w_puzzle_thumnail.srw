$PBExportHeader$w_puzzle_thumnail.srw
$PBExportComments$Thumnail view of the PowerPuzzle
forward
global type w_puzzle_thumnail from w_center
end type
type p_1 from picture within w_puzzle_thumnail
end type
end forward

global type w_puzzle_thumnail from w_center
int X=5
int Y=4
int Width=617
int Height=624
boolean TitleBar=true
string Title="Thumbnail"
long BackColor=79416533
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
p_1 p_1
end type
global w_puzzle_thumnail w_puzzle_thumnail

on w_puzzle_thumnail.create
this.p_1=create p_1
this.Control[]={this.p_1}
end on

on w_puzzle_thumnail.destroy
destroy(this.p_1)
end on

type p_1 from picture within w_puzzle_thumnail
int X=18
int Y=16
int Width=558
int Height=504
string PictureName="logo.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

