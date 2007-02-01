package cases
{
	import org.aswing.graphics.Graphics2D;
	import org.aswing.Icon;
	import org.aswing.Component;
	import flash.display.DisplayObject;
	import org.aswing.ASColor;
	import org.aswing.graphics.SolidBrush;

	public class ColorDotIcon implements Icon
	{
		
		private var size:int;
		private var color:ASColor;
		
		public function ColorDotIcon(size:int=20, color:ASColor=ASColor.RED){
			this.size = size;
			if(color == null) color = ASColor.RED;
			this.color = color;
		}
		
		public function updateIcon(com:Component, g:Graphics2D, x:int, y:int):void
		{
			g.fillCircle(new SolidBrush(color), x+size/2, y+size/2, size/2);
		}
		
		public function getIconHeight():int
		{
			return size;
		}
		
		public function getIconWidth():int
		{
			return size;
		}
		
		public function getDisplay():DisplayObject
		{
			return null;
		}
		
	}
}