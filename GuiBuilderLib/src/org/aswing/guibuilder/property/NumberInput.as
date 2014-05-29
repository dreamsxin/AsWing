package org.aswing.guibuilder.property{

import org.aswing.event.AWEvent;
import org.aswing.event.FocusKeyEvent;
import org.aswing.guibuilder.util.MathUtils;
import flash.ui.Keyboard;
import flash.events.MouseEvent;

public class NumberInput extends LabelInput{
	
	private var min:Number;
	private var max:Number;
	private var unit:Number;
	
	public function NumberInput(labelText:String="", inputText:String="", gap:int=2, column:int=0, editable:Boolean=true){
		super(labelText, inputText, gap, column, editable);
		setInputType(LabelInput.FLOAT);
		input.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __intKeyDown);
		input.addEventListener(MouseEvent.MOUSE_WHEEL, __intMouseWheel);
		min = Number.MIN_VALUE;
		max = Number.MAX_VALUE;
		unit = 1;
	}
	
	public function setMinMax(min:Number, max:Number):void{
		this.min = min;
		this.max = max;
		unit = (max-min)/100;
	}
		
	private function __intMouseWheel(e:MouseEvent):void{
		var value:Number = getInputNumber() + e.delta*unit;
		if(value > max) value = max;
		if(value < min) value = min;
		setInputText(value+"");
		dispatchEvent(new AWEvent(AWEvent.ACT));
	}
	
	private function __intKeyDown(e:FocusKeyEvent):void{
		var value:Number = getInputNumber();
		var code:uint = e.keyCode;
		var enableKey:Boolean = false;
		if(code == Keyboard.UP){
			value += unit;
			enableKey = true;
		}else if(code == Keyboard.DOWN){
			value -= unit;
			enableKey = true;
		}else if(code == Keyboard.PAGE_UP){
			value += unit*10;
			enableKey = true;
		}else if(code == Keyboard.PAGE_DOWN){
			value -= unit*10;
			enableKey = true;
		}
		if(value > max) value = max;
		if(value < min) value = min;
		if(enableKey){
			setInputText(value+"");
			dispatchEvent(new AWEvent(AWEvent.ACT));
		}
	}
}
}