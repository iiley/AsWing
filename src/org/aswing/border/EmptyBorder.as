package org.aswing.border
{
	import org.aswing.graphics.Graphics2D;
	import org.aswing.Border;
	import org.aswing.geom.IntRectangle;
	import org.aswing.Component;
	import org.aswing.Insets;
	import flash.display.DisplayObject;

	public class EmptyBorder implements Border
	{
		public function updateBorder(com:Component, g:Graphics2D, bounds:IntRectangle):void
		{
		}
		
		public function getBorderInsets(com:Component, bounds:IntRectangle):Insets
		{
			return new Insets();
		}
		
		public function getDisplay():DisplayObject
		{
			return null;
		}
		
	}
}