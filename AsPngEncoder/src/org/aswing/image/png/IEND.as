/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.utils.ByteArray;

/**
 * The image trailer, which is the last chunk in a PNG datastream. 
 * @author iiley
 */
public class IEND implements Chunk{
	
	public function IEND(){}
	
	public function getType():uint{
		return 0x49454E44;
	}
	
	public function getData():ByteArray{
		return null;
	}
	
}
}