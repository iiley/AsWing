/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf
{
	
import org.aswing.*;
import org.aswing.error.ImpMissError;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;

/**
 * The base class for ComponentUI.
 */
public class BaseComponentUI implements ComponentUI
{
	
	private var defaults:UIDefaults;
	
	public function putDefault(key:String, value:*):void
	{
		if(defaults == null){
			defaults = new UIDefaults();
		}
		defaults.put(key, value);
	}
	
	public function getDefault(key:String):*{
		if(containsDefaultsKey(key)){
			return defaults.get(key);
		}else{
			return UIManager.get(key);
		}
	}
	
	public function getDefaultInstance(key:String):*{
		if(containsDefaultsKey(key)){
			return defaults.getInstance(key);
		}else{
			return UIManager.getInstance(key);
		}
	}
	
	public function getMaximumSize(c:Component):IntDimension
	{
		return IntDimension.createBigDimension();
	}
	
	public function uninstallUI(c:Component):void
	{
		throw new ImpMissError();
	}
	
	public function getMinimumSize(c:Component):IntDimension
	{
		return c.getInsets().getOutsideSize();
	}
	
	public function getPreferredSize(c:Component):IntDimension
	{
		throw new ImpMissError();
		return null;
	}
	
	public function paint(c:Component, g:Graphics2D, b:IntRectangle):void
	{
		paintBackGround(c, g, b);
	}
	
	public function installUI(c:Component):void
	{
		throw new ImpMissError();
	}
	
	protected function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):void{
		if(c.isOpaque()){
			g.fillRectangle(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height);
		}
	}	
	//-----------------------------------------------------------
	//           Convernent methods
	//-----------------------------------------------------------

	public function containsDefaultsKey(key:String):Boolean{
		return defaults != null && defaults.containsKey(key);
	}
	
	public function getBoolean(key:String):Boolean{
		if(containsDefaultsKey(key)){
			return defaults.getBoolean(key);
		}
		return UIManager.getBoolean(key);
	}
	
	public function getNumber(key:String):Number{
		if(containsDefaultsKey(key)){
			return defaults.getNumber(key);
		}
		return UIManager.getNumber(key);
	}
	
	public function getInt(key:String):int{
		if(containsDefaultsKey(key)){
			return defaults.getInt(key);
		}
		return UIManager.getInt(key);
	}
	
	public function getUint(key:String):uint{
		if(containsDefaultsKey(key)){
			return defaults.getUint(key);
		}
		return UIManager.getUint(key);
	}
	
	public function getString(key:String):String{
		if(containsDefaultsKey(key)){
			return defaults.getString(key);
		}
		return UIManager.getString(key);
	}
	
	public function getBorder(key:String):Border{
		if(containsDefaultsKey(key)){
			return defaults.getBorder(key);
		}
		return UIManager.getBorder(key);
	}
	
	public function getIcon(key:String):Icon{
		if(containsDefaultsKey(key)){
			return defaults.getIcon(key);
		}
		return UIManager.getIcon(key);
	}
	
	public function getGroundDecorator(key:String):GroundDecorator{
		if(containsDefaultsKey(key)){
			return defaults.getGroundDecorator(key);
		}
		return UIManager.getGroundDecorator(key);
	}
	
	public function getColor(key:String):ASColor{
		if(containsDefaultsKey(key)){
			return defaults.getColor(key);
		}
		return UIManager.getColor(key);
	}
	
	public function getFont(key:String):ASFont{
		if(containsDefaultsKey(key)){
			return defaults.getFont(key);
		}
		return UIManager.getFont(key);
	}
	
	public function getInsets(key:String):Insets{
		if(containsDefaultsKey(key)){
			return defaults.getInsets(key);
		}
		return UIManager.getInsets(key);
	}
	
	public function getInstance(key:String):Object{
		if(containsDefaultsKey(key)){
			return defaults.getInstance(key);
		}
		return UIManager.getInstance(key);
	}
}

}