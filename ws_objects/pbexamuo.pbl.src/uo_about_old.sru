$PBExportHeader$uo_about_old.sru
$PBExportComments$Standard datawindow user object used to display system information
forward
global type uo_about_old from datawindow
end type
end forward

global type uo_about_old from datawindow
integer width = 1833
integer height = 764
integer taborder = 1
string dataobject = "d_about"
boolean livescroll = true
event ue_populate pbm_custom01
end type
global uo_about_old uo_about_old

type prototypes

end prototypes

forward prototypes
public subroutine get_available_resources ()
public subroutine get_operating_info ()
public subroutine get_additional_info ()
end prototypes

event ue_populate;If ge_Environment.OSType <> sol2! And ge_Environment.Win16 Then
	/* Get Windows Resource Information */
	get_available_resources ()
End if

/* get the mode Windows is running in */
If ge_Environment.Win16 Then
	get_operating_info ()
End If

/*  Get additional Windows information, eg. Free Space available, 
		How long Windows has been running, and the Windows directory */
get_additional_info ()

end event

public subroutine get_available_resources ();uint resourceavail

resourceavail = gu_ext_func.uf_GetFreeSystemResources(0)    // System Resources
this.setitem(1,"system"," " + string(resourceavail) + " % ")

resourceavail = gu_ext_func.uf_GetFreeSystemResources(1)    // GDI
this.setitem(1,"gdi"," " + string(resourceavail) + " % ")

resourceavail = gu_ext_func.uf_GetFreeSystemResources(2)    // User
this.setitem(1,"user"," " + string(resourceavail) + " % ")

end subroutine

public subroutine get_operating_info ();string ls_mode

/* get Windows mode  */


ls_mode = gu_ext_func.uf_getos_mode()
If trim(ls_mode) <> "" Then 
	this.setitem(1,"windows",ls_mode)
End If

end subroutine

public subroutine get_additional_info ();long winticks
longlong winfreespace
int myhours, mymins, mysecs, rtncd
uint textlen
string tmp1, tmp2

/*  get windows free space */

winfreespace = gu_ext_func.uf_GetFreeMemory()
this.setitem(1,"freespace"," " + string(winfreespace / 1024,"##,##0"))

/*  get windows running time */

winticks = gu_ext_func.uf_Get_logon_time() / 1000

if winticks < 60 then
	mysecs = winticks
else
	mymins = winticks / 60
	winticks = winticks - (mymins * 60)
	mysecs = winticks
	if mymins >= 60 then
		myhours = mymins / 60
		mymins = mymins - (myhours * 60)
	end if
end if

if myhours = 1 then
	tmp1 = string(myhours) + " hour "
else
	tmp1 = string(myhours) + " hours "
end if

if mymins < 1 then
	tmp1 = tmp1
elseif mymins = 1 then
	tmp1 = tmp1 + string(mymins) + " minute "
else
	tmp1 = tmp1 + string(mymins) + " minutes "
end if

if mysecs < 1 then
	tmp1 = tmp1
elseif mysecs = 1 then
	tmp1 = tmp1 + string(mysecs) + " second "
else
	tmp1 = tmp1 + string(mysecs) + " seconds "
end if

this.setitem(1,"duration"," " + tmp1)

/*  get windows directory */

tmp1 = space(144)
rtncd = gu_ext_func.uf_GetWindowsDirectory(tmp1,144)
this.setitem(1,"directory"," " + trim(tmp1))

If ge_Environment.OSType <> sol2! Then
	// get the network id
	tmp2 = space(255)
	rtncd = gu_ext_func.uf_get_logon_name(tmp2)
	this.setitem(1,"username"," " + trim(tmp2))
End if

end subroutine

event constructor;If ge_Environment.OSType = sol2! Then
	This.DataObject = "d_about_sol2"
Elseif Not ge_Environment.Win16 Then
	This.DataObject = "d_about_win32"
End if

end event

on uo_about_old.create
end on

on uo_about_old.destroy
end on

