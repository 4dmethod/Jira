//%attributes = {}
  // JIRA_Macros
  // 
  // Created by Brent Raymond on 01/08/20
  // Purpose: 
  // 
  // Note:
  //  
  // History:

C_OBJECT:C1216($1;$oInput)

C_TEXT:C284($tComment;$tAction;$tHighlightedText)

$oInput:=$1

$tAction:=$oInput.action
GET MACRO PARAMETER:C997(Highlighted method text:K5:18;$tHighlightedText)

Case of 
	: (JIRA_Search (New object:C1471("key";$tHighlightedText)).length>0)
		  // assume all actions relate to this issue
		$oInput.issueKey:=$tHighlightedText
		
	: ((JIRA_Init .currentIssue#"") & ($tAction#"select"))
		$oInput.issueKey:=JIRA_Init .currentIssue
		
	Else 
		  // display selection dialog of issues
		C_COLLECTION:C1488($cChoices;$cIssues)
		C_OBJECT:C1216($oIssue)
		C_LONGINT:C283($lChoice)
		
		$cChoices:=New collection:C1472
		$cIssues:=JIRA_Search (New object:C1471("project";JIRA_Init .currentProject))
		
		For each ($oIssue;$cIssues)
			$cChoices.push(Char:C90(1)+$oIssue.key+\
				" ("+$oIssue.fields.issuetype.name+") ["+$oIssue.fields.status.name+"] "+\
				$oIssue.fields.summary)
			
		End for each 
		
		$lChoice:=Pop up menu:C542($cChoices.join(";"))
		
		If ($lChoice>0)
			$oInput.issueKey:=$cIssues[$lChoice-1].key
			
		End if 
		
End case 

Case of 
	: ($tAction="select")
		JIRA_Init (New object:C1471("currentIssue";$oInput.issueKey))  // updates init 
		
	: ($tAction="open")
		JIRA_OpenIssue ($oInput)
		
	: ($tAction="methodComment")
		$tComment:=JIRA_IssueSummary ($oInput)
		
		SET MACRO PARAMETER:C998(Highlighted method text:K5:18;$tComment)
		
	: ($tAction="issueComment")
		$tComment:=Request:C163("Add comment to issue: "+$oInput.issueKey)
		
		If ($tComment#"")
			$oInput.comment:=$tComment
			JIRA_UpdateIssue ($oInput)
			
		End if 
		
	: ($tAction="update")
		If (($oInput.comment#Null:C1517) & ($tHighlightedText#""))
			  // also add highlighted code to comment
			$oInput.codeBlock:=$tHighlightedText
			
		End if 
		
		JIRA_UpdateIssue ($oInput)
		
		
		
		
End case 

