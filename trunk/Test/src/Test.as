package {

import cases.*;
import cases.color.*;

import flash.display.*;
import flash.events.Event;
import flash.events.TimerEvent;
import flash.filters.*;
import flash.text.*;
import flash.utils.Timer;

import org.aswing.*;

[SWF (width="360", height="300", backgroundColor="0x006666")]
public class Test extends Sprite{
	
	public function Test(){
		super();
		
		if(stage != null){
			init();
		}else{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}
	
	private var timer:Timer;

	private function init(e:Event=null):void{
		AsWingManager.initAsStandard(this, true, false);
		this.stage.frameRate = 25;
		//create other case instance here to test others
		//for example change below with addChild(new Button());
		//to test buttons.
		//UIManager.setLookAndFeel(new SkinBuilderLAF());
		addChild(new TabbedPane());
		timer = new Timer(1000, 1);
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, __timer);
		timer.start();
	}
	
	private function __timer(e:TimerEvent):void{
		trace(timer.running);
		timer.reset();
		timer.start();
	}
}
}

