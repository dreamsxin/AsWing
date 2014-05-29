/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
import org.aswing.error.ImpMissError;
import org.aswing.AbstractButton;
import org.aswing.Icon;
import org.aswing.ButtonModel;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.skinbuilder.ButtonStateObject;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import flash.display.DisplayObject;
/**
 * Skin button icon.
 * You can use only four states, defaultImage, pressedImage, disabledImage and rolloverImage.
 * additional states will works too(selectedImage, disabledSelectedImage, rolloverSelectedImage) 
 * if they are defined in the assets properties.
 * @author iiley
 */
class SkinButtonIcon extends DefaultsDecoratorBase   implements Icon  implements UIResource {
	
	private var forceWidth:Int;
	private var forceHeight:Int;
 
    private var stateAsset:ButtonStateObject;
    private var fixedPrefix:String;
    private var setuped:Bool;
    
	public function new(forceWidth:Int=-1, forceHeight:Int=-1, fixedPrefix:String=null, owner:Component=null){
			this.forceWidth=-1;
				this.forceHeight=-1;
			this.forceWidth = forceWidth;
		this.forceHeight = forceHeight;
		setuped = false;
		this.fixedPrefix = fixedPrefix;
		if(owner != null){
			setDefaultsOwner(owner.getUI());
		}
		stateAsset = new ButtonStateObject();
		super();
	}
	
	private function getPropertyPrefix():String{
		if(fixedPrefix != null){
			return fixedPrefix;
		}else{
        	throw new ImpMissError();
        	return null;
  		}
    }
	
	private function setupAssets(ui:ComponentUI):Void{
        var pp:String= getPropertyPrefix();
		var defaultImage:DisplayObject  =  flash.Lib.as(ui.getInstance(pp+"defaultImage") , DisplayObject);
		var pressedImage:DisplayObject  =  flash.Lib.as(ui.getInstance(pp+"pressedImage"), DisplayObject);
		var pressedSelectedImage:DisplayObject  =  flash.Lib.as(ui.getInstance(pp+"pressedSelectedImage") , DisplayObject);
		var disabledImage:DisplayObject =  flash.Lib.as(ui.getInstance(pp+"disabledImage") , DisplayObject);
        var selectedImage:DisplayObject         =  flash.Lib.as(ui.getInstance(pp+"selectedImage") , DisplayObject);
        var disabledSelectedImage:DisplayObject =  flash.Lib.as(ui.getInstance(pp+"disabledSelectedImage"), DisplayObject);
        var rolloverImage:DisplayObject         =  flash.Lib.as(ui.getInstance(pp+"rolloverImage") , DisplayObject);
        var rolloverSelectedImage:DisplayObject =  flash.Lib.as(ui.getInstance(pp+"rolloverSelectedImage") , DisplayObject);
        
        stateAsset.setDefaultImage(defaultImage);
        stateAsset.setPressedImage(pressedImage);
        stateAsset.setPressedSelectedImage(pressedSelectedImage);
        stateAsset.setDisabledImage(disabledImage);
        stateAsset.setSelectedImage(selectedImage);
        stateAsset.setDisabledSelectedImage(disabledSelectedImage);
        stateAsset.setRolloverImage(rolloverImage);
        stateAsset.setRolloverSelectedImage(rolloverSelectedImage);
	}
	
	public function checkSetup(c:Component):Void{
		if(setuped!=true){
			setupAssets(getDefaultsOwner(c));
			setuped = true;
		}		
	}
 	
 	public function getDisplay(c:Component):DisplayObject{
 		checkSetup(c);
 		return stateAsset;
 	}
 	
	public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		checkSetup(c);
		var button:AbstractButton =flash.Lib.as(c, AbstractButton);
 		var model:ButtonModel = button.getModel();
 		stateAsset.setEnabled(model.isEnabled());
 		stateAsset.setPressed(model.isPressed() && model.isArmed());
 		stateAsset.setSelected(model.isSelected());
 		stateAsset.setRollovered(button.isRollOverEnabled() && model.isRollOver());
		stateAsset.x = x;
		stateAsset.y = y;
		stateAsset.updateRepresent();
 	}
	
	public function getIconHeight(c:Component):Int{
 		checkSetup(c);
		if(forceHeight >= 0){
			return forceHeight;
		}else{
			return Std.int(stateAsset.height);
		}
	}
	
	public function getIconWidth(c:Component):Int{
 		checkSetup(c);
		if(forceWidth >= 0){
			return forceWidth;
		}else{
			return Std.int(stateAsset.width);
		}
	}
	
}