/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.util{

import flash.display.*;

/**
 * DepthManager to manage the depth of display objects.
 * 
 * @author iiley
 */
public class DepthManager{
	
	/**
	 * bringToBottom(mc:MovieClip, exceptMC:MovieClip)<br>
	 * bringToBottom(mc:MovieClip)
	 * <p>
	 * Bring the mc to all brother mcs' bottom.
	 * <p>
	 * if exceptMC is undefined or null, the mc will be sent to bottom of all.
	 * else, the exceptMC will be set to bottom of all, mc will be above it.
	 * @param mc the mc to be set to bottom
	 * @param exceptMC the exceptMC of bottom mc.
	 * @see #isBottom()
	 * @throws Error when the exceptMC is not at the bottom currently.
	 */
	public static function bringToBottom(mc:DisplayObject, exceptMC:DisplayObject=null):void{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null){ return; }
		if(exceptMC != null){
			if(exceptMC.parent != parent){
				throw new Error("The two display object is not in same parent!");
			}
		}
		if(exceptMC == null){
			if(parent.getChildIndex(mc) != 0){
				parent.setChildIndex(mc, 0)
			}
		}else{
			if(parent.getChildIndex(exceptMC) != 0){
				parent.setChildIndex(exceptMC, 0)
			}
			if(parent.getChildIndex(mc) != 1){
				parent.setChildIndex(mc, 1)
			}
		}
	}
	
	/**
	 * Bring the mc to all brother mcs' top.
	 */	
	public static function bringToTop(mc:DisplayObject):void{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null) return;
		var maxIndex:int = parent.numChildren-1;
		if(parent.getChildIndex(mc) != maxIndex){
			parent.setChildIndex(mc, maxIndex);
		}
	}
	
	/**
	 * Returns is the mc is on the top depths in DepthManager's valid depths.
	 * Valid depths is that depths from MIN_DEPTH to MAX_DEPTH.
	 */
	public static function isTop(mc:DisplayObject):Boolean{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null) return true;
		return (parent.numChildren-1) == parent.getChildIndex(mc);
	}
	
	/**
	 * isBottom(mc:MovieClip, exceptMC:MovieClip)<br>
	 * isBottom(mc:MovieClip)
	 * <p>
	 * Returns is the mc is at the bottom depths in DepthManager's valid depths.
	 * Valid depths is that depths from MIN_DEPTH to MAX_DEPTH.
	 * <p>
	 * if exceptMC is undefined or null, judge is the mc is at bottom of all.
	 * else, the mc judge is the mc is at bottom of all except the exceptMC.
	 * @param mc the mc to be set to bottom
	 * @param exceptMC the exceptMC of bottom mc.
	 * @return is the mc is at the bottom
	 */
	public static function isBottom(mc:DisplayObject, exceptMC:DisplayObject=null):Boolean{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null) return true;
		var depth:int = parent.getChildIndex(mc);
		if(depth == 0){
			return true;
		}
		if(parent.getChildIndex(exceptMC)==0 && depth==1){
			return true;
		}
		return false;
	}
	
	/**
	 * Return if mc is just first bebow the aboveMC.
	 * if them don't have the same parent, whatever depth they has just return false.
	 */
	public static function isJustBelow(mc:DisplayObject, aboveMC:DisplayObject):Boolean{
		var parent:DisplayObjectContainer = mc.parent;
		if(parent == null) return false;
		if(aboveMC.parent != parent) return false;
		
		return parent.getChildIndex(mc) == parent.getChildIndex(aboveMC)-1;
	}
	
	/**
	 * Returns if mc is just first above the belowMC.
	 * if them don't have the same parent, whatever depth they has just return false.
	 * @see #isJustBelow
	 */	
	public static function isJustAbove(mc:DisplayObject, belowMC:DisplayObject):Boolean{
		return isJustBelow(belowMC, mc);
	}
}
	
}