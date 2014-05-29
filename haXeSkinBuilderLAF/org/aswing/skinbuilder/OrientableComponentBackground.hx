/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import flash.display.DisplayObject;
import flash.display.Sprite;

import org.aswing.error.ImpMissError;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.plaf.UIResource;

class OrientableComponentBackground extends DefaultsDecoratorBase  implements GroundDecorator  implements UIResource {

	private var verticalImage:DisplayObject;
	private var horizotalImage:DisplayObject;
	private var verticalDisabledImage:DisplayObject;
	private var horizotalDisabledImage:DisplayObject;
	private var lastImage:DisplayObject;
	private var imageContainer:Sprite;
	private var loaded:Bool;
	
	public function new(){
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
		imageContainer.mouseChildren = false;
		loaded = false;
		super();
	}
	
	private function checkReloadAssets(c:Component):Void{
		if(loaded!=true){
			var ui:ComponentUI = getDefaultsOwner(c);
			verticalImage = flash.Lib.as(ui.getInstance(getPropertyPrefix()+"verticalBGImage"), DisplayObject);
			horizotalImage = flash.Lib.as(ui.getInstance(getPropertyPrefix()+"horizotalBGImage") , DisplayObject);
			verticalDisabledImage = flash.Lib.as(ui.getInstance(getPropertyPrefix()+"verticalBGDisabledImage"), DisplayObject);
			horizotalDisabledImage = flash.Lib.as(ui.getInstance(getPropertyPrefix()+"horizotalBGDisabledImage") , DisplayObject);
			//default
			if(horizotalImage!=null)	{
				imageContainer.addChild(horizotalImage);
				lastImage = horizotalImage;
			}
			loaded = true;
		}
	}
    	
    private function getPropertyPrefix():String{
    	throw new ImpMissError();
        return null;
    }
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
		checkReloadAssets(c);
		var bar:Orientable = flash.Lib.as(c,Orientable);
		imageContainer.x = bounds.x;
		imageContainer.y = bounds.y;
		var image:DisplayObject;
		if(bar.getOrientation() == AsWingConstants.HORIZONTAL){
			if((!c.isEnabled()) && horizotalDisabledImage!=null){
				image = horizotalDisabledImage;
			}else{
				image = horizotalImage;
			}
		}else{
			if((!c.isEnabled()) && verticalDisabledImage!=null){
				image = verticalDisabledImage;
			}else{
				image = verticalImage;
			}
		}

		if(image != lastImage){
			if(lastImage!=null)	{
				imageContainer.removeChild(lastImage);
			}
			if(image!=null)	{
				imageContainer.addChild(image);
			}
			lastImage = image;
		}
		if(image!=null)	{
			image.width = bounds.width;
			image.height = bounds.height;
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		checkReloadAssets(c);
		return imageContainer;
	}
	
}