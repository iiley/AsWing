package org.aswing.plaf.basic.background
{
	import flash.display.DisplayObject;
	
	import org.aswing.Component;
	import org.aswing.GroundDecorator;
	import org.aswing.geom.IntRectangle;
	import org.aswing.graphics.Graphics2D;
	import org.aswing.plaf.*;

	public class TabbedPaneItem implements GroundDecorator, UIResource
	{
		public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):void
		{
		}
		
		public function getDisplay():DisplayObject
		{
			return null;
		}
		
	}
}