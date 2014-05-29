package cases
{

import flash.display.Sprite;
import org.aswing.*;
import org.aswing.event.*;

public class Button extends Sprite
{
	public function Button()
	{
		super();
		var button:JButton = new JButton("A &Button");
		button.setRollOverEnabled(true);
		button.setSize(button.getPreferredSize());
		addChild(button);
		button.addActionListener(__buttonAction);
		button.doubleClickEnabled = true;
	}
	
	private function __buttonAction(e:AWEvent):void{
		trace("button act");
	}
		
}
}