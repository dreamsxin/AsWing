package org.aswing.guibuilder.property{
	
import org.aswing.Component;
import org.aswing.JComboBox;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class BooleanEditor extends BasePropertyEditor implements PropertyEditor{
	
	protected var combo:JComboBox;
	
	public function BooleanEditor(){
		combo = new JComboBox(["Default", "true", "false"]);
		combo.setPreferredWidth(70);
		combo.addActionListener(__apply);
	}
	
	public function getDisplay():Component{
		return combo;
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		var index:int = 0;
		if(!noValueSet){
			if(v.getValue() == true){
				index = 1;
			}else{
				index = 2;
			}
		}
		combo.setSelectedIndex(index);
	}	
	
	override protected function getEditorValue():ValueModel{
		if(combo.getSelectedIndex() <= 0){
			return ProModel.NONE_VALUE_SET;
		}else{
			return new SimpleValue(combo.getSelectedIndex() == 1);
		}
	}
	
}
}