package org.aswing{

import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.*;
import flash.net.URLRequest;
import flash.system.LoaderContext;

import org.aswing.border.EmptyBorder;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;

/**
 * @author iiley (Burstyx Studio)
 */
public class LoadBackground implements GroundDecorator{
	
	protected var loader:Loader;
	protected var asset:DisplayObject;
	protected var ignorBorderMargin:Boolean;
	
	private var _w:Number = -1;
	private var _h:Number = -1;
	
	public function LoadBackground(url:String, ignoreMargin:Boolean, context:LoaderContext=null){
		ignorBorderMargin = ignoreMargin;
		var urlRequest:URLRequest = new URLRequest(url);
		getLoader().load(urlRequest, context);
	}

	public function getLoader():Loader{
		if (loader == null){
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onLoadError);
		}
		return loader;
	}
	
	/**
	 * when the loader init updateUI
	 */
	private function __onComplete(e:Event):void{
		asset = loader.content;
		if(_w >= 0){
			asset.width = _w;
			asset.height = _h;
		}
	}
	private function __onLoadError(e:IOErrorEvent):void{
		//do nothing
		trace(e);
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void{
		if(ignorBorderMargin){
			loader.x = 0;
			loader.y = 0;
			_w = c.width;
			_h = c.height;
		}else{
			loader.x = b.x;
			loader.y = b.y;
			_w = b.width;
			_h = b.height;
		}
		if(asset){
			asset.width = _w;
			asset.height = _h;
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return loader;
	}
}
}