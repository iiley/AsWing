package org.aswing.guibuilder.model{

public interface Model{
	
	function applyProperty(name:String, value:*, action:String):void;
	
	function getProperties():Array;
}
}