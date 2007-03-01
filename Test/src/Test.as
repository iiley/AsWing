package {
	
	import flash.display.*;
	import org.aswing.*;
	import org.aswing.event.AWEvent;
	import cases.*;
	import sington.*;

	public class Test extends Sprite
	{
		
		public function Test()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			AsWingManager.setRoot(this);
			//create other case instance here to test others
			//for example change below with addChild(new Button());
			//to test buttons.
			addChild(new Accordion());
			
			SingtonTry.getInstance().singtonMethod();
			//SingtonTry.getInstance().singtonMethod();
		}
	}
}

