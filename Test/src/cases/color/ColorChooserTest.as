

package cases.color
{
import flash.display.Sprite;

import org.aswing.*;
import org.aswing.geom.*;
import flash.events.Event;

public class ColorChooserTest extends Sprite
{

	
	private var infoText:JTextArea;
	private var chooserDialog:JFrame;
	
	public function ColorChooserTest(){
		super();
		var frame:JFrame = new JFrame(this, "Choose color");
		frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);		
		frame.getContentPane().setLayout(new BorderLayout());	
			
		var button:JButton = new JButton("Choose Color");
		button.addActionListener(__openColorChooserDialog);
		
		frame.getContentPane().append(button, BorderLayout.NORTH);
		
		infoText = new JTextArea();
		frame.getContentPane().append(new JScrollPane(infoText), BorderLayout.CENTER);
		
		chooserDialog = JColorChooser.createDialog(new JColorChooser(), frame, "Chooser a color to test", 
			false, __colorSelected, 
			__colorCanceled);
		//center it
		var location:IntPoint = AsWingUtils.getScreenCenterPosition();
		location.x -= chooserDialog.getWidth()/2;
		location.y -= chooserDialog.getHeight()/2;
		chooserDialog.setLocation(location);
		
		frame.setLocationXY(0, 0);
		frame.setSizeWH(400,400);
		frame.show();
	}
	
	private function __openColorChooserDialog(e:Event):void{
		chooserDialog.show();
	}
	
	private function __colorSelected(color:ASColor):void{
		infoText.appendText("Selected Color : " + color + "\n");
	}
	private function __colorCanceled():void{
		infoText.appendText("Selecting canceled!\n");
	}	
	
}
}