package cn.harryxu.tenerLaf{

import flash.filters.DropShadowFilter;

import org.aswing.Component;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.skinbuilder.SinglePicBackground;

public class TenerPopupMenuBackground extends SinglePicBackground{
	
	public function TenerPopupMenuBackground(){
		super();
		avoidBorderMargin = false;
	}
	
	override protected function getDefaltsKey():String{
		return "PopupMenu.bgImage";
	}
	
	override public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void{
		super.updateDecorator(c, g, b);
	}
}
}