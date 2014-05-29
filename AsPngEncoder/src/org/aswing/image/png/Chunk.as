/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.utils.ByteArray;
	
/**
 * Chunk of a png
 * @author iiley
 */
public interface Chunk{
	
	/**
	 * Returns the chunk type
	 */
	function getType():uint;
	
	/**
	 * Returns the chunk data
	 */
	function getData():ByteArray;
	
}
}