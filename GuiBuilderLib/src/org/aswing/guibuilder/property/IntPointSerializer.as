package org.aswing.guibuilder.property{

import org.aswing.geom.IntPoint;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;
import org.aswing.guibuilder.util.MathUtils;

public class IntPointSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):ValueModel{
		var str:String = valueXML.@value;
		var strs:Array = str.split(",");
		return new SimpleValue(new IntPoint(MathUtils.parseInteger(strs[0]), MathUtils.parseInteger(strs[1])));
	}
	
	public function encodeValue(value:ValueModel, pro:ProModel):XML{
		var p:IntPoint = value.getValue();
		var xml:XML = <Value></Value>;
		xml.@value = p.x + "," + p.y;
		return xml;
	}
	
	public function getCodeLines(value:ValueModel, pro:ProModel):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:ValueModel, pro:ProModel):String{
		var p:IntPoint = value.getValue();
		return "new IntPoint(" + p.x + ", " + p.y + ")";
	}
	
}
}