package cases{

import flash.display.*;
import flash.events.*;
import org.aswing.*;
import org.aswing.border.*;
import flash.net.URLRequest;

public class LoadPane extends Sprite
{
	private var pane:JPanel;
	private var loadPane:JLoadPane;
	private var unloadButton:JButton;
	private var loadButton:JButton;
	public function LoadPane(){
		pane = new JPanel(new BorderLayout());
		loadPane = new JLoadPane("../res/princess.jpg");
		loadPane.setScaleMode(AssetPane.SCALE_FIT_PANE);
		loadPane.setBorder(new LineBorder(null,ASColor.GREEN));
		loadPane.addEventListener(IOErrorEvent.IO_ERROR, __onIOError);
		loadPane.addEventListener(Event.INIT, __onLoadInnit);
		loadPane.setVerticalAlignment(AssetPane.CENTER);
		pane.append(loadPane, BorderLayout.CENTER);
		
		unloadButton = new JButton("unload");
		loadButton = new JButton("load");
		unloadButton.addEventListener(MouseEvent.CLICK, __unloadButton);
		loadButton.addEventListener(MouseEvent.CLICK, __loadButton);
		var newpane:JPanel = new JPanel();
		newpane.append(unloadButton);
		newpane.append(loadButton);
		
		pane.append(newpane, BorderLayout.SOUTH);
		pane.setSizeWH(100,400);
		this.addChild(pane);
		pane.validate();
	}
	
	private function __unloadButton(e:MouseEvent):void{
		loadPane.unloadAsset();
	}
	
	private function __loadButton(e:Event):void{
		loadPane.load(new URLRequest( "../res/princess.jpg" ));
	}
	
	private function __onIOError(e:Event):void{
		loadPane.load(new URLRequest("../res/princess.jpg"));
	}
	
	private function __onLoadInnit(e:Event):void{
	}
}
}