/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.display.Sprite;
import flash.utils.ByteArray;
import flash.display.BitmapData;

/**
 * AsPngEncoder
 * @author iiley
 */
public class AsPngEncoder extends Sprite{
	
	private var png:ByteArray;
	
	private static var crcTable:Array;
	
	public function AsPngEncoder(){
		if(crcTable == null){
            crcTable = [];
            for (var n:uint = 0; n < 256; n++) {
                var c:uint = n;
                for (var k:uint = 0; k < 8; k++) {
                    if (c & 1) {
                        c = uint(uint(0xedb88320) ^ 
                            uint(c >>> 1));
                    } else {
                        c = uint(c >>> 1);
                    }
                }
                crcTable[n] = c;
            }
		}
	}
	
	public function encode(image:BitmapData, encodeStrategy:EncodeStrategy):ByteArray{
		png = new ByteArray();
		writeSignature();
		encodeStrategy.encode(image, this);
        //IEND chunk
        writeChunk(new IEND());
		return png;
	}
	
	protected function writeSignature():void{
        png.writeUnsignedInt(0x89504e47);
        png.writeUnsignedInt(0x0D0A1A0A);
	}
	
	/**
	 * Use for EncodeStrategy to write chunks.
	 */
	internal function writeChunk(chunk:Chunk):void{
		if(chunk == null){
			return;
		}
		var data:ByteArray = chunk.getData();
		var type:uint = chunk.getType();
		
        var len:uint = 0;
        if(data != null){
            len = data.length;
        }
        png.writeUnsignedInt(len);
        var p:uint = png.position;
        png.writeUnsignedInt(type);
        if(data != null){
            png.writeBytes(data);
        }
        var e:uint = png.position;
        png.position = p;
        var c:uint = 0xffffffff;
        var e_p:uint = e-p;
        for (var i:int = 0; i < e_p; i++) {
            c = uint(crcTable[
                (c ^ png.readUnsignedByte()) & 
                0xff] ^ (c >>> 8));
        }
        c = uint(c^uint(0xffffffff));
        png.position = e;
        png.writeUnsignedInt(c);
	}
}
}
