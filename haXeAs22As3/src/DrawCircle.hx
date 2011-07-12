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
	}
	
}