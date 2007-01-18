/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

/**
 * ASColor object to set color and alpha for a movieclip.
 * @author firdosh, iiley, n0rthwood
 */
public class ASColor{
			
	public static const WHITE:ASColor = new ASColor(0xffffff);
	
	public static const LIGHT_GRAY:ASColor = new ASColor(0xc0c0c0);
	
	public static const GRAY:ASColor = new ASColor(0x808080);
	
	public static const DARK_GRAY:ASColor = new ASColor(0x404040);
	
	public static const BLACK:ASColor = new ASColor(0x000000);
	
	public static const RED:ASColor = new ASColor(0xff0000);
	
	public static const PINK:ASColor = new ASColor(0xffafaf);
	
	public static const ORANGE:ASColor = new ASColor(0xffc800);
	
	public static const HALO_ORANGE:ASColor = new ASColor(0xFFC200);
	
	public static const YELLOW:ASColor = new ASColor(0xffff00);
	
	public static const GREEN:ASColor = new ASColor(0x00ff00);
	
	public static const HALO_GREEN:ASColor = new ASColor(0x80FF4D);
	
	public static const MAGENTA:ASColor = new ASColor(0xff00ff);
	
	public static const CYAN:ASColor = new ASColor(0x00ffff);
	
	public static const BLUE:ASColor = new ASColor(0x0000ff);
	
	public static const HALO_BLUE:ASColor = new ASColor(0x2BF5F5);
	
	
	protected var rgb:int;
	protected var alpha:Number;
	
	/**
	 * Create a ASColor
	 */
	public function ASColor (color:int=0x000000, alpha:Number=1){
		setRGB(color);
		setAlpha(alpha);
	}
	
	private function setRGB(rgb:int):void{
		this.rgb = rgb;
	}
	
	protected function setAlpha(alpha:Number):void{
		this.alpha = Math.min(1, Math.max(0, alpha));
	}
	
	/**
	 * Returns the alpha component in the range 0-1.
	 */
	public function getAlpha():Number{
		return alpha;	
	}
	
	/**
	 * Returns the RGB value representing the color.
	 */
	public function getRGB():int{
		return rgb;	
	}
	
	/**
     * Returns the red component in the range 0-255.
     * @return the red component.
     */
	public function getRed():int{
		return (rgb & 0x00FF0000) >> 16;
	}
	
	/**
     * Returns the green component in the range 0-255.
     * @return the green component.
     */	
	public function getGreen():int{
		return (rgb & 0x0000FF00) >> 8;
	}
	
	/**
     * Returns the blue component in the range 0-255.
     * @return the blue component.
     */	
	public function getBlue():int{
		return (rgb & 0x000000FF);
	}
	
	/**
	 * Create a new <code>ASColor</code> with another alpha but same rgb.
	 * @param alpha the new alpha
	 * @return the new <code>ASColor</code>
	 */
	public function changeAlpha(alpha:Number):ASColor{
		return new ASColor(getRGB(), alpha);
	}
	
    /**
     * Creates a new <code>ASColor</code> that is a darker version of this
     * <code>ASColor</code>.
     * @param factor the darker factor(0, 1), default is 0.7
     * @return     a new <code>ASColor</code> object that is  
     *                 a darker version of this <code>ASColor</code>.
     * @see        #brighter()
     */		
	public function darker(factor:Number=0.7):ASColor{
        var r:int = getRed();
        var g:int = getGreen();
        var b:int = getBlue();
		return getASColor(r*factor, g*factor, b*factor, alpha);
	}
	
    /**
     * Creates a new <code>ASColor</code> that is a brighter version of this
     * <code>ASColor</code>.
     * @param factor the birghter factor 0 to 1, default is 0.7
     * @return     a new <code>ASColor</code> object that is  
     *                 a brighter version of this <code>ASColor</code>.
     * @see        #darker()
     */	
	public function brighter(factor:Number=0.7):ASColor{
        var r:int = getRed();
        var g:int = getGreen();
        var b:int = getBlue();

        /* From 2D group:
         * 1. black.brighter() should return grey
         * 2. applying brighter to blue will always return blue, brighter
         * 3. non pure color (non zero rgb) will eventually return white
         */
        var i:Number = Math.floor(1.0/(1.0-factor));
        if ( r == 0 && g == 0 && b == 0) {
           return getASColor(i, i, i, alpha);
        }
        if ( r > 0 && r < i ) r = i;
        if ( g > 0 && g < i ) g = i;
        if ( b > 0 && b < i ) b = i;
        
        return getASColor(r/factor, g/factor, b/factor, alpha);
	}
	
	/**
	 * Returns a ASColor with with the specified red, green, blue values in the range [0 - 255] 
	 * and alpha value in range[0, 1]. 
	 * @param r red channel
	 * @param g green channel
	 * @param b blue channel
	 * @param a alpha channel
	 */
	public static function getASColor(r:int, g:int, b:int, a:Number=1):ASColor{
		return new ASColor(getRGBWith(r, g, b), a);
	}
		
	/**
	 * Returns the RGB value representing the red, green, and blue values. 
	 * @param rr red channel
	 * @param gg green channel
	 * @param bb blue channel
	 */
	public static function getRGBWith(rr:int, gg:int, bb:int):int {
		var r:int = Math.round(rr);
		var g:int = Math.round(gg);
		var b:int = Math.round(bb);
		if(r < 0){
			r = 0;
		}else if(r > 255){
			r = 255;
		}
		if(g < 0){
			g = 0;
		}else if(g > 255){
			g = 255;
		}
		if(b < 0){
			b = 0;
		}else if(b > 255){
			b = 255;
		}
		var color_n:int = (r<<16) + (g<<8) +b;
		return color_n;
	}
	
	public function toString():String{
		return "ASColor(rgb:"+rgb.toString(16)+", alpha:"+alpha+")";
	}

	/**
	 * Compare if compareTo object has the same value as this ASColor object does
	 * @param compareTo the object to compare with
	 * 
	 * @return  a Boolean value that indicates if the compareTo object's value is the same as this one
	 */	
	public function equals(o:Object):Boolean{
		var c:ASColor = ASColor(o);
		if(c!=null){
			return c.alpha === alpha && c.rgb === rgb;
		}else{
			return false;
		}
	}
}

}