package{

import flash.display.DisplayObjectContainer;

import org.aswing.JOptionPane;
import org.aswing.guibuilder.Main;
import org.aswing.guibuilder.model.FileModel;

/**
 * For online version.
 * @author iiley
 */
public class OnlineMain extends Main{
		
	public function OnlineMain(owner:DisplayObjectContainer){
		super(owner);
	}
	
	override protected function getAboutWords():String{
		return "Version:1.3.2 online trial\nDate:2008-03-17\nCreated by aswing.org\n \n" 
				+ "For a AIR version, you can open aswing home to download.";
	}

	override protected function save(file:FileModel):void{
		JOptionPane.showMessageDialog("Tip", "The online version is just for trial, \n" + 
				"If you need a full functions one, please download the AIR version.", null, this);
	}
	
	override protected function open():void{
		JOptionPane.showMessageDialog("Tip", "The online version is just for trial, \n" + 
				"If you need a full functions one, please download the AIR version.", null, this);
	}
	
	override protected function loadSetting():void{
	}
	
	override protected function saveSetting():void{
	}	
}
}