package org.aswing.guibuilder.property{

import org.aswing.*;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class AbsComboIntEditor extends BasePropertyEditor implements PropertyEditor{
	
	protected var combo:JComboBox;
	
	public function AbsComboIntEditor(labels:Array){
		combo = new JComboBox(labels);
		combo.setPreferredWidth(70);
		combo.addActionListener(__apply);
		combo.setListCellFactory(new DefaultComboBoxListCellFactory(false, true));
		combo.revalidate();
	}
	
	public function getDisplay():Component{
		return combo;
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		var index:int = v.getValue();
		if(noValueSet){
			index = -1;
		}
		combo.setSelectedIndex(index);
	}	
	
	override protected function getEditorValue():ValueModel{
		if(combo.getSelectedIndex() < 0){
			return ProModel.NONE_VALUE_SET;
		}else{
			return new SimpleValue(combo.getSelectedIndex());
		}
	}
}
}