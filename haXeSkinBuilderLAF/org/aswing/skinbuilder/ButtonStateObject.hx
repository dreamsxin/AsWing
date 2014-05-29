/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import flash.display.Sprite;
import flash.display.DisplayObject;
import org.aswing.geom.IntRectangle;
import flash.errors.Error;
/**
 * A sprite that can view different child with different state set.
 * And scale by setSize().
 * @author paling
 */
class ButtonStateObject extends Sprite{
	
    private var defaultImage:DisplayObject;
    private var pressedImage:DisplayObject;
    private var pressedSelectedImage:DisplayObject;
    private var disabledImage:DisplayObject;
    private var selectedImage:DisplayObject;
    private var disabledSelectedImage:DisplayObject;
    private var rolloverImage:DisplayObject;
    private var rolloverSelectedImage:DisplayObject;
    private var defaultButtonImage:DisplayObject;
    
    private   var enabled:Bool;
    private   var pressed:Bool;
    private   var selected:Bool;
    private   var rollovered:Bool;
    private   var defaultButton:Bool;
    
    private var lastViewedImage:DisplayObject;
    
	public function new(){
		enabled=true;
			pressed=false;
			selected=false;
			rollovered=false;
			defaultButton=false;
			super();
		name = "ButtonStateObject";
		mouseEnabled = false;
		tabEnabled = false;
	}
	
	/**
	 * update the right image to view.
	 * @param r the bounds, null if not need to change the bounds of assets
	 */
	public function updateRepresent(r:IntRectangle=null):Void{
 		var image:DisplayObject = defaultImage;
		var tmpImage:DisplayObject=null;
		if(enabled!=true){
			if(selected && disabledSelectedImage!=null){
				tmpImage = disabledSelectedImage;
			}else{
				tmpImage = disabledImage;
			}
		}else if(pressed)	{
			if(selected && pressedSelectedImage!=null){
				tmpImage = pressedSelectedImage;
			}else{
				tmpImage = pressedImage;
			}
		}else if(rollovered)	{
			if(selected && rolloverSelectedImage!=null){
				tmpImage = rolloverSelectedImage;
			}else{
				tmpImage = rolloverImage;
			}
		}else if(selected)	{
			tmpImage = selectedImage;
		}else if(defaultButton)	{
			tmpImage = defaultButtonImage;
		}
		if(tmpImage != null){
			image = tmpImage;
		}
		if(image != lastViewedImage){
			if(lastViewedImage!=null)	lastViewedImage.visible = false;
			if(image!=null)	image.visible = true;
			lastViewedImage = image;
		}
		if(r != null){
			if(image!=null)	{
				image.width = r.width;
				image.height = r.height;
			}
			this.x = r.x;
			this.y = r.y;
		}
	}
	
	public function setEnabled(b:Bool):Void{
		this.enabled = b;
	}
	
	public function setPressed(b:Bool):Void{
		this.pressed = b;
	}
	
	public function setSelected(b:Bool):Void{
		this.selected = b;
	}
	
	public function setRollovered(b:Bool):Void{
		this.rollovered = b;
	}
	
	public function setDefaultButton(b:Bool):Void{
		this.defaultButton = b;
	}
	
	private function checkAsset(image:DisplayObject):Void{
		if(image != null && contains(image)){
			throw new Error("You are set a already exists asset!");
		}
	}
	
	override public function addChild(child:DisplayObject):DisplayObject{
		if(child != null){
			child.visible = false;
			return super.addChild(child);
		}
		return null;
	}
	
	public function setDefaultButtonImage(image:DisplayObject):Void{
		checkAsset(defaultButtonImage);
		defaultButtonImage = image;
		addChild(image);
	}
	
	public function setDefaultImage(image:DisplayObject):Void{
		checkAsset(defaultImage);
		defaultImage = image;
		addChild(image);
	}
	
	public function setPressedImage(image:DisplayObject):Void{
		checkAsset(pressedImage);
		pressedImage = image;
		addChild(image);
	}
	
	public function setPressedSelectedImage(image:DisplayObject):Void{
		checkAsset(pressedSelectedImage);
		pressedSelectedImage = image;
		addChild(image);
	}
	
	public function setDisabledImage(image:DisplayObject):Void{
		checkAsset(disabledImage);
		disabledImage = image;
		addChild(image);
	}
	
	public function setSelectedImage(image:DisplayObject):Void{
		checkAsset(selectedImage);
		selectedImage = image;
		addChild(image);
	}
	
	public function setDisabledSelectedImage(image:DisplayObject):Void{
		checkAsset(disabledSelectedImage);
		disabledSelectedImage = image;
		addChild(image);
	}
	
	public function setRolloverImage(image:DisplayObject):Void{
		checkAsset(rolloverImage);
		rolloverImage = image;
		addChild(image);
	}
	
	public function setRolloverSelectedImage(image:DisplayObject):Void{
		checkAsset(rolloverSelectedImage);
		rolloverSelectedImage = image;
		addChild(image);
	}
}