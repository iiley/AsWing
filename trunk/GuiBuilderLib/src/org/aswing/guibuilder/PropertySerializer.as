package org.aswing.guibuilder{

public interface PropertySerializer{
	
	/**
	 * @param valueXML this param can be null, means default value
	 */		
	function decodeValue(valueXML:XML):*;
	
	/**
	 * @param if the value is default value, null should be returned
	 */
	function encodeValue(value:*):XML;
	
	/**
	 * @param valueXML this param should never be null
	 */
	function getCodeLines(value:*):Array;
	
	/**
	 * @param valueXML this param should never be null
	 */	
	function isSimpleOneLine(value:*):String;
}
}