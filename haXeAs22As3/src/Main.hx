package ;

import flash.display.DisplayObject; 
import flash.display.MovieClip;
import flash.display.Sprite; 
import flash.events.EventDispatcher;  
import flash.display.Bitmap;
import flash.Lib;
import flash.text.TextField;
import flash.utils.Timer;
import flash.display.Graphics;
import flash.events.TimerEvent;
import flash.events.MouseEvent;
import flash.display.Stage;
/**
 * ...
 * @author paling
 */

class Main extends Sprite
{
	private var time:Timer;
	public function new():Void
	{
		super();
		stage.root = this;
		
		
		this.y= 130;
		this.x = 130;
		 
		this.addChild(new DrawRect());
		this.addChild(new DrawCircle());
		var dc:DrawCircle;
	 	this.addChildAt(dc = new DrawCircle(),0);
	 
		
		dc.x = -80;
		dc.buttonMode = true;
		
		dc.addEventListener(MouseEvent.CLICK, __click);
		dc.width = 100;
		dc.height = 100;
		var tf:TextField = new TextField();
		tf.text = "12312";
		tf.x = 90;
		this.addChild(tf);
		// this.swapChildrenAt(1, 2); 
	}
	private function __click(e:MouseEvent):Void
	{
		var dc:DrawCircle=e.target;
		trace("__click");
	}
	static function main() 
	{
		var __main:Main = new Main(); 
		 
	 	//Lib.current.attachMovie("in", "ain", flash.Lib.current.getNextHighestDepth(), mc);
		// trace("as2"); 
	}
	
}