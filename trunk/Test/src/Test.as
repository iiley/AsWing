package {
	
	import flash.display.*;
	import org.aswing.*;
	import org.aswing.event.AWEvent;
	import cases.*;

	public class Test extends Sprite
	{
		
		public function Test()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			AsWingManager.setRoot(this);
			addChild(new TextAreaCase());
		}
	}
}

