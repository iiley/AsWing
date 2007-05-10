package {

import flash.system.fscommand;
import flash.display.*;
import org.aswing.*;
import org.aswing.event.AWEvent;
import cases.*;
import flash.text.*;

[SWF (width="400", height="450")]
public class Test extends Sprite{
	
	public function Test(){
		super();
		//fscommand("trapallkeys", "true");
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.stageFocusRect = false;
		AsWingManager.setRoot(this);
		//create other case instance here to test others
		//for example change below with addChild(new Button());
		//to test buttons.
		addChild(new NormalMenu());
		
	}
}
}

