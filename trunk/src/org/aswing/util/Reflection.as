/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.util
{
	
import flash.utils.getQualifiedClassName;

public class Reflection
{
	
	public function getFullClassName(o:*):String{
		return getQualifiedClassName(o);
	}
	
	public function getClassName(o:*):String{
		var name:String = getFullClassName(o);
		var lastI:int = name.lastIndexOf(".");
		if(lastI >= 0){
			name = name.substr(lastI+1);
		}
		return name;
	}
	
	public function getPackageName(o:*):String{
		var name:String = getFullClassName(o);
		var lastI:int = name.lastIndexOf(".");
		if(lastI >= 0){
			return name.substring(0, lastI);
		}else{
			return "";
		}
	}
}

}