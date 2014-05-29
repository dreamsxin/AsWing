/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;
	import org.aswing.geom.IntRectangle;
	import org.aswing.AbstractButton;
	import org.aswing.ButtonModel;
	import org.aswing.JButton;
	import org.aswing.plaf.UIResource;
	import org.aswing.plaf.DefaultsDecoratorBase;
	import org.aswing.plaf.ComponentUI;
	import org.aswing.Component;
	import org.aswing.skinbuilder.ButtonStateObject;
	import org.aswing.GroundDecorator;
	import org.aswing.graphics.Graphics2D;
	import flash.display.DisplayObject;
 
class SkinButtonBackground extends DefaultsDecoratorBase   implements GroundDecorator   implements UIResource {
	
    private var stateAsset:ButtonStateObject;
    private var setuped:Bool;
    private var fixedPrefix:String;
    
	public function new(fixedPrefix:String=null){
		setuped = false;
		this.fixedPrefix = fixedPrefix;
		stateAsset = new ButtonStateObject();
		super();
	}
	
	public function getStateAsset():ButtonStateObject{
		return stateAsset;
	}
	
    private function getPropertyPrefix():String{
    	if(fixedPrefix != null){
    		return fixedPrefix;
    	}
        return "Button.";
    }
	
	private function setupAssets(ui:ComponentUI):Void{
		stateAsset.setDefaultButtonImage(getAsset(ui, "DefaultButton.defaultImage"));
		stateAsset.setDefaultImage(getAsset(ui, "defaultImage"));
		stateAsset.setPressedImage(getAsset(ui, "pressedImage"));
		stateAsset.setPressedSelectedImage(getAsset(ui, "pressedSelectedImage"));
		stateAsset.setDisabledImage(getAsset(ui, "disabledImage"));
		stateAsset.setSelectedImage(getAsset(ui, "selectedImage"));
		stateAsset.setDisabledSelectedImage(getAsset(ui, "disabledSelectedImage"));
		stateAsset.setRolloverImage(getAsset(ui, "rolloverImage"));
		stateAsset.setRolloverSelectedImage(getAsset(ui, "rolloverSelectedImage"));
	}
	
	private function getAsset(ui:ComponentUI, extName:String):DisplayObject{
        var pp:String= getPropertyPrefix();
        return flash.Lib.as(ui.getInstance(pp+extName) , DisplayObject);
	}
 	
 	public function getDisplay(c:Component):DisplayObject{
 		return stateAsset;
 	}
 	
 	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):Void{
 		if(setuped!=true){
 			setupAssets(getDefaultsOwner(c));
 			setuped = true;
 		}
 		
 		var button:AbstractButton = flash.Lib.as(c,AbstractButton);
 		var model:ButtonModel = button.getModel();
 		stateAsset.setEnabled(model.isEnabled());
 		stateAsset.setPressed(model.isPressed() && model.isArmed());
 		stateAsset.setSelected(model.isSelected());
 		stateAsset.setRollovered(button.isRollOverEnabled() && model.isRollOver());
 		stateAsset.setDefaultButton(Std.is(button,JButton)&&  flash.Lib.as(button,JButton).isDefaultButton());
 		stateAsset.updateRepresent(bounds);
 	}
}