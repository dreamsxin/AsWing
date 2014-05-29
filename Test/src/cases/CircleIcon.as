package cases
{
	import org.aswing.graphics.*;
	import org.aswing.*;
	import flash.display.*;

	public class CircleIcon implements Icon
	{
		private var shape:Shape;
		private var color:ASColor;
		private var width:int;
		private var height:int;
		
		public function CircleIcon(color:ASColor, width:int, height:int){
			shape = new Shape();
			this.color = color;
			this.width = width;
			this.height = height;	
		}
		
		public function updateIcon(com:Component, g:Graphics2D, x:int, y:int):void
		{
			shape.graphics.clear();
			g = new Graphics2D(shape.graphics);
			g.fillEllipse(new SolidBrush(color), x, y, width, height);
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