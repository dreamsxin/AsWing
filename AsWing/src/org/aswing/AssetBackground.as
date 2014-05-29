/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import flash.display.DisplayObject;

import org.aswing.border.EmptyBorder;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;

/**
 * A background with specified asset display object.
 * <p>
 * The display object will be added to component to be the backgound, and will 
 * be set <code>width</code> and <code>height</code> property to fit the size 
 * of the component.
 * </p>
 * @author iiley
 */
public class AssetBackground implements GroundDecorator{
	
	protected var asset:DisplayObject;
	protected var ignorBorderMargin:Boolean;
	
	/**
	 * Create a asset background
	 * @param asset the displayobject to be the background
	 * @param ignorBorderMargin if it is set to true, the asset will be full filled in the owner, otherwish it will be push inside the borders(if it has borders)
	 */
	public function AssetBackground(asset:DisplayObject, ignorBorderMargin:Boolean=false){
		this.asset = asset;
		this.ignorBorderMargin = ignorBorderMargin;
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
		if(ignorBorderMargin){
			asset.x = 0;
			asset.y = 0;
			asset.width = c.width;
			asset.height = c.height;	
		}else{
			asset.x = b.x;
			asset.y = b.y;
			asset.width = b.width;
			asset.height = b.height;
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return asset;
	}
}
}