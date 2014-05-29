/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
import org.aswing.Icon;
import org.aswing.geom.IntRectangle;
import org.aswing.Orientable;
import org.aswing.Component;
import org.aswing.error.ImpMissError;
import org.aswing.plaf.ComponentUI; 
import org.aswing.AWSprite;
import flash.events.MouseEvent;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.skinbuilder.ButtonStateObject;
import org.aswing.GroundDecorator;
import org.aswing.geom.IntDimension;
import flash.events.Event;
import flash.display.DisplayObject;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
import org.aswing.event.ReleaseEvent;
class OrientableThumb extends DefaultsDecoratorBase  implements GroundDecorator  implements Icon  implements UIResource{
	
    private var thumb:AWSprite;
    private var verticalContainer:ButtonStateObject;
    private var horizontalContainer:ButtonStateObject;
    
    private var verticalDefaultImage:DisplayObject;
    private var verticalPressedImage:DisplayObject;
    private var verticalDisabledImage:DisplayObject;
    private var verticalRolloverImage:DisplayObject;
    
    private var horizontalDefaultImage:DisplayObject;
    private var horizontalPressedImage:DisplayObject;
    private var horizontalDisabledImage:DisplayObject;
    private var horizontalRolloverImage:DisplayObject;
    
    
    private var verticalIcon:ButtonStateObject;
    private var horizontalIcon:ButtonStateObject;
    
    private var size:IntDimension;
    private var verticle:Bool;
    
    private var enabled:Bool;
	private var rollover:Bool;
	private var pressed:Bool;
	
	private var origWidth:Int;
	private var origHeight:Int;
	
	public function new(){
		thumb = new AWSprite();
		thumb.tabEnabled = false;
		rollover = false;
		pressed = false;
		enabled = true;
		verticle = false;
		initSelfHandlers();
		super();
	}
		
	private function checkReloadAssets(c:Component):Void{
		if(verticalContainer!=null)	{
			return;
		}
		verticalContainer = new ButtonStateObject();
		horizontalContainer = new ButtonStateObject();
		var ui:ComponentUI = getDefaultsOwner(c);
		verticalContainer.setDefaultImage(getAsset(ui, "thumbVertical.defaultImage"));
		verticalContainer.setPressedImage(getAsset(ui, "thumbVertical.pressedImage"));
		verticalContainer.setDisabledImage(getAsset(ui, "thumbVertical.disabledImage"));
		verticalContainer.setRolloverImage(getAsset(ui, "thumbVertical.rolloverImage"));
		verticalIcon = new ButtonStateObject();
		verticalIcon.mouseChildren = false;
		verticalIcon.setDefaultImage(getAsset(ui, "thumbVertical.iconImage"));
		verticalIcon.setPressedImage(getAsset(ui, "thumbVertical.iconPressedImage"));
		verticalIcon.setDisabledImage(getAsset(ui, "thumbVertical.iconDisabledImage"));
		verticalIcon.setRolloverImage(getAsset(ui, "thumbVertical.iconRolloverImage"));
		
		var defaultHori:DisplayObject = getAsset(ui, "thumbHorizontal.defaultImage");
		origWidth = Std.int(defaultHori.width);
		origHeight =Std.int( defaultHori.height);
		horizontalContainer.setDefaultImage(defaultHori);
		horizontalContainer.setPressedImage(getAsset(ui, "thumbHorizontal.pressedImage"));
		horizontalContainer.setDisabledImage(getAsset(ui, "thumbHorizontal.disabledImage"));
		horizontalContainer.setRolloverImage(getAsset(ui, "thumbHorizontal.rolloverImage"));
		horizontalIcon = new ButtonStateObject();
		horizontalIcon.mouseChildren = false;
		horizontalIcon.setDefaultImage(getAsset(ui, "thumbHorizontal.iconImage"));
		horizontalIcon.setPressedImage(getAsset(ui, "thumbHorizontal.iconPressedImage"));
		horizontalIcon.setDisabledImage(getAsset(ui, "thumbHorizontal.iconDisabledImage"));
		horizontalIcon.setRolloverImage(getAsset(ui, "thumbHorizontal.iconRolloverImage"));
		
		thumb.mouseEnabled = c.isEnabled();
	}
	
	
    private function getAsset(ui:ComponentUI, exName:String):DisplayObject {
        return flash.Lib.as( ui.getInstance(getPropertyPrefix()+exName) , DisplayObject);
    }
    
