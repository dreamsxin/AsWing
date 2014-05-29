/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
 	import org.aswing.geom.IntRectangle;
	import org.aswing.EditableComponent;
	import org.aswing.graphics.SolidBrush;
	import org.aswing.Component;
	import org.aswing.error.ImpMissError;
	import org.aswing.plaf.ComponentUI; 
	import org.aswing.plaf.DefaultsDecoratorBase;
	import org.aswing.GroundDecorator;
	import org.aswing.AsWingUtils;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.UIResource;
class SkinAbsEditorBackground extends DefaultsDecoratorBase  implements GroundDecorator  implements UIResource {
	
	private var imageContainer:Sprite;
	private var defaultImage:DisplayObject;
	private var uneditableImage:DisplayObject;
	private var disabledImage:DisplayObject;
	private var lastViewedImage:DisplayObject;
	
	private var loaded:Bool;
	
	public function new(){
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
		imageContainer.mouseChildren = false;
		imageContainer.mouseEnabled = false;
		loaded = false;
		super();
	}
	
	private function getPropertyPrefix():String{
        throw new ImpMissError();
        return null;
    }
	
    private function isEditable(c:Component):Bool{
        var text:EditableComponent = flash.Lib.as(c,EditableComponent);
        return text.isEditable();
    }
    
    private function reloadAssets(ui:ComponentUI):Void{
    	var pp:String= getPropertyPrefix();
    	addImage(defaultImage = flash.Lib.as(ui.getInstance(pp+"defaultImage") , DisplayObject));
    	addImage(uneditableImage = flash.Lib.as(ui.getInstance(pp+"uneditableImage"), DisplayObject));
    	addImage(disabledImage = flash.Lib.as(ui.getInstance(pp+"disabledImage") , DisplayObject));
    	defaultImage.visible = true;
    	lastViewedImage = defaultImage;
    }
    
    private function addImage(image:DisplayObject):Void{
    	if(image!=null)	{
    		image.visible = false;
    		imageContainer.addChild(image);
    	}
    }
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(loaded!=true){
			reloadAssets(getDefaultsOwner(c));
			loaded = true;
		}
		
		var image:DisplayObject = null;
		if(!c.isEnabled()){
			image = disabledImage;
		}else if(!isEditable(c)){
			image = uneditableImage;
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
		
		if(c.isOpaque()){
			g.fillRectangle(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height);
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return imageContainer;
	}
	
}