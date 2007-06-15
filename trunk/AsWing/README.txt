How to use AsWing A3?

See Test folder sources.

Notice: 

You'd better to call :

		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.stageFocusRect = false;
		AsWingManager.setRoot(this);
		
		or 
		
		AsWingManager.initAsStandard(this);

at the begin of your application code.

more infomations please visite http://www.aswing.org