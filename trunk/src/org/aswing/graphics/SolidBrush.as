/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import flash.display.Graphics;
import org.aswing.ASColor;
import org.aswing.graphics.Brush;

/**
 * 
 * @author iiley
 */
class org.aswing.graphics.SolidBrush implements Brush{
	private var color:Number;
	private var alpha:Number;
	
	/**
	 * <p>
	 * SolidBrush(color:ASColor)<br>
	 */
	function SolidBrush(color:ASColor){
		
	}
	
	public function getColor():Number{
		return color;
	}
	
	public function setColor(color:Number):void{		
		if(color!=null){
			this.color=color;
		}		
	}
	
	public function setAlpha(alpha:Number):void{
			if(alpha!=null){
				this.alpha=alpha;
			}
	}
	
	public function getAlpha():Number{
		return alpha;
	}
	
	public function beginFill(target:Graphics):void{
		target.beginFill(color,alpha);
	}
	
	public function endFill(target:Graphics):void{
		target.endFill();
	}
	
	public function setASColor(color:ASColor):void{
		if(color!=null){
			this.color=color.getRGB();
			this.alpha=color.getAlpha();
		}
	}
}
