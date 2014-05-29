/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;

	
import flash.events.MouseEvent;
import org.aswing.plaf.ComponentUI;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.event.ReleaseEvent;
import flash.events.Event;
import flash.display.DisplayObject;	
	
class SkinAbsEditorRolloverEnabledBackground extends SkinAbsEditorBackground{
	
	private var defaultRolloverImage:DisplayObject;
	private var uneditableRolloverImage:DisplayObject;
	private var defaultPressedImage:DisplayObject;
	private var uneditablePressedImage:DisplayObject;
	private var rollover:Bool;
	private var pressed:Bool;
	private var c:Component;
	private var bounds:IntRectangle;
	
	public function new(){
		super();
		rollover = false;
		pressed  = false;
	}
	
	private function __rollover(e:MouseEvent):Void{
		if(checkRemoveListeners()){
			return;
		}
		if(rollover!=true){
			rollover = true;
			updateDecorator(c, null, bounds);
		}
	}
	
	private function __rollout(e:MouseEvent):Void{
		if(checkRemoveListeners()){
			return;
		}
		if(rollover)	{
			rollover = false;
			updateDecorator(c, null, bounds);
		}	
	}
	
	private function __pressed(e:Event):Void{
		if(checkRemoveListeners()){
			return;
		}
		if(pressed!=true){
			pressed = true;
			updateDecorator(c, null, bounds);
		}
	}
	
	private function __released(e:Event):Void{
		if(checkRemoveListeners()){
			return;
		}
		if(pressed)	{
			pressed = false;
			updateDecorator(c, null, bounds);
		}
	}
	
	
	private function checkRemoveListeners():Bool{
		if(!c.contains(imageContainer)){
			c.removeEventListener(MouseEvent.ROLL_OVER, __rollover);
			c.removeEventListener(MouseEvent.ROLL_OUT, __rollout);
			c.removeEventListener(MouseEvent.MOUSE_DOWN, __pressed);
			c.removeEventListener(ReleaseEvent.RELEASE, __released);
			c = null;
			bounds = null;
			return true;
		}
		return false;
	}
    
    override private function reloadAssets(ui:ComponentUI):Void{
    	super.reloadAssets(ui);
    	var pp:String= getPropertyPrefix();
    	addImage(defaultRolloverImage = flash.Lib.as(ui.getInstance(pp+"defaultRolloverImage") , DisplayObject));
    	addImage(uneditableRolloverImage = flash.Lib.as(ui.getInstance(pp+"uneditableRolloverImage") , DisplayObject));
    	addImage(defaultPressedImage = flash.Lib.as(ui.getInstance(pp+"defaultPressedImage") , DisplayObject));
    	addImage(uneditablePressedImage = flash.Lib.as(ui.getInstance(pp+"uneditablePressedImage") , DisplayObject));
    }
	
	override public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
		if(this.c == null){
			c.addEventListener(MouseEvent.ROLL_OVER, __rollover);
			c.addEventListener(MouseEvent.ROLL_OUT, __rollout);
			c.addEventListener(MouseEvent.MOUSE_DOWN, __pressed);
			c.addEventListener(ReleaseEvent.RELEASE, __released);
		}
		this.c = c;
		this.bounds = bounds.clone();
		if(loaded!=true){
			reloadAssets(getDefaultsOwner(c));
			loaded = true;
		}
		
		var image:DisplayObject = null;
		if(!c.isEnabled()){
			image = disabledImage;
		}else if(!isEditable(c)){
			if(pressed && uneditablePressedImage!=null){
				image = uneditablePressedImage;
			}else if(rollover && uneditableRolloverImage!=null){
				image = uneditableRolloverImage;
			}else{
				image = uneditableImage;
			}
		}else{
			if(pressed && defaultPressedImage!=null){
				image = defaultPressedImage;
			}else if(rollover && defaultRolloverImage!=null){
				image = defaultRolloverImage;
			}else{
				image = defaultImage;
			}
		}
		if(image == null) image = defaultImage;
		if(lastViewedImage != image){
			lastViewedImage.visible = false;
			lastViewedImage = image;
			lastViewedImage.visible = true;
		}
		//not use bounds, avoid the border
		lastViewedImage.width = c.width;
		lastViewedImage.height = c.height;
	}	
}