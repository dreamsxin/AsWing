package{

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.filesystem.File;
import flash.filesystem.FileMode;
import flash.filesystem.FileStream;
import flash.net.FileFilter;

import org.aswing.JOptionPane;
import org.aswing.ListModel;
import org.aswing.guibuilder.*;
import org.aswing.guibuilder.model.FileModel;

public class AirMain extends Main{
	
	private var openFile:File;
	
	public function AirMain(owner:DisplayObjectContainer){
		super(owner);
		
		var file:File = File.applicationDirectory;
		rootPath = file.nativePath+"/";
		workspacePath = rootPath+"workspace/";
		openFile = new File(workspacePath);
		openFile.addEventListener(Event.SELECT, __fileSelected);
		
		addEventListener(Event.ADDED_TO_STAGE, __mainAddedToStage);
	}
	
	private function __mainAddedToStage(e:Event):void{
		stage.nativeWindow.addEventListener(Event.CLOSING, __appClosing);
		loadWorkspacePath();
	}
	
	private function loadWorkspacePath():void{
		var wf:File = new File(rootPath + "workspace.txt");
		if(wf.exists){
			var stream:FileStream = new FileStream();
			stream.open(wf, FileMode.READ);
			var str:String = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			workspacePath = str;
			openFile.nativePath = workspacePath;
		}else{
			JOptionPane.showMessageDialog(
				"Workspace path set", 
				"Workspace path is not set, You need to choose a directory for it.", 
				__doChooseWPD, this, true, null, 
				JOptionPane.OK); 
		}
	}
	
	private var wfd:File;
	private function __doChooseWPD(r:int):void{
		wfd = new File(workspacePath);
		wfd.addEventListener(Event.SELECT, __wpSelected);
		wfd.addEventListener(Event.CANCEL, __wpCanceled);
		wfd.browseForDirectory("Please Select a directory to be the WorkSpace");
	}
	
	private function __wpCanceled(e:Event):void{
		JOptionPane.showMessageDialog("Tip", "Your workspace path is temp default to:\n"+workspacePath, null, this);
	}
	
	private function __wpSelected(e:Event):void{
		var wf:File = wfd;
		workspacePath = wf.nativePath+"/";
		
		var saveFile:File = new File(rootPath + "workspace.txt");
		var stream:FileStream = new FileStream();
		stream.open(saveFile, FileMode.WRITE);
		stream.writeUTFBytes(workspacePath);
		stream.close();
		
		openFile.nativePath = workspacePath;
		JOptionPane.showMessageDialog("Tip", "Your workspace path is set to:\n"+workspacePath, null, this);
	}
	
	private var unsavedFiles:Array;
	private function __appClosing(e:Event):void{
		unsavedFiles = [];
		for(var i:int=0; i<files.size(); i++){
			var f:FileModel = files.get(i);
			if(!f.isSaved()){
				unsavedFiles.push(f);
			}
		}
		if(unsavedFiles.length > 0){
			e.preventDefault();
			JOptionPane.showMessageDialog(
				"Tip", 
				"Some files is not saved, do you need to save them?", 
				__exitAnswered, this, true, null, 
				JOptionPane.YES|JOptionPane.NO|JOptionPane.CANCEL); 
		}
	}
	
	private function __exitAnswered(result:int):void{
		if(result == JOptionPane.YES){
			for each(var f:FileModel in unsavedFiles){
				save(f);
			}
			stage.nativeWindow.close();
		}else if(result == JOptionPane.NO){
			stage.nativeWindow.close();
		}
	}
	
	override protected function getAboutWords():String{
		return "Version:1.4.3\nDate:2011-3-3\nDeveloped by aswing.org";
	}
	
	override protected function checkIsExists(className:String, pkgName:String):Boolean{
		var path:String = getXMLSavePath(className, pkgName);
		var file:File = new File(path);
		if(file.exists){
			cacheClassName = className;
			cachePkgName = pkgName;
			JOptionPane.showMessageDialog(
				"Warnning", 
				"Same name file is already exists! Override it?", 
				__override, this, true, null, 
				JOptionPane.YES|JOptionPane.CANCEL);
			return true;
		}
		return false;
	}
	
	override protected function save(file:FileModel):void{
		var path:String = file.getFilePath();
		if(path == null){
			path = getXMLSavePath(file.getName(), file.getPackageName());
			file.setFilePath(path);
		}
		var saveFile:File = new File(path);
		var xml:XML = file.exportXML();
		
		var stream:FileStream = new FileStream();
		if(!saveFile.exists){
			trace("create new file");
		}
		stream.open(saveFile, FileMode.WRITE);
		stream.writeUTFBytes(xml.toXMLString());
		stream.close();
		file.setSaved(true);
		__fileChanged(file);
	}
	
	override protected function open():void{
		openFile.browseForOpen("Select a UI xml file", [new FileFilter("AsWing UI (*.xml)", "*.xml")]);
	}
	
	private function __fileSelected(e:Event):void{
		trace("__fileSelected : " + openFile.nativePath);
		var stream:FileStream = new FileStream();
		stream.open(openFile, FileMode.READ);
		var str:String = stream.readUTFBytes(stream.bytesAvailable);
		stream.close();
		var xml:XML = new XML(str);
		if(isFileExists(xml.@name, xml.@packageName)){
			JOptionPane.showMessageDialog("Error", "The same name file is already opened!", null, this);
			return;
		}
		var fm:FileModel = FileModel.parseXML(xml);
		fm.setFilePath(openFile.nativePath);
		fm.setSaved(true);
		fm.setChangeHandler(__fileChanged);
		files.append(fm, 0);
		setCurrentFile(files.first());
	}
	
	override protected function loadSetting():void{
		var loadFile:File = new File(rootPath+"option.txt");
		if(loadFile.exists){
			var stream:FileStream = new FileStream();
			stream.open(loadFile, FileMode.READ);
			var str:String = stream.readUTFBytes(stream.bytesAvailable);
			stream.close();
			var xml:XML = new XML(str);
			if(xml.LAF != null){
				var lafName:String = xml.LAF.@name;
				var model:ListModel = toolBarPane.getLAFsCombo().getModel();
				for(var i:int=0; i<model.getSize(); i++){
					var info:LookAndFeelInfo = model.getElementAt(i) as LookAndFeelInfo;
					if(info.getName() == lafName && info.getClazz() != "org.aswing.plaf.basic.BasicLookAndFeel"){
						toolBarPane.getLAFsCombo().setSelectedItem(info);
						return;
					}
				}
			}
		}
	}
	
	override protected function saveSetting():void{
		var saveFile:File = new File(rootPath+"option.txt");
		var xml:XML = <Option></Option>;
		var laf:XML = <LAF></LAF>;
		var lafName:String = "";
		if(toolBarPane.getLAFsCombo().getSelectedItem() != null){
			var info:LookAndFeelInfo = toolBarPane.getLAFsCombo().getSelectedItem() as LookAndFeelInfo;
			lafName = info.getName();
		}
		laf.@name = lafName;
		xml.appendChild(laf)
		
		var stream:FileStream = new FileStream();
		stream.open(saveFile, FileMode.WRITE);
		stream.writeUTFBytes(xml.toXMLString());
		stream.close();
	}	
}
}