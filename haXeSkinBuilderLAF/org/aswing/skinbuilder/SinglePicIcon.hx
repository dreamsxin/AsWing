/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import flash.display.DisplayObject;

import org.aswing.Component;
import org.aswing.Icon;
import org.aswing.error.ImpMissError;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.plaf.UIResource;

class SinglePicIcon extends DefaultsDecoratorBase   implements Icon   implements UIResource {
	
	private var image:DisplayObject;
	private var loaded:Bool;
	
	public function new(){
		loaded = false;
		super();
	}
	
	private function getDefaltsKey():String{
		throw new ImpMissError();
		return null;
	}
	
	private function checkLoad(c:Component):Void{
		if(loaded!=true){
			image = flash.Lib.as(getDefaultsOwner(c).getInstance(getDefaltsKey()), DisplayObject);
			loaded = true;
		}
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		checkLoad(c);
		if(image!=null)	{
			//not use bounds, avoid border margin
			image.x = x;
			image.y = y;
		}
	}
	
	public function getIconHeight(c:Component):Int{
		checkLoad(c);
		return Std.int(image!=null ? image.height : 0);
	}
	
	public function getIconWidth(c:Component):Int{
		checkLoad(c);
		return  Std.int(image!=null ? image.width : 0);
	}
	
	public function getDisplay(c:Component):DisplayObject{
		checkLoad(c);
		return image;
	}
	
}