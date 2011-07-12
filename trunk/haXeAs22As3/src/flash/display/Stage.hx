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
import flash.geom.Rectangle;
class Stage extends EventDispatcher
{ 
	static public var  stage:Stage = new Stage();
	static public var renderCount:Int;
	static public var align : StageAlign;


	static public var displayState : StageDisplayState;
	static public var focus : InteractiveObject;
	static public var frameRate : Float;
	static public var fullScreenHeight(default,null) : Int;
	static public var fullScreenSourceRect :  Rectangle<Float> ;
	static public var fullScreenWidth(default,null) : Int;
	static public var quality : StageQuality;
	static public var scaleMode : StageScaleMode;
	static public var showDefaultContextMenu : Bool;
	static public var stageFocusRect : Bool;
	static public var stageHeight : Int;
	static public var stageWidth : Int;
	
	
	
	
	public var mLastMouse:Point<Float> ;
	public var root(GetRoot,SetRoot):DisplayObjectContainer;
	var time:Timer; 
	
	public function new() 
	{
		mLastMouse= new Point<Float>(0, 0);
		super();
		//flash.Mouse.
		//flash.Key
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
	private function invalidate() : Void
	{
		renderCount =Std.int(root.target.getDepth()-1);
		root.invalidate();
	}
	public function isFocusInaccessible() : Bool
	{
		return false;
	}
	function GetRoot():DisplayObjectContainer
	{
		return root;
	}
	private function __timer(e:TimerEvent):Void
	{ 
		invalidate(); 
	}
	

	private function onEnterFrame(e:Event):Void
	{ 
		  invalidate();
		  root.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	} 
	 
}