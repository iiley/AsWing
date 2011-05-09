package org.aswing.util;


import flash.utils.Dictionary;
	
/**
 * WeakReference, the value will be weak referenced.
 * @author paling
 */
class WeakReference{
	
	private var weakDic:Dictionary;
	
	public function new(){
 
	}
	
	public function set_value(v:Dynamic):Dynamic{
		if(v == null){
			weakDic = null;
		}else{
			weakDic = new Dictionary(true);
			untyped weakDic[v] = null;
		}
	
			return v;
		}
	
	public function get_value():Dynamic{
		if (weakDic != null)	{
			var itr:Iterator<Dynamic> = untyped __keys__(weakDic).iterator();	  	 
			for(v in itr){
		 
				return v;
			}
		}
		return null;
	}
	
	/**
	 * Clear the value, same to <code>WeakReference.value=null;</code>
	 */
	public function clear():Void{
		weakDic = null;
	}

		public var value(get_value,set_value):Dynamic;
}