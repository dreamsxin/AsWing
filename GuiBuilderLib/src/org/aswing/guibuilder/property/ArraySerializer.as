package org.aswing.guibuilder.property{
	
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class ArraySerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):ValueModel{
		var vStr:String = valueXML.@value;
		if(vStr == null || vStr == "null" || vStr == ""){
			return new SimpleValue(null);
		}else{
			return new SimpleValue(vStr.split(","));
		}
	}
	
	public function encodeValue(value:ValueModel, pro:ProModel):XML{
		var arr:Array = value.getValue() as Array;
		var xml:XML = <Value></Value>;
		if(arr == null){
			xml.@value = "null";
		}else{
			xml.@value = arr.join(",");
		}
		return xml;
	}
	
	public function getCodeLines(value:ValueModel, pro:ProModel):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:ValueModel, pro:ProModel):String{
		if(pro.getDef().getEditorParam() == "no-generate-code"){
			return null;
		}
		var arr:Array = value.getValue() as Array;
		if(arr){
			return "['"+ arr.join("','") + "']";
		}else{
			return null;
		}
	}
}
}