package org.aswing.guibuilder.property{

import flash.events.Event;

import org.aswing.*;
import org.aswing.guibuilder.FontChooser;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class FontEditor extends BasePropertyEditor implements PropertyEditor{
	
	private static var DEFAULT:ASFont = new ASFont();
	
	private var defaultRadio:JRadioButton;
	private var nullRadio:JRadioButton;
	private var button:JButton;
	private var pane:Container;
	private var font:ASFont;
	private var buttonFont:ASFont;
	
	public function FontEditor(){
		pane = new JPanel(new FlowLayout(FlowLayout.LEFT, 2, 0, false));
		button = new JButton("Default");
		buttonFont = button.getFont();
		defaultRadio = new JRadioButton("default");
		nullRadio = new JRadioButton("null");
		pane.appendAll(button, defaultRadio, nullRadio);
		defaultRadio.addActionListener(__default);
		nullRadio.addActionListener(__null);
		defaultRadio.setSelected(true);
		button.addActionListener(__showChooser);
	}
	
	private function __showChooser(e:Event):void{
		FontChooser.getIns().open(__choosed, font);
	}
	private function __choosed(f:ASFont):void{
		if(f){
			nullRadio.setSelected(false);
			defaultRadio.setSelected(false);
			font = f;
			applyProperty();
		}
	}
	
	private function __default(e:Event):void{
		nullRadio.setSelected(false);
		font = DEFAULT;
		applyProperty();
	}
	
	private function __null(e:Event):void{
		defaultRadio.setSelected(false);
		font = null;
		applyProperty();
	}	
	
	public function getDisplay():Component{
		return pane;
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			font = DEFAULT;
		}else{
			font = v.getValue();
		}
		updateRepresents();
	}
	
	private function updateRepresents():void{
		if(font === DEFAULT){
			nullRadio.setSelected(false);	
			defaultRadio.setSelected(true);
			button.setText("Default");
			button.setToolTipText("The default font value of this component");
		}else if(font == null){
			nullRadio.setSelected(true);
			defaultRadio.setSelected(false);
			button.setText("null");
			button.setToolTipText("null font, means it will use parent font.");
		}else{
			nullRadio.setSelected(false);
			defaultRadio.setSelected(false);
			button.setText(font.getName());
			button.setToolTipText(
				"Name: "+font.getName() 
				+ "\nSize: "+font.getSize()
				+ "\nBold: "+font.isBold()
				+ "\nItalic: "+font.isItalic()
				+ "\nUnderline: "+font.isUnderline()
				+ "\nEmbeded: "+font.isEmbedFonts());
		}
	}
	
	override protected function getEditorValue():ValueModel{
		if(font === DEFAULT){
			return ProModel.NONE_VALUE_SET;
		}else{
			return new SimpleValue(font);
		}
	}
	
	override public function applyProperty():void{
		super.applyProperty();
		updateRepresents();
	}
}
}