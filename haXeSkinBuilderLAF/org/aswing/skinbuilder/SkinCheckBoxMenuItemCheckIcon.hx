/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;

	
import org.aswing.graphics.Graphics2D;

class SkinCheckBoxMenuItemCheckIcon extends SinglePicIcon{
	override private function getDefaltsKey():String{
		return "CheckBoxMenuItem.checkIconImage";
	}	
	
	override public function updateIcon(c:Component, g:Graphics2D, x:Int, y:Int):Void{
		super.updateIcon(c, g, x, y);
		if(image!=null)	{
			image.visible = flash.Lib.as(c,AbstractButton).isSelected();
		}
	}	
}