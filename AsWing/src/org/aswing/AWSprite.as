/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.*;
import org.aswing.event.AWEvent;

/**
 *  Dispatched when the mouse released or released out side.
 *
 *  @eventType org.aswing.event.AWEvent.RELEASE
 */
[Event(name="release", type="org.aswing.event.AWEvent")]

/**
 *  Dispatched only when the mouse released out side.
 *
 *  @eventType org.aswing.event.AWEvent.RELEASE_OUT_SIDE
 */
[Event(name="releaseOutSide", type="org.aswing.event.AWEvent")]

/**
 * AsWing component based Sprite.
 * <p>
 * The AsWing Component Assets structure:(Assets means flash player display objects)
 * <pre>
 *             | -- foreground decorator asset
 *             |
 *             |    [other assets, there is no depth restrict between them, see below ]
 * AWSprite -- | -- [icon, border, ui creation, children component assets ...]          
 *             |    [they are above background decorator and below foreground decorator]
 *             |
 *             | -- background decorator asset
 * </pre>
 */
public class AWSprite extends Sprite
{
	private var foregroundChild:DisplayObject;
	private var backgroundChild:DisplayObject;
	
	public function AWSprite(){
		super();
		addEventListener(MouseEvent.MOUSE_DOWN, __awSpriteMouseDownListener);
	}
	
	/**
	 * Adds a child DisplayObject instance to this DisplayObjectContainer instance. 
	 * The child is added to the front (top) of all other children except foreground decorator child(It is topest)
	 *  in this DisplayObjectContainer instance. 
	 * (To avoid this restrict and add a child to a specific index position, use the <code>addChildAt()</code> method.)
	 * (<b>Note:</b> Generally if you don't want to break the component asset depth management, use 
	 * getHighestIndexUnderForeground() and getLowestIndexAboveBackground() to get the 
	 * right depth you can use. You can also refer to getChildIndex() to
	 * insert child after or before an existing child) 
	 * 
	 * @param dis The DisplayObject instance to add as a child of this DisplayObjectContainer instance. 
	 * @see #getLowestIndexAboveBackground()
	 * @see #getHighestIndexUnderForeground()
	 * @see #http://livedocs.macromedia.com/flex/2/langref/flash/display/DisplayObjectContainer.html#getChildIndex()
	 */
	public override function addChild(dis:DisplayObject):DisplayObject{
		if(foregroundChild != null){
			return addChildAt(dis, getChildIndex(foregroundChild));
		}else{
			return super.addChild(dis);
		}
	}
	
	/**
	 * Returns the current top index for none forground child.
	 * @return the current top index for child that is not a foreground child.
	 */
	public function getHighestIndexUnderForeground():int{
		if(foregroundChild == null){
			return numChildren;
		}else{
			return numChildren - 1;
		}
	}
	
	/**
	 * Returns the current bottom index for none background child.
	 * @return the current bottom index for child that is not a background child.
	 */		
	public function getLowestIndexAboveBackground():int{
		if(backgroundChild == null){
			return 0;
		}else{
			return 1;
		}
	}
	
	/**
	 * Sets the child to be the component background, it will be add to the bottom of all other children. 
	 * (old backgournd child will be removed). pass no paramter (null) to remove the background child.
	 * 
	 * @param child the background child to be added.
	 */
	protected function setBackgroundChild(child:DisplayObject = null):void{
		if(child != backgroundChild){
			removeChild(backgroundChild);
			backgroundChild = child;
			if(child != null){
				addChildAt(child, 0);
			}
		}
	}
	
	/**
	 * Returns the background child. 
	 * @return the background child.
	 * @see #setBackgroundChild()
	 */
	protected function getBackgroundChild():DisplayObject{
		return backgroundChild;
	}
	
	/**
	 * Sets the child to be the component foreground, it will be add to the top of all other children. 
	 * (old foregournd child will be removed), pass no paramter (null) to remove the foreground child.
	 * 
	 * @param child the foreground child to be added.
	 */
	protected function setForegroundChild(child:DisplayObject = null):void{
		if(child != foregroundChild){
			removeChild(foregroundChild);
			foregroundChild = child;
			if(child != null){
				addChild(child);
			}
		}
	}
	
	/**
	 * Returns the foreground child. 
	 * @return the foreground child.
	 * @see #setForegroundChild()
	 */
	protected function getForegroundChild():DisplayObject{
		return foregroundChild;
	}
	
	private function __awSpriteMouseDownListener(e:MouseEvent):void{
		stage.addEventListener(MouseEvent.MOUSE_UP, __awStageMouseUpListener);
	}
	private function __awStageMouseUpListener(e:MouseEvent):void{
		stage.removeEventListener(MouseEvent.MOUSE_UP, __awStageMouseUpListener);
		dispatchEvent(new AWEvent(AWEvent.RELEASE));
		if(e.target != this){
			dispatchEvent(new AWEvent(AWEvent.RELEASE_OUT_SIDE));
		}
	}
	
	override public function toString():String{
		var p:DisplayObject = this;
		var str:String = p.name;
		while(p.parent != null){
			var name:String = (p.parent == p.stage ? "Stage" : p.parent.name);
			p = p.parent;
			str = name + "." + str;
		}
		return str;
	}
}
}