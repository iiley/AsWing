package org.aswing.guibuilder.property
{
	import org.aswing.guibuilder.PropertySerializer;
	import org.aswing.guibuilder.model.ProModel;

	public class EmptySerializer implements PropertySerializer
	{
		public function decodeValue(valueXML:XML, pro:ProModel):*
		{
			return null;
		}
		
		public function encodeValue(value:*, pro:ProModel):XML
		{
			return null;
		}
		
		public function getCodeLines(value:*, pro:ProModel):Array
		{
			return null;
		}
		
		public function isSimpleOneLine(value:*, pro:ProModel):String
		{
			return null;
		}
		
	}
}