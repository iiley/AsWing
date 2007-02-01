package {
	
	import flash.display.Sprite;
	import org.aswing.*;
	import org.aswing.event.AWEvent;
	import cases.*;

	public class Test extends Sprite
	{
		
		public function Test()
		{
			super();
			stage.stageFocusRect = false;
			AsWingManager.setRoot(this);
			addChild(new Popup("tt"));
		}
	}
}

