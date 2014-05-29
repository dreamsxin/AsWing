package org.aswing.skinbuilder.orange
{
import org.aswing.graphics.Graphics2D;
import org.aswing.Icon;
import org.aswing.Component;
import org.aswing.plaf.UIResource;
import flash.display.*;

public class OrangeFrameIcon implements Icon, UIResource
{
	
	public function OrangeFrameIcon(){
		
	}
	
	public function getDisplay(c:Component):DisplayObject
	{
		return null;
	}
	
	public function getIconWidth(c:Component):int
	{
		return 4;
	}
	
	public function getIconHeight(c:Component):int
	{
		return 0;
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void
	{
	}
	
}
}