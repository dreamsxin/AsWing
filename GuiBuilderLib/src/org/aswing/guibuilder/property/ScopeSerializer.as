package org.aswing.guibuilder.property{

import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.ValueModel;	

public class ScopeSerializer extends StringSerializer{
	
	override public function isSimpleOneLine(value:ValueModel, pro:ProModel):String{
		return null;
	}
}
}