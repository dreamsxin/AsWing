/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.utils.ByteArray;

/**
 * The image data chunk.
 * @author iiley
 */
public class IDAT implements Chunk{
	
	private var data:ByteArray;
	
	public function IDAT(data:ByteArray){
		this.data = data;
	}
	
	public function getType():uint{
		return 0x49444154;
	}
	
	public function getData():ByteArray{
		return data;
	}
	
}
}