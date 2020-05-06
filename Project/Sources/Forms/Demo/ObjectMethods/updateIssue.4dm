  // Demo.updateIssue
  // 
  // Created by Brent Raymond on 01/02/20
  // Purpose: 
  // 
  // Note:
  //  
  // History:

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_OBJECT:C1216($oInput)
		C_TEXT:C284($tNewComment)
		
		$oInput:=New object:C1471(\
			"issueKey";Form:C1466.selectedIssue.key;\
			"description";(OBJECT Get pointer:C1124(Object named:K67:5;"description"))->;\
			"statusTransition";(OBJECT Get pointer:C1124(Object named:K67:5;"status"))->)
		
		$tNewComment:=(OBJECT Get pointer:C1124(Object named:K67:5;"newComment"))->
		
		If ($tNewComment#"")
			$oInput.comment:=$tNewComment
			(OBJECT Get pointer:C1124(Object named:K67:5;"newComment"))->:=""
			
		End if 
		
		JIRA_UpdateIssue ($oInput)
		
		
		Form:C1466.selectedIssue:=JIRA_Issue (New object:C1471(\
			"issueKey";Form:C1466.selectedIssue.key))
		
		  // questionable hack to update the listbox
		Form:C1466.issues[Form:C1466.currentIssuePos-1]:=Form:C1466.selectedIssue
		
	Else 
		
End case 


