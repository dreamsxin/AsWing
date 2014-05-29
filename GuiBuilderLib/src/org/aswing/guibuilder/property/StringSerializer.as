package org.aswing.guibuilder.property{

import org.aswing.guibuilder.DefaultValueHelper;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.Model;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class StringSerializer implements PropertySerializer, DefaultValueHelper{
	
	public function decodeValue(valueXML:XML, pro:ProModel):ValueModel{
		return new SimpleValue(valueXML.@value+"");
	}
	
	public function encodeValue(value:ValueModel, pro:ProModel):XML{
		var xml:XML = <Value></Value>;
		xml.@value = value+"";
		return xml;
	}
	
	public function getCodeLines(value:ValueModel, pro:ProModel):Array{
		return null;
	}
	
	public function isSimpleOneLine(value:ValueModel, pro:ProModel):String{
		if(pro.getDef().getEditorParam() == "no-generate-code"){
			return null;
		}
		return "\"" + value + "\"";
	}
	
	public function getDefaultValue(propertyName:String, model:Model):ValueModel{
		if(model is ComModel && propertyName == ComModel.ID_NAME){
			return new SimpleValue(ComModel(model).getID());
		}else{
			throw new Error("It is not default value helped!");
			return null;
		}
	}
	
	public function isNeedHelp(propertyName:String, model:Model):Boolean{
		if(model is ComModel && propertyName == ComModel.ID_NAME){
			return true;
		}
		return false;
	}
}
}