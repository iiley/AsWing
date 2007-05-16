/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{
	
import flash.display.*;
import flash.events.*;
import flash.net.*;
import flash.system.*;

import org.aswing.geom.*;
import org.aswing.util.*;

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
 * JLoadPane, a container load a external image/animation to be its asset.
 * @see org.aswing.JAttachPane
 * @author iiley
 */	
public class JLoadPane extends AssetPane{
	
	private var loader:Loader;
	private var loadedError:Boolean;
	private var urlRequest:URLRequest;
	private var context:LoaderContext;
	
	/**
	 * Creates a JLoadPane with a path to load external image or animation file.
	 * @param url the path string or a URLRequst instance, null to make it do not load any thing.
	 * @param prefferSizeStrategy the prefferedSize count strategy. Must be one of below:
	 * <ul>
	 * <li>{@link org.aswing.AssetPane#PREFER_SIZE_BOTH}
	 * <li>{@link org.aswing.AssetPane#PREFER_SIZE_IMAGE}
	 * <li>{@link org.aswing.AssetPane#PREFER_SIZE_LAYOUT}
	 * </ul>
	 * @param context the loader context.
	 * @see #setPath()
	 */
	public function JLoadPane(url:*, prefferSizeStrategy:int=1, context:LoaderContext = null) {
		super(null, prefferSizeStrategy);
		setName("JLoadPane");
		loadedError = false;
		if(url is URLRequest){
			urlRequest = url;
		}else if(url != null){
			urlRequest = new URLRequest(url);
		}else{
			urlRequest = null;
		}
		this.context = context;
		loader = createLoader();
		loadAsset();
	}
	
	
	/**
	 * Load the asset.
	 * @param request The absolute or relative URL of the SWF, JPEG, GIF, or PNG file to be loaded. 
	 * 		A relative path must be relative to the main SWF file. Absolute URLs must include 
	 * 		the protocol reference, such as http:// or file:///. Filenames cannot include disk drive specifications. 
	 * @param context (default = null) — A LoaderContext object.
	 * @see flash.display.Loader#load()
	 */
	public function load(request:URLRequest, context:LoaderContext = null):void{
		this.urlRequest = request;
		this.context = context;
		loadAsset();
	}
	
	/**
	 * return the path of image/animation file
	 * @return the path of image/animation file
	 */ 
	public function getURLRequest():URLRequest{
		return urlRequest;
	}	
	
	/**
	 * Returns is error loaded.
	 * @see #ON_LOAD_ERROR
	 */
	public function isLoadedError():Boolean{
		return loadedError;
	}
	
	protected function loadAsset():void{
		if(urlRequest != null){
			loadedError = false;
			loader.load(urlRequest, context);
		}
	}
	
	protected function createLoader():Loader{
		loader = new Loader();
		loader.contentLoaderInfo.addEventListener(Event.COMPLETE, __onLoadComplete);
		loader.contentLoaderInfo.addEventListener(Event.INIT, __onLoadInit);
		loader.contentLoaderInfo.addEventListener(Event.OPEN, __onLoadStart);
		loader.contentLoaderInfo.addEventListener(Event.UNLOAD, __onUnload);
		loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, __onLoadHttpStatus);
		loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onLoadError);	
		loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, __onLoadProgress);
		return loader;
	}
	
	/**
	 * Returns a object contains <code>bytesLoaded</code> and <code>bytesTotal</code> 
	 * properties that indicate the current loading status.
	 */
	public function getProgress():ProgressEvent{
		return new ProgressEvent(ProgressEvent.PROGRESS, false, false, 
			loader.contentLoaderInfo.bytesLoaded, 
			loader.contentLoaderInfo.bytesTotal);
	}
	
	public function getAssetLoaderInfo():LoaderInfo{
		return loader.contentLoaderInfo;
	}
	
	public function getLoader():Loader{
		return loader;
	}
	
	//-----------------------------------------------

	private function __onLoadComplete(e:Event):void{
		var content:DisplayObject = loader.content;
		loader.unload();
		setAsset(content);
		
		dispatchEvent(new Event(Event.COMPLETE));
	}
	
	private function __onLoadError(e:IOErrorEvent):void{
		loadedError = true;
		setAsset(null);
		dispatchEvent(new IOErrorEvent(IOErrorEvent.IO_ERROR, false, false, e.toString()));
	}
	
	private function __onLoadInit(e:Event):void{
		dispatchEvent(new Event(Event.INIT));
	}
	
	private function __onLoadProgress(e:ProgressEvent):void{
		dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS, false, false, e.bytesLoaded, e.bytesTotal));
	}
	
	private function __onLoadStart(e:Event):void{
		dispatchEvent(new Event(Event.OPEN));
	}
	
	private function __onUnload(e:Event):void{
		//do nothing
	}
	
	private function __onLoadHttpStatus(e:HTTPStatusEvent):void{
		dispatchEvent(new HTTPStatusEvent(HTTPStatusEvent.HTTP_STATUS,false,false,e.status));		
	}
}
}