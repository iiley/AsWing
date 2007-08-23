package {

import flash.system.fscommand;
import flash.display.*;
import org.aswing.*;
import org.aswing.event.AWEvent;
import cases.*;
import flash.text.*;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.geom.Point;
import flash.filters.*;
import flash.net.URLRequest;
import cases.List;
import aeon.AeonLAF;
import cases.color.*;
import flash.geom.Rectangle;

[SWF (width="400", height="450")]
public class Test extends Sprite{
	
	public function Test(){
		super();
		
		if(stage != null){
			init();
		}else{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(e:Event=null):void{
		AsWingManager.initAsStandard(this, true);
		//create other case instance here to test others
		//for example change below with addChild(new Button());
		//to test buttons.
		addChild(new ColorChooserTest());
	}
}
}

