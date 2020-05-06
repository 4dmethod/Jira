//%attributes = {}
  // JIRA_NewIssue (object) : object
  // 
  // Created by Brent Raymond on 12/27/19
  // Purpose: 
  // 
  // Parameters:
  //         summary - (required)
  //         projectKey - (required)
  //         issuetype - (required) name of issue type (Bug...)  see JIRA_Project.issueTypes
  //         description - 
  //         priority - JIRA_PrioritiesList[].name  (High...)
  //         reporter - short name of user, eg JIRA_User.name (admin...) 
  //         assignee - short name of user, eg JIRA_User.name (admin...) 
  //         labels - collection of free text labels
  //         originalEstimate - (eg. 3w 4d 12h)
  // 
  // Note:
  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-post
  // https://developer.atlassian.com/server/jira/platform/jira-rest-api-examples/
  // https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/
  //  
  // History:


C_OBJECT:C1216($1;$oInput)
C_OBJECT:C1216($0;$oResult)

C_OBJECT:C1216($oBody)
C_LONGINT:C283($lStatus)

ARRAY TEXT:C222($atHeaderNames;0)
ARRAY TEXT:C222($atHeaderValues;0)

$oInput:=$1

Case of 
	: (Not:C34(JIRA_Init .success))
		
	: (False:C215)  // check for required parameters...
		
	: ($oInput.summary=Null:C1517)
		
	: ($oInput.projectKey=Null:C1517)
		
	: ($oInput.issuetype=Null:C1517)
		
	Else 
		$oBody:=New object:C1471
		
		$oBody.update:=New object:C1471
		
		$oBody.fields:=New object:C1471
		$oBody.fields.summary:=$oInput.summary
		$oBody.fields.project:=New object:C1471("key";$oInput.projectKey)
		$oBody.fields.issuetype:=New object:C1471("name";$oInput.issuetype)
		
		If (Value type:C1509($oInput.description)=Is text:K8:3)
			$oBody.fields.description:=New object:C1471(\
				"type";"doc";\
				"version";1;\
				"content";New collection:C1472(New object:C1471(\
				"type";"paragraph";\
				"content";New collection:C1472(New object:C1471(\
				"text";$oInput.description;\
				"type";"text")))))
			
		End if 
		
		If (Value type:C1509($oInput.priority)=Is text:K8:3)
			$oBody.fields.priority:=New object:C1471("name";$oInput.priority)
			
		End if 
		
		If (Value type:C1509($oInput.reporter)=Is text:K8:3)
			$oBody.fields.reporter:=New object:C1471("name";$oInput.reporter)
			
		End if 
		
		If (Value type:C1509($oInput.assignee)=Is text:K8:3)
			$oBody.fields.assignee:=New object:C1471("name";$oInput.assignee)
			
		End if 
		
		If (Value type:C1509($oInput.labels)=Is collection:K8:32)
			$oBody.fields.labels:=$oInput.labels
			
		End if 
		
		If (Value type:C1509($oInput.timetracking)=Is text:K8:3)
			$oBody.fields.timetracking:=New object:C1471("originalEstimate";$oInput.timetracking)
			
		End if 
		
		
		HTTP AUTHENTICATE:C1161(JIRA_Init .username;JIRA_Init .password;HTTP basic:K71:8)
		
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerNames;$atHeaderNames)
		COLLECTION TO ARRAY:C1562(JIRA_Init .headerValues;$atHeaderValues)
		
		$lStatus:=HTTP Request:C1158(HTTP POST method:K71:2;JIRA_Init .server+"/rest/api/3/issue";$oBody;$oResult;$atHeaderNames;$atHeaderValues)
		
		
End case 

$0:=$oResult
