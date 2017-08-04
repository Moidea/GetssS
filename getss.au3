#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile_x64=getss_x64.exe
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <IE.au3>
#include <array.au3>
Opt('TrayAutoPause',0)
Opt('TrayMenuMode',3)
Func getss()
Local $oIE = _IEcreate("http://ss.ishadowx.com",0,0,1)
Local $sHTML = _IEBodyReadHTML($oIE)

Local $shtml2=_IEBodyReadText ($oIE)
;~ ConsoleWrite($sHTML2)
;~ FileWrite("1.txt",$shtml2)
_IEQuit($oIE)


$array=StringRegExp($shtml2,'IP Address:(.+)',3)
;~ _ArrayDisplay($array)
$arrayport=StringRegExp($shtml2,'Port：([0-9]+)',3)
;~ _ArrayDisplay($arrayport)
$arraypass=StringRegExp($shtml2,'Password:([0-9]*)',3)
;~ _ArrayDisplay($arraypass)
$arraymeth=StringRegExp($shtml2,'Method:(.+)',3)
;~ _ArrayDisplay($arraymeth)


_ArrayColInsert($array,1)
;~ _ArrayDisplay($array)

For $i=0 To UBound ($arrayport)-1
$array[$i][1]=$arrayport[$i]
Next

_ArrayColInsert($array,2)
;~ _ArrayDisplay($array)

For $i=0 To UBound ($arraypass)-1
$array[$i][2]=$arraypass[$i]
Next

_ArrayColInsert($array,3)
;~ _ArrayDisplay($array)

For $i=0 To UBound ($arraymeth)-1
$array[$i][3]=$arraymeth[$i]
Next




;~ _ArrayDisplay($array)

;~ Local $newarray[1][4]

;~ For $=0 To UBound($array)-1
;~ 	If $array[$i][3] ="" Then ContinueLoop
;~ 	$newarray[0][0] +=1
;~ 	_arrayadd($newarray,$array[$i][0],)

$cf=@ScriptDir&"\gui-config.json"
$cf=FileOpen($cf,2+8)
FileWriteLine($cf,"{")
FileWriteLine($cf,'  "configs": [')

Local $a=0
For $i=0 To UBound($array)-1
	If $array[$i][2]="" Then ContinueLoop
	FileWriteLine($cf,"    {")
	FileWriteLine($cf,'      "server": "'&$array[$i][0]&'",')
	FileWriteLine($cf,'      "server_port": '&$array[$i][1]&',')
	FileWriteLine($cf,'      "password": "'&$array[$i][2]&'",')
	FileWriteLine($cf,'      "method": "'&$array[$i][3]&'",')
	FileWriteLine($cf,'      "remarks": "",')
	FileWriteLine($cf,'      "timeout": 5')
	FileWriteLine($cf,"    },")
	$a+=1
Next
	
FileWriteLine($cf,'  ],')
	
FileWriteLine($cf,'  "localPort": 8787,')	
FileWriteLine($cf,"}")	
	
	FileClose($cf)
	
	TrayTip("已经完成服务器更新！",'更新了 '&$a &'个服务器。',5)
EndFunc

Func stss()
	TrayTip("更新服务器！",'SS将会重启！',5)
If 	ProcessExists('Shadowsocks.exe') Then ProcessClose('Shadowsocks.exe')
getss()

ShellExecute (@ScriptDir&'\Shadowsocks.exe')
EndFunc


	
	
 Local $idFlash = TrayCreateItem("手动更新")
    TrayCreateItem("") ; Create a separator line.

    Local $idAbout = TrayCreateItem("退出")
    TrayCreateItem("") ; Create a separator line.
stss()
AdlibRegister('auto',1000*60*10)	
	TraySetToolTip("SS自动助手")
	
While 1
Switch TrayGetMsg ( )
	
	Case $idFlash
		stss()
	Case $idAbout
		If 	ProcessExists('Shadowsocks.exe') Then ProcessClose('Shadowsocks.exe')
		Exit
EndSwitch

WEnd

	
	Func auto()
;~ 		If @HOUR='00' Or '06' Or '12' Or '18' And @MIN>='05' Or '15' Then 
;~ 			stss()
;~ 		
		
		
		Switch @HOUR
			Case 0
				If @MIN>=5 And @MIN <=14.5 Then stss()
			Case 6
				If @MIN>=5 And @MIN <=14.5 Then stss()
			Case 12
				If @MIN>=5 And @MIN <=14.5 Then stss()
			Case 18
				If @MIN>=5 And @MIN <=14.5 Then stss()
		EndSwitch
		
				
				
		
		
		
		
		
		
		
;~ 		EndIf
		
	EndFunc
	


	
	
	
	