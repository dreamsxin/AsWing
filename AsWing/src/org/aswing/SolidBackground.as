/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import flash.display.DisplayObject;
import flash.display.Shape;

import org.aswing.border.EmptyBorder;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;

/**
 * A background decorator that paint a solid color.
 * @author
 */
public class SolidBackground implements GroundDecorator{
	
	protected var color:ASColor;
	protected var shape:Shape;
	protected var ignorBorderMargin:Boolean;
	
	/**
	 * Create a solid background
	 * @param color the background color
	 * @param ignorBorderMargin if it is set to true, the solid background will be full filled in the owner, otherwish it will be push inside the borders(if it has borders)
	 */
	public function SolidBackground(color:ASColor, ignorBorderMargin:Boolean=false){
		this.color = color;
		this.ignorBorderMargin = ignorBorderMargin;
		shape = new Shape();
	}
	
	/**
	 * Skin a component with this background and margin
	 */
	public function skin(comp:Component, margin:Insets=null):void{
		comp.setBackgroundDecorator(this);
		if(margin){
			comp.setBorder(new EmptyBorder(null, margin));
		}
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void{
		shape.graphics.clear();
		g = new Graphics2D(shape.graphics);
		if(ignorBorderMargin){
			g.fillRectangle(new SolidBrush(color), 0, 0, c.width, c.height);
		}else{
			g.fillRectangle(new SolidBrush(color), b.x, b.y, b.width, b.height);
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return shape;
	}
	
}
}