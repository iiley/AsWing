package flash.events;

import flash.events.IEventDispatcher;

class Callback
{
   var mDispatcher:IEventDispatcher;
   var mType:String;
 
   var mFunc:Function;
   var mCapture:Null<Bool>;
 
   public function new(inDispatcher:IEventDispatcher,
       type:String, listener:Function,
       ?useCapture:Bool /*= false*/, ?priority:Int /*= 0*/)
   {
      mDispatcher = inDispatcher;
      mType = type;

 
      mFunc = listener;
      mCapture = useCapture;
  
      inDispatcher.addEventListener(type,listener,useCapture,priority);
   }

   public function Remove()
   {
    
      mDispatcher.removeEventListener(mType,mFunc,mCapture);
     
      mDispatcher = null;
   }

}

