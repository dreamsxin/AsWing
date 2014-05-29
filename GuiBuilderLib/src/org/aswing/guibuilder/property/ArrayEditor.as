package org.aswing.guibuilder.property{

import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;
	

public class ArrayEditor extends StringEditor{
	
	public function ArrayEditor(){
		super();
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			text.setText("");
		}else{
			var value:Array = v.getValue() as Array;
			if(value){
				text.setText(value.join(","));
			}else{
				text.setText("");
			}
		}
	}
	
	override protected function getEditorValue():ValueModel{
		var label:String = text.getText();
		if(label != null && label != ""){
			return new SimpleValue(label.split(","));
		}else{
			return ProModel.NONE_VALUE_SET;
		}
	}	
}
}