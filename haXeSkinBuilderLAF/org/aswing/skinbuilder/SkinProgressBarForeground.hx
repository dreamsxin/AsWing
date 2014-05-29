/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;

import org.aswing.JProgressBar;
import org.aswing.geom.IntRectangle;
import org.aswing.Insets;
import org.aswing.plaf.ComponentUI;
import flash.display.Sprite;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.AsWingUtils;
import org.aswing.Component;
import org.aswing.GroundDecorator;
import org.aswing.graphics.Graphics2D; 
import flash.display.DisplayObject;
class SkinProgressBarForeground extends DefaultsDecoratorBase   implements GroundDecorator   implements UIResource {

	private var verticalImage:DisplayObject;
	private var horizotalImage:DisplayObject;
	private var imageContainer:Sprite;
	private var fgMargin:Insets;
	private var loaded:Bool;
	private var indeterminatePercent:Float;
	
	public function new(){
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
		imageContainer.mouseChildren = false;
		loaded = false;
		indeterminatePercent = 0;
		super();
	}
	
	private function checkReloadAssets(c:Component):Void{
		if(loaded!=true){
			var ui:ComponentUI = getDefaultsOwner(c);
			verticalImage = flash.Lib.as(ui.getInstance(getPropertyPrefix()+"verticalFGImage") , DisplayObject);
			horizotalImage =flash.Lib.as( ui.getInstance(getPropertyPrefix()+"horizotalFGImage"), DisplayObject);
			fgMargin = ui.getInsets(getPropertyPrefix()+"fgMargin");
			loaded = true;
		}
	}
    	
    private function getPropertyPrefix():String{
        return "ProgressBar.";
    }
	
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):Void{
		checkReloadAssets(com);
		var bar:JProgressBar = flash.Lib.as(com,JProgressBar);
		var image:DisplayObject;
		var removeImage:DisplayObject;
		if(bar.getOrientation() == AsWingConstants.HORIZONTAL){
			image = horizotalImage;
			removeImage = verticalImage;
		}else{
			image = verticalImage;
			removeImage = horizotalImage;
		}

		if(image!=null)	{
			if(!imageContainer.contains(image)){
				imageContainer.addChild(image);
			}
		}
		if(removeImage!=null)	{
			if(imageContainer.contains(removeImage)){
				imageContainer.removeChild(removeImage);
			}
		}
		var percent:Float;
		if(bar.isIndeterminate()){
			percent = indeterminatePercent;
			indeterminatePercent += 0.05;
			if(indeterminatePercent > 1){
				indeterminatePercent = 0;
			}
		}else{
			percent = bar.getPercentComplete();
		}
		var bounds:IntRectangle = bounds.clone();
		if(fgMargin != null){
			if(bar.getOrientation() == AsWingConstants.HORIZONTAL){
				bounds = fgMargin.getInsideBounds(bounds);
			}else{//transfer if vertical
				bounds = new Insets(fgMargin.right, fgMargin.top, fgMargin.left, fgMargin.bottom).getInsideBounds(bounds);
			}
		}
		imageContainer.x = bounds.x;
		imageContainer.y = bounds.y;
		if(image!=null)	{
			if(bar.getOrientation() == AsWingConstants.HORIZONTAL){
				image.width = Math.round(bounds.width * percent);
				image.height = bounds.height;
				image.y = 0;
				image.x = 0;
			}else{
				image.width = bounds.width;
				image.height = Math.round(bounds.height * percent);
				image.y = bounds.height - image.height;
				image.x = 0;
			}
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		checkReloadAssets(c);
		return imageContainer;
	}
	
}