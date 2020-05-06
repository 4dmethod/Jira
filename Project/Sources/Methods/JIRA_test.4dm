//%attributes = {}
  // JIRA_test


  // 4/30/20 Designer: JIRA issue QL4D-63 - demo issue - 
  // 4/30/20 Designer: JIRA issue QL4D-63 - demo issue - 



C_LONGINT:C283($lStatus)
C_OBJECT:C1216($oConfig;$oResponse;$oDescription;$oBody;$oIssue)
C_COLLECTION:C1488($cResponse)

ARRAY TEXT:C222($atHeaderNames;0)
ARRAY TEXT:C222($atHeaderValues;0)

$oConfig:=New object:C1471
$oResponse:=New object:C1471
$oDescription:=New object:C1471

$oConfig.username:="4dmethod@gmail.com"
$oConfig.password:="iBBEkpJI9Ez53q7YejDX2174"  // API Token
$oConfig.server:="https://4dmethod.atlassian.net"
$oConfig.currentProject:="QL4D"

  // 4/30/20 Designer: JIRA issue QL4D-63 - demo issue - found bug here!
If (JIRA_Init ($oConfig).success)
	
	$oDescription.currentUser:=JIRA_User 
	
	$oDescription.projectList:=JIRA_ProjectList 
	$oConfig.currentProject:=$oDescription.projectList.values[0].key
	
	$oDescription.projectInfo:=JIRA_Project (New object:C1471("projectKey";$oConfig.currentProject))
	
	$oDescription.priorities:=JIRA_PrioritiesList 
	
	$oDescription.newIssue:=JIRA_NewIssue (New object:C1471(\
		"summary";"test issue "+Timestamp:C1445;\
		"projectKey";$oConfig.currentProject;\
		"issuetype";"Bug";\
		"description";"A problem in "+Current method path:C1201;\
		"priority";"High";\
		"reporter";$oDescription.currentUser.name;\
		"assignee";$oDescription.currentUser.name;\
		"labels";New collection:C1472("v18";"groovy");\
		"originalEstimate";"2d 4h"))
	
	
	JIRA_OpenIssue (New object:C1471("issueKey";$oDescription.newIssue.key))
	
	$oDescription.currentIssue:=JIRA_Issue (New object:C1471("issueKey";$oDescription.newIssue.key))
	
	$oDescription.transitions:=JIRA_StatusTransitionList (New object:C1471("issueKey";$oDescription.newIssue.key))
	
	$oDescription.updatedIssue:=JIRA_UpdateIssue (New object:C1471(\
		"issueKey";$oDescription.newIssue.key;\
		"summary";"123 issue "+Timestamp:C1445;\
		"statusTransition";"In Progress";\
		"comment";"This is a comment about the issue!"))
	
	$oDescription.search1:=JIRA_Search (New object:C1471(\
		"project";"QL4D"))
	
	
	If (False:C215)  // clean house
		For each ($oIssue;JIRA_Search (New object:C1471("project";"QL4D")))
			JIRA_DeleteIssue (New object:C1471("issueKey";$oIssue.key))
			
		End for each 
		
	End if 
	
	
	
	If (False:C215)  // List unreleased versions
		  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-group-Project-versions
		
		$lStatus:=HTTP Get:C1157($oConfig.server+"/rest/api/3/project/"+$oConfig.currentProject+"/version?status=unreleased";$oResponse;$atHeaderNames;$atHeaderValues)
		
		$oDescription.unreleasedVersions:=OB Copy:C1225($oResponse)
		
	End if 
	
	  // add attachment
	  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-issueIdOrKey-attachments-post
	
	
	If (False:C215)  // List new issue meta fields
		  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-createmeta-get
		
		$lStatus:=HTTP Get:C1157($oConfig.server+"/rest/api/3/issue/createmeta?projectKeys="+$oConfig.currentProject;$oResponse;$atHeaderNames;$atHeaderValues)
		
		$oDescription.createmeta:=OB Copy:C1225($oResponse)
		
	End if 
	
	If (False:C215)  // List status values
		  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-status-get
		
		$lStatus:=HTTP Get:C1157($oConfig.server+"/rest/api/3/status";$cResponse;$atHeaderNames;$atHeaderValues)
		
		$oDescription.statuses:=$cResponse.copy()
		
	End if 
	
	If (False:C215)  // List update issue meta fields
		  // https://developer.atlassian.com/cloud/jira/platform/rest/v3/#api-rest-api-3-issue-issueIdOrKey-editmeta-get
		
		$lStatus:=HTTP Get:C1157($oConfig.server+"/rest/api/3/issue/"+$oDescription.newIssue.key+"/editmeta";$oResponse;$atHeaderNames;$atHeaderValues)
		
		$oDescription.editmeta:=OB Copy:C1225($oResponse)
		
	End if 
	
End if 

SET TEXT TO PASTEBOARD:C523(JSON Stringify:C1217($oDescription;*))






