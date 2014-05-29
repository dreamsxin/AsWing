package {

import flash.display.Sprite;
import flash.events.Event;
import flash.ui.ContextMenu;

import org.aswing.AsWingManager;
import org.aswing.JFrame;
import org.aswing.JOptionPane;
import org.aswing.guibuilder.*;

[SWF (width="1200", height="700", backgroundColor="0x000000")]
public class GuiBuilder extends Sprite{
	
	private var main:Main;
	private var loadingFrame:JFrame;
	
	public function GuiBuilder(){
		AsWingManager.initAsStandard(this);
		
		loadingFrame = JOptionPane.showMessageDialog(
			"Initing", 
			"Loading LAFs, please wait...").getFrame();
		loadingFrame.setClosable(false);
		
		LookAndFeelManager.getIns().load(__lafLoaded);
	}
	
	private function __lafLoaded():void{
		loadingFrame.dispose();
		loadingFrame = null;
		start();
	}
	
	private function start():void{
		main = new AirMain(this);
		main.show();
		
		stage.addEventListener(Event.RESIZE, __stageResized);
		__stageResized(null);
	}
		
	private function __stageResized(e:Event):void{
		main.setSizeWH(stage.stageWidth, stage.stageHeight);
	}
}
}
