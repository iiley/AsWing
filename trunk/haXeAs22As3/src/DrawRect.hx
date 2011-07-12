/**
 * ...
 * @author paling
 */

package ;
import flash.display.Sprite;

class DrawRect  extends Sprite
{

	public function new() 
	{
		super();
		this.graphics.beginFill(0x00ffff,1);
		this.graphics.drawRect(0, 0, 100, 100);
		this.graphics.endFill();
	}
	
}