/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	
import flash.display.*;
import flash.events.*;

import org.aswing.geom.*;
import org.aswing.util.*;
import flash.net.URLRequest;

/**
 * Dispatched when data has loaded successfully. The complete event is always dispatched after the init event. 
 * @eventType flash.events.Event.COMPLETE
 */
[Event(name="complete", type="flash.events.Event")]

/**
 * Dispatched when a network request is made over HTTP and Flash Player can detect the HTTP status code.  
 * @eventType flash.events.HTTPStatusEvent.HTTP_STATUS
 */
[Event(name="httpStatus", type="flash.events.HTTPStatusEvent")]

/**
 * Dispatched when the properties and methods of a loaded SWF file are accessible. A LoaderInfo object dispatches the init event when the following two conditions exist:  
 * @eventType flash.events.Event.INIT 
 */
[Event(name="init", type="flash.events.Event")]

/**
 * Dispatched when an input or output error occurs that causes a load operation to fail. 
 * @eventType flash.events.IOErrorEvent.IO_ERROR 
 */
[Event(name="ioError", type="flash.events.IOErrorEvent")]

/**
 * Dispatched when a load operation starts. 
 * @eventType  flash.events.Event.OPEN
 */
[Event(name="open", type="flash.events.Event")]

/**
 * Dispatched when data is received as the download operation progresses. 
 * @eventType flash.events.ProgressEvent.PROGRESS 
 */
[Event(name="progress", type="flash.events.ProgressEvent")]

/**
 * Dispatched if a call to the load() method of a Loader object attempts to load data from a server outside the security sandbox. 
 * To prevent this error, you can place a policy file on the server. 
 * Details about the error are included in the text property of the dispatched SecurityErrorEvent object. 
 * @eventType flash.events.SecurityErrorEvent.SECURITY_ERROR 
 */
[Event(name="securityError", type="flash.events.SecurityErrorEvent")]

/**
 * Dispatched by a LoaderInfo object whenever a loaded object is removed by using the unload() method of the Loader object, 
 * or when a second load is performed by the same Loader object and the original content is removed prior to the load beginning. 
 * @eventType flash.events.Event.UNLOAD
 */
[Event(name="unload", type="flash.events.Event")]
/**
 * JLoadPane, a container load a external image/animation to be its floor.
 * @see org.aswing.JAttachPane
 * @author iiley
 */	
public class JLoadPane extends FloorPane
{
	private var loader:Loader;
	private var loadedError:Boolean;
	private var lockroot:Boolean;
	
	/**
	 * JLoadPane(path:String, prefferSizeStrategy:Number) <br>
	 * JLoadPane(path:String) prefferSizeStrategy default to PREFER_SIZE_BOTH<br>
	 * JLoadPane() path default to null,prefferSizeStrategy default to PREFER_SIZE_BOTH<br>
	 * Creates a JLoadPane with a path to load external image or animation file.
	 * @param path the path of the extenal image/animation file.
	 * @param prefferSizeStrategy the prefferedSize count strategy. Must be one of below:
	 * <ul>
	 * <li>{@link org.aswing.FloorPane#PREFER_SIZE_BOTH}
	 * <li>{@link org.aswing.FloorPane#PREFER_SIZE_IMAGE}
	 * <li>{@link org.aswing.FloorPane#PREFER_SIZE_LAYOUT}
	 * </ul>
	 * @see #setPath()
	 */
	public function JLoadPane(path:String, prefferSizeStrategy:int) {
		super(path, prefferSizeStrategy);
		setName("JLoadPane");
		loadedError = false;
	}
	
	/**
	 * Returns the loader.
	 * @return the loader.
	 * @see #getFloorMC()
	 */
	override public function getFloorMC():DisplayObject{
		return loader;
	}
	
