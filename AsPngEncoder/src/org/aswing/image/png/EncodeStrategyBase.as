/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.display.BitmapData;

/**
 * A abstract implementation of EncodeStrategy, for certain imp to extend.
 * @author iiley
 */
public class EncodeStrategyBase implements EncodeStrategy{
	
	protected var ihdr:IHDR;
	protected var plte:PLTE;
	protected var trns:tRNS;
	protected var idats:Array;
	
	public function EncodeStrategyBase(){
		idats = new Array();
	}
	
	public function encode(image:BitmapData, encoder:AsPngEncoder):void{
		buildChunks(image, encoder);
		writeChunks(image, encoder);
	}
	
	protected function buildChunks(image:BitmapData, encoder:AsPngEncoder):void{
		throw new PngError("Subclass should overrid this method!");
	}
	
	protected function writeChunks(image:BitmapData, encoder:AsPngEncoder):void{
		writeChunk(encoder, getIHDR());
		writeChunk(encoder, getPLTE());
		writeChunk(encoder, gettRNS());
		var idats:Array = getIDATs();
		for(var i:int=0; i<idats.length; i++){
			writeChunk(encoder, idats[i]);
		}
	}
	
	/**
	 * Write a chunk to the encoder.
	 */
	protected function writeChunk(encoder:AsPngEncoder, chunk:Chunk):void{
		encoder.writeChunk(chunk);
	}
	
	public function getIHDR():IHDR{
		return ihdr;
	}
	
	public function getPLTE():PLTE{
		return plte;
	}
	
	public function gettRNS():tRNS{
		return trns;
	}
	
	public function getIDATs():Array{
		return idats;
	}
	
}
}