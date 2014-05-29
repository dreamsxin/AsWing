package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.code.CodeGenerator;
import org.aswing.guibuilder.model.*;

public class BorderSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):ValueModel{
		if(valueXML.@value == "null"){
			return new SimpleValue(null);
		}
		var model:BorderModel = pro.getValue() as BorderModel;
		if(model == null){
			model = new BorderModel();
		}
		model.parse(valueXML.children()[0]);
		return model;
	}
	
	public function encodeValue(value:ValueModel, pro:ProModel):XML{
		var xml:XML = <Value></Value>;
		if(value.getValue() == null){
			xml.@value="null";
			return xml;
		}
		var model:BorderModel = value as BorderModel;
		//var borderDef:BorderDefinition = model.getDef();
		xml.appendChild(model.encodeXML());
		return xml;
	}
	
	public function getCodeLines(value:ValueModel, pro:ProModel):Array{
		var borderModel:BorderModel = value as BorderModel;
		var id:String = "border" + (CodeGenerator.border_id_counter++);
		var clazz:String = borderModel.getDef().getShortClassName();
		var arr:Array = [];
		arr.push("var " + id + ":" + clazz + " = new " + clazz + "();");
		var pros:Array = borderModel.getProperties();
		for each(var pro:ProModel in pros){
			var simple:String = pro.isSimpleOneLine();
			if(simple != null){
				arr.push(id + ".set" + pro.getName() + "(" + simple + ");");
			}else{
				var proCodeLines:Array = pro.getCodeLines();
				if(proCodeLines != null){
					var n:int = proCodeLines.length - 1;
					for(var i:int=0; i<n; i++){
						arr.push(proCodeLines[i]);
					}
					arr.push(id + ".set" + pro.getName() + "(" + proCodeLines[n] + ");");
				}
			}
		}
		arr.push(id);
		return arr;
	}
	
	public function isSimpleOneLine(value:ValueModel, pro:ProModel):String{
		if(value.getValue() == null){
			return "null";
		}
		return null;
	}
	
}
}