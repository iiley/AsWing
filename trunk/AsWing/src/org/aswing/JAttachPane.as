/*
 Copyright aswing.org, see the LICENCE.txt.
*/
	
package org.aswing { 
	
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.utils.*;

import org.aswing.event.AttachEvent;
import org.aswing.geom.IntDimension;
import flash.display.Loader;
import flash.display.Sprite;
import flash.events.*;
import flash.net.URLRequest;

/**
 * Dispatched when when the symbol was attached.
 * @eventType org.aswing.event.AttachEvent.ATTACHED
 */
[Event(name="attached", type="org.aswing.event.AttachEvent")]
/**
 * JAttachPane, a container attach flash symbol in library to be its floor.
 * @see org.aswing.JLoadPane
 * @author iiley
 */
public class JAttachPane extends FloorPane {
	
	private var loader:Loader;
	private var loadpath:String;
	private var loading:Boolean;
	/**
	 * JAttachPane(path:String, prefferSizeStrategy:int) <br>
	 * JAttachPane(path:String) prefferSizeStrategy default to PREFER_SIZE_BOTH<br>
	 * JAttachPane() path default to null,prefferSizeStrategy default to PREFER_SIZE_BOTH<br>
	 * Creates a JAttachPane with a path to attach a symbol from library
	 * @param path the linkageID of the symbol in library
	 * @param prefferSizeStrategy the prefferedSize count strategy. Must be one of below:
	 * <ul>
	 * <li>{@link org.aswing.FloorPane#PREFER_SIZE_BOTH}
	 * <li>{@link org.aswing.FloorPane#PREFER_SIZE_IMAGE}
	 * <li>{@link org.aswing.FloorPane#PREFER_SIZE_LAYOUT}
	 * </ul>
	 * @see #setPath()
	 */
	public function JAttachPane(path:String, prefferSizeStrategy:int) {
		super(path, prefferSizeStrategy);
		this.loader = null;
		this.loadpath = null;
		this.loading = false;
		setName("JAttachPane");
	}
	
	/**
	 * Sets the path to attach displayObject from library of root sprite.
	 * This method will cause <code>reload()</code> action if the path 
	 * is different from old one.
	 * @param path the linkageID of a displayObject.
	 * @see #reload()
	 */
	override public function setPath(path:String):void{
		this.loader = null;
		this.loadpath = null;
		super.setPath(path);
	}
	
	/**
	 * Sets the path to attach displayObject from library of loader.
	 * This method will cause <code>reload()</code> action if the path 
	 * is different from old one.
	 * @param path the linkageID of a displayObject.
	 * @param loader the loader object of the loader with library.
	 * @see #reload()
	 */
	public function setPathAndLoader(path:String, loader:Loader=null):void{
		if(path != this.path || loader != this.loader){
			this.path = path;
			this.loader = loader;
			this.loadpath = null;
			setLoaded(false);
			reload();
		}
	}
	
	/**
	 * Sets the path to attach displayObject from library of loader with loaderpath.
	 * This method will cause <code>reload()</code> action if the path 
	 * is different from old one.
	 * @param path the linkageID of a displayObject.
	 * @param loadpath the path of the swf path with library.
	 * @see #reload()
	 */
	public function setPathAndLoaderPath(path:String, loadpath:String=null):void{
		if(path != this.path || loadpath != this.loadpath){
			this.loadpath = loadpath;
			this.path = path;
			this.loader = null;
			this.loading = false;
			setLoaded(false);
			reload();
		}
	}
	
	override protected function loadFloor():void{
		if (contains(getFloorMC())){
			setLoaded(true);
			revalidate();
		}
	}
	
	/**
	 * Create the floor mc.
	 * <p> here it is empty.
	 * Subclass must override this method to make creating.
	 */
	override protected function createFloor():DisplayObject{
		if (this.getPath() != null){
			if (loadpath != null && !loading){
				return createLoader();
			}else{
				return getAttachDisplayObject();
			}
		}
		return null;
	}
	
	private function createLoader():DisplayObject{
		if (loader == null){
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, __onLoadInit, false, 0, true);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onLoadError, false, 0, true);
		}
		loader.load(new URLRequest(loadpath));
		loading = true;
		return null;		
	}
	
	private function __onLoadInit(e:Event):void{
		setLoaded(false);
		reload();
	}
	
	private function __onLoadError(e:IOErrorEvent):void{
	}
	
	private function getAttachDisplayObject():DisplayObject{
		try{
			var classReference:Class;
			if (loader == null){
				classReference = getDefinitionByName(this.getPath()) as Class;
			}else{
				classReference = loader.contentLoaderInfo.applicationDomain.getDefinition(this.getPath()) as Class;
			}
			var attachMC:DisplayObject = new classReference();
			setFloorOriginalSize(new IntDimension(attachMC.width, attachMC.height));
			dispatchEvent(new AttachEvent(AttachEvent.ATTACHED));
			return attachMC;
		}catch(e:Error){
			trace("createFloor error:"+e.toString());
			return null;
		}
		return null
	}
}
}