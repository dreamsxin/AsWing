/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import flash.display.DisplayObject;
import flash.display.Sprite;

import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.ComponentUI;
import org.aswing.plaf.DefaultsDecoratorBase;
import org.aswing.plaf.UIResource;

class SkinFrameBackground extends DefaultsDecoratorBase   implements GroundDecorator   implements UIResource {
	
	private var imageContainer:Sprite;
	private var activeBG:DisplayObject;
	private var inactiveBG:DisplayObject;
	
	public function new(){
		imageContainer = AsWingUtils.createSprite(null, "bgContainer");
		super();
	}
	
	private function reloadAssets(ui:ComponentUI):Void{
		activeBG = flash.Lib.as(ui.getInstance("Frame.activeBG") , DisplayObject);
		inactiveBG = flash.Lib.as(ui.getInstance("Frame.inactiveBG"), DisplayObject);
		imageContainer.addChild(activeBG);
		imageContainer.addChild(inactiveBG);
		inactiveBG.visible = false;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):Void{
		if(activeBG == null){
			reloadAssets(getDefaultsOwner(c));
		}
		var frame:JFrame = flash.Lib.as(c,JFrame);
		activeBG.visible = frame.getFrameUI().isPaintActivedFrame();
		inactiveBG.visible = !frame.getFrameUI().isPaintActivedFrame();
		//not use bounds, avoid the border
		activeBG.width = inactiveBG.width = c.width;
		activeBG.height = inactiveBG.height = c.height;
		
		if(c.isOpaque()){
			g.fillRectangle(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height);
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return imageContainer;
	}
	
}