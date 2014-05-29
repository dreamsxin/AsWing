package org.aswing.guibuilder.property{

import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;
import org.aswing.guibuilder.util.MathUtils;	

public class NumberSerializer extends IntSerializer{
	
	override public function decodeValue(valueXML:XML, pro:ProModel):ValueModel{
		return new SimpleValue(MathUtils.parseNumber(valueXML.@value));
	}
}
}