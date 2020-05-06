//%attributes = {}
  // JIRA_DeleteIssue (object) : object
  // 
  // Created by Brent Raymond on 12/30/19
  // Purpose: 
  // 
  // Parameters:
  //       issueKey   - 
  // 
  // Note:
  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-issueIdOrKey-delete
  //  
  // History:


C_OBJECT:C1216($1;$oInput)
C_OBJECT:C1216($0;$oResult)

C_LONGINT:C283($lStatus)
C_OBJECT:C1216($oBody)

ARRAY TEXT:C222($atHeaderNames;0)
ARRAY TEXT:C222($atHeaderValues;0)

$oInput:=$1

Case of 
	: (Not:C34(JIRA_Init .success))
		
	: ($oInput.issueKey=Null:C1517)
		
	Else 
		HTTP AUTHENTICATE:C1161(JIRA_Init .username;JIRA_Init .password;HTTP basic:K71:8)
		
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerNames;$atHeaderNames)
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerValues;$atHeaderValues)
		
		$lStatus:=HTTP Request:C1158(HTTP DELETE method:K71:5;JIRA_Init .server+"/rest/api/3/issue/"+$oInput.issueKey;$oBody;$oResult;$atHeaderNames;$atHeaderValues)
		
		
End case 

$0:=$oResult
