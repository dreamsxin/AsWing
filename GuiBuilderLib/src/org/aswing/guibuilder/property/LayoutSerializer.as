package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.code.CodeGenerator;
import org.aswing.guibuilder.model.LayoutModel;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.ValueModel;

public class LayoutSerializer implements PropertySerializer{
	
	public function decodeValue(valueXML:XML, pro:ProModel):ValueModel{
		var model:LayoutModel = pro.getValue() as LayoutModel;
		if(model == null){
			model = new LayoutModel();
		}
		model.parse(valueXML.children()[0]);
		return model;
	}
	
	public function encodeValue(value:ValueModel, pro:ProModel):XML{
		var model:LayoutModel = value as LayoutModel;
		//var layoutDef:LayoutDefinition = model.getDef();
		var xml:XML = <Value></Value>;
		xml.appendChild(model.encodeXML());
		return xml;
	}
	
	public function getCodeLines(value:ValueModel, pro:ProModel):Array{
		var layoutModel:LayoutModel = value as LayoutModel;
		var id:String = "layout" + (CodeGenerator.border_id_counter++);
		var clazz:String = layoutModel.getDef().getShortClassName();
		var arr:Array = [];
		arr.push("var " + id + ":" + clazz + " = new " + clazz + "();");
		var pros:Array = layoutModel.getProperties();
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
		return null;
	}
	
}
}