package {

import flash.display.*;
import org.aswing.*;
import org.aswing.event.AWEvent;
import cases.*;

[SWF (width="400", height="450")]
public class Test extends Sprite{
	
	public function Test(){
		super();
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.stageFocusRect = false;
		AsWingManager.setRoot(this);
		//create other case instance here to test others
		//for example change below with addChild(new Button());
		//to test buttons.
		addChild(new Frame());
		
	}
}
}

