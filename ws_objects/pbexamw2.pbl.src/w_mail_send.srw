$PBExportHeader$w_mail_send.srw
$PBExportComments$Window used to send MSMail
forward
global type w_mail_send from w_center
end type
type cb_help from commandbutton within w_mail_send
end type
type mle_msg from multilineedit within w_mail_send
end type
type cbx_receipt_requested from checkbox within w_mail_send
end type
type rb_employees from radiobutton within w_mail_send
end type
type rb_departments from radiobutton within w_mail_send
end type
type rb_customers from radiobutton within w_mail_send
end type
type st_status_bar from statictext within w_mail_send
end type
type mle_subject from multilineedit within w_mail_send
end type
type cbx_file from checkbox within w_mail_send
end type
type cbx_address_live from checkbox within w_mail_send
end type
type cb_send_mail from commandbutton within w_mail_send
end type
type cb_close from commandbutton within w_mail_send
end type
type dw_1 from datawindow within w_mail_send
end type
type gb_body from groupbox within w_mail_send
end type
type gb_5 from groupbox within w_mail_send
end type
type gb_4 from groupbox within w_mail_send
end type
type gb_3 from groupbox within w_mail_send
end type
type gb_subject from groupbox within w_mail_send
end type
type gb_1 from groupbox within w_mail_send
end type
end forward

global type w_mail_send from w_center
int X=8
int Y=1
int Width=2905
int Height=2004
boolean TitleBar=true
string Title="MAPI Mail - Send Mail"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean ToolBarVisible=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_help cb_help
mle_msg mle_msg
cbx_receipt_requested cbx_receipt_requested
rb_employees rb_employees
rb_departments rb_departments
rb_customers rb_customers
st_status_bar st_status_bar
mle_subject mle_subject
cbx_file cbx_file
cbx_address_live cbx_address_live
cb_send_mail cb_send_mail
cb_close cb_close
dw_1 dw_1
gb_body gb_body
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_subject gb_subject
gb_1 gb_1
end type
global w_mail_send w_mail_send

type variables
string	is_dwSyntax, is_dataSyntax
end variables

forward prototypes
public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name)
end prototypes

public subroutine wf_logoff_mail (ref mailsession ams_mses, string as_attach_name);string 	ls_ret	
mailreturncode mRet

/*****************************************************************
	Log off from the mail system
 *****************************************************************/
mRet = ams_mSes.mailLogoff ( )
ls_ret = f_mail_error_to_string ( mRet, 'Logoff:', FALSE )
st_status_bar.text = ' Logoff: ' + ls_ret

If mRet <> mailReturnSuccess! Then
	MessageBox ("Mail Logoff", 'Return Code <> mailReturnSuccess!' )
	return
End If

/*****************************************************************
	Finally, destroy the mail session object created earlier.
	Also, delete the temporary attachment file.
 *****************************************************************/
destroy ams_mses


FileDelete ( as_attach_name )
end subroutine

on open;// Open script

dw_1.SetTransObject (sqlca)

dw_1.Retrieve ( )

end on

on close;// Close script

w_main.Show ( )

end on

on w_mail_send.create
this.cb_help=create cb_help
this.mle_msg=create mle_msg
this.cbx_receipt_requested=create cbx_receipt_requested
this.rb_employees=create rb_employees
this.rb_departments=create rb_departments
this.rb_customers=create rb_customers
this.st_status_bar=create st_status_bar
this.mle_subject=create mle_subject
this.cbx_file=create cbx_file
this.cbx_address_live=create cbx_address_live
this.cb_send_mail=create cb_send_mail
this.cb_close=create cb_close
this.dw_1=create dw_1
this.gb_body=create gb_body
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_subject=create gb_subject
this.gb_1=create gb_1
this.Control[]={ this.cb_help,&
this.mle_msg,&
this.cbx_receipt_requested,&
this.rb_employees,&
this.rb_departments,&
this.rb_customers,&
this.st_status_bar,&
this.mle_subject,&
this.cbx_file,&
this.cbx_address_live,&
this.cb_send_mail,&
this.cb_close,&
this.dw_1,&
this.gb_body,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_subject,&
this.gb_1}
end on

on w_mail_send.destroy
destroy(this.cb_help)
destroy(this.mle_msg)
destroy(this.cbx_receipt_requested)
destroy(this.rb_employees)
destroy(this.rb_departments)
destroy(this.rb_customers)
destroy(this.st_status_bar)
destroy(this.mle_subject)
destroy(this.cbx_file)
destroy(this.cbx_address_live)
destroy(this.cb_send_mail)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.gb_body)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_subject)
destroy(this.gb_1)
end on

type cb_help from commandbutton within w_mail_send
int X=1689
int Y=1716
int Width=338
int Height=100
int TabOrder=80
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help(parent.ClassName( ))
end on

