package org.aswing.guibuilder.property{

import org.aswing.Component;
import org.aswing.JComboBox;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class ConstraintsEditor extends BasePropertyEditor implements PropertyEditor{
	
	private var combo:JComboBox;
	
	public function ConstraintsEditor(){
		combo = new JComboBox(["Center", "North", "South", "East", "West"]);
		combo.setEditable(true);
		combo.setPreferredWidth(70);
		combo.addActionListener(__apply);
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			combo.setSelectedItem("");
		}else{
			combo.setSelectedItem(v+"");
		}
	}	
	
	override protected function getEditorValue():ValueModel{
		var value:* = combo.getSelectedItem();
		if(value == null || value == ""){
			return ProModel.NONE_VALUE_SET;
		}else{
			return new SimpleValue(value);
		}
	}
	
	public function getDisplay():Component{
		return combo;
	}	
}
}