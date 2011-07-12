package flash.display;

import flash.display.Graphics;
import flash.display.InteractiveObject;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Point;

class Sprite extends  Shape
{ 

	#if debug
	static var spriteIndex : Int = 0;
	#end

	public var buttonMode(GetButtonMode,SetButtonMode):Bool;
	public function new()
	{
		
		super();
		name = "Shape " + DisplayObject.mNameID;
		target.name = name;
		buttonMode = false;
		
	}
	function GetButtonMode() { return  target.useHandCursor ; }
 

	function SetButtonMode(_buttonMode:Bool)
	{
		 target.useHandCursor = _buttonMode;
		return  target.useHandCursor ;
	}
 

	public function startDrag(?lockCenter:Bool, ?bounds:Rectangle<Float>):Void
	{
		//neash.Lib.SetDragged(this,lockCenter,bounds);
		target.startDrag(lockCenter, bounds.x, bounds.y, bounds.width, bounds.height);
	}

	public function stopDrag():Void
	{
		//neash.Lib.SetDragged(null);
		target.stopDrag();
	}


 
  
}

