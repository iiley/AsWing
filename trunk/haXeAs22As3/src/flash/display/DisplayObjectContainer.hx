package flash.display;


import flash.events.Event;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.geom.Point; 
 
 
class DisplayObjectContainer extends InteractiveObject
{

	public var mObjs : Array<DisplayObject>; 
	var __mouseChildren:Bool;
	public var numChildren(GetNumChildren,null):Int;
	public var mouseChildren(GetMouseChildren,SetMouseChildren):Bool;

	public function new()
	{

		super();
		mObjs = new Array<DisplayObject>();  
		mouseChildren = true;
		name = "DisplayObjectContainer " +  flash.display.DisplayObject.mNameID;
	}
	
	 
	public function GetMouseChildren() { return  __mouseChildren; }
 

	public function SetMouseChildren(_in_mouseChildren:Bool)
	{
		__mouseChildren =_in_mouseChildren;
		return _in_mouseChildren;
	}
	public function getObjectsUnderPoint( pPoint:Point<Float> ):Array<DisplayObject> {
			// TODO
			return null;
	}
	public function areInaccessibleObjectsUnderPoint(point    :Point<Float>) : Bool
	{
		 return true;
	}
	 

	override public function AsContainer() { return this; }

	public function Broadcast(inEvent:Event)
	{
		dispatchEvent(inEvent);
		for(obj in mObjs)
		{
			var container = obj.AsContainer();
			//#if !js
			if (container!=null)
				container.Broadcast(inEvent);
			else
			//#end
				obj.dispatchEvent(inEvent);
		}

	}
 

	override function DoAdded(inObj:DisplayObject)
	{
		super.DoAdded(inObj);
		for(child in mObjs)
			child.DoAdded(inObj);
	}

	override function DoRemoved(inObj:DisplayObject)
	{
		super.DoAdded(inObj);
		for(child in mObjs)
			child.DoRemoved(inObj);
	}
 

	  
	public override function GetNumChildren() {
		return mObjs.length;
	}
 


	///////////////////////////// FLASH API ///////////////////////////////

	public function addChild(inObject:DisplayObject)
	{
		if (inObject == this) {
			throw "Adding to self";
		}
		if (inObject.mParent==this)
		{
			setChildIndex(inObject,mObjs.length-1);
			return;
		}

		#if debug
		for(i in 0...mObjs.length) {
			if(mObjs[i] == inObject) {
				throw "Internal error: child already existed at index " + i;
			}
		}
		#end

		mObjs.push(inObject);
		inObject.SetParent(this);
	}

	public function addChildAt( obj : DisplayObject, index : Int )
	{
		if(index > mObjs.length || index < 0) {
			throw "Invalid index position " + index;
		}

		if (obj.mParent == this)
		{
			setChildIndex(obj, index);
			return;
		}
		
		if(index == mObjs.length)
			mObjs.push(obj);
		else
			mObjs.insert(index, obj);
		obj.SetParent(this); 
	}

	public function contains( obj : DisplayObject )
	{
		if ( obj == this ) return true;
		for ( i in mObjs )
			if ( obj == i ) return true;
		return false;
	}

	public function getChildAt( index : Int )
	{
		return mObjs[index];
	}
	public function __removeChild( child : DisplayObject )
	{
		var i = getChildIndex(child);
		if (i>=0)
		{
			mObjs.splice( i, 1 );
		}
	}
	public function getChildByName(inName:String):DisplayObject
	{
		for(i in 0...mObjs.length)
			if (mObjs[i].name==inName)
				return mObjs[i];
		return null;
	}

	public function getChildIndex( child : DisplayObject )
	{
		for ( i in 0...mObjs.length )
			if ( mObjs[i] == child )
				return i;
		return -1;
	}

	public function removeChild( child : DisplayObject )
	{
		for ( i in 0...mObjs.length )
		{
			if ( mObjs[i] == child )
			{
				child.SetParent( null );
				#if debug
				if (getChildIndex(child) >= 0) {
					throw "Not removed properly";
				}
				#end
				return;
			}
		}
		throw "removeChild : none found?";
	}

	public function removeChildAt(inI:Int)
	{
		mObjs[inI].SetParent(null);
	}

	 

	public function setChildIndex( child : DisplayObject, index : Int )
	{
		if(index > mObjs.length) {
			throw "Invalid index position " + index;
		}

		var s : DisplayObject = null;
		var orig = getChildIndex(child);

		if (orig < 0) {
			var msg = "setChildIndex : object " + child.name + " not found.";
			if(child.parent == this) {
				var realindex = -1;
				for(i in 0...mObjs.length) {
					if(mObjs[i] == child) {
						realindex = i;
						break;
					}
				}
				if(realindex != -1)
					msg += "Internal error: Real child index was " + Std.string(realindex);
				else
					msg += "Internal error: Child was not in mObjs array!";
			}
			throw msg;
		}
		
		// move down ...
		if (index<orig)
		{
			var i = orig;
			while (i > index) {
				 
				mObjs[i] = mObjs[i - 1];
				
				i--; 
			}  
			mObjs[index] = child;
			
		}
		// move up ...
		else if (orig<index)
		{
			var i = orig;
			while (i < index) {
				 
				mObjs[i] = mObjs[i+1];
				i++;
			} 
			mObjs[index] = child;
		}

		#if debug
			for(i in 0...mObjs.length)
				if(mObjs[i] == null) {
					throw "Null element at index " + i + " length " + mObjs.length;
				}
		#end
	}
	 
	 
   
	public function swapChildren( child1 : DisplayObject, child2 : DisplayObject )
	{
		var c1 : Int = -1;
		var c2 : Int = -1;
		var swap : DisplayObject;
		for ( i in 0...mObjs.length )
		if ( mObjs[i] == child1 ) c1 = i;
		else if  ( mObjs[i] == child2 ) c2 = i;
		var target:flash.MovieClip;
		var target1:flash.MovieClip;
		if ( c1 != -1 && c2 != -1 )
		{ 		
			swap = mObjs[c1];
			mObjs[c1] = mObjs[c2];
			mObjs[c2] = swap;
			swap = null;
			
		}
	}

	public function swapChildrenAt( child1 : Int, child2 : Int )
	{
	 
		
		var swap : DisplayObject = mObjs[child1];
		mObjs[child1] = mObjs[child2];
		mObjs[child2] = swap;
		swap = null;
	}

}

