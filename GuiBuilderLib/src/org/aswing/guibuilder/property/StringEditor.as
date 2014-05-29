package org.aswing.guibuilder.property{

import org.aswing.Component;
import org.aswing.JTextField;
import org.aswing.event.AWEvent;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class StringEditor extends BasePropertyEditor implements PropertyEditor{
	
	protected var text:JTextField;
	
	public function StringEditor(){
		text = new JTextField("", 16);
		text.addActionListener(__apply);
		text.addEventListener(AWEvent.FOCUS_LOST, __apply);
	}
		
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			text.setText("");
		}else{
			text.setText(v+"");
		}
	}
	
	override protected function getEditorValue():ValueModel{
		var label:String = text.getText();
		if(label != null && label != ""){
			return new SimpleValue(label);
		}else{
			return ProModel.NONE_VALUE_SET;
		}
	}
	
	public function getDisplay():Component{
		return text;
	}
}
}