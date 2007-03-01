/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	import org.aswing.graphics.Graphics2D;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.*;
	import mx.validators.ValidationResult;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	
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
	public class LoadIcon implements Icon
	{
		private var url:String;
		private var width:Number;
		private var height:Number;
		private var scale:Boolean; 
		private var sizeInited:Boolean;
		private var loader:Loader;
		private var maskMC:Sprite;
		private var loaded:Boolean;
		
		private var c:Component;
		private var g:Graphics2D;
		private var x:int;
		private var y:int;
		
		public function LoadIcon(url:String, width:Number=0, height:Number=0, scale:Boolean=false){
			this.url = url;
			this.width = width;
			this.height = height;
			this.scale = scale;
			this.loaded = false;
			this.sizeInited = true;
			if (width == 0 || height == 0){
				sizeInited = false;
			}
		}
		
		private function createLoader():Loader{
			if (loader == null){
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.INIT, __onLoadInit);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, __onLoadError);
				
			}
			return loader;
		}
		
		private function createMask():Sprite{
			if (maskMC == null){
				maskMC = new Sprite();
				maskMC.graphics.beginFill(0xFF0000);
				maskMC.graphics.drawRect(0, 0, 1, 1);
				maskMC.visible = false;
			}
			return maskMC;
		}
		
		private function __onLoadInit(e:Event):void{
			loaded = true;
			if(!sizeInited){
				this.width = loader.width;
				this.height = loader.height;
				sizeInited = true;
				c.revalidate();
			}			
			updateIcon(c, g, x, y);
		}
		
		private function __onLoadError(e:IOErrorEvent):void{
			loaded = true;
		}
		
		public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void
		{
			this.c = c;
			this.g = g;
			this.x = x;
			this.y = y;
			if (loaded){
				loader.x = x;
				loader.y = y;
				if(loader.width == width && loader.height == height){
					loader.mask = null;
				}else if(scale){
					loader.width = width;
					loader.height = height;
					loader.mask = null;
				}else{
					maskMC.x = c.x+x;
					maskMC.y = c.y+y;
					maskMC.width = width;
					maskMC.height = height;
					loader.mask = maskMC;
				}
			}else{
				loader = createLoader();
				maskMC = createMask();
				reload();
			}
		}
		
		private function reload():void{
			if (url != null){
				loaded = false;
				loader.load(new URLRequest(url));
			}
		}
		
		public function getIconHeight():int
		{
			return height;
		}
		
		public function getIconWidth():int
		{
			return width;
		}
		
		public function getDisplay():DisplayObject
		{
			return createLoader();
		}
		
	}
}