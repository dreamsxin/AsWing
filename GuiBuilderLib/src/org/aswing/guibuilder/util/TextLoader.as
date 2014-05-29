package org.aswing.guibuilder.util{

import flash.net.URLLoader;
import flash.display.Loader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.events.*;
import flash.events.ProgressEvent;	

/**
 * Text Loader
 * @author iiley
 */
public class TextLoader{
	
	private var loader:URLLoader;
	private var url:URLRequest;
	private var loadHandler:Function;
	private var progressHandler:Function;
	
	/**
	 * @param __loadHandler(data:String), null means loaded failed
	 * @param __progressHandler(bytesLoaded:Number, bytesTotal:Number)
	 */
	public function TextLoader(path:String, __loadHandler:Function, __progressHandler:Function=null){
		loader = new URLLoader();
		loader.dataFormat = URLLoaderDataFormat.TEXT;
		url = new URLRequest(path);
		loader.addEventListener(Event.COMPLETE, __complete);
		loader.addEventListener(IOErrorEvent.IO_ERROR, __error);
		loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, __error);
		loader.addEventListener(ProgressEvent.PROGRESS, __progress);
		loadHandler = __loadHandler;
		progressHandler = __progressHandler;
	}
	
	private function __complete(e:Event):void{
		loadHandler(loader.data);
	}
	
	private function __error(e:ErrorEvent):void{
		trace("Load text Error : " + e, this);
		loadHandler(null);
	}
	
	private function __progress(e:ProgressEvent):void{
		if(progressHandler != null){
			progressHandler(e.bytesLoaded, e.bytesTotal);
		}
	}
	
	public function execute():void{
		loader.load(url);
	}
}
}