package org.aswing.guibuilder.util{

public class MathUtils{
	
	public static function parseInteger(str:String):int{
		var i:int = parseInt(str);
		if(isNaN(i)){
			return 0;
		}
		return i;
	}
	
}
}