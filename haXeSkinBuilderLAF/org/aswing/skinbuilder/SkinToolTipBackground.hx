/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


import org.aswing.AssetBackground;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;

class SkinToolTipBackground extends SinglePicBackground{
	
	public function new(){
		super();
	}
	
	override private function getDefaltsKey():String{
		return "ToolTip.bgImage";
	}
}