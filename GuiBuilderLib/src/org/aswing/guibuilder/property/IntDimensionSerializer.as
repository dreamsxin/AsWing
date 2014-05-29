package org.aswing.guibuilder.property{

import org.aswing.geom.IntDimension;
import org.aswing.guibuilder.DefaultValueHelper;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.Model;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;
import org.aswing.guibuilder.util.MathUtils;

public class IntDimensionSerializer implements PropertySerializer, DefaultValueHelper{
	
	public function decodeValue(valueXML:XML, pro:ProModel):ValueModel{
		var str:String = valueXML.@value;
		var strs:Array = str.split(",");
		var dim:IntDimension = new IntDimension(MathUtils.parseInteger(strs[0]), MathUtils.parseInteger(strs[1]));
		return new SimpleValue(dim);
	}
	
	public function encodeValue(value:ValueModel, pro:ProModel):XML{
		var dim:IntDimension = value.getValue();
		var xml:XML = <Value></Value>;
		xml.@value = dim.width + "," + dim.height;
		return xml;
	}
	
	public function getCodeLines(value:ValueModel, pro:ProModel):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:ValueModel, pro:ProModel):String{
		var dim:IntDimension = value.getValue();
		return "new IntDimension(" + dim.width 
				+ ", " + dim.height + ")";
	}
	
	public function getDefaultValue(propertyName:String, model:Model):ValueModel{
		if(model is ComModel && propertyName == "PreferredSize"){
			return new SimpleValue(null);
		}else{
			throw new Error("It is not default value helped!");
			return null;
		}
	}
	
	public function isNeedHelp(propertyName:String, model:Model):Boolean{
		if(model is ComModel && propertyName == "PreferredSize"){
			return true;
		}
		return false;
	}
}
}