package{

import flash.display.Sprite;
import flash.events.Event;
import flash.ui.ContextMenu;

import org.aswing.AsWingManager;
import org.aswing.JFrame;
import org.aswing.JOptionPane;
import org.aswing.guibuilder.*;

/**
 * GuiBuilder online version.
 * @author iiley
 */
public class GuiBuilderOnline extends Sprite{

	private var main:Main;
	private var loadingFrame:JFrame;
	
	public function GuiBuilderOnline(){
		stage.showDefaultContextMenu = true;
		contextMenu = new ContextMenu();
		contextMenu.hideBuiltInItems();
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
		main = new OnlineMain(this);
		main.show();
		
		stage.addEventListener(Event.RESIZE, __stageResized);
		__stageResized(null);
	}
		
	private function __stageResized(e:Event):void{
		main.setSizeWH(stage.stageWidth, stage.stageHeight);
	}
}
}