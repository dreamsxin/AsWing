package org.aswing.guibuilder.util{

import flash.display.Loader;
import flash.events.*;
import flash.net.URLRequest;
import flash.system.ApplicationDomain;
import flash.system.LoaderContext;

import org.aswing.JOptionPane;	

/**
 * Swf lib loader.
 * @author iiley
 */
public class LibLoader{
	
	private var loader:Loader;
	private var url:URLRequest;
	private var loadHandler:Function;
	private var progressHandler:Function;
	
	/**
	 * @param __loadHandler(data:String), null means loaded failed
	 * @param __progressHandler(bytesLoaded:Number, bytesTotal:Number)
	 */
	public function LibLoader(path:String, __loadHandler:Function, __progressHandler:Function=null){
		loader = new Loader();
		url = new URLRequest(path);
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __complete);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __error);
		loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __error);
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, __progress);
		loadHandler = __loadHandler;
		progressHandler = __progressHandler;
	}
	
	private function __complete(e:Event):void{
		if(loadHandler != null){
			loadHandler(loader.content);
		}else{
			JOptionPane.showMessageDialog("Error", "Can't loaded " + url.url);
		}
	}
	
	private function __error(e:ErrorEvent):void{
		trace("Load text Error : " + e, this);
		if(loadHandler != null){
			loadHandler(null);
		}else{
			JOptionPane.showMessageDialog("Error", "Can't loaded " + url.url);
		}
	}
	
	private function __progress(e:ProgressEvent):void{
		if(progressHandler != null){
			progressHandler(e.bytesLoaded, e.bytesTotal);
		}
	}
	
	public function execute():void{
		loader.load(url, new LoaderContext(false, ApplicationDomain.currentDomain));
	}
	
}
}