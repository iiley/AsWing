package org.aswing.guibuilder{

import org.aswing.Component;	

/**
 * The interface for component property editors.
 * @author iiley
 */
public interface PropertyEditor{
	
	function getDisplay():Component;
	
	function setApplyFunction(apply:Function):void;
	
	function applyProperty():void;
}
}