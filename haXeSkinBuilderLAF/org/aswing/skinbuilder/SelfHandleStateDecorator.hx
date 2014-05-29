/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
import org.aswing.Icon;
import org.aswing.geom.IntRectangle;
import flash.display.Stage;
import org.aswing.Component;
import org.aswing.error.ImpMissError;
import org.aswing.plaf.ComponentUI; 
import flash.events.MouseEvent;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.skinbuilder.ButtonStateObject;
import org.aswing.GroundDecorator;
import org.aswing.geom.IntDimension;
import flash.events.Event;
import flash.display.DisplayObject;
import org.aswing.graphics.Graphics2D;
import org.aswing.plaf.UIResource;
class SelfHandleStateDecorator extends DefaultsDecoratorBase   implements GroundDecorator   implements Icon  implements UIResource{
	
    private var thumb:ButtonStateObject;
    
    private var defaultImage:DisplayObject;
    private var pressedImage:DisplayObject;
    private var disabledImage:DisplayObject;
    private var rolloverImage:DisplayObject;
    
    private var size:IntDimension;
    
    private var enabled:Bool;
	private var rollover:Bool;
	private var pressed:Bool;
	
	private var origWidth:Int;
	private var origHeight:Int;
	
	private var loaded:Bool;
	
	public function new(){
		thumb = new ButtonStateObject();
		rollover = false;
		pressed = false;
		enabled = true;
		loaded = false;
		initSelfHandlers();
		super();
	}
	
	private function checkReloadAssets(c:Component):Void{
		if(loaded)	{
			return;
		}
		loaded = true;
		var ui:ComponentUI = getDefaultsOwner(c);
		var defaultImage:DisplayObject = getAsset(ui, "defaultImage");
		origWidth =Std.int( defaultImage.width);
		origHeight = Std.int(defaultImage.height);
		thumb.setDefaultImage(defaultImage);
		thumb.setPressedImage(getAsset(ui, "pressedImage"));
		thumb.setDisabledImage(getAsset(ui, "disabledImage"));
		thumb.setRolloverImage(getAsset(ui, "rolloverImage"));
		thumb.mouseEnabled = c.isEnabled();
	}
	
	
    private function getAsset(ui:ComponentUI, exName:String):DisplayObject {
        return flash.Lib.as(ui.getInstance(getPropertyPrefix()+exName), DisplayObject);
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
		enabled = c.isEnabled();
		paint();
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		checkReloadAssets(c);
		thumb.x = x;
		thumb.y = y;
		size = null;
		enabled = c.isEnabled();
		paint();
	}
	
	public function getIconHeight(c:Component):Int{
		checkReloadAssets(c);
		return origHeight;
	}
	
	public function getIconWidth(c:Component):Int{
		checkReloadAssets(c);
		return origWidth;
	}
	
	public function getDisplay(c:Component):DisplayObject{
		checkReloadAssets(c);
		return thumb;
	}
	
	private function paint():Void{
		thumb.mouseEnabled = enabled;
		thumb.setEnabled(enabled);
		thumb.setPressed(pressed);
		thumb.setRollovered(rollover);
		thumb.updateRepresent(size != null ? size.getBounds() : null);
	}

	private function initSelfHandlers():Void{
		thumb.addEventListener(MouseEvent.ROLL_OUT, __rollOutListener);
		thumb.addEventListener(MouseEvent.ROLL_OVER, __rollOverListener);
		thumb.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDownListener);
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
		if(thumb.stage!=null)	{
			thumb.stage.addEventListener(MouseEvent.MOUSE_UP, __mouseUpListener, false, 0, true);
		}
	}
	private function __mouseUpListener(e:Event):Void{
		if(pressed)	{
			pressed = false;
			paint();
		}
		var st:Stage = flash.Lib.as(e.currentTarget,Stage)	;
		st.removeEventListener(MouseEvent.MOUSE_UP, __mouseUpListener);
	}
	
}