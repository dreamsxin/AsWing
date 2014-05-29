package org.aswing.guibuilder.property{

import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.BorderLayout;
import org.aswing.JLabel;
import org.aswing.JTextField;
import org.aswing.Border;
import org.aswing.border.EmptyBorder;
import flash.events.Event;
import org.aswing.event.AWEvent;
import org.aswing.guibuilder.util.MathUtils;

/**
 * Dispatched when the user input ENTER in the textfield.
 * @eventType org.aswing.event.AWEvent.ACT
 * @see org.aswing.JTextField#addActionListener()
 */
[Event(name="act", type="org.aswing.event.AWEvent")]

public class LabelInput extends JPanel{
	
	public static const INT:int = 0;
	public static const FLOAT:int = 0;
	public static const STRING:int = 0;
	
	protected var label:JLabel;
	protected var input:JTextField;
	
	public function LabelInput(labelText:String="", inputText:String="", gap:int=2
		, column:int=0, editable:Boolean=true){
		super(new BorderLayout(gap, 0));
		label = new JLabel(labelText);
		input = new JTextField(inputText, column);
		input.setMaxChars(32);
		setEditable(editable);
		append(label, BorderLayout.WEST);
		append(input, BorderLayout.CENTER);
		setInputType(INT);
		
		input.addActionListener(__action);
		input.addEventListener(AWEvent.FOCUS_LOST, __action);
	}
	
	private function __action(e:Event):void{
		dispatchEvent(new AWEvent(AWEvent.ACT));
	}
	
	public function getLabel():JLabel{
		return label;
	}
	
	public function getInput():JTextField{
		return input;
	}
	
	public function setInputType(t:int):void{
		if(t == INT){
			input.setRestrict("-0987654321");
		}else if(t == FLOAT){
			input.setRestrict("-0987654321.E");
		}else{
			input.setRestrict(null);
		}
	}
	
	public function getInputText():String{
		return input.getText();
	}
	
	public function getInputInt():int{
		return MathUtils.parseInteger(input.getText());
	}
	
	public function getInputNumber():Number{
		return MathUtils.parseNumber(input.getText());
	}
	
	public function isEmpty():Boolean{
		return input.getText() == "" || input.getText() == null;
	}
	
	public function setInputText(text:String):void{
		input.setText(text);
	}
	
	public function getLabelText():String{
		return label.getText();
	}
	
	public function setEditable(b:Boolean):void{
		input.setEditable(b);
	}
}
}