type mle_msg from multilineedit within w_mail_send
int X=260
int Y=445
int Width=2283
int Height=173
int TabOrder=20
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_receipt_requested from checkbox within w_mail_send
int X=1547
int Y=81
int Width=761
int Height=71
int TabOrder=120
string Text="Request Receipt"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_employees from radiobutton within w_mail_send
int X=1046
int Y=717
int Width=338
int Height=77
int TabOrder=50
string Text="&Employees"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.DataObject = "d_empl_basic_data"
dw_1.settransobject(sqlca)
dw_1.retrieve()
end on

type rb_departments from radiobutton within w_mail_send
int X=644
int Y=717
int Width=377
int Height=77
int TabOrder=40
string Text="&Departments"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_1.DataObject = "d_dept"
dw_1.settransobject(sqlca)
dw_1.retrieve()
end on

type rb_customers from radiobutton within w_mail_send
int X=260
int Y=717
int Width=338
int Height=71
int TabOrder=30
string Text="&Customers"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
dw_1.DataObject = "d_retrieve_cust"
dw_1.settransobject(sqlca)
dw_1.retrieve()
end on

type st_status_bar from statictext within w_mail_send
int X=292
int Y=1604
int Width=2194
int Height=71
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_subject from multilineedit within w_mail_send
int X=257
int Y=279
int Width=2283
int Height=93
int TabOrder=10
boolean AutoVScroll=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_file from checkbox within w_mail_send
int X=260
int Y=119
int Width=808
int Height=71
int TabOrder=110
string Text="&Read recipient names from a file"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_address_live from checkbox within w_mail_send
int X=260
int Y=61
int Width=1156
int Height=71
int TabOrder=100
string Text="&Select recipients from Post Office address book"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_send_mail from commandbutton within w_mail_send
int X=758
int Y=1716
int Width=338
int Height=100
int TabOrder=70
string Text="Send &Mail"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Clicked script for cb_send_mail

/*******************************************************************
	Mail the definition and current contents of a DataWindow using
	MAPI facilities.
	1. Get the PSR file saved from the datawindow chosen
	2. Create a mail session object and log onto the mail system
	3. Read addressees from a file (ASCII, one per line), If desired
	4. Get address names from box If needed
	5. Resolve all names
	6. send mail, with attached .dwx file
	7. Log off from mail system
	8. Destroy the mail session object
	9. Delete the attachment (saved) file
 *******************************************************************/

mailSession				mSes
mailReturnCode			mRet
mailMessage			mMsg
mailFileDescription		mAttach
string					ls_ret, ls_syntax, ls_name, ls_open_pathname, ls_filename
string					ls_attach_name='DataWndw.psr'
int						li_index, li_nret, li_nrecipients, li_nfile
boolean 				lb_noerrors


/*****************************************************************
	Make sure user has chosen at least one addressing option.
 *****************************************************************/
If NOT cbx_file.checked AND NOT cbx_address_live.checked Then
	MessageBox ("send Mail", &
					"Please select at least 1 address option", &
					Exclamation!)
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If


/*****************************************************************
	Obtain the syntax of the DataWindow definition and contents,
	and write it in a ".dwx" transport file (in ASCII)
 *****************************************************************/

dw_1.saveas(ls_attach_name,PSReport!,True)

//This is another way of sending the datawindow contents. ie breaking the 
//syntax and data up and mailing them together. 
//The PSR file is the prefered method now.
//is_dwsyntax = dw_1.Describe ( 'datawindow.syntax' )
//is_datasyntax = dw_1.Describe ( 'datawindow.syntax.data' )
//ls_syntax = is_dwsyntax + '~r' + is_datasyntax
//
//li_nfile = FileOpen  ( ls_attach_name, StreamMode!, Write!, LockReadWrite!, Replace! )
//If li_nfile < 0 Then
//	MessageBox ( "send Mail", &
//				"Unable to open file to save DataWindow attachment", &
//				 StopSign! )
//	wf_logoff_mail(mSes, ls_attach_name)
//	return
//End If
//li_nret = FileWrite ( li_nfile, ls_syntax )
//FileClose ( li_nfile )

/*****************************************************************
	Establish an instance of the Mail Session object, and log on
 *****************************************************************/
mSes = create mailSession

/*****************************************************************
	Note: If the mail-system user ID and password are known,
			they could be hard-coded here, as shown in the
			commented-out statement that follows.  If user ID and
			password are not supplied, it is assumed that they
			are stored in MSMAIL.INI
 *****************************************************************/
mRet = mSes.mailLogon ( mailNewSession! )
ls_ret = f_mail_error_to_string ( mRet, 'Logon:', FALSE )
st_status_bar.text = ' Logon: ' + ls_ret
If mRet <> mailReturnSuccess! Then
	MessageBox ("Mail Logon", 'Return Code <> mailReturnSuccess!' )
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If

SetPointer(HourGlass!)

/*****************************************************************
	Copy user's subject to the mail message.
	Set return receipt flag If needed.
	Build an Attachment structure, and assign it to the mail message.
 *****************************************************************/
mMsg.Subject	= mle_subject.text

If cbx_receipt_requested.checked Then
	mMsg.ReceiptRequested = true
End If

mMsg.notetext = mle_msg.text +"~n~r "

