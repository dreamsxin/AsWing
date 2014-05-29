/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.utils.ByteArray;

/**
 * The tRNS chunk specifies either alpha values that are associated with palette entries (for indexed-colour images) 
 * or a single transparent colour (for greyscale and truecolour images).
 * @author iiley
 */
public class tRNS implements Chunk{
	
	private var data:ByteArray;
	
	public function tRNS(data:ByteArray){
		this.data = data;
	}
	
	public function getType():uint{
		return 0x74524E53;
	}
	
	public function getData():ByteArray{
		return data;
	}
	
}
}