#Region ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#AccAu3Wrapper_Outfile_x64=getss2_x64.exe
#AccAu3Wrapper_Res_Language=2052
#AccAu3Wrapper_Res_requestedExecutionLevel=None
#EndRegion ;**** 由 AccAu3Wrapper_GUI 创建指令 ****
#include <IE.au3>
#include <array.au3>
Opt('TrayAutoPause',0)
Opt('TrayMenuMode',3)
Func getss()
$file=@TempDir&"\ssgetinfo.tmp"

$b=InetGet ( "https://tingyuan.me/services/ssaccount", $file ,0 ,0)
;~ ShellExecute("1.txt")

If @error Then MsgBox(0,"0",$b)
$h=FileOpen($file)
$arraytmp=FileRead($h)
;~ _ArrayDisplay($arraytmp)
;~ ConsoleWrite ($arraytmp)
;~ $a=StringRegExp($arraytmp,'(\[\[.+\]\])',3)
;~ ConsoleWrite ($a)
;~ _ArrayDisplay($arraytmp)
FileClose($h)
FileDelete($file)
$arraytmp=StringTrimLeft($arraytmp,24)
$arraytmp=StringTrimright($arraytmp,3)

;~ ConsoleWrite($arraytmp)

;~ Assign("sString", $arraytmp)

; Find the value of the variable string sString and assign to the variable $sEvalString.
;~ Local $sEvalString = Eval("sString")

; Display the value of $sEvalString. This should be the same value as $sString.
;~ MsgBox($MB_SYSTEMMODAL, "", $sEvalString)



$arraytmp=StringSplit($arraytmp,'],[',1)
;~ _ArrayDisplay($arraytmp)
Local $array[$arraytmp[0]][4]
For $i=1 To $arraytmp[0]
	$temp=StringSplit($arraytmp[$i],",",1)
	$array[$i-1][0]=StringReplace($temp[1],'"','')
$array[$i-1][1]=StringReplace($temp[2],'"','')
$array[$i-1][2]=StringReplace($temp[3],'"','')

$array[$i-1][3]=StringReplace($temp[4],'"','')
Next


;~ ConsoleWrite(@CRLF)
;~ ConsoleWrite ($arraytmp)
;~ _ArrayDisplay($a)
;~  If IsArray($arraytmp ) Then _ArrayDisplay($arraytmp)
;~ _ArrayDisplay($array)




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
	


	
	
	
	