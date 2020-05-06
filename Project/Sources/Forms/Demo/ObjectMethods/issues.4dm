  // Demo.issues
  // 
  // Created by Brent Raymond on 12/31/19
  // Purpose: 
  // 
  // Note:
  //  
  // History:


Case of 
	: (Form event code:C388=On Double Clicked:K2:5)
		If (Form:C1466.selectedIssue#Null:C1517)
			JIRA_OpenIssue (New object:C1471("issueKey";Form:C1466.selectedIssue.key))
			
		End if 
		
	: (Form event code:C388=On Selection Change:K2:29)
		C_TEXT:C284($tDescription;$tStatus)
		
		If (Form:C1466.selectedIssue#Null:C1517)
			  // update the values and also pull comments
			Form:C1466.selectedIssue:=JIRA_Issue (New object:C1471(\
				"issueKey";Form:C1466.selectedIssue.key))
			
			  // questionable hack to update the listbox
			Form:C1466.issues[Form:C1466.currentIssuePos-1]:=Form:C1466.selectedIssue
			
			$tDescription:=Form:C1466.selectedIssue.fields.description.content.extract("content.text").extract("text").join("\r")
			
			$tStatus:=Form:C1466.selectedIssue.fields.status.name
			
		End if 
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"status"))->:=$tStatus
		(OBJECT Get pointer:C1124(Object named:K67:5;"description"))->:=$tDescription
		
	: (Form event code:C388=On Begin Drag Over:K2:44)
		  // generate comment for working on this issue in a method
		SET TEXT TO PASTEBOARD:C523("// "+String:C10(Current date:C33)+" "+Current user:C182+\
			": JIRA issue "+Form:C1466.selectedIssue.key+" - "+Form:C1466.selectedIssue.fields.summary+" - \r")
		
		
		If (True:C214)  // setting drag icon
			C_PICTURE:C286($gDragIcon)
			C_TEXT:C284($tSvgRef;$tTextAreaRef;$tRectRef)
			
			$tSvgRef:=SVG_New (100;40)
			
			$tRectRef:=SVG_New_rect ($tSvgRef;5;5;100;30;10;10;"";"blue:50";1)
			
			$tTextAreaRef:=SVG_New_textArea ($tSvgRef;Form:C1466.selectedIssue.key;17;12;0;0;"Helvetica";14;Bold:K14:2)
			SVG_SET_FONT_COLOR ($tTextAreaRef;"white")
			
			$gDragIcon:=SVG_Export_to_picture ($tSvgRef)
			SVG_CLEAR ($tSvgRef)
			
			SET DRAG ICON:C1272($gDragIcon;15;15)
			
		End if 
		
	Else 
		
End case 