	/**
	 * remove mask,floor,loader and listenner
	 */
	override protected function removeFloorMCs():void{
		removeListenners();
		super.removeFloorMCs();
		loader = null;
	}
	private function removeListenners():void{
		if (loader != null){
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, __onLoadComplete);
			loader.contentLoaderInfo.removeEventListener(Event.INIT, __onLoadInit);
			loader.contentLoaderInfo.removeEventListener(Event.OPEN, __onLoadStart);
			loader.contentLoaderInfo.removeEventListener(Event.UNLOAD, __onUnload);
			loader.contentLoaderInfo.removeEventListener(HTTPStatusEvent.HTTP_STATUS, __onLoadHttpStatus);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, 	__onLoadProgress);
		}
	}
	
	/**
	 * Returns is error loaded.
	 * @see #ON_LOAD_ERROR
	 */
	public function isLoadedError():Boolean{
		return loadedError;
	}
	
	/**
	 * load the floor content.
	 * <p> here it is empty.
	 * Subclass must override this method to make loading.
	 */
	override protected function loadFloor():void{
		if (loader != null && path != null){
			loadedError = false;
			loader.load(new URLRequest(path));
		}
	}
	
	/**
	 * Create the floor mc.
	 * <p> here it is empty.
	 * Subclass must override this method to make creating.
	 */
	override protected function createFloor():DisplayObject{
		if (loader == null){
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __onLoadComplete);
			loader.contentLoaderInfo.addEventListener(Event.INIT, __onLoadInit);
			loader.contentLoaderInfo.addEventListener(Event.OPEN, __onLoadStart);
			loader.contentLoaderInfo.addEventListener(Event.UNLOAD, __onUnload);
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, __onLoadHttpStatus);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onLoadError, false, 0, true);	
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, 	__onLoadProgress);		
		}
		return loader;
	}
	
	/**
	 * Sets whether the _root refers of the loaded swf file is locked to itself.(default value is false)
	 * @param b whether the _root refers of the loaded swf file is locked to itself.
	 * @see adobe doc about this {@link http://livedocs.macromedia.com/flash/8/main/wwhelp/wwhimpl/js/html/wwhelp.htm?href=Part4_ASLR2.html}
	 */
	public function setLockroot(b:Boolean):void{
		lockroot = b;
	}
	
	/**
	 * Returns a Boolean value that specifies what _root refers to when the SWF file is loaded into the pane.(default value is false)
	 * @return whether the _root refers of the loaded swf file is locked to itself
	 * @see adobe doc about this {@link http://livedocs.macromedia.com/flash/8/main/wwhelp/wwhimpl/js/html/wwhelp.htm?href=Part4_ASLR2.html}
	 */
	public function isLockroot():Boolean{
		return lockroot;
	}
	
	/**
	 * Returns a object contains <code>bytesLoaded</code> and <code>bytesTotal</code> 
	 * properties that indicate the current loading status.
	 */
	public function getProgress():Object{
		var object:Object = new Object();
		object.bytesLoaded = loader.loaderInfo.bytesLoaded;
		object.bytesTotal = loader.loaderInfo.bytesTotal;
		return object;
	}
	
	//-----------------------------------------------

	private function __onLoadComplete(e:Event):void{
		dispatchEvent(new Event(Event.COMPLETE));
	}
	
	private function __onLoadError(e:IOErrorEvent):void{
		loadedError = true;
		dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, e.toString()));
	}
	
	private function __onLoadInit(e:Event):void{
		setFloorOriginalSize(new IntDimension(loader.width, loader.height));
		setLoaded(true);
		valid = false;
		dispatchEvent(new Event(Event.INIT));
		revalidate();
		validate();
	}
	
	private function __onLoadProgress(e:ProgressEvent):void{
		dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, e.bytesLoaded, e.bytesTotal));
	}
	
	private function __onLoadStart(e:Event):void{
		dispatchEvent(new Event(Event.OPEN));
	}
	
	private function __onUnload(e:Event):void{
		dispatchEvent(new Event(Event.UNLOAD));
	}
	
	private function __onLoadHttpStatus(e:HTTPStatusEvent):void{
		dispatchEvent(new HTTPStatusEvent(HTTPStatusEvent.HTTP_STATUS,false,false,e.status));		
	}
	
}
}