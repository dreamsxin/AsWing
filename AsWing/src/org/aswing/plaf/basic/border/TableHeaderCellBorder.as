/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border{
	
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.geom.Matrix;

import org.aswing.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.plaf.UIResource;

/**
 * @private
 */
public class TableHeaderCellBorder implements Border, UIResource{
	
	protected var shape:Shape;
    
	public function TableHeaderCellBorder(){
		shape = new Shape();
	}
		
	public function updateBorder(c:Component, g:Graphics2D, b:IntRectangle):void{
		b = b.clone();
		b.height -= 4;
		b.y += 2;
		if(c is AbstractButton){
			trace("header AbstractButton");
		}
		if(b.height > 0){
			var cl:ASColor = c.getBackground();
			var dark:ASColor = cl.offsetHLS(0, -0.2, 0);
			var light:ASColor = cl.offsetHLS(0, 0.06, 0);
			shape.graphics.clear();
			g = new Graphics2D(shape.graphics);
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(b.width, b.height, Math.PI/2, b.x, b.y);
			g.fillRectangle(new GradientBrush(
				GradientBrush.LINEAR, 
				[dark.getRGB(), dark.getRGB(), dark.getRGB()], 
				[0, 1, 0], 
				[0, 122, 255], 
				matrix
				), b.x+b.width-2, b.y, 1, b.height);
			g.fillRectangle(new GradientBrush(
				GradientBrush.LINEAR, 
				[light.getRGB(), light.getRGB(), light.getRGB()], 
				[0, 1, 0], 
				[0, 122, 255], 
				matrix
				), b.x+b.width-1, b.y, 1, b.height);
		}
	}
	
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets{
		return new Insets(0, 0, 1, 1);
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
}
}