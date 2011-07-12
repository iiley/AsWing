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
	private var renderList:FastList<Array<DisplayObject>>;
	private var renderCount:Int;
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
		 
		renderCount = 1;
		 //trace("renderCount "+ root.target.getDepth());
		  renderList = new FastList<Array<DisplayObject>>();
		  renderList.add(root.mObjs);
		  var mObjs : Array<DisplayObject>;
 
		  while(!renderList.isEmpty()){
			  mObjs = renderList.pop();
			  var mCount:Int = mObjs.length;
			  var i:Int=0;
			  while (i < mCount)
			  {
				   var mr:DisplayObject = mObjs[i];
				  //深度
				   if (mr.target.getDepth() != renderCount)
				   { 
						mr.target.swapDepths(renderCount); 
						 //计算　mStageX/mStageY
						
				   } 
					mr.updateLocalXY();
				   //计算　mask
				   if (Std.is(mObjs[i], DisplayObjectContainer))
				   {
					    renderList.add(as(mObjs[i], DisplayObjectContainer).mObjs);
				   }
				   i++;
				   renderCount++;
			  }
		  }
		 // trace("renderCount "+renderCount);
	}
	

	private function onEnterFrame(e:Event):Void
	{ 
			__timer(null);
		  root.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
	} 
	public inline static function as<T>( v : Dynamic, c : Class<T> ) : Null<T> {
		return untyped __as__(v,c);
	}
}