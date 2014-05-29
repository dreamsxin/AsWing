package org.aswing.guibuilder.property{

import flash.events.Event;

import org.aswing.Component;
import org.aswing.JButton;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.model.PackProModel;
import org.aswing.guibuilder.model.ProModel;

public class PackEditor implements PropertyEditor{
	
	private var button:JButton;
	private var model:PackProModel;
	
	public function PackEditor(){
		button = new JButton("pack");
		button.addActionListener(__apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function getDisplay():Component{
		return button;
	}
			
	public function setSerializer(ser:PropertySerializer):void{
	}
	
	public function bindTo(pro:ProModel):void{
		model = pro as PackProModel;
	}
	
	public function setEditorParam(param:String):void{
	}
	
	public function applyProperty():void{
		model.valueChanged(null);
	}
}
}