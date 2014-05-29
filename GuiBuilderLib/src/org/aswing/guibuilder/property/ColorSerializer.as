package org.aswing.guibuilder.property{

import org.aswing.ASColor;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;
import org.aswing.guibuilder.util.MathUtils;

public class ColorSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):ValueModel{
		var str:String = valueXML.@value;
		var color:ASColor;
		if(str == "null"){
			color = null;
		}else{
			var strs:Array = str.split(",");
			color = new ASColor(
				MathUtils.parseInteger(strs[0], 16), 
				MathUtils.parseNumber(strs[1]));
		}
		return new SimpleValue(color);
	}
	
	public function encodeValue(value:ValueModel, pro:ProModel):XML{
		var color:ASColor = value.getValue();
		var xml:XML = <Value></Value>;
		if(color == null){
			xml.@value = "null";
		}else{
			xml.@value = color.getRGB().toString(16)+","+color.getAlpha();
		}
		return xml;
	}
	
	public function getCodeLines(value:ValueModel, pro:ProModel):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:ValueModel, pro:ProModel):String{
		var color:ASColor = value.getValue();
		if(color == null){
			return "null";
		}
		return "new ASColor(0x" + color.getRGB().toString(16) + ", " + color.getAlpha() + ")";
	}
	
}
}