package org.aswing.guibuilder{

public interface PropertySerializer{
	
	/**
	 * @param valueXML this param should never be null
	 */
	function decodeValue(valueXML:XML):*;
	
	/**
	 * @param value this param should never be null unless this type accept null value
	 */
	function encodeValue(value:*):XML;
	
	/**
	 * @param value this param should never be null unless this type accept null value
	 */
	function getCodeLines(value:*):Array;
	
	/**
	 * @param value this param should never be null unless this type accept null value
	 */	
	function isSimpleOneLine(value:*):String;
}
}