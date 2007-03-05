/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
import org.aswing.graphics.Graphics2D;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.*;
import flash.net.URLRequest;
import flash.display.Sprite;

/**
 * LoadIcon allow you load extenal image/animation to be the icon content.
 * @author senkay
 */
public class LoadIcon extends FloorIcon
{
	private var loader:Loader;
	private var c:Component;
	private var url:String;
	
	/**
	 * LoadIcon(url:String, width:Number, height:Number, scale:Boolean)<br>
	 * LoadIcon(url:String, width:Number, height:Number) default scale to false<br>
	 * LoadIcon(url:String) the width and height will be count when content loaded
	 * <p>
	 * Creates a LoadIcon with specified url, width, height.
	 * @param url the url of the extenal image/animation file
	 * @param width the width of this icon.(miss this param mean use image width)
	 * @param height the height of this icon.(miss this param mean use image height)
	 * @param scale (optional)whether scale the extenal image/anim to fit the size 
	 * specified by front two params, default is false
	 */
	public function LoadIcon(url:String, width:Number=0, height:Number=0, scale:Boolean=false){
		this.url = url;
		super(getLoader(), width, height, scale);
		this.setLoaded(false);
	}
	
	/**
	 * Return the loader
	 * @return this loader
	 */
	private function getLoader():DisplayObject{
		if (loader == null){
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.INIT, __onLoadInit);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onLoadError);
		}
		return loader;
	}
	
	/**
	 * when the loader init updateUI
	 */
	private function __onLoadInit(e:Event):void{
		this.setLoaded(true);
		c.repaint();
	}
	
	private function __onLoadError(e:IOErrorEvent):void{
		this.setLoaded(true);
	}
	
	override public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void
	{
		this.c = c;
		super.updateIcon(c, g, x, y);
	}
	
	override protected function reload():void{
		if (url != null){
			setLoaded(false);
			loader.load(new URLRequest(url));
		}
	}
}
}