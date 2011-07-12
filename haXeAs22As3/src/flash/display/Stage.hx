/**
 * ...
 * @author paling
 */

package flash.display;
import flash.errors.Error;
import flash.geom.Point;
import flash.events.Event;
import flash.Lib;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.EventDispatcher;
import haxe.FastList;
class Stage extends EventDispatcher
{ 
	static public  var mLastMouse:Point<Float> = new Point<Float>(0, 0);
	static public var  stage:Stage = new Stage();
	public var root(GetRoot,SetRoot):DisplayObjectContainer;
	private var time:Timer; 
	static public var renderCount:Int;
	public function new() 
	{
	 
		super();
		
	}
	function SetRoot(__root:DisplayObjectContainer)
	{
		if (__root == null) throw new Error("root can t null ");
		
		if (root != null) root.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		 
		root = __root;
		root.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		time = new Timer(100);
		time.addEventListener(TimerEvent.TIMER, __timer);
		time.start(); 
	  
	
		return __root;
	}
	function GetRoot():DisplayObjectContainer
	{
		return root;
	}
	private function __timer(e:TimerEvent):Void
	{
		renderCount =Std.int(root.target.getDepth()-1);
		root.update();
	 
	}
	

	private function onEnterFrame(e:Event):Void
	{ 
			__timer(null);
		  root.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	} 
	 
}