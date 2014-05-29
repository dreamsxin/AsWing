/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.utils.ByteArray;

/**
 * The palette table associated with indexed PNG images. 
 * @author iiley
 */
public class PLTE implements Chunk{
	
	private var data:ByteArray;
	
	public function PLTE(data:ByteArray){
		this.data = data;
	}
	
	public function getType():uint{
		return 0x504C5445;
	}
	
	public function getData():ByteArray{
		return data;
	}
	
}
}