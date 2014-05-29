package org.aswing.guibuilder.property{

import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JComboBox;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.util.MathUtils;

public class AlignEditor extends BasePropertyEditor implements PropertyEditor {
	
	private var combo:JComboBox;
	
	private var values:Array;
		
	public function AlignEditor(){
		values = new Array();
		values.push( "Center" );
		values.push( "Top" );
		values.push( "Left" );
		values.push( "Bottom" );
		values.push( "Right" );
		
		combo = new JComboBox(["Center", "Top", "Left", "Bottom", "Right"]);
		combo.setEditable(true);
		combo.setPreferredWidth(70);
		combo.addActionListener(__apply);
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			combo.setSelectedItem("");
		}else {
			var index:int = MathUtils.parseInteger( String( v ) );
			combo.setSelectedItem( values[ index ] );
		}
	}	
	
	override protected function getEditorValue():ValueModel{
		var value:* = combo.getSelectedItem();
		if(value == null || value == ""){
			return ProModel.NONE_VALUE_SET;
		}else{
			return new SimpleValue( values.indexOf( value ) );
		}
	}
	
	public function getDisplay():Component{
		return combo;
	}	
	
	override public function setEditorParam(param:String):void{
		var arr:Array;
		if(param == "hor-only"){
			arr = ["Center", "Left", "Right"];
		}else if(param == "ver-only"){
			arr = ["Center", "Top", "Bottom"];
		}else{
			arr = ["Center", "Top", "Left", "Bottom", "Right"];
		}
		combo.setListData( arr );
	}
}
}