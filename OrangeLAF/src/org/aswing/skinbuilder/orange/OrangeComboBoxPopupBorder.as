package org.aswing.skinbuilder.orange
{
import org.aswing.ASColor;
import org.aswing.Border;
import org.aswing.Component;
import org.aswing.border.LineBorder;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import org.aswing.plaf.UIResource;

public class OrangeComboBoxPopupBorder extends LineBorder implements UIResource
{
	public function OrangeComboBoxPopupBorder()
	{
		super(null, new ASColor(0xFDAC05));
	}
	
	override public function updateBorderImp(c:Component, g:Graphics2D, b:IntRectangle):void
	{
		var color:ASColor = c.getStyleProxy().getBackground();
		g.fillRectangle(new SolidBrush(color), b.x, b.y, b.width, b.height);
		super.updateBorderImp(c, g, b);
	}	
}
}