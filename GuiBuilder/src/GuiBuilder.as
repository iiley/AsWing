package {

import flash.display.Sprite;
import org.aswing.AsWingManager;
import flash.events.Event;

[SWF (width="800", height="600")]
public class GuiBuilder extends Sprite{
	
	private var main:Main;
	
	public function GuiBuilder(){
		AsWingManager.initAsStandard(this);
		
		main = new Main(this);
		main.setSizeWH(800, 600);
		main.show();
		
		stage.addEventListener(Event.RESIZE, __stageResized);
	}
	
	private function __stageResized(e:Event):void{
		main.setSizeWH(stage.stageWidth, stage.stageHeight);
	}
}
}
