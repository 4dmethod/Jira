//%attributes = {}
  //Method:OB_CopyToSharedCollection
  //$1:Collection to copy from
  //$2:Shared Collection to copy to

  // Note: see Tech Tip: Two Methods to copy object/collection to shared object/collection
  // https://kb.4d.com/assetid=78197

C_COLLECTION:C1488($1;$2)
C_LONGINT:C283($counter)

For ($counter;0;$1.length-1)
	Case of 
		: (Value type:C1509($1[$counter])=Is object:K8:27)
			$2[$counter]:=New shared object:C1526
			Use ($2[$counter])
				  //Element type is object, copy with OB_CopyObject 
				OB_CopyToSharedObject ($1[$counter];$2[$counter])
			End use 
		: (Value type:C1509($1[$counter])=Is collection:K8:32)
			  //Element type is collection, copy with OB_CopyCollection //Element type is collection, copy with OB_CopyCollection//Element type is collection, copy with OB_CopyCollection
			$2[$counter]:=New shared collection:C1527
			Use ($2[$counter])
				OB_CopyToSharedCollection ($1[$counter];$2[$counter])
			End use 
		Else 
			  // Other supported types can be copied directly.
			$2[$counter]:=$1[$counter]
	End case 
End for 
