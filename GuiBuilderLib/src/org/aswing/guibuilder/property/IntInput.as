package org.aswing.guibuilder.property{

import org.aswing.event.AWEvent;
import org.aswing.event.FocusKeyEvent;
import org.aswing.guibuilder.util.MathUtils;
import flash.ui.Keyboard;
import flash.events.MouseEvent;	

public class IntInput extends LabelInput{
	
	public function IntInput(labelText:String="", inputText:String="", gap:int=2, column:int=0, editable:Boolean=true){
		super(labelText, inputText, gap, column, editable);
		setInputType(LabelInput.INT);
		input.addEventListener(FocusKeyEvent.FOCUS_KEY_DOWN, __intKeyDown);
		input.addEventListener(MouseEvent.MOUSE_WHEEL, __intMouseWheel);
	}
		
	private function __intMouseWheel(e:MouseEvent):void{
		var value:int = getInputInt() + e.delta;
		setInputText(value+"");
		dispatchEvent(new AWEvent(AWEvent.ACT));
	}
	
	private function __intKeyDown(e:FocusKeyEvent):void{
		var value:int = getInputInt();
		var code:uint = e.keyCode;
		var enableKey:Boolean = false;
		if(code == Keyboard.UP){
			value++;
			enableKey = true;
		}else if(code == Keyboard.DOWN){
			value--;
			enableKey = true;
		}else if(code == Keyboard.PAGE_UP){
			value += 10;
			enableKey = true;
		}else if(code == Keyboard.PAGE_DOWN){
			value -= 10;
			enableKey = true;
		}
		if(enableKey){
			setInputText(value+"");
			dispatchEvent(new AWEvent(AWEvent.ACT));
		}
	}
}
}