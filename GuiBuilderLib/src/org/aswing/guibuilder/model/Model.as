package org.aswing.guibuilder.model{

public interface Model{
	
	function applyProperty(name:String, value:*, action:String):void;
	
	function captureProperty(name:String):*;
	
	function getProperties():Array;
	
	function parse(xml:*):void;
	
	function encodeXML():XML;
}
}