package;

import org.aswing.AsWingManager;
import flash.Lib;
 
class Main 
{

    static function main():Void
    {  
		AsWingManager.initAsStandard( Lib.current);
		Lib.current.addChild(new ComSet()); 
   
 
		
    }
}