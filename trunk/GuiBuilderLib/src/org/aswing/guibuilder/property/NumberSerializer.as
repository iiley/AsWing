package org.aswing.guibuilder.property{

import org.aswing.guibuilder.util.MathUtils;	

public class NumberSerializer extends IntSerializer{
	
	override public function decodeValue(valueXML:XML):*{
		return MathUtils.parseNumber(xml.@value);
	}
}
}