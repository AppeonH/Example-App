$PBExportHeader$u_tower.sru
$PBExportComments$This is the "peg" used in w_tower_hanoi -- the tower of hanoi example
forward
global type u_tower from UserObject
end type
type rr_pole from roundrectangle within u_tower
end type
type r_base from rectangle within u_tower
end type
type rr_1 from roundrectangle within u_tower
end type
type rr_2 from roundrectangle within u_tower
end type
type rr_3 from roundrectangle within u_tower
end type
type rr_4 from roundrectangle within u_tower
end type
type rr_5 from roundrectangle within u_tower
end type
type rr_6 from roundrectangle within u_tower
end type
type rr_7 from roundrectangle within u_tower
end type
type rr_8 from roundrectangle within u_tower
end type
type rr_9 from roundrectangle within u_tower
end type
type rr_10 from roundrectangle within u_tower
end type
type rr_11 from roundrectangle within u_tower
end type
type rr_12 from roundrectangle within u_tower
end type
type rr_13 from roundrectangle within u_tower
end type
type rr_14 from roundrectangle within u_tower
end type
end forward

global type u_tower from UserObject
int Width=957
int Height=967
long BackColor=78682240
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
rr_pole rr_pole
r_base r_base
rr_1 rr_1
rr_2 rr_2
rr_3 rr_3
rr_4 rr_4
rr_5 rr_5
rr_6 rr_6
rr_7 rr_7
rr_8 rr_8
rr_9 rr_9
rr_10 rr_10
rr_11 rr_11
rr_12 rr_12
rr_13 rr_13
rr_14 rr_14
end type
global u_tower u_tower

type prototypes

end prototypes

type variables
roundrectangle irr_disk[14]
int ii_count
//window iw_parent_window
//u_rectangle i_rect[11]
end variables

forward prototypes
public subroutine adddisk (str_disk astr_disk)
public subroutine removedisk (ref str_disk as_disk)
public subroutine resetpeg ()
end prototypes

public subroutine adddisk (str_disk astr_disk);int li_x
int li_y
int li_index
long ll_rc

//increment total disk for this peg
ii_count++

//only 14 rectangles were predefined.
If ii_count > 14 Then
	Messagebox("Peg Error","Error only 14 disk are allowed")
	ii_count --
	Return
End If

//find position of where the disk should be placed on the screen
li_y = r_base.y - ((irr_disk[ii_count].height+ 5)*ii_count) 
li_x = rr_pole.x + (rr_pole.width / 2) - (astr_disk.size / 2)


//set the rectangle width and color to what was passed to this function
irr_disk[ii_count].width = astr_disk.size
irr_disk[ii_count].fillcolor = astr_disk.color

irr_disk[ii_count].visible = true
irr_disk[ii_count].x = li_x

//This will slide the disk down from the top of the peg down to 
//position just above the bottom or other disks.
irr_disk[ii_count].y = rr_pole.y + irr_disk[ii_count].height
do while irr_disk[ii_count].y < li_y
	If irr_disk[ii_count].y +  irr_disk[ii_count].height  > li_y Then
		 irr_disk[ii_count].y = li_y
	Else
		irr_disk[ii_count].y = irr_disk[ii_count].y + irr_disk[ii_count].height
		irr_disk[ii_count].visible = true
		irr_disk[ii_count].show()
		yield()
	End If
loop

//This will play a click each time the disk reaches the bottom
//Only plays if supported by platform
gu_ext_func.uf_PlaySound("clicktp.wav",1)









end subroutine

public subroutine removedisk (ref str_disk as_disk);//This routine will visually remove 1 disk from the pole and 
//decrement the counter ii_count by 1

//This should never happen. (try to take a disk that is not there)
If ii_count <= 0 Then return

// This will slide the disk from its current position to the top of the peg (pole)
do while irr_disk[ii_count].y > rr_pole.y + irr_disk[ii_count].height
	If irr_disk[ii_count].y - (irr_disk[ii_count].height) < rr_pole.y + irr_disk[ii_count].height Then
		 irr_disk[ii_count].y = rr_pole.y + irr_disk[ii_count].height
	Else
		irr_disk[ii_count].y = irr_disk[ii_count].y - (irr_disk[ii_count].height)
		irr_disk[ii_count].visible = true
		irr_disk[ii_count].show()
		yield()
	End If
loop

