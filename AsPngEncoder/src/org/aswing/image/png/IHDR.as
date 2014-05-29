/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.utils.ByteArray;	

/**
 * Png image header chunk, which is the first chunk in a PNG datastream.
 * See {@link http://www.libpng.org/pub/png/spec/iso/index-object.html#11IHDR}
 * @author iiley
 */
public class IHDR implements Chunk{
	
	public static const CT_GreyScale:int = 0;
	public static const CT_TrueColor:int = 2;
	public static const CT_IndexedColor:int = 3;
	public static const CT_GreyScale_Alpha:int = 4;
	public static const CT_TrueColor_Alpha:int = 6;
	
	public static const ByteDepth_1:int = 1;
	public static const ByteDepth_2:int = 2;
	public static const ByteDepth_4:int = 4;
	public static const ByteDepth_8:int = 8;
	public static const ByteDepth_16:int = 16;
	
	public var width:int;
	public var height:int;
	
	/**
	 * The bit depth, should be one of : 
	 * <ul>
	 *     <li>ByteDepth_1</li>
	 *     <li>ByteDepth_2</li>
	 *     <li>ByteDepth_4</li>
	 *     <li>ByteDepth_8</li>
	 *     <li>ByteDepth_16</li>
	 * </ul>
	 */
	public var bitDepth:int;
	
	/**
	 * The color type, should be one of : 
	 * <ul>
	 *     <li>CT_GreyScale</li>
	 *     <li>CT_TrueColor</li>
	 *     <li>CT_IndexedColor</li>
	 *     <li>CT_Greyscale_Alpha</li>
	 *     <li>CT_TrueColor_Alpha</li>
	 * </ul>
	 */	
	public var colorType:int;
	
	public var compressionMethod:int = 0;
	public var filterMethod:int = 0;
	public var interlaceMethod:int = 0;
	
	/**
	 * Create a IHDR with width, height, bitDepth and colorType, others are default to 0.
	 * @param w width
	 * @param h height;
	 * @param bd bitDepth
	 * @param ct colorType
	 */
	public function IHDR(w:int, h:int, bd:int=8, ct:int=6){
		this.width = w;
		this.height = h;
		this.bitDepth = bd;
		this.colorType = ct;
		this.compressionMethod = 0;
		this.filterMethod = 0;
		this.interlaceMethod = 0;
	}
	
	public function getData():ByteArray{
		if(bitDepth == ByteDepth_1 || bitDepth == ByteDepth_2 || bitDepth == ByteDepth_4){
			if(colorType != CT_GreyScale && colorType != CT_IndexedColor){
				throw new PngError("BitDepth 1, 2 or 4 only can be used for GreyScale and IndexedColor!");
			}
		}else if(bitDepth == ByteDepth_16){
			if(colorType == CT_IndexedColor){
				throw new PngError("BitDepth 16 can't be used for IndexedColor!");
			}
		}
		
		var data:ByteArray = new ByteArray();
		data.writeInt(width);
		data.writeInt(height);
		data.writeByte(bitDepth);
		data.writeByte(colorType);
		data.writeByte(compressionMethod);
		data.writeByte(filterMethod);
		data.writeByte(interlaceMethod);
		return data;
	}
	
	public function getType():uint{
		return 0x49484452;
	}
}
}