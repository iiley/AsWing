/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.tree;

 
	
/**
 * A hash map that accept TreePath key.
 * @author paling
 */	
class TreePathMap{
	
	private var map:IntHash<Dynamic>; 
	private var keyMap:IntHash<TreePath>; 
	public function new() {
		keyMap=	new IntHash<TreePath>(); 
		map = new IntHash<Dynamic>(); 
	}
	
 	public function size():Int {
		var len:Int = 0;
		for (i  in map.keys())
		{
			len++;
		}
  		return len;
 	}
 	
 	public function isEmpty():Bool {
		var len:Int = 0;
		for (i  in map.keys())
		{
			len++;
		}	
  		return len==0;
 	}

 	public function keys():Iterator<TreePath>{
  		return keyMap.iterator();
 	}
 	
 	/**
  	 * Returns an Array of the values in this HashMap.
  	 */
 	public function values():Iterator<Dynamic>{
  		return map.iterator();
 	}
 	
 	public function containsValue(value:Dynamic):Bool {
		for (i  in map.keys())
		{
			if(map.get(i)==value)return true;
		}	
		
 		return false;
 	}

 	public function containsKey(key:TreePath):Bool { 
		
 		return keyMap.get(key.getLastPathComponent().getAwmlIndex())!=null;
 	}

 	public function get(key:TreePath):Dynamic {
  		return map.get(key.getLastPathComponent().getAwmlIndex());
 	}
 	
 	public function getValue(key:TreePath):Dynamic{
  		return map.get(key.getLastPathComponent().getAwmlIndex());
 	}

 	public function put(key:TreePath, value:Dynamic):Dynamic { 
		keyMap.set(key.getLastPathComponent().getAwmlIndex(), key);
  		return map.set(key.getLastPathComponent().getAwmlIndex(), value);
 	}

 	public function remove(key:TreePath):Dynamic{
 		 keyMap.remove(key.getLastPathComponent().getAwmlIndex());
 		return map.remove(key.getLastPathComponent().getAwmlIndex());
 	}

 	public function clear():Void { 
		keyMap = new IntHash<TreePath>();
  		map= new IntHash<Dynamic>(); 
 	}

 	/**
 	 * Return a same copy of HashMap object
 	 */
 	public function clone():TreePathMap{
  		var temp:TreePathMap = new TreePathMap();
  		temp.map = new IntHash<Dynamic>(); 
		temp.keyMap = new IntHash<TreePath>();
		for (key  in keys())
		{
			temp.keyMap.set(key.getLastPathComponent().getAwmlIndex(), key);
  		    temp.map.set(key.getLastPathComponent().getAwmlIndex(), map.get(key.getLastPathComponent().getAwmlIndex()));
		}
  		return temp;
 	}

 	public function toString():String{
  		return map.toString();
 	}
}