//pass the color and widht of the disk removed back to the caller. 
//The caller will then have the option to use that information in the adddisk call.
as_disk.size = irr_disk[ii_count].width
as_disk.color = irr_disk[ii_count].fillcolor

//hide it
irr_disk[ii_count].visible = False

//one less disk now
ii_count --


////////////////for future use......................
//
//i_rect[ii_count].visible = False
//this.setredraw(true)
////destroy(i_rect[ii_count])
//
////iw_parent_window.closeuserobject(i_rect[ii_count])
//
//
//ii_count --
//return(u_rectangle)

end subroutine

public subroutine resetpeg ();str_disk lstr_disk

//ii count hold the total # of disks on this peg...
//keep removing disks until there are no more
do while ii_count > 0
	removedisk(lstr_disk)
loop
end subroutine

on constructor;//attach the 14 rectangles on the screen to the array
int li_index
int li_control_limit
int li_control_index
int li_array_limit
drawobject ldo_temp

li_array_limit = upperbound (irr_disk[])
li_control_limit = upperbound (control[])

//this will cycle throught the control array and grab the hidden rectangles
//and place a point to each in my instance array.
For li_index = 1 to li_array_limit
	If li_index > li_control_limit Then Exit	
	do while li_control_index <= li_control_limit
		li_control_index ++
		ldo_temp = control[li_control_index]
		If ldo_temp.classname() = "rr_" + String(li_index) Then
			irr_disk[li_index] = ldo_temp
			Exit
		End If
	Loop
Next

end on

on u_tower.create
this.rr_pole=create rr_pole
this.r_base=create r_base
this.rr_1=create rr_1
this.rr_2=create rr_2
this.rr_3=create rr_3
this.rr_4=create rr_4
this.rr_5=create rr_5
this.rr_6=create rr_6
this.rr_7=create rr_7
this.rr_8=create rr_8
this.rr_9=create rr_9
this.rr_10=create rr_10
this.rr_11=create rr_11
this.rr_12=create rr_12
this.rr_13=create rr_13
this.rr_14=create rr_14
this.Control[]={ this.rr_pole,&
this.r_base,&
this.rr_1,&
this.rr_2,&
this.rr_3,&
this.rr_4,&
this.rr_5,&
this.rr_6,&
this.rr_7,&
this.rr_8,&
this.rr_9,&
this.rr_10,&
this.rr_11,&
this.rr_12,&
this.rr_13,&
this.rr_14}
end on

on u_tower.destroy
destroy(this.rr_pole)
destroy(this.r_base)
destroy(this.rr_1)
destroy(this.rr_2)
destroy(this.rr_3)
destroy(this.rr_4)
destroy(this.rr_5)
destroy(this.rr_6)
destroy(this.rr_7)
destroy(this.rr_8)
destroy(this.rr_9)
destroy(this.rr_10)
destroy(this.rr_11)
destroy(this.rr_12)
destroy(this.rr_13)
destroy(this.rr_14)
end on

type rr_pole from roundrectangle within u_tower
int X=449
int Y=17
int Width=97
int Height=865
boolean Enabled=false
FillPattern FillPattern=bdiagonal!
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=32896
end type

type r_base from rectangle within u_tower
int X=264
int Y=865
int Width=456
int Height=87
boolean Enabled=false
int LineThickness=7
long FillColor=32896
end type

type rr_1 from roundrectangle within u_tower
int X=964
int Y=17
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_2 from roundrectangle within u_tower
int X=964
int Y=97
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_3 from roundrectangle within u_tower
int X=964
int Y=177
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_4 from roundrectangle within u_tower
int X=964
int Y=257
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_5 from roundrectangle within u_tower
int X=964
int Y=337
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_6 from roundrectangle within u_tower
int X=964
int Y=417
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_7 from roundrectangle within u_tower
int X=964
int Y=497
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_8 from roundrectangle within u_tower
int X=964
int Y=577
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_9 from roundrectangle within u_tower
int X=964
int Y=657
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_10 from roundrectangle within u_tower
int X=964
int Y=737
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_11 from roundrectangle within u_tower
int X=964
int Y=817
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_12 from roundrectangle within u_tower
int X=964
int Y=897
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_13 from roundrectangle within u_tower
int X=964
int Y=977
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

type rr_14 from roundrectangle within u_tower
int X=964
int Y=1057
int Width=225
int Height=65
boolean Visible=false
boolean Enabled=false
int LineThickness=7
int CornerHeight=39
int CornerWidth=40
long FillColor=33554432
end type

