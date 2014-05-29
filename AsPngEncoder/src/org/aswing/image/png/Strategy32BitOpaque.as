/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.display.BitmapData;
import flash.utils.ByteArray;

/**
 * This strategy encode to a 32 bit true color without alpha channel png.
 * @author iiley
 */
public class Strategy32BitOpaque extends EncodeStrategyBase{
		
	public function Strategy32BitOpaque(){
	}
	
	override protected function buildChunks(image:BitmapData, encoder:AsPngEncoder):void{
		var w:int = image.width;
		var h:int = image.height;
		ihdr = new IHDR(w, h, IHDR.ByteDepth_8, IHDR.CT_TrueColor);
		
		var idatBytes:ByteArray = new ByteArray();
		
		for(var y:int=0; y<h; y++){
            idatBytes.writeByte(0);//no filter
            var p:uint;
			for(var x:int=0; x<w; x++){
                p = image.getPixel(x, y);
                idatBytes.writeShort(p >>> 8);
                idatBytes.writeByte(p);
			}
		}
		idatBytes.compress();
		idats = [new IDAT(idatBytes)];
	}
	
	public function toString():String{
		return "24-bit TrueColor Opaque";
	}
}
}