mAttach.FileType = mailAttach!
mAttach.PathName = ls_attach_name
mAttach.FileName = ls_attach_name
// Note: In MS Mail version 3.0b, Position=-1 puts attachment at
//  the beginning of the message.
// This will place the attachment at the End of the text of the message
mAttach.Position = len(mMsg.notetext) - 1		
mMsg.AttachmentFile[1] = mAttach

/*****************************************************************
	If user requested "addresses-from-a-file," open that file and
	read the address list.
 *****************************************************************/
If cbx_file.checked Then
	li_nret = GetFileOpenName ("Address", ls_open_pathname, &
								ls_filename,"adr", &
		"Address Text Files (*.adr),*.adr,All Files (*.*),*.*")
	If li_nret < 1 Then return
	li_nfile = FileOpen ( ls_open_pathname )
	If li_nfile < 0 Then
		MessageBox ( "send Mail", "Unable to open file " &
						+ ls_open_pathname, StopSign! )
		wf_logoff_mail(mSes, ls_attach_name)
		return
	End If

	li_nrecipients = 0
	do while FileRead ( li_nfile, ls_name ) > 0
		li_nrecipients = li_nrecipients + 1
		mMsg.Recipient[li_nrecipients].Name = ls_name
	loop
	FileClose ( li_nfile )
End If



/*****************************************************************
	If user requested "address-from-Post-Office," call the
	mail system's Address function
 *****************************************************************/
If cbx_address_live.checked Then
	mRet = mSes.mailAddress ( mMsg )
	If mRet = mailReturnUserAbort! Then 
		st_status_bar.text = "User Canceled send Mail"
		wf_logoff_mail(mSes, ls_attach_name)
		Return
	End If
	ls_ret = f_mail_error_to_string ( mRet, 'Address Mail:', FALSE )
	st_status_bar.text = ' Address Mail: ' + ls_ret
End If


/*****************************************************************
	Resolve recipient addresses, which may be only partially
	supplied, to get the complete address for each one.

	Loop in this until the names are all resovled with no
	errors. The message will not be sent If errors are in
	the user name.

	The user can cancel out of resolving names which
	will cancel the entire send mail process
 *****************************************************************/
SetPointer(HourGlass!)

Do 
	lb_noerrors = True
	li_nrecipients = UpperBound( mMsg.Recipient )
	For li_index = 1 To li_nrecipients
		mRet = mSes.mailResolveRecipient(mMsg.Recipient[li_index].Name)
		If mRet <> mailReturnSuccess! Then lb_noerrors = False
		ls_ret = f_mail_error_to_string ( mRet, 'Resolve Recipient:', FALSE )
		st_status_bar.text = ' Resolve Recipient (' + mMsg.Recipient[li_index].Name + '): ' + ls_ret
	Next
	If Not lb_noerrors Then
		Messagebox("Microsoft Mail","Error Resolving Name(s)~n~r"+&
		"The name(s) not underlined are unresolvable.~n~n~rPlease Correct or Cancel"&
		,Exclamation!)
		mRet = mSes.mailAddress(mMsg)
		If mRet = mailReturnUserAbort! Then 
			st_status_bar.text = "User Canceled Send Mail"
			wf_logoff_mail(mSes, ls_attach_name)
			Return
		End If
	End If
Loop Until lb_noerrors

/*****************************************************************
	Now, send the mail message, including the attachment
 *****************************************************************/
If UpperBound ( mMsg.Recipient ) < 1 Then 
	messagebox ("Powerbuilder send","Mail must included at least 1 recipient",Exclamation!)
	wf_logoff_mail(mSes, ls_attach_name)
	return
End If
mRet = mSes.mailsend ( mMsg )
ls_ret = f_mail_error_to_string ( mRet, 'send Mail:', FALSE )
st_status_bar.text = ' send Mail: ' + ls_ret

wf_logoff_mail(mSes, ls_attach_name)

end event

type cb_close from commandbutton within w_mail_send
int X=1224
int Y=1716
int Width=338
int Height=100
int TabOrder=90
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Clicked script for cb_exit

Close (Parent)

end on

type dw_1 from datawindow within w_mail_send
int X=217
int Y=829
int Width=2354
int Height=669
int TabOrder=60
string DataObject="d_retrieve_cust"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type gb_body from groupbox within w_mail_send
int X=217
int Y=385
int Width=2354
int Height=263
string Text="&Message"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_5 from groupbox within w_mail_send
int X=217
int Y=1543
int Width=2354
int Height=157
string Text="Status"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_4 from groupbox within w_mail_send
int X=1512
int Y=4
int Width=1057
int Height=205
string Text="Mail Receipt Requested"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_3 from groupbox within w_mail_send
int X=217
int Y=663
int Width=2354
int Height=135
string Text="DataWindow to Send"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_subject from groupbox within w_mail_send
int X=217
int Y=221
int Width=2354
int Height=164
string Text="&Subject"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_mail_send
int X=217
int Y=4
int Width=1281
int Height=205
string Text="Address"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

