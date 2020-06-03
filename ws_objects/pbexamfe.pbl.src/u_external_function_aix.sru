$PBExportHeader$u_external_function_aix.sru
$PBExportComments$Cross platform user object for AIX
forward
global type u_external_function_aix from u_external_function
end type
type str_memorystatus from structure within u_external_function_aix
end type
end forward

type str_memorystatus from structure
    unsignedlong sul_dwlength
    unsignedlong sul_dwmemoryload
    unsignedlong sul_dwtotalphys
    unsignedlong sul_dwavailphys
    unsignedlong sul_dwtotalpagefile
    unsignedlong sul_dwavailpagefile
    unsignedlong sul_dwtotalvirtual
    unsignedlong sul_dwavailvirtual
end type

global type u_external_function_aix from u_external_function
end type
global u_external_function_aix u_external_function_aix

type prototypes
//playsound
//Function boolean sndPlaySoundA (string SoundName, uint Flags) Library "WINMM.DLL"
//Function uint waveOutGetNumDevs () Library "WINMM.DLL"

//getsyscolor
//Function ulong GetSysColor (int index) Library "libuser40.a"

//getsystemmetrics
Function int GetSystemMetrics (int index) Library "libuser43.so"

//getfreememory
Subroutine GlobalMemoryStatus (ref str_memorystatus memorystatus ) Library "libkernel43.so"

//set and kill timer
Function Boolean KillTimer (long handle, uint id ) library "libuser43.so"
Function uint SetTimer (long handle, uint id, uint time, long addr ) library "libuser43.so"

//GetModuleHandle
Function long GetModuleHandleA(string modname) Library "libkernel43.so"

Function uint GetWindow (long handle,uint relationship) Library "libuser43.so"
Function int GetWindowTextA(long handle, ref string wintext, int length) Library "libuser43.so"
Function boolean IsWindowVisible (long handle) Library "libuser43.so"
Function uint GetWindowsDirectoryA (ref string dirtext, uint textlen) library "libkernel43.so"
Function uint GetSystemDirectoryA (ref string dirtext, uint textlen) library "libkernel43.so"
Function ulong GetCurrentDirectoryA (ulong textlen, ref string dirtext) library "libkernel43.so"

Function boolean GetUserName (ref string name, ref ulong len) library "libkernel43.so"
Function ulong GetTickCount ( ) Library "libkernel43.so"
end prototypes

forward prototypes
public function integer uf_getscreenwidth ()
public function integer uf_getscreenheight ()
public function long uf_getmodulehandle (string as_modname)
public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size)
public function unsignedinteger uf_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size)
public function unsignedlong uf_getfreememory ()
public function unsignedlong uf_get_logon_time ()
public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id)
public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time)
public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship)
public function boolean uf_iswindowvisible (long aui_handle)
public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max)
protected function string uf_get_pb_ini ()
public function integer uf_get_logon_name (ref string as_name)
public function string uf_getcurrentdirectory ()
end prototypes

public function integer uf_getscreenwidth ();Return GetSystemMetrics(0)
end function

public function integer uf_getscreenheight ();Return GetSystemMetrics(1)
end function

public function long uf_getmodulehandle (string as_modname);//use win 32 getmodulehandle function

Return GetModuleHandleA(as_modname)
end function

public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size);Return GetSystemDirectoryA(as_dir,aui_size)
end function

public function unsignedinteger uf_getwindowsdirectory (ref string as_dir, unsignedinteger aui_size);Return GetWindowsDirectoryA(as_dir,aui_size)
end function

public function unsignedlong uf_getfreememory ();//return # bytes free memory

str_memorystatus lstr_memory

//structure size is 8 ulong's or 8 * 4 bytes
lstr_memory.sul_dwlength = 32

GlobalMemoryStatus(lstr_memory)

//bytes of virtual memory available
Return (lstr_memory.sul_dwavailpagefile)
end function

public function unsignedlong uf_get_logon_time ();//use win32 gettickcount() for time logged in

Return GetTickCount()
end function

public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id);//win32 to kill timer
Return KillTimer(aui_handle,aui_id)
end function

public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time);//win 32 call to create timer
Return SetTimer(aui_handle,aui_id,aui_time,0)

end function

public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship);//function not found
Return GetWindow(aui_handle,aui_relationship)
end function

public function boolean uf_iswindowvisible (long aui_handle);Return IsWindowVisible(aui_handle)
end function

public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max);//function not found
Return GetWindowTextA (aui_handle,as_text,ai_max)
end function

protected function string uf_get_pb_ini ();return ".pb.ini"

end function

public function integer uf_get_logon_name (ref string as_name);//use windows function wnetgetuser
ulong lul_len
boolean lb_rc
string ls_temp
lul_len =255
ls_temp = space(255)
lb_rc = GetUserName(ls_temp,lul_len)

as_name = ls_temp
If lb_rc then
	return 1
else
	return -1
end if
//Return li_rc
end function

public function string uf_getcurrentdirectory ();string	ls_CurrentDir

ls_CurrentDir = Space ( 260 )

GetCurrentDirectoryA ( 260, ls_CurrentDir )

Return ls_CurrentDir

end function

on u_external_function_aix.create
call super::create
end on

on u_external_function_aix.destroy
call super::destroy
end on

event constructor;is_separator = "/"
ib_registry = true
end event

