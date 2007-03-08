package org.aswing.event { 
	/*
	 Copyright aswing.org, see the LICENCE.txt.
	*/
	
	/**
	 * Exception used to stop and expand/collapse from happening.
	 * @author iiley
	 */
	public class ExpandVetoException extends Error {
		
		public function ExpandVetoException(message : String) {
			super(message);
		}
	
	}
}