//%attributes = {}
  // JIRA_Project (object) : object
  // 
  // Created by Brent Raymond on 12/27/19
  // Purpose: 
  // 
  // Parameters:
  //       projectKey   - 
  // 
  // Note:
  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-project-projectIdOrKey-get
  //  
  // History:


C_OBJECT:C1216($1;$oInput)
C_OBJECT:C1216($0;$oResult)

C_LONGINT:C283($lStatus)

ARRAY TEXT:C222($atHeaderNames;0)
ARRAY TEXT:C222($atHeaderValues;0)

$oInput:=$1

Case of 
	: (Not:C34(JIRA_Init .success))
		
	: ($oInput.projectKey=Null:C1517)
		
	Else 
		HTTP AUTHENTICATE:C1161(JIRA_Init .username;JIRA_Init .password;HTTP basic:K71:8)
		
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerNames;$atHeaderNames)
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerValues;$atHeaderValues)
		
		$lStatus:=HTTP Get:C1157(JIRA_Init .server+"/rest/api/3/project/"+$oInput.projectKey;$oResult;$atHeaderNames;$atHeaderValues)
		
		
End case 

$0:=$oResult
