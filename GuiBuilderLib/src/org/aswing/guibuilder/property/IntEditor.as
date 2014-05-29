package org.aswing.guibuilder.property{

import org.aswing.Component;
import org.aswing.event.AWEvent;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class IntEditor extends BasePropertyEditor implements PropertyEditor{
	
	protected var text:IntInput;
	
	public function IntEditor(){
		text = new IntInput("", "", 0, 6);
		text.addEventListener(AWEvent.ACT, __apply);
	}
		
	public function getDisplay():Component{
		return text;
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			text.setInputText("");
		}else{
			text.setInputText(v+"");
		}
	}	
	
	override protected function getEditorValue():ValueModel{
		if(text.isEmpty()){
			return ProModel.NONE_VALUE_SET;
		}
		return new SimpleValue(text.getInputInt());
	}
}
}