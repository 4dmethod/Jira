//%attributes = {}
  // JIRA_UpdateIssue (object) : object
  // 
  // Created by Brent Raymond on 12/30/19
  // Purpose: 
  // 
  // Parameters:
  //         issueKey   - (required)
  //         summary - 
  //         description - 
  //         statusTransition - see JIRA_StatusTransitionList[].name (In Progress...)
  //         priority - JIRA_PrioritiesList[].name  (High...)
  //         reporter - short name of user, eg JIRA_User.name (admin...) 
  //         assignee - short name of user, eg JIRA_User.name (admin...) 
  //         labels - collection of free text labels
  //         originalEstimate - (eg. 3w 4d 12h)
  //         comment - 
  //         codeBlock - 
  // 
  // Note:
  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-issueIdOrKey-put
  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-issueIdOrKey-transitions-post
  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-issueIdOrKey-comment-post
  //  https://developer.atlassian.com/cloud/jira/platform/apis/document/structure/
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
		
	: ($oInput.issueKey=Null:C1517)
		
	Else 
		$oBody:=New object:C1471
		
		$oBody.update:=New object:C1471
		
		$oBody.fields:=New object:C1471
		
		If (Value type:C1509($oInput.summary)=Is text:K8:3)
			$oBody.fields.summary:=$oInput.summary
			
		End if 
		
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
		
		$lStatus:=HTTP Request:C1158(HTTP PUT method:K71:6;JIRA_Init .server+"/rest/api/3/issue/"+$oInput.issueKey;$oBody;$oResult;$atHeaderNames;$atHeaderValues)
		
		
		If (Value type:C1509($oInput.statusTransition)=Is text:K8:3)  // status transitions handled separately from other issue properties
			$oBody:=New object:C1471
			
			$oBody.update:=New object:C1471
			
			$oBody.fields:=New object:C1471
			
			$oBody.transition:=New object:C1471("id";JIRA_StatusTransitionList ($oInput).query("name = :1";$oInput.statusTransition)[0].id)
			
			COLLECTION TO ARRAY:C1562(JIRA_Init .headerNames;$atHeaderNames)
			COLLECTION TO ARRAY:C1562(JIRA_Init .headerValues;$atHeaderValues)
			
			$lStatus:=HTTP Request:C1158(HTTP POST method:K71:2;JIRA_Init .server+"/rest/api/3/issue/"+$oInput.issueKey+"/transitions";$oBody;$oResult;$atHeaderNames;$atHeaderValues)
			
		End if 
		
		If ((Value type:C1509($oInput.comment)=Is text:K8:3) | (Value type:C1509($oInput.codeBlock)=Is text:K8:3))  // comment handled separately from other issue properties
			$oBody:=New object:C1471
			
			$oBody.body:=New object:C1471(\
				"type";"doc";\
				"version";1;\
				"content";New collection:C1472)
			
			If (Value type:C1509($oInput.comment)=Is text:K8:3)
				  // https://developer.atlassian.com/cloud/jira/platform/apis/document/nodes/paragraph/
				  //https://developer.atlassian.com/cloud/jira/platform/apis/document/marks/link/
				
				If (Position:C15("{methodLink}";$oInput.comment)>0)
					  // link the text back to the project
					$oBody.body.content.push(New object:C1471(\
						"type";"paragraph";\
						"content";New collection:C1472(\
						New object:C1471(\
						"text";Replace string:C233($oInput.comment;"{methodLink}";"")+"\n";\
						"type";"text";\
						"marks";New collection:C1472(\
						New object:C1471(\
						"type";"link";\
						"attrs";New object:C1471(\
						"href";"http://localhost:80/accessCode/"+Split string:C1554($oInput.comment;"{methodLink}";sk trim spaces:K86:2)[1])))))))
					
				Else 
					$oBody.body.content.push(New object:C1471(\
						"type";"paragraph";\
						"content";New collection:C1472(\
						New object:C1471(\
						"text";$oInput.comment+"\n";\
						"type";"text"))))
					
				End if 
				
			End if 
			
			If (Value type:C1509($oInput.codeBlock)=Is text:K8:3)
				  // https://developer.atlassian.com/cloud/jira/platform/apis/document/nodes/codeBlock/
				$oBody.body.content.push(New object:C1471(\
					"type";"codeBlock";\
					"content";New collection:C1472(New object:C1471(\
					"text";Replace string:C233($oInput.codeBlock;"\r";"\n";*);\
					"type";"text"))))
				
			End if 
			
			
			COLLECTION TO ARRAY:C1562(JIRA_Init .headerNames;$atHeaderNames)
			COLLECTION TO ARRAY:C1562(JIRA_Init .headerValues;$atHeaderValues)
			
			$lStatus:=HTTP Request:C1158(HTTP POST method:K71:2;JIRA_Init .server+"/rest/api/3/issue/"+$oInput.issueKey+"/comment";$oBody;$oResult;$atHeaderNames;$atHeaderValues)
			
		End if 
		
		
		
End case 

$0:=$oResult
