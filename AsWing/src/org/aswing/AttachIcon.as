/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.utils.*;

import org.aswing.event.AttachEvent;
import org.aswing.graphics.Graphics2D;
import flash.display.Sprite;

/**
 * Attach a displayObject from library with the linkage name to be a icon.
 * @author senkay
 */
public class AttachIcon extends FloorIcon
{
	private var attachErrored:Boolean;
	private var loader:Loader;
	private var c:Component;
	private var attachMC:DisplayObject;
	
	/**
	 * AttachIcon(linkage:String, loader:Loader, width:Number, height:Number, scale:Boolean)<br>
	 * AttachIcon(linkage:String, loader:Loader, width:Number, height:Number)<br>
	 * AttachIcon(linkage:String, loader:Loader)<br>
	 * AttachIcon(linkage:String)<br>
	 * <p>
	 * Attach a mc from library to be a icon.<br>
	 * If speciaficed the width and height, the mc will be scale to be this size if scale setted true.
	 * else the width and height will be the symbol's _width and _height.
	 * @param linkage the linkageID of the symbol to attach
	 * @param loader the loaderObject with attach symbol,if loader is null then loader is root
	 * @param width (optional)if you specifiled the width of the Icon, and scale is true,
	 * the mc will be scale to this width when paint.
	 * @param height (optional)if you specifiled the height of the Icon, and scale is true, 
	 * the mc will be scale to this height when paint.
	 * @param scale (optional)whether scale MC to fix the width and height specified. Default is true
	 */
	public function AttachIcon(linkage:String, loader:Loader=null, width:Number=0, height:Number=0, scale:Boolean=false){
		this.loader = loader;
		this.attachErrored = false;
		super(linkage, width, height, scale);
	}
	
	/**
	 * update the icon when the displayObject is not null
	 * @see #updateIcon();
	 * @see org.aswing.LoadIcon
	 * @see org.aswing.AttachIcon
	 */
	override public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void{
		this.c = c;
		super.updateIcon(c, g, x, y);
	}
	
	/**
	 * update the icon when the displayObject is not null
	 * @see #updateIcon();
	 * @see org.aswing.LoadIcon
	 * @see org.aswing.AttachIcon
	 */
	override protected function reload():void{
		if (this.getDisplay() != null){
			setLoaded(true);
			c.updateUI();
		}
	}
	
	/**
	 * return the attach displayObject
	 * if cannot create from Class then return null
	 */
	private function getAttachDisplayObject():DisplayObject{
		try{
			var classReference:Class;
			if (loader == null){
				classReference = getDefinitionByName(this.getPath()) as Class;
			}else{
				classReference = loader.contentLoaderInfo.applicationDomain.getDefinition(this.getPath()) as Class;
			}
			attachMC = new classReference();
			return attachMC;
		}catch(e:Error){
			attachErrored = true;
			trace("createFloor error:"+e.toString());
			return null;
		}
		return null;
	}
	
	override public function getDisplay():DisplayObject
	{
		if (attachMC!=null)
			return attachMC;
		else if (attachErrored)
			return null;
		else
			return getAttachDisplayObject();
	}	
}
}