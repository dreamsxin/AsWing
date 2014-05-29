package org.aswing.skinbuilder.orange{

import flash.display.DisplayObject;
import flash.display.Sprite;

import org.aswing.*;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.plaf.UIResource;

public class OrangeSplitPaneDividerBackground extends DefaultsDecoratorBase implements GroundDecorator, UIResource{
	
	protected var verticalImage:DisplayObject;
	protected var horizotalImage:DisplayObject;
	protected var verticalDisabledImage:DisplayObject;
	protected var horizotalDisabledImage:DisplayObject;
	protected var lastImage:DisplayObject;
	protected var imageContainer:Sprite;
	protected var loaded:Boolean;
	
	public function OrangeSplitPaneDividerBackground(owner:Component){
		super();
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
		imageContainer.mouseChildren = false;
		loaded = false;
		setDefaultsOwner(owner.getUI());
	}
	
	protected function checkReloadAssets(c:Component):void{
		if(!loaded){
			var ui:ComponentUI = getDefaultsOwner(c);
			verticalImage = ui.getInstance(getPropertyPrefix()+"verticalBGImage") as DisplayObject;
			horizotalImage = ui.getInstance(getPropertyPrefix()+"horizotalBGImage") as DisplayObject;
			verticalDisabledImage = ui.getInstance(getPropertyPrefix()+"verticalBGDisabledImage") as DisplayObject;
			horizotalDisabledImage = ui.getInstance(getPropertyPrefix()+"horizotalBGDisabledImage") as DisplayObject;
			//default
			if(horizotalImage){
				imageContainer.addChild(horizotalImage);
				lastImage = horizotalImage;
			}
			loaded = true;
		}
	}
    	
    protected function getPropertyPrefix():String {
        return "SplitPane.divider.";
    }
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void{
		checkReloadAssets(c);
		var bar:Orientable = Orientable(c);
		imageContainer.x = bounds.x;
		imageContainer.y = bounds.y;
		var image:DisplayObject;
		if(bar.getOrientation() == AsWingConstants.HORIZONTAL){
			if((!c.isEnabled()) && horizotalDisabledImage){
				image = horizotalDisabledImage;
			}else{
				image = horizotalImage;
			}
		}else{
			if((!c.isEnabled()) && verticalDisabledImage){
				image = verticalDisabledImage;
			}else{
				image = verticalImage;
			}
		}

		if(image != lastImage){
			if(lastImage){
				imageContainer.removeChild(lastImage);
			}
			if(image){
				imageContainer.addChild(image);
			}
			lastImage = image;
		}
		if(image){
			image.x = (bounds.width - image.width)/2;
			image.y = (bounds.height - image.height)/2;
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		checkReloadAssets(c);
		return imageContainer;
	}
	
}
}