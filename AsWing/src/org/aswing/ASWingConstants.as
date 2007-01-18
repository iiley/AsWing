/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing
{
/**
 * A collection of constants generally used for positioning and orienting
 * components on the screen.
 * 
 * @author iiley
 */
public class ASWingConstants{
		
		
		public static const NONE:Number = -1;

        /** 
         * The central position in an area. Used for
         * both compass-direction constants (NORTH, etc.)
         * and box-orientation constants (TOP, etc.).
         */
        public static const CENTER:Number  = 0;

        // 
        // Box-orientation constant used to specify locations in a box.
        //
        /** 
         * Box-orientation constant used to specify the top of a box.
         */
        public static const TOP:Number     = 1;
        /** 
         * Box-orientation constant used to specify the left side of a box.
         */
        public static const LEFT:Number    = 2;
        /** 
         * Box-orientation constant used to specify the bottom of a box.
         */
        public static const BOTTOM:Number  = 3;
        /** 
         * Box-orientation constant used to specify the right side of a box.
         */
        public static const RIGHT:Number   = 4;

        // 
        // Compass-direction constants used to specify a position.
        //
        /** 
         * Compass-direction North (up).
         */
        public static const NORTH:Number      = 1;
        /** 
         * Compass-direction north-east (upper right).
         */
        public static const NORTH_EAST:Number = 2;
        /** 
         * Compass-direction east (right).
         */
        public static const EAST:Number       = 3;
        /** 
         * Compass-direction south-east (lower right).
         */
        public static const SOUTH_EAST:Number = 4;
        /** 
         * Compass-direction south (down).
         */
        public static const SOUTH:Number      = 5;
        /** 
         * Compass-direction south-west (lower left).
         */
        public static const SOUTH_WEST:Number = 6;
        /** 
         * Compass-direction west (left).
         */
        public static const WEST:Number       = 7;
        /** 
         * Compass-direction north west (upper left).
         */
        public static const NORTH_WEST:Number = 8;

        //
        // These constants specify a horizontal or 
        // vertical orientation. For example, they are
        // used by scrollbars and sliders.
        //
        /** 
         * Horizontal orientation. Used for scrollbars and sliders.
         */
        public static const HORIZONTAL:Number = 0;
        /** 
         * Vertical orientation. Used for scrollbars and sliders.
         */
        public static const VERTICAL:Number   = 1;
}
}