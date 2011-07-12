package flash.display;

/**
* @author	Hugh Sanderson
* @author	Russell Weir
**/
class InteractiveObject extends DisplayObject
{
	public var doubleClickEnabled(__getDoubleClickEnabled,__setDoubleClickEnabled) : Bool;
	
	public var tabEnabled:Bool;
	public var tabIndex(default,SetTabIndex):Int;
	var __mouseEnabled:Bool;
	public var mouseEnabled(GetMouseEnabled,SetMouseEnabled):Bool;
	public function new()
	{
		super();
		tabEnabled = false;
		mouseEnabled = true;
		tabIndex = 0;
		name = "InteractiveObject";
	}
	public function GetMouseEnabled() { return  __mouseEnabled; }
 

	public function SetMouseEnabled(_in_mouseEnabled:Bool)
	{
		if (__mouseEnabled != _in_mouseEnabled)
		{
			if (_in_mouseEnabled)
			{
				
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

			}else
			{
				target.onDragOut = null;
				target.onDragOver = null;  
				
				target.onMouseDown = null;
				target.onMouseMove = null;
				target.onMouseUp = null;
				
				target.onPress = null;
				target.onRelease = null;
				target.onReleaseOutside = null;
				
				target.onRollOut = null;
				target.onRollOver = null;
			} 
			__mouseEnabled =_in_mouseEnabled;
		}
		
		return _in_mouseEnabled;
	}
	override public function toString() { return name; }

	public function OnKey(inKey:flash.events.KeyboardEvent):Void { }

	override public function AsInteractiveObject() : flash.display.InteractiveObject
	{
		return this;
	}


	public function SetTabIndex(inIndex:Int)
	{
		tabIndex = inIndex;
		return inIndex;
	}

	/**
	* @todo Implement
	* @todo Check default right now, is it true or false?
	*/
	private function __getDoubleClickEnabled() : Bool {
		return true;
	}
	/**
	* @todo Implement
	*/
	private function __setDoubleClickEnabled(v:Bool) : Bool {
		return v;
	}

	public function OnFocusIn(inMouse:Bool) : Void { }
	public function OnFocusOut() : Void { }
	public function OnMouseDown(inX:Int, inY:Int) : Void { }
	public function OnMouseUp(inX:Int, inY:Int) : Void { }
	public function OnMouseDrag(inX:Int, inY:Int) : Void { }

}

