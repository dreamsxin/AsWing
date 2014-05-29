package org.aswing.guibuilder.property{

import org.aswing.Component;
import org.aswing.JPanel;
import org.aswing.SoftBoxLayout;
import org.aswing.event.AWEvent;
import org.aswing.geom.IntPoint;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;

/**
 * IntPoint editor
 */
public class IntPointEditor extends BasePropertyEditor implements PropertyEditor{
	
	private var pane:JPanel;
	private var xInput:LabelInput;
	private var yInput:LabelInput;
	
	public function IntPointEditor(){
		pane = new JPanel(new SoftBoxLayout(SoftBoxLayout.X_AXIS, 0));
		xInput = new IntInput("x:", "", 0, 4);
		yInput = new IntInput("y:", "", 0, 4);
		pane.appendAll(xInput, yInput);
		xInput.addEventListener(AWEvent.ACT, __handApply);
		yInput.addEventListener(AWEvent.ACT, __handApply);
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
			xInput.setInputText("");
			yInput.setInputText("");
		}else{
			var p:IntPoint = v.getValue();
			xInput.setInputText(p.x+"");
			yInput.setInputText(p.y+"");
		}
	}	
	
	override protected function getEditorValue():ValueModel{
		if(xInput.isEmpty() || yInput.isEmpty()){
			return ProModel.NONE_VALUE_SET;
		}
		return new SimpleValue(new IntPoint(xInput.getInputInt(), yInput.getInputInt()));
	}
}
}