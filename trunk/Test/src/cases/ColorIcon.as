package cases
{
	import org.aswing.graphics.Graphics2D;
	import org.aswing.Icon;
	import org.aswing.Component;
	import flash.display.DisplayObject;
	import org.aswing.ASColor;
	import org.aswing.graphics.SolidBrush;

	public class ColorIcon implements Icon
	{
		private var color:ASColor;
		private var width:int;
		private var height:int;
		
		public function ColorIcon(color:ASColor, width:int, height:int){
			this.color = color;
			this.width = width;
			this.height = height;
		}
		
		public function updateIcon(com:Component, g:Graphics2D, x:int, y:int):void
		{
			g.fillRectangle(new SolidBrush(color), x, y, width, height);
		}
		
		public function getIconHeight():int
		{
			return height;
		}
		
		public function getIconWidth():int
		{
			return width;
		}
		
		public function getDisplay():DisplayObject
		{
			return null;
		}
		
	}
}