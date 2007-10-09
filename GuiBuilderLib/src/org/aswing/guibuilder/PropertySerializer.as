package org.aswing.guibuilder{

import org.aswing.guibuilder.model.ProModel;	

public interface PropertySerializer{
	
	/**
	 * @param valueXML this param should never be null
	 * @param pro the value of the pro model
	 */
	function decodeValue(valueXML:XML, pro:ProModel):*;
	
	/**
	 * @param value this param should never be null unless this type accept null value
	 * @param pro the value of the pro model
	 */
	function encodeValue(value:*, pro:ProModel):XML;
	
	/**
	 * @param value this param should never be null unless this type accept null value
	 * @param pro the value of the pro model
	 */
	function getCodeLines(value:*, pro:ProModel):Array;
	
	/**
	 * @param value this param should never be null unless this type accept null value
	 * @param pro the value of the pro model
	 */	
	function isSimpleOneLine(value:*, pro:ProModel):String;
}
}