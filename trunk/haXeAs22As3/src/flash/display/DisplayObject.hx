package flash.display;

import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.events.EventDispatcher;
import flash.events.Event;
import flash.display.DisplayObjectContainer;
import flash.display.IBitmapDrawable;
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.filters.BitmapFilter;
import flash.geom.Rectangle;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Transform;  

import flash.display.BitmapData; 
 
  
class DisplayObject extends EventDispatcher, implements IBitmapDrawable
{
	public var x(GetX,SetX):Float;
	public var y(GetY,SetY):Float;
	public var scaleX(GetScaleX,SetScaleX):Float;
	public var scaleY(GetScaleY,SetScaleY):Float; 
	public var scale9Grid(GetScale9Grid,SetScale9Grid):Rectangle<Float>;
 
	public var alpha(GetAlpha,SetAlpha):Float;
	public var name(default,default):String;
	public var width(GetWidth,SetWidth):Float;
	public var height(GetHeight,SetHeight):Float;
	public var visible(GetVisible,SetVisible):Bool;
	public var cacheAsBitmap(GetCacheAsBitmap,SetCacheAsBitmap):Bool;
	public var opaqueBackground(GetOpaqueBackground,SetOpaqueBackground):Null<Int>;
	public var mouseX(GetMouseX,null):Float;
	public var mouseY(GetMouseY,null):Float;
	public var parent(GetParent,null):DisplayObjectContainer;
	public var stage(GetStage,null):Stage;
	public var rotation(GetRotation,SetRotation):Float;
	public var scrollRect(GetScrollRect,SetScrollRect):Rectangle<Float>;
	public var mask(GetMask,SetMask):DisplayObject;
	public var filters(GetFilters, SetFilters):Array<Dynamic>;
	public var useHandCursor(getUseHandCursor,setUseHandCursor) : Bool;
	public var blendMode : flash.display.BlendMode;


	// This is used by the swf-code for z-sorting
	public var __swf_depth:Int; 
	public var transform(GetTransform,SetTransform):Transform;
	public var graphics(GetGraphics,null):Graphics;
	public static var TRANSLATE_CHANGE     = 0x01;
	public static var NON_TRANSLATE_CHANGE = 0x02;
	public static var GRAPHICS_CHANGE      = 0x04;
	public static var mNameID:Int = 0;
	public var target:Dynamic;//flash.MovieClip;
	private var mMask:DisplayObject;
	private var mParent:DisplayObjectContainer;
	private var mGraphics:Graphics;
    private	var mX:Float;
	private var mY:Float; 
	private	var mStageX:Float; 
	private var mStageY:Float; 
	 var inMouseRoll:Bool;
	 var inMouseDown:Bool;

