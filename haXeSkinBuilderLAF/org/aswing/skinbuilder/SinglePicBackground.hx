/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
	import org.aswing.geom.IntRectangle;
	import org.aswing.error.ImpMissError;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.plaf.UIResource;
	import org.aswing.plaf.DefaultsDecoratorBase;
	import org.aswing.Component;
	import org.aswing.GroundDecorator;
	import org.aswing.graphics.Graphics2D; 
	import flash.display.DisplayObject;
class SinglePicBackground extends DefaultsDecoratorBase  implements GroundDecorator  implements UIResource {
	private var image:DisplayObject;
	private var loaded:Bool;
	private var avoidBorderMargin:Bool;
	
	public function new(){
		loaded = false;
		avoidBorderMargin = true;
		super();
	}
	
	private function getDefaltsKey():String{
		throw new ImpMissError();
		return null;
	}
	
	private function checkLoad(c:Component):Void{
		if(loaded!=true){
			var ui:ComponentUI = getDefaultsOwner(c);
			image = flash.Lib.as(ui.getInstance(getDefaltsKey()), DisplayObject);
			loaded = true;
		}
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
		checkLoad(c);
		if(image!=null)	{
			//not use bounds, avoid border margin
			if(avoidBorderMargin)	{
				image.x = 0;
				image.y = 0;
				image.width = c.width;
				image.height = c.height;
			}else{
				image.x = bounds.x;
				image.y = bounds.y;
				image.width = bounds.width;
				image.height = bounds.height;
			}
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		checkLoad(c);
		return image;
	}
	
}