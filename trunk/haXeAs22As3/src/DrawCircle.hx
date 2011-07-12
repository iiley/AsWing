/**
 * ...
 * @author paling
 */

package ;
import flash.display.Sprite;

class DrawCircle extends Sprite
{

	public function new() 
	{
		super(); 
		this.graphics.beginFill(0xffff00,1); 
		this.graphics.drawCircle(100, 100, 50);
		this.graphics.endFill();
		
		 var dv:Sprite = new Sprite();
		dv.graphics.beginFill(0xff00ff,1); 
		dv.graphics.drawRect(100,100, 50, 50);
		   dv.graphics.endFill(); 
		  this.addChild(dv);
	 
			//this.mask = dv;
	}
	
}