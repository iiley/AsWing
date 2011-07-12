package flash.display;

import flash.geom.ColorTransform;
import flash.geom.Matrix;
import flash.geom.Rectangle;

 
interface IBitmapDrawable 
{
    public function drawToSurface(inSurface : Dynamic,
                        matrix:Matrix,
                        colorTransform:ColorTransform,
                        blendMode:String,
                        clipRect:Rectangle<Float>,
                        smoothing:Bool):Void;
}
 
