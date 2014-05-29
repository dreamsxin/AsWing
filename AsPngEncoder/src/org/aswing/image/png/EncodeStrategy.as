/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.display.BitmapData;	

/**
 * Encode strategy, call encode first, and then call the getXXX method to get the encoded chunks.
 * @author iiley
 */
public interface EncodeStrategy{
	
	/**
	 * Encode the image.
	 * This method should be called before getXXX methods.
	 * @param image the image data source
	 * @param encoder the encoder where the strategy should call it's writeChunk to 
	 * fill the chunks except IEND.
	 */
	function encode(image:BitmapData, encoder:AsPngEncoder):void;
	
}
}