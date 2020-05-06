//%attributes = {}
  // JIRA_Search (object) : collection
  // 
  // Created by Brent Raymond on 12/30/19
  // Purpose: 
  // 
  // Parameters:
  //       jql - pass a specific search string here or pass these specific values....
  //       project - 
  //       key - 
  //       issuetype - 
  //       summary - is wildcarded
  //       status - 
  //       assignee - pass currentuser() to find assigned to myself (JIRA_User), otherwise pass quoted name
  //       priority - 
  //       labels - 
  //       fixVersion - 
  // 
  // Note:
  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-group-Issue-search
  // https://www.atlassian.com/blog/jira-software/jql-the-most-flexible-way-to-search-jira-14
  //  
  // History:


C_OBJECT:C1216($1;$oInput)
C_COLLECTION:C1488($0;$cResult)

C_LONGINT:C283($lStatus)
C_OBJECT:C1216($oBody;$oResult)
C_COLLECTION:C1488($cSearches)
C_TEXT:C284($tParam)

ARRAY TEXT:C222($atHeaderNames;0)
ARRAY TEXT:C222($atHeaderValues;0)

$oInput:=$1

$oBody:=New object:C1471
$cResult:=New collection:C1472

Case of 
	: (Not:C34(JIRA_Init .success))
		
	Else 
		HTTP AUTHENTICATE:C1161(JIRA_Init .username;JIRA_Init .password;HTTP basic:K71:8)
		
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerNames;$atHeaderNames)
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerValues;$atHeaderValues)
		
		If (Value type:C1509($oInput.jql)=Is text:K8:3)
			$oBody.jql:=$oInput.jql
			
		Else 
			$cSearches:=New collection:C1472
			
			For each ($tParam;$oInput)
				Case of 
					: ($tParam="summary")
						$cSearches.push($tParam+" ~ \""+$oInput[$tParam]+"\"")  // quoted fuzzy
						
					: (($tParam="status") | ($tParam="fixVersion"))  // quoted
						$cSearches.push($tParam+" = \""+$oInput[$tParam]+"\"")
						
					Else 
						$cSearches.push($tParam+" = "+$oInput[$tParam])
						
				End case 
				
			End for each 
			
			$oBody.jql:=$cSearches.join(" AND ")  // can also use OR or != for not equal above
			
		End if 
		
		$lStatus:=HTTP Request:C1158(HTTP POST method:K71:2;JIRA_Init .server+"/rest/api/3/search";$oBody;$oResult;$atHeaderNames;$atHeaderValues)
		
		If ($lStatus=200)
			$cResult:=$oResult.issues
			
		End if 
		
End case 

$0:=$cResult
