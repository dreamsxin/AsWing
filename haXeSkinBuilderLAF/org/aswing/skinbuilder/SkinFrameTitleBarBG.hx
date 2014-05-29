package org.aswing.skinbuilder;

import org.aswing.GroundDecorator;
import flash.display.DisplayObject;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
import org.aswing.Component;

/**
 * blank bg.
 */
class SkinFrameTitleBarBG implements GroundDecorator   implements UIResource {
	public function new()
		{
	 
	}

	public function getDisplay(c:Component):DisplayObject
	{
		return null;
	}
	
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):Void{
	}
	
}