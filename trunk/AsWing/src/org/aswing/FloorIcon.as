package org.aswing
{
import org.aswing.graphics.Graphics2D;
import flash.display.DisplayObject;
import flash.display.Sprite;
import org.aswing.error.ImpMissError;
import flash.geom.Rectangle;

/**
 * Abstract class for A icon with a decorative displayObject.
 * <p> External content will be load automatically when the pane was create on the stage if floorEnabled.
 * @see org.aswing.AttachIcon
 * @see org.aswing.LoadIcon
 * @author senkay
 */	
public class FloorIcon implements Icon
{
	private var path:String;
	private var width:Number;
	private var height:Number;
	private var scale:Boolean; 
	private var sizeInited:Boolean;
	private var floorMC:DisplayObject;
	private var scrollRect:Rectangle;
	private var floorLoaded:Boolean;
	
	/**
	 * FloorIcon(floorMC:DisplayObject,, width:Number, height:Number, scale:Boolean)<br>
	 * FloorIcon(floorMC:DisplayObject, width:Number, height:Number)<br>)<br>
	 * FloorIcon(floorMC:DisplayObject)<br>
	 * <p>
	 * Creates a FloorIcon with a path to load external content.
	 * @param path the path of the external content.
	 * @param width (optional)if you specifiled the width of the Icon, and scale is true,
	 * the mc will be scale to this width when paint.
	 * @param height (optional)if you specifiled the height of the Icon, and scale is true, 
	 * the mc will be scale to this height when paint.
	 * @param scale (optional)whether scale MC to fix the width and height specified. Default is true
	 */
	public function FloorIcon(floorMC:DisplayObject=null, width:Number=0, height:Number=0, scale:Boolean=false){
		this.floorMC = floorMC;
		this.width = width;
		this.height = height;
		this.scale = scale;
		this.sizeInited = true;		
		this.floorLoaded = false;
		if (width==0 || height==0){
			sizeInited = false;
		}
		scrollRect = createScrollRect();
		setLoaded(floorMC != null);
		reload();
	}
	
	protected function setSizeInited(b:Boolean):void{
		sizeInited = b;
	}
	
	protected function isSizeInited():Boolean{
		return sizeInited;
	}
	
	protected function setLoaded(b:Boolean):void{
		floorLoaded = b;
	}
	
	/**
	 * Returns is the extenal image/animation file was loaded ok.
	 * @return true if the file loaded ok, otherwish return false
	 */
	public function isLoaded():Boolean{
		return floorLoaded;
	}
	
	protected function setWidth(width:Number):void{
		this.width = width;
	}
	
	protected function setHeight():void{
		this.height = height;
	}
	
	/**
	 * Updates the icon. is displayObject is not load then reload
	 * @see #reload()
	 * @param c the component which owns the icon.
	 * @param g the graphics of the component, you can paint picture onto it.
	 * @param x the x coordinates of the icon should be.
	 * @param y the y coordinates of the icon should be.
	 */
	public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void
	{
		if (isLoaded()){
			var floor:DisplayObject = getDisplay();
			if(!isSizeInited()){
				this.width = floor.width;
				this.height = floor.height;
				this.setSizeInited(true);
				c.revalidate();
				return;
			}
			floor.x = x;
			floor.y = y;
			if(floor.width == width && floor.height == height){
				floor.scrollRect = null;
			}else if(scale){
				floor.width = width;
				floor.height = height;
				floor.scrollRect = null;
			}else{
				scrollRect.width = width;
				scrollRect.height = height;
				floor.scrollRect = scrollRect;
			}
		}
	}
	
	/**
	 * Reload the floor image/animation
	 * @see org.aswing.LoadIcon
	 * @see org.aswing.AttachIcon
	 */
	protected function reload():void{
	}
	
	/**
	 * create the mask of the displayObject
	 */
	protected function createScrollRect():Rectangle{
		if (scrollRect == null){
			scrollRect = new Rectangle(0,0,1,1);
		}
		return scrollRect;
	}
	
	public function getIconHeight():int
	{
		return height;
	}
	
	public function getIconWidth():int
	{
		return width;
	}
	
	/**
	 * Returns the display object which is used as the component decorator.
	 */	
	public function getDisplay():DisplayObject
	{
		return floorMC;
	}
	
}
}