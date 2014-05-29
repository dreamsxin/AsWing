package cases
{
	import org.aswing.graphics.Graphics2D;
	import org.aswing.Icon;
	import org.aswing.Component;
	import flash.display.DisplayObject;
	import org.aswing.ASColor;
	import org.aswing.graphics.SolidBrush;
	import flash.display.Shape;

	public class ColorIcon implements Icon
	{
		private var color:ASColor;
		private var width:int;
		private var height:int;
		private var shape:Shape;
		
		public function ColorIcon(color:ASColor, width:int, height:int){
			shape = new Shape();
			this.color = color;
			this.width = width;
			this.height = height;
		}
		
		public function updateIcon(com:Component, g:Graphics2D, x:int, y:int):void
		{
			shape.graphics.clear();
			g = new Graphics2D(shape.graphics);
			g.fillRectangle(new SolidBrush(color), x, y, width, height);
		}
		
		public function getIconHeight(com:Component):int
		{
			return height;
		}
		
		public function getIconWidth(com:Component):int
		{
			return width;
		}
		
		public function getDisplay(com:Component):DisplayObject
		{
			return shape;
		}
		
	}
}