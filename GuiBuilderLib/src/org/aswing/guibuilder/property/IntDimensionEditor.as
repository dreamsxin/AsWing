package org.aswing.guibuilder.property{

import org.aswing.Component;
import org.aswing.JPanel;
import org.aswing.SoftBoxLayout;
import org.aswing.event.AWEvent;
import org.aswing.geom.IntDimension;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

public class IntDimensionEditor extends BasePropertyEditor implements PropertyEditor{
	
	protected var pane:JPanel;
	protected var widthInput:LabelInput;
	protected var heightInput:LabelInput;
	
	public function IntDimensionEditor(){
		pane = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
		widthInput = new IntInput("w:", "", 0, 4);
		heightInput = new IntInput("h:", "", 0, 4);
		pane.appendAll(widthInput, heightInput);
		widthInput.addEventListener(AWEvent.ACT, __handApply);
		heightInput.addEventListener(AWEvent.ACT, __handApply);
	}
	
	protected function __handApply(e:AWEvent):void{
		handApply();
	}
	
	protected function handApply():void{
		__apply(null);
	}
	
	public function getDisplay():Component{
		return pane;
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			widthInput.setInputText("");
			heightInput.setInputText("");
		}else{
			var dim:IntDimension = v.getValue();
			widthInput.setInputText(dim.width+"");
			heightInput.setInputText(dim.height+"");
		}
	}	
	
	override protected function getEditorValue():ValueModel{
		if(widthInput.isEmpty() || heightInput.isEmpty()){
			return ProModel.NONE_VALUE_SET;
		}
		return new SimpleValue(new IntDimension(widthInput.getInputInt(), heightInput.getInputInt()));
	}
}
}