package org.aswing.guibuilder.property{

import org.aswing.guibuilder.util.MathUtils;
import org.aswing.guibuilder.model.ProModel;	

public class NumberSerializer extends IntSerializer{
	
	override public function decodeValue(valueXML:XML, pro:ProModel):*{
		return MathUtils.parseNumber(xml.@value);
	}
}
}