//%attributes = {}
  // JIRA_ProjectList : object
  // 
  // Created by Brent Raymond on 12/27/19
  // Purpose: 
  // 
  // Note:
  // Get projects paginated
  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-project-search-get
  //  
  // History:


C_OBJECT:C1216($0;$oResult)

C_LONGINT:C283($lStatus)

ARRAY TEXT:C222($atHeaderNames;0)
ARRAY TEXT:C222($atHeaderValues;0)

If (JIRA_Init .success)
	HTTP AUTHENTICATE:C1161(JIRA_Init .username;JIRA_Init .password;HTTP basic:K71:8)
	
	COLLECTION TO ARRAY:C1562(JIRA_Init .headerNames;$atHeaderNames)
	COLLECTION TO ARRAY:C1562(JIRA_Init .headerValues;$atHeaderValues)
	
	$lStatus:=HTTP Get:C1157(JIRA_Init .server+"/rest/api/3/project/search";$oResult;$atHeaderNames;$atHeaderValues)
	
	
End if 

$0:=$oResult
