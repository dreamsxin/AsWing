/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.utils.ByteArray;
import flash.display.BitmapData;

/**
 * Uniform Quantization strategy to quatizate color to (0, 256) opaque.
 * @author iiley
 */
public class Strategy8BitUniformQuant extends EncodeStrategyBase{
		
	private var RED_SEQ:int = 6;
	private var GREEN_SEQ:int = 7;
	private var BLUE_SEQ:int = 6;
	
	/**
	 * Create a Strategy8BitUniformQuant with specified segments.
	 * (redSeg*greenSeg*blueSeg) must be in range (0, 256]
	 * @param redSeg red segments
	 * @param greenSeg green segments
	 * @param blueSeg blue segments
	 */
	public function Strategy8BitUniformQuant(redSeg:uint=6, greenSeg:uint=7, blueSeg:uint=6){
		super();
		if(redSeg*greenSeg*blueSeg > 256 || redSeg*greenSeg*blueSeg == 0){
			throw new PngError("(redSeg*greenSeg*blueSeg) must be in range (0, 256]");
		}
		RED_SEQ = redSeg;
		GREEN_SEQ = greenSeg;
		BLUE_SEQ = blueSeg;
	}

	override protected function buildChunks(image:BitmapData, encoder:AsPngEncoder):void{
		var w:int = image.width;
		var h:int = image.height;
		ihdr = new IHDR(w, h, IHDR.ByteDepth_8, IHDR.CT_IndexedColor);
		
		//build the PLTE chunk
		var plteBytes:ByteArray = new ByteArray();
		var RDIV:Number = 255/(RED_SEQ-1);
		var GDIV:Number = 255/(GREEN_SEQ-1);
		var BDIV:Number = 255/(BLUE_SEQ-1);
		
		for(var r:int=0; r<RED_SEQ; r++){
			for(var g:int=0; g<GREEN_SEQ; g++){
				for(var b:int=0; b<BLUE_SEQ; b++){
					plteBytes.writeByte(int(r*RDIV));
					plteBytes.writeByte(int(g*GDIV));
					plteBytes.writeByte(int(b*BDIV));
				}
			}
		}
		plte = new PLTE(plteBytes);
		
		//build the IDAT chunk
		var idatBytes:ByteArray = new ByteArray();
		for(var y:int=0; y<h; y++){
            idatBytes.writeByte(0);//no filter
            var p:uint;
            var R_M:Number = GREEN_SEQ*BLUE_SEQ;
			for(var x:int=0; x<w; x++){
                p = image.getPixel(x, y);
                r = Math.round(((p&0x00FF0000) >>> 16)/RDIV);
                g = Math.round(((p&0x0000FF00) >>> 8)/GDIV);
                b = Math.round((p&0x000000FF)/BDIV);
                idatBytes.writeByte(r*R_M+g*BLUE_SEQ+b);
			}
		}
		idatBytes.compress();
		idats = [new IDAT(idatBytes)];
	}
	
	public function toString():String{
		return "8-bit Indexed Color (color " + (RED_SEQ*GREEN_SEQ*BLUE_SEQ) + ")";
	}	
}
}