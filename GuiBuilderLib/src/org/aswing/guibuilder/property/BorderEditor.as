package org.aswing.guibuilder.property{
	
import flash.events.Event;

import org.aswing.*;
import org.aswing.guibuilder.BorderChooser;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.*;

public class BorderEditor extends BasePropertyEditor implements PropertyEditor{
	
	private static var DEFAULT:BorderModel = new BorderModel();
	
	private var defaultRadio:JRadioButton;
	private var nullRadio:JRadioButton;
	private var button:JButton;
	private var pane:Container;
	private var borderChooser:BorderChooser;
	
	private var borderModel:BorderModel;
	
	public function BorderEditor(){
		pane = new JPanel(new FlowLayout(FlowLayout.LEFT, 2, 0, false));
		button = new JButton("Default");
		defaultRadio = new JRadioButton("default");
		nullRadio = new JRadioButton("null");
		pane.appendAll(button, defaultRadio, nullRadio);
		defaultRadio.addActionListener(__default);
		nullRadio.addActionListener(__null);
		defaultRadio.setSelected(true);
		button.addActionListener(__showChooser);
		borderChooser = new BorderChooser();
	}
	
	private function __showChooser(e:Event):void{
		borderChooser.open(__choosed, (borderModel===DEFAULT ? null : borderModel));
	}
	private function __choosed(m:BorderModel):void{
		if(m){
			borderModel = m;
			applyProperty();
			updateRepresents();
		}
	}
	
	private function __default(e:Event):void{
		borderModel = DEFAULT;
		applyProperty();
		updateRepresents();
	}
	
	private function __null(e:Event):void{
		borderModel = null;
		applyProperty();
		updateRepresents();
	}	
	
	private function updateRepresents():void{
		if(borderModel === DEFAULT){
			defaultRadio.setSelected(true);
			nullRadio.setSelected(false);
			button.setText("Default");
		}else if(borderModel == null){
			defaultRadio.setSelected(false);
			nullRadio.setSelected(true);
			button.setText("null");
		}else{
			defaultRadio.setSelected(false);
			nullRadio.setSelected(false);
			button.setText(borderModel.getName());
		}
	}
	
	public function getDisplay():Component{
		return pane;
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			borderModel = DEFAULT;
		}else if(v.getValue() == null){
			borderModel = null;
		}else{
			borderModel = v as BorderModel;
		}
		updateRepresents();
	}	
	
	override protected function getEditorValue():ValueModel{
		if(borderModel === DEFAULT){
			return ProModel.NONE_VALUE_SET;
		}else if(borderModel != null){
			return borderModel;
		}else{
			return new SimpleValue(null);
		}
	}
}
}