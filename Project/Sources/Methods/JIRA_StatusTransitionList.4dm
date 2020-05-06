//%attributes = {}
  // JIRA_StatusTransitionList (object) : collection
  // 
  // Created by Brent Raymond on 12/27/19
  // Purpose: 
  // 
  // Parameters:
  //       issueKey   - 
  // 
  // Note:
  //  https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-issueIdOrKey-transitions-get
  //
  // History:


C_OBJECT:C1216($1;$oInput)
C_COLLECTION:C1488($0;$cResult)

C_LONGINT:C283($lStatus)
C_OBJECT:C1216($oResult)

ARRAY TEXT:C222($atHeaderNames;0)
ARRAY TEXT:C222($atHeaderValues;0)

$oInput:=$1

$cResult:=New collection:C1472

Case of 
	: (Not:C34(JIRA_Init .success))
		
	: ($oInput.issueKey=Null:C1517)
		
	Else 
		HTTP AUTHENTICATE:C1161(JIRA_Init .username;JIRA_Init .password;HTTP basic:K71:8)
		
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerNames;$atHeaderNames)
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerValues;$atHeaderValues)
		
		$lStatus:=HTTP Get:C1157(JIRA_Init .server+"/rest/api/3/issue/"+$oInput.issueKey+"/transitions";$oResult;$atHeaderNames;$atHeaderValues)
		
		If ($lStatus=200)
			$cResult:=$oResult.transitions
			
		End if 
		
End case 

$0:=$cResult