    private function getPropertyPrefix():String{
    	throw new ImpMissError();
    	return null;
    }
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
		checkReloadAssets(c);
		thumb.x = bounds.x;
		thumb.y = bounds.y;
		size = bounds.getSize();
		var sb:Orientable = flash.Lib.as(c,Orientable);
		enabled = c.isEnabled();
		verticle = (sb.getOrientation() == AsWingConstants.VERTICAL);
		paint();
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		checkReloadAssets(c);
		thumb.x = x;
		thumb.y = y;
		size = null;
		var sb:Orientable = flash.Lib.as(c,Orientable);
		enabled = c.isEnabled();
		verticle = (sb.getOrientation() == AsWingConstants.VERTICAL);
		paint();
	}
	
	public function getIconHeight(c:Component):Int{
		checkReloadAssets(c);
		return verticle ? origWidth : origHeight;
	}
	
	public function getIconWidth(c:Component):Int{
		checkReloadAssets(c);
		return verticle ? origHeight : origWidth;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		checkReloadAssets(c);
		return thumb;
	}
	
	private function paint():Void{
		if(verticle)	{
			if(!thumb.contains(verticalContainer)){
				thumb.addChild(verticalContainer);
			}
			if(thumb.contains(horizontalContainer)){
				thumb.removeChild(horizontalContainer);
			}
			verticalContainer.setEnabled(enabled);
			verticalContainer.setPressed(pressed);
			verticalContainer.setRollovered(rollover);
			verticalContainer.updateRepresent(size != null ? size.getBounds() : null);
		}else{
			if(!thumb.contains(horizontalContainer)){
				thumb.addChild(horizontalContainer);
			}
			if(thumb.contains(verticalContainer)){
				thumb.removeChild(verticalContainer);
			}
			horizontalContainer.setEnabled(enabled);
			horizontalContainer.setPressed(pressed);
			horizontalContainer.setRollovered(rollover);
			horizontalContainer.updateRepresent(size != null ? size.getBounds() : null);
		}
		if(size!=null)	{
			var curIcon:ButtonStateObject = verticle ? verticalIcon : horizontalIcon;
			if(lastIcon != curIcon){
				if(lastIcon!=null)	{
					thumb.removeChild(lastIcon);
				}
				lastIcon = curIcon;
				if(curIcon!=null)	{
					thumb.addChild(curIcon);
				}
			}
			if(curIcon!=null)	{
				curIcon.setEnabled(enabled);
				curIcon.setPressed(pressed);
				curIcon.setRollovered(rollover);
				curIcon.updateRepresent();
				if(size.width >= curIcon.width && size.height >= curIcon.height){
					curIcon.x = Math.round((size.width - curIcon.width)/2);
					curIcon.y = Math.round((size.height - curIcon.height)/2);
				}else{
					if(lastIcon!=null)	{
						thumb.removeChild(lastIcon);
						lastIcon = null;
					}
				}
			}
		}
		thumb.mouseEnabled = enabled;
	}
	private var lastIcon:DisplayObject;

	private function initSelfHandlers():Void{
		thumb.addEventListener(MouseEvent.ROLL_OUT, __rollOutListener);
		thumb.addEventListener(MouseEvent.ROLL_OVER, __rollOverListener);
		thumb.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDownListener);
		thumb.addEventListener(ReleaseEvent.RELEASE, __mouseUpListener);
	}
	
	private function __rollOverListener(e:Event):Void{
		rollover = true;
		paint();
	}
	private function __rollOutListener(e:Event):Void{
		rollover = false;
		if(pressed!=true){
			paint();
		}
	}
	private function __mouseDownListener(e:Event):Void{
		pressed = true;
		paint();
	}
	private function __mouseUpListener(e:Event):Void{
		if(pressed)	{
			pressed = false;
			paint();
		}
	}
}