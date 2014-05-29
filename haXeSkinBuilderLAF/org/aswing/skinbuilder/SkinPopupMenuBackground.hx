/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder;


class SkinPopupMenuBackground extends SinglePicBackground{
	
	public function new(){
		super();
		avoidBorderMargin = false;
	}
	
	override private function getDefaltsKey():String{
		return "PopupMenu.bgImage";
	}
}