	public function new()
	{
		inMouseDown=inMouseRoll = false;
		name = "DisplayObject"+DisplayObject.mNameID; 		
		mX = mY = mStageX = mStageY = 0;
		//visible = false;
		DisplayObject.mNameID++;
		super();
		buildGui();
	}
	private function buildGui():Void
	{
		target =  flash.Lib.current.createEmptyMovieClip(name, flash.Lib.current.getNextHighestDepth());
 
		mGraphics = new Graphics(target);
		
		target.useHandCursor = false;
		target.onData = onData;
		target.onEnterFrame = onEnterFrame;
		target.onKeyDown = onKeyDown;
		target.onKeyUp = onKeyUp;
		target.onKillFocus = onKillFocus;
		target.onLoad = onLoad;
		target.onSetFocus = onSetFocus;
		target.onUnload = onUnload;
		target.onDragOut = onData;
		
		target.onDragOver = onDragOver;  
		
		target.onMouseDown = onMouseDown;
		target.onMouseMove = onMouseMove;
		target.onMouseUp = onMouseUp;
		
		target.onPress = onPress;
		target.onRelease = onRelease;
		target.onReleaseOutside = onReleaseOutside;
		
		target.onRollOut = onRollOut;
		target.onRollOver = onRollOver;
			 
		 
	}   
	public function getUseHandCursor():Bool{
		return target.useHandCursor;
	}
	public function setUseHandCursor(b:Bool):Bool{
		return target.useHandCursor = b;
	}
	public function update():Void
	{
		mStageX = parent.target._x;
		mStageY = parent.target._y;
		
		
		if(target._x !=  mStageX + mX) target._x = mStageX + mX;
		if (target._y !=  mStageY + mY) target._y = mStageY + mY;
		//	trace(name + " " +target._x + " " + target._y);
	 
	}
	function onData() : Void 
	{ 
	}
	function onDragOut() : Void
	{
		
	}
	function onDragOver() : Void
	{
	}
	function onEnterFrame() : Void 
	{	
		var evt:Event = new Event(Event.ENTER_FRAME);
		evt.currentTarget = this;
		evt.target = this;
		this.dispatchEvent(evt);
	}
	function onKeyDown() : Void
	{
		
		var evt:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_DOWN);
		evt.currentTarget = this;
		evt.target = this;
		this.dispatchEvent(evt);
	}
	function onKeyUp() : Void
	{
		var evt:KeyboardEvent = new KeyboardEvent(KeyboardEvent.KEY_UP);
		evt.currentTarget = this;
		evt.target = this;
		this.dispatchEvent(evt);
	}
	function onKillFocus(newFocus :Dynamic) : Void
	{
	}
	function onLoad() : Void
	{
	}
	function onMouseDown() : Void
	{
		if (inMouseRoll)
		{
			var evt:MouseEvent = new MouseEvent(MouseEvent.MOUSE_DOWN);
			evt.currentTarget = this;
			evt.target = this;
			this.dispatchEvent(evt);
			inMouseDown = true;
		}
	}
	function onMouseMove() : Void
	{
		if (inMouseRoll)
		{
			var evt:MouseEvent = new MouseEvent(MouseEvent.MOUSE_MOVE);
			evt.currentTarget = this;
			evt.target = this;
			this.dispatchEvent(evt);
		}
	}
	function onMouseUp() : Void
	{
		if (inMouseDown)
		{
			var evt:MouseEvent = new MouseEvent(MouseEvent.MOUSE_UP);
			evt.currentTarget = this;
			evt.target = this;
			this.dispatchEvent(evt);
			
			var c_evt:MouseEvent = new MouseEvent(MouseEvent.CLICK);
			c_evt.currentTarget = this;
			c_evt.target = this;
			this.dispatchEvent(c_evt);
			
		}
		inMouseDown = false;
	}
	function onPress() : Void
	{
	}
	function onRelease() : Void
	{
	}
	function onReleaseOutside() : Void
	{
	}
	 
	function onRollOut() : Void
	{
		inMouseRoll = false;
		var evt:MouseEvent = new MouseEvent(MouseEvent.ROLL_OUT);
		evt.currentTarget = this;
		evt.target = this;
		this.dispatchEvent(evt);
	}
	function onRollOver() : Void
	{
		inMouseRoll = true;
		var evt:MouseEvent = new MouseEvent(MouseEvent.ROLL_OVER);
		evt.currentTarget = this;
		evt.target = this;
		this.dispatchEvent(evt);
	}
	function onSetFocus(oldFocus : Dynamic) : Void
	{
	}
	function onUnload() : Void
	{
	}  
	public function getBounds(targetCoordinateSpace : DisplayObject) : Rectangle<Float>{
		// TODO
		var rt  = target.getBounds(targetCoordinateSpace.target);
	
		return new Rectangle( rt.xMin,rt.yMin,rt.xMax,rt.yMax);
		//BuildBounds();
		//return mBoundsRect.clone();
	}
	public function getRect(targetCoordinateSpace : DisplayObject) : Rectangle<Float>{
		// TODO
		var rt  = target.getRect(targetCoordinateSpace.target);
	
		return new Rectangle( rt.xMin,rt.yMin,rt.xMax,rt.yMax);
	}

	/**
	* @todo Implement
	**/
	public function localToGlobal( pPoint:Point<Float>  ) : Point<Float>  {
			// TODO
			return null;
	}
	public function globalToLocal( pPoint:Point<Float>  ) : Point<Float>  {
			// TODO
			return null;
	}
	
	function GetAlpha() { return  target._alpha/100 ; }
 

	function SetAlpha(inAlpha:Float)
	{
		inAlpha = Math.min(1, inAlpha);
		target._alpha = inAlpha*100;
		return inAlpha;
	}
	function GetVisible() { return  target._visible ; }
 

	function SetVisible(_visible:Bool)
	{
		target._visible =_visible;
		return target._visible ;
	}
	function GetTransform() { return  target.transform; }
 

	function SetTransform(trans:Transform)
	{
		target.transform=trans;
		return trans;
	}
	// Bitmap caching
	function SetFilters(inFilters:Array<Dynamic>)
	{ 
		target.filters = inFilters;
		return GetFilters();
	}

	function GetFilters()
	{
		 
		return target.filters;
	}
	function GetScrollRect() : Rectangle<Float>
	{
		if (target.scrollRect==null) return null;
		return target.scrollRect.clone();
	} 
	function SetScrollRect(inRect:Rectangle<Float>)
	{
		target.scrollRect = inRect;
		return target.scrollRect;
	}
	function GetOpaqueBackground() { return target.opaqueBackground; }
	function SetOpaqueBackground(inBG:Null<Int>)
	{
		target.opaqueBackground = inBG;
		return target.opaqueBackground;
	}
	function GetCacheAsBitmap() : Bool
	{
		return target.cacheAsBitmap;
	}

	function SetCacheAsBitmap(inVal:Bool) : Bool
	{	  
		if (inVal!=target.cacheAsBitmap)target.cacheAsBitmap=inVal;
		return inVal;
	} 
	function GetBitmapDrawable() : flash.display.Graphics { return GetGraphics(); }
	function GetScale9Grid()
	{
		if (target.scale9Grid==null) return null;
		return target.scale9Grid.clone();
	}
	function SetScale9Grid(inRect:Rectangle<Float>) : Rectangle<Float>
	{
		if (inRect==null)
		{
			target.scale9Grid = null;
			return null;
		}
		target.scale9Grid = inRect.clone();
		return target.scale9Grid.clone();
	}
	public function toString() { return name; }


	 function DoMouseEnter() {}
	 function DoMouseLeave() {}

 

	 function GetX() { 
		 
		 return mX; 
	}
	 function GetParent() { return mParent; }
	 function GetY() { 
		return mY; 
	}
	 function SetX(inX:Float) { 
		 mX = inX;
		 //
		 target._x = inX+mStageX; 
		 return target._x ;
	}
	 function SetY(inY:Float) { 
		 mY = inY;
		 target._y = inY+mStageY; 
		 return target._y ;
	}
	 function GetStage():flash.display.Stage { return  Stage.stage; }
	 public function AsContainer() : DisplayObjectContainer { return null; }

	 function GetScaleX() { return target._xscale; }
	 function GetScaleY() { return target._yscale; }
	 function SetScaleX(inS:Float)
		{ target._xscale = inS;  return inS; }
	 function SetScaleY(inS:Float)
		{ target._yscale = inS;  return inS; } 
 


	 function SetRotation(inRotation:Float)
	{ 
		target._rotation = inRotation; 
		return inRotation;
	}
	 function GetRotation()
	{
		return target._rotation;
	}

 

	public function AsInteractiveObject() : flash.display.InteractiveObject
		{ return null; }



	public function hitTestPoint(x:Float, y:Float, ?shapeFlag:Bool)
	{
		var bounding_box:Bool = shapeFlag==null ? true : !shapeFlag;

		// TODO:
		return true;
	}

	// TODO:
	  function GetMouseX() { 
		var mLastMouse:Point<Float> = Stage.mLastMouse;
		target.globalToLocal(mLastMouse);
		return mLastMouse.x; 
	}
	  function GetMouseY() { 
		var mLastMouse:Point<Float> = Stage.mLastMouse;
		target.globalToLocal(mLastMouse);
		return mLastMouse.y; 
	}

 
  
	// This tells us we are an empty container, or not a container at all
	public function GetNumChildren() { return 0; }

 
 



	function GetGraphics() : flash.display.Graphics
	{ return    mGraphics; }

 
	function GetHeight() : Float
	{
		 
		return target._height;
	}
	function SetHeight(inHeight:Float) : Float
	{  
		if (inHeight!=target._height)
		{
			target._height = inHeight;
		}
		return inHeight;
	}



	function GetWidth() : Float
	{ 
		return target._width;
	}

	function SetWidth(inWidth:Float) : Float
	{
	 
		if (target._width!=inWidth)
		{
			target._width = inWidth;
		}
		return inWidth;
	}

  

 

	// Masking

	function GetMask() : DisplayObject { return mMask; }

	function SetMask(inMask:Dynamic) : DisplayObject
	{
		 mMask = inMask;
		 target.setMask(inMask);
		return mMask;
	} 
	 public function drawToSurface(inSurface : Dynamic,
				   matrix:flash.geom.Matrix,
				   colorTransform:flash.geom.ColorTransform,
				   blendMode:String,
				   clipRect:flash.geom.Rectangle<Float>,
				   smoothing:Bool):Void
		{
		   if (matrix==null) matrix = new Matrix();
	 
		}
	 
	function DoAdded(inObj:DisplayObject)
	{
 
		if (inObj==this)
		{
			var evt = new Event(Event.ADDED, true, false);
			evt.target = inObj;
			dispatchEvent(evt);
		}

		var evt = new Event(Event.ADDED_TO_STAGE, false, false);
		evt.target = inObj;
		dispatchEvent(evt);
	}

	function DoRemoved(inObj:DisplayObject)
	{
		if (inObj==this)
		{
			var evt = new Event(Event.REMOVED, true, false);
			evt.target = inObj;
			dispatchEvent(evt);
		}
		var evt = new Event(Event.REMOVED_FROM_STAGE, false, false);
		evt.target = inObj;
		dispatchEvent(evt);
	}
     public function SetParent(inParent:DisplayObjectContainer)
	{
		if (inParent == mParent)
			return;

		if (mParent != null)
			mParent.__removeChild(this);

		if (mParent==null && inParent!=null)
		{
			mParent = inParent; 
			DoAdded(this);
			if (inParent.mask != null)
			{
				this.mask = inParent.mask;
			}
		}
		else if (mParent!=null && inParent==null)
		{ 
			target.removeMovieClip();
			mParent = inParent; 
			DoRemoved(this);
			if (this.mask != null)
			{
				this.mask = null;
			}
		}
		else
			mParent = inParent;
	}

 

}

