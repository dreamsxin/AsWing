/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import org.aswing.graphics.Graphics2D;
import org.aswing.GroundDecorator;
import org.aswing.geom.IntRectangle;
import org.aswing.Component;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;

class SkinTableHeaderSortableCellBackground extends SelfHandleStateDecorator{
	
	override private function getPropertyPrefix():String{
		return "TableHeader.cell.";
	}
	
}