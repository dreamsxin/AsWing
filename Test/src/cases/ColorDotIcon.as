package cases
{
	import org.aswing.graphics.Graphics2D;
	import org.aswing.Icon;
	import org.aswing.Component;
	import flash.display.*;
	import org.aswing.ASColor;
	import org.aswing.graphics.SolidBrush;

	public class ColorDotIcon implements Icon
	{
		
		private var size:int;
		private var color:ASColor;
		private var shape:Shape;
		
		public function ColorDotIcon(size:int=20, color:ASColor=null){
			shape = new Shape();
			this.size = size;
			if(color == null) color = ASColor.RED;
			this.color = color;
		}
		
		public function updateIcon(com:Component, g:Graphics2D, x:int, y:int):void
		{
			shape.graphics.clear();
			g = new Graphics2D(shape.graphics);
			g.fillCircle(new SolidBrush(color), x+size/2, y+size/2, size/2);
		}
		
		public function getIconHeight(com:Component):int
		{
			return size;
		}
		
		public function getIconWidth(com:Component):int
		{
			return size;
		}
		
		public function getDisplay(com:Component):DisplayObject
		{
			return shape;
		}
		
	}
}