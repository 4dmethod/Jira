  // On Web Connection
  // 
  // Created by Brent Raymond on 01/09/20
  // Purpose: 
  // 
  // $1 - (text) URL
  // $2 - (text) HTTP header + HTTP body
  // $3 - (text) IP address of the Web client
  // $4 - (text) IP address of the server
  // $5 - (text) User name
  // $6 - (text) Password
  //
  // Note:
  //  
  // History:


C_TEXT:C284($1;$2;$3;$4;$5;$6)

C_TEXT:C284($tURL;$tMethodPath;$tMessage)
C_LONGINT:C283($lPosition)

$tURL:=$1

$lPosition:=Position:C15("accessCode";$tURL)

If ($lPosition>0)
	$tMethodPath:=Substring:C12($tURL;$lPosition+Length:C16("accessCode")+1)
	
	METHOD OPEN PATH:C1213($tMethodPath)
	
	DISPLAY NOTIFICATION:C910("JIRA Code Access";$tMethodPath)
	
	$tMessage:="<html><body><h1>Switch to 4D Project to view the code.</h1></body></html>"
	
	ARRAY TEXT:C222($atHeaders;0)
	ARRAY TEXT:C222($atHeaderValues;0)
	
	APPEND TO ARRAY:C911($atHeaders;"Status")
	APPEND TO ARRAY:C911($atHeaderValues;"200 OK")
	
	WEB SET HTTP HEADER:C660($atHeaders;$atHeaderValues)
	
	WEB SEND TEXT:C677($tMessage)
	
End if 
