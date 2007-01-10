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
	
	
	private var rgb:uint;
	private var alpha:Number;
	
	public function ASColor (color:uint=0x000000, alpha:Number=1){
		setRGB(color);
		setAlpha(alpha);
	}
	
	private function setRGB(rgb:uint):void{
		this.rgb = rgb;
	}
	
	private function setAlpha(alpha:Number):void{
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
	public function getRGB():uint{
		return rgb;	
	}
	
	/**
     * Returns the red component in the range 0-255.
     * @return the red component.
     */
	public function getRed():uint{
		return (rgb & 0x00FF0000) >> 16;
	}
	
	/**
     * Returns the green component in the range 0-255.
     * @return the green component.
     */	
	public function getGreen():uint{
		return (rgb & 0x0000FF00) >> 8;
	}
	
	/**
     * Returns the blue component in the range 0-255.
     * @return the blue component.
     */	
	public function getBlue():uint{
		return (rgb & 0x000000FF);
	}
	
    /**
     * darker(factor:Number)<br>
     * darker() default factor to 0.7
     * <p>
     * Creates a new <code>Color</code> that is a darker version of this
     * <code>Color</code>.
     * @param factor the darker factor(0, 1), default is 0.7
     * @return     a new <code>ASColor</code> object that is  
     *                 a darker version of this <code>Color</code>.
     * @see        #brighter()
     */		
	public function darker(factor:Number=0.7):ASColor{
        var r:uint = getRed();
        var g:uint = getGreen();
        var b:uint = getBlue();
		return getASColor(r*factor, g*factor, b*factor, alpha);
	}
	
    /**
     * brighter(factor:Number)<br>
     * brighter() default factor to 0.7
     * <p>
     * Creates a new <code>Color</code> that is a brighter version of this
     * <code>Color</code>.
     * @param factor the birghter factor 0 to 1, default is 0.7
     * @return     a new <code>ASColor</code> object that is  
     *                 a brighter version of this <code>Color</code>.
     * @see        #darker()
     */	
	public function brighter(factor:Number=0.7):ASColor{
        var r:uint = getRed();
        var g:uint = getGreen();
        var b:uint = getBlue();

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
	 * <p>
	 * getASColor(r:uint, g:uint, b:uint, a:Number)<br>
	 * getASColor(r:uint, g:uint, b:uint)<br> alpha default value is 1
	 */
	public static function getASColor(r:uint, g:uint, b:uint, a:Number=1):ASColor{
		return new ASColor(getRGBWith(r, g, b), a);
	}
		
	/**
	 * Returns the RGB value representing the red, green, and blue values. 
	 */
	public static function getRGBWith(rr:uint, gg:uint, bb:uint):uint {
		var r:uint = Math.round(rr);
		var g:uint = Math.round(gg);
		var b:uint = Math.round(bb);
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
		var color_n:uint = (r<<16) + (g<<8) +b;
		return color_n;
	}
	
	public function toString():String{
		return "ASColor(rgb:"+rgb.toString(16)+", alpha:"+alpha+")";
	}
	
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