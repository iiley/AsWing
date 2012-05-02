/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.util;

  
import org.aswing.error.Error;
/**
 * To successfully store and retrieve (key->value) mapping from a HashMap.
 * HashMap accept any type of object to be the key: number, string, Object etc... 
 * But it is only get fast accessing with string type keys. Others are slow.
 * <p>
 * ----------------------------------------------------------
 * This example creates a HashMap of friends. It uses the number of the friends as keys:
 * <listing>
 *     function person(name,age,sex){
 *         this.name=name;
 *         this.age=age;
 *         this.sex=sex;
 *     }
 *     var friends = new HashMap();
 *     friends.put("one", new person("paling",21,"M"));
 *     friends.put("two", new person("gothic man",22,"M"));
 *     friends.put("three", new person("rock girl",19,"F"));
 * </listing>
 * </p>
 * <p>To retrieve a friends, use the following code:
 *
 * <listing>
 *     var thisperson = friends.get("two");
 *     if (thisperson != null) {
 *         trace("two name is "+thisperson.name);
 *         trace("two age is "+thisperson.age);
 *         trace("two sex is "+thisperson.sex);
 *     }else{
 *         trace("two is not in friends!");
 *     }
 * </listing>
 *</p>
 * @author paling
 */	
 
 

#if flash
import flash.utils.TypedDictionary;
#end


class HashMap <T> {
	
	private var length:Int;
	#if flash
	
	/** @private */ private var dictionary:TypedDictionary <Dynamic, T>;
	
	#else
	
	/** @private */ private var hash:IntHash <T>;
	
	#end
	
	/** @private */ private static var nextObjectID:Int = 0;
	
	
	public function new () {
		
		#if flash
		
		dictionary = new TypedDictionary <Dynamic, T> ();
		
		#else
		
		hash = new IntHash <T> ();
		
		#end
		length = 0;
	}
	
	
	public inline function exists (key:Dynamic):Bool {
		
		#if flash
		
		return dictionary.exists (key);
		
		#else
		
		return hash.exists (getID (key));
		
		#end
		
	}
	
	
	public inline function get (key:Dynamic):T {
		
		#if flash
		
		return dictionary.get (key);
		
		#else
		
		return hash.get (getID (key));
		
		#end
		
	}
	
	
	/** @private */ private inline function getID (key:Dynamic):Int {
		
		#if cpp
		
		return untyped __global__.__hxcpp_obj_id (key);
		
		#else
		
		if (key.___id___ == null) {
			
			key.___id___ = nextObjectID ++;
			
			if (nextObjectID == #if neko 0x3fffffff #else 0x7fffffff #end) {
				
				nextObjectID = 0;
				
			}
			
		}
		
		return key.___id___;
		
		#else
		
		return 0;
		
		#end
		
	}
	
	
	public inline function iterator ():Iterator <T> {
		
		#if flash
		
		var values:Array <T> = new Array <T> ();
		
		for (key in dictionary.iterator ()) {
			
			values.push (dictionary.get (key));
			
		}
		
		return values.iterator ();
		
		#else
		
		return hash.iterator ();
		
		#end
		
	}
	
	
	public inline function keys ():Iterator <Dynamic> {
		
		#if flash
		
		return dictionary.iterator ();
		
		#else
		
		return hash.keys ();
		
		#end
		
	}
	
	
	public inline function remove (key:Dynamic):Void {
		
		#if flash
		
		dictionary.delete (key);
		
		#else
		
		hash.remove (getID (key));
		
		#end
		length--;
	}
	
	
	public inline function set (key:Dynamic, value:T):Void {
		
		#if flash
		
		dictionary.set (key, value);
		
		#else
		
		hash.set (getID (key), value);
		
		#end
		
	}
	
	
	 
 	//-------------------public methods--------------------

 	/**
  	 * Returns the number of keys in this HashMap.
  	 */
 	public function size():Int{
  		return length;
 	}

 	/**
  	 * Returns if this HashMap maps no keys to values.
  	 */
 	public function isEmpty():Bool{
  		return (length==0);
 	}

 
 	
 	/**
 	 * Call func(key) for each key.
 	 * @param func the function to call
 	 */
 	public function eachKey(func:Dynamic -> Void):Void {
	 
  		for(i in keys()){
  			func(i);
  		}
 	}
 	
 	/**
 	 * Call func(value) for each value.
 	 * @param func the function to call
 	 */ 	
 	public function eachValue(func:Dynamic -> Void):Void{ 
  		for(i in iterator()){
  			func(i);
  		}
 	}
  
 	/**
  	 * Tests if some key maps into the specified value in this HashMap. 
  	 * This operation is more expensive than the containsKey method.
  	 */
 	public function containsValue(value:T):Bool{
  		var itr:Iterator<T> =  iterator();	
  		for(i in itr){
   			if(i == value){
    			return true;
   			}
  		}
 		return false;
 	}

 	/**
  	 * Tests if the specified object is a key in this HashMap.
  	 * This operation is very fast if it is a string.
     * @param   key   The key whose presence in this map is to be tested
     * @return <tt>true</tt> if this map contains a mapping for the specified
  	 */
 	public function containsKey(key:Dynamic ):Bool {
 
  		return exists(key);
 	}
	
 	 
 	
 	/**
 	 * Same functionity method with different name to <code>get</code>.
 	 * 
     * @param   key the key whose associated value is to be returned.
     * @return  the value to which this map maps the specified key, or
     *          <tt>null</tt> if the map contains no mapping for this key
     *           or it is null value originally.
 	 */
 	public function getValue(key:Dynamic):Dynamic{
 		return get(key);
 	}

 	/**
 	 * Associates the specified value with the specified key in this map. 
 	 * If the map previously contained a mapping for this key, the old value is replaced. 
 	 * If value is null, means remove the key from the map.
     * @param key key with which the specified value is to be associated.
     * @param value value to be associated with the specified key. null to remove the key.
     * @return previous value associated with specified key, or <tt>null</tt>
     *	       if there was no mapping for key.  A <tt>null</tt> return can
     *	       also indicate that the HashMap previously associated
     *	       <tt>null</tt> with the specified key.
  	 */
 	public function put(key:Dynamic, value:T):T {
		if (!exists(key)) length++;
		set(key, value);
		return value;
 	}
 
 	/**
 	 * Clears this HashMap so that it contains no keys no values.
 	 */
 	public function clear():Void{
		var itr:Iterator<T> =  iterator();	
  		for(i in itr){
   			remove(itr);
  		}
 	}

 	/**
 	 * Return a same copy of HashMap object
 	 */
 	public function clone():HashMap<T>{
  		var temp:HashMap<T> = new HashMap<T>();
  		var itr:Iterator<Dynamic> =  keys();	
  		for(i in itr){
   			 temp.put(i , get(i));
  		}
  		return temp;
 	}
 	
}