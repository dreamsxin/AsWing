package org.aswing.guibuilder{

import flash.display.DisplayObject;
import flash.xml.XMLDocument;
import flash.xml.XMLNode;

import org.aswing.AsWingUtils;
import org.aswing.JOptionPane;
import org.aswing.ListModel;
import org.aswing.LookAndFeel;
import org.aswing.UIManager;
import org.aswing.VectorListModel;
import org.aswing.guibuilder.util.LibLoader;
import org.aswing.guibuilder.util.TextLoader;
import org.aswing.util.Reflection;	

/**
 * LookAndFeel Manager.
 * @author iiley
 */
public class LookAndFeelManager{
	
	private var lafs:VectorListModel;
	private var xml:XMLDocument;
	private var loadHandler:Function;
	
	private static var ins:LookAndFeelManager;
	
	public static function getIns():LookAndFeelManager{
		if(ins == null){
			new LookAndFeelManager();
		}
		return ins;
	}
	
	public function LookAndFeelManager(){
		if(ins){
			throw new Error("Sington Error!");
		}
		ins = this;
		lafs = new VectorListModel();
	}
	
	/**
	 * hander()
	 */
	public function load(handler:Function):void{
		loadHandler = handler;
		lafs.clear();
		new TextLoader("laf.xml", __loaded).execute();
	}
	
	private function __loaded(data:String):void{
		if(data != null){
			xml = new XMLDocument();
			xml.ignoreWhite = true;
			xml.parseXML(data);
			
			for(var node:XMLNode = xml.firstChild.firstChild; node!=null; node=node.nextSibling){
				var info:LookAndFeelInfo = new LookAndFeelInfo(
					node.attributes["name"], node.attributes["clazz"], node.attributes["path"]
				);
				lafs.append(info);
			}
			
			var skinBuilderPath:String = xml.firstChild.attributes["skinBuilder"];
			if(skinBuilderPath != null){
				new LibLoader(skinBuilderPath, __skinBuilderLoaded).execute();
			}else{
				loadLookAndFeels();
			}
		}else{
			loadHandler();
			JOptionPane.showMessageDialog("Error", "Can't loaded laf.xml!");
		}
	}
	
	private function __skinBuilderLoaded(content:DisplayObject):void{
		if(content != null){
			loadLookAndFeels();
		}else{
			loadHandler();
			JOptionPane.showMessageDialog("Error", "Can't loaded " + xml.firstChild.attributes["skinBuilder"]);
		}
	}
	
	private var index:int;
	private function loadLookAndFeels():void{
		index = -1;
		loadNext();
	}
	
	private function loadNext():void{
		index++;
		if(index >= lafs.size()){
			loadHandler();
		}else{
			var info:LookAndFeelInfo = lafs.get(index) as LookAndFeelInfo;
			if(info.getPath() != null){
				new LibLoader(info.getPath(), __libLoaded).execute();
			}else{
				loadNext();
			}
		}
	}
	
	private function __libLoaded(content:DisplayObject):void{
		if(content == null){
			var info:LookAndFeelInfo = lafs.get(index) as LookAndFeelInfo;
			JOptionPane.showMessageDialog("Error", "Can't loaded " + info.getPath());
			lafs.removeAt(index);
			index--;
		}
		loadNext();
	}
	
	public function getLookAndFeels():ListModel{
		return lafs;
	}
	
	public function setLookAndFeel(info:LookAndFeelInfo):void{
		var laf:LookAndFeel = Reflection.createInstance(info.getClazz());
		if(laf != null){
			UIManager.setLookAndFeel(laf);
			AsWingUtils.updateAllComponentUIInMemory();
		}else{
			JOptionPane.showMessageDialog("Error", "Can't create " + info.getClazz());
		}
	}
}
}