package org.aswing.guibuilder.property{

import flash.events.Event;

import org.aswing.Component;
import org.aswing.JButton;
import org.aswing.guibuilder.LayoutChooser;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.LayoutModel;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.ValueModel;

public class LayoutEditor extends BasePropertyEditor implements PropertyEditor{
	
	private var display:JButton;
	private var layoutChooser:LayoutChooser;
	private var layoutModel:LayoutModel;
	
	public function LayoutEditor(){
		display = new JButton("Default");
		display.addActionListener(__showChooser);
		layoutChooser = new LayoutChooser();
	}
	
	private function __showChooser(e:Event):void{
		layoutChooser.open(__choosed, layoutModel);
	}
	private function __choosed(m:LayoutModel):void{
		if(m){
			layoutModel = m;
			updateRepresents();
			applyProperty();
		}
	}
	
	public function getDisplay():Component{
		return display;
	}
	
	override public function setEditorParam(param:String):void{
		display.setEnabled(param != "disabled");
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		layoutModel = v as LayoutModel;
		updateRepresents();
	}
	
	private function updateRepresents():void{
		if(layoutModel != null){
			display.setText(layoutModel.getName());
		}else{
			display.setText("Default");
		}
	}
	
	override protected function getEditorValue():ValueModel{
		if(layoutModel != null){
			return layoutModel;
		}else{
			return ProModel.NONE_VALUE_SET;
		}
	}
}
}