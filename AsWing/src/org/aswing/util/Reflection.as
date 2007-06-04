/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.util{
	
import flash.utils.getQualifiedClassName;
import flash.system.ApplicationDomain;
import flash.display.DisplayObject;

public class Reflection{
	
	public static function createDisplayObjectInstance(fullClassName:String, applicationDomain:ApplicationDomain=null):DisplayObject{
		if(applicationDomain == null){
			applicationDomain = ApplicationDomain.currentDomain;
		}
		var assetClass:Class = applicationDomain.getDefinition(fullClassName) as Class;
		return new assetClass() as DisplayObject;
	}
	
	public static function getFullClassName(o:*):String{
		return getQualifiedClassName(o);
	}
	
	public static function getClassName(o:*):String{
		var name:String = getFullClassName(o);
		var lastI:int = name.lastIndexOf(".");
		if(lastI >= 0){
			name = name.substr(lastI+1);
		}
		return name;
	}
	
	public static function getPackageName(o:*):String{
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