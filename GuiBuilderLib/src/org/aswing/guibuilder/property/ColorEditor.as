package org.aswing.guibuilder.property{

import flash.events.Event;

import org.aswing.*;
import org.aswing.border.BevelBorder;
import org.aswing.colorchooser.JColorSwatches;
import org.aswing.event.InteractiveEvent;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class ColorEditor extends BasePropertyEditor implements PropertyEditor{
	
	private static var DEFAULT:ASColor = new ASColor();
	
	private var colorButton:JButton;
	private var colorIcon:ColorIcon;
	private var defaultRadio:JRadioButton;
	private var nullRadio:JRadioButton;
	private var pane:Container;
	private var color:ASColor;
	
	private var colorSwatches:JColorSwatches;
	private var colorMixer:JColorChooser;
	private var swatchesWindow:JWindow;
	private var mixerWindow:JFrame;
	private var mixerButton:JButton;
	
	public function ColorEditor(nonull:String=null){
		pane = new JPanel(new FlowLayout(FlowLayout.LEFT, 2, 0, false));
		colorIcon = new ColorIcon();
		colorButton = new JButton(null, colorIcon);
		defaultRadio = new JRadioButton("default");
		nullRadio = new JRadioButton("null");
		pane.appendAll(colorButton, defaultRadio, nullRadio);
		defaultRadio.addActionListener(__default);
		nullRadio.addActionListener(__null);
		colorButton.addActionListener(__chooseColor);
		defaultRadio.setSelected(true);
		if(nonull == "nonull"){
			nullRadio.setVisible(false);
		}
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		defaultRadio.setSelected(noValueSet);
		if(noValueSet){
			color = DEFAULT;
			nullRadio.setSelected(false);
		}else if(v.getValue() == null){
			color = null;
			nullRadio.setSelected(true);
		}else{
			color = v.getValue();
			nullRadio.setSelected(false);
		}
		if(color === DEFAULT){
			colorIcon.setColor(null);
		}else{
			colorIcon.setColor(color);
		}
		colorButton.repaint();
	}	
	
	override protected function getEditorValue():ValueModel{
		if(color === DEFAULT){
			return ProModel.NONE_VALUE_SET;
		}else{
			return new SimpleValue(color);
		}
	}
	
	private var settingColor:Boolean = false;
	private function __chooseColor(e:Event):void{
		checkInitColorChoosers();
		settingColor = true;
		colorSwatches.setSelectedColor(color);
		settingColor = false;
		swatchesWindow.show();
		AsWingUtils.centerLocate(swatchesWindow);
	}
	
	private function __openMixer(e:Event):void{
		colorMixer.setSelectedColor(colorSwatches.getSelectedColor());
		swatchesWindow.dispose();
		mixerWindow.show();
		AsWingUtils.centerLocate(mixerWindow);
	}
	
	private function checkInitColorChoosers():void{
		if(colorSwatches == null){
			mixerButton = new JButton("M");
			colorSwatches = new JColorSwatches();
			colorSwatches.addComponentColorSectionBar(mixerButton);
			colorMixer = new JColorChooser();
			colorMixer.setOpaque(true);
			swatchesWindow = new JWindow(null, true);
			colorSwatches.setBorder(new BevelBorder(null, BevelBorder.RAISED));
			colorSwatches.setOpaque(true);
			swatchesWindow.setContentPane(colorSwatches);
			swatchesWindow.pack();
			
			mixerWindow = new JFrame(null, "Color Mixer", true);
			mixerWindow.setResizable(false);
			mixerWindow.setContentPane(colorMixer);
			mixerWindow.pack();
			
			colorSwatches.addEventListener(InteractiveEvent.STATE_CHANGED, __colorChanged);
			colorMixer.getOkButton().addActionListener(__okMixer);
			colorMixer.getCancelButton().addActionListener(__cancelMixer);
			mixerButton.addActionListener(__openMixer);
		}
	}
	
	private function __okMixer(e:Event):void{
		chooseColor(colorMixer.getSelectedColor());
	}
	private function __cancelMixer(e:Event):void{
		swatchesWindow.dispose();
		mixerWindow.dispose();
	}
	
	private function __colorChanged(e:InteractiveEvent):void{
		if(settingColor) return;
		chooseColor(colorSwatches.getSelectedColor());
	}
	
	private function chooseColor(c:ASColor):void{
		swatchesWindow.dispose();
		mixerWindow.dispose();
		nullRadio.setSelected(false);
		defaultRadio.setSelected(false);
		setColor(c);
	}
	
	private function __default(e:Event):void{
		nullRadio.setSelected(false);
		setColor(DEFAULT);
	}
	
	private function __null(e:Event):void{
		defaultRadio.setSelected(false);
		setColor(null);
	}
	
	public function setColor(c:ASColor):void{
		color = c;
		if(c === DEFAULT || c == null){
			colorIcon.setColor(null);
		}else{
			colorIcon.setColor(color);
		}
		colorButton.repaint();
		applyProperty();
	}
	
	public function getDisplay():Component{
		return pane;
	}
}
}

import org.aswing.Icon;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import flash.display.DisplayObject;
import flash.display.Shape;	

class ColorIcon implements Icon{
	
	private var color:ASColor;
	private var shape:Shape;
	
	public function ColorIcon(){
		color = null;
		shape = new Shape();
	}
	
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
	public function setColor(c:ASColor):void{
		color = c;
	}
	
	public function getIconWidth(c:Component):int{
		return 16;
	}

	public function getIconHeight(c:Component):int{
		return 16;
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void{
		shape.graphics.clear();
		if(color != null){
			g = new Graphics2D(shape.graphics);
			g.fillRectangle(new SolidBrush(color), x, y, 15, 16);
		}
	}
}