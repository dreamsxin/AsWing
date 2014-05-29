package cases
{
import flash.display.Sprite;

import org.aswing.*;

public class OptionPane extends Sprite
{
	public function OptionPane(){
		super();
		JOptionPane.showMessageDialog("System", "Input your Name:", __entered);
	}
	
	public static function __entered(r:int):void{
		if(r == JOptionPane.CLOSE){
			JOptionPane.showMessageDialog("Result", "User canceled");
		}else{
			JOptionPane.showMessageDialog("Result", "it is: OK");
		}
	}	
}
}