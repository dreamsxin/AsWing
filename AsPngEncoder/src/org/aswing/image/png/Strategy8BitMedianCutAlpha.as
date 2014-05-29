/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.image.png{

import flash.display.BitmapData;
import flash.geom.Rectangle;
import flash.utils.ByteArray;
import flash.utils.Dictionary;
import flash.utils.getTimer;

/**
 * Median Cut Algorithms to do color quantization. With ARGB four demesion.
 * @author iiley
 */
public class Strategy8BitMedianCutAlpha extends EncodeStrategyBase{
	
	private var colorNumber:int;
	private var alphaWeight:int;
	
	/**
	 * @param colorNumber the number of colors to be quantized.
	 * @param alphaWeight the weight of alpha compare to rgb, 1 means as same weight as rgb, 
	 * 		  256 means smallest weight, 2 means half of weight of rbg, so the number means 1/alphaWeight of rbg.
	 */
	public function Strategy8BitMedianCutAlpha(colorNumber:int=256, alphaWeight:int=1){
		super();
		this.colorNumber = colorNumber;
		this.alphaWeight = alphaWeight;
		if(colorNumber > 256 || colorNumber < 1){
			throw new PngError("Color Number should be [1, 256]");
		}
		if(alphaWeight < 1 || alphaWeight > 256){
			throw new PngError("Alpha weight should be [1, 256]");
		}
	}
	
	override protected function buildChunks(image:BitmapData, encoder:AsPngEncoder):void{
		var w:int = image.width;
		var h:int = image.height;
		var i:int = 0;
		var x:int;
		var y:int;
		
		Debug.traceMsg("++++++++++++++++++++++++++++++++++++");
		
		var time:int;
		time = getTimer();
		
		var pixels:ByteArray = image.getPixels(new Rectangle(0, 0, w, h));
		pixels.position = 0;
		
		var n:int = w*h;
		var points:Array = new Array();
		var colors:Array = new Array();//there may casue problem because array only accept int not uint to be index
		
		time = getTimer();
		for(i=n-1; i>=0; i--){
			var pix:uint = pixels.readUnsignedInt();
			colors[int(pix)] = pix;//there may casue problem because array only accept int not uint to be index
		}
		Debug.traceMsg("++++++++ build Colors : " + (getTimer() - time));
		time = getTimer();
		for each(var pi:* in colors){
			points.push(pi);
		}
		Debug.traceMsg("start color number : " + points.length);
		
		Debug.traceMsg("++++++++ build Points : " + (getTimer() - time));
		time = getTimer();
		
		var block:Block = new Block(points, alphaWeight);
		var blockQueue:Array = new Array();
		blockQueue.push(block);
		while(blockQueue.length < colorNumber){
			block = blockQueue.pop();
			if(block.maxSideLength <= 1){
				blockQueue.push(block);//push back
				break; //all splited
			}
			var splited:Array = block.splite();
			addToQueue(blockQueue, splited[0]);
			addToQueue(blockQueue, splited[1]);
		}
		
		Debug.traceMsg("++++++++ build Blocks : " + (getTimer() - time));
		time = getTimer();
		
		Debug.traceMsg("block number : " + blockQueue.length);
		
		ihdr = new IHDR(w, h, IHDR.ByteDepth_8, IHDR.CT_IndexedColor);
		
		//build the PLTE chunk and tRNS
		var plteBytes:ByteArray = new ByteArray();
		var trnsBytes:ByteArray = new ByteArray();
		
		var midP:uint;
		n = blockQueue.length;
		for(i=0; i<n; i++){
			block = blockQueue[i];
			midP = block.publishColor;
			plteBytes.writeByte((midP&0x00FF0000)>>>16);
			plteBytes.writeByte((midP&0x0000FF00)>>>8);
			plteBytes.writeByte((midP&0x000000FF));
			trnsBytes.writeByte(midP>>>24);
		}
		plte = new PLTE(plteBytes);
		trns = new tRNS(trnsBytes);
		
		Debug.traceMsg("++++++++ build PLTE : " + (getTimer() - time));
		time = getTimer();
		
		//build the IDAT chunk
		var idatBytes:ByteArray = new ByteArray();
		i=0;
		pixels.position = 0;
		var filled:Array = new Array();
		for(y=0; y<h; y++){
			idatBytes.writeByte(0);//no filter
			for(x=0; x<w; x++){
				var point:uint = pixels.readUnsignedInt();
				var index:* = filled[int(point)];//there may casue problem because array only accept int not uint to be index
				if(index !== undefined){
					idatBytes.writeByte(int(index));
				}else{
					index = getIndexInQueue(blockQueue, point);
					filled[int(point)] = index;//there may casue problem because array only accept int not uint to be index
					idatBytes.writeByte(int(index));
				}
				i++;
			}
		}
		
		Debug.traceMsg("++++++++ build IDAT : " + (getTimer() - time));
		time = getTimer();
		
		idatBytes.compress();
		idats = [new IDAT(idatBytes)];
	}
	
	private function getIndexInQueue(queue:Array, point:uint):int{
		var n:int = queue.length;
		var bn:int = Block.NUM_DIM*8;
		for(var i:int=0; i<n; i++){
			var bl:Block = queue[i];
			var mx:uint = bl.maxCorner;
			var mn:uint = bl.minCorner;
			var isIn:Boolean = true;
			for(var offset:int=0; offset<bn; offset+=8){
				var mask:uint = uint(0x000000FF << offset);
				var p:uint = uint(point & mask);
				var mxp:uint = uint(mx & mask);
				var mnp:uint = uint(mn & mask);
				if(p < mnp || p > mxp){
					isIn = false;
					break;
				}
			}
			if(isIn){
				return i;
			}
		}
		throw new PngError("Can't found index!!");
	}
	
	private function addToQueue(queue:Array, block:Block):void{
		var blockV:uint = block.maxSideLength;
		var n:int = queue.length;
		for(var i:int=0; i<n; i++){
			if(blockV < queue[i].maxSideLength){
				queue.splice(i, 0, block);
				return;
			}
		}
		queue.push(block);
	}
	
	public function toString():String{
		return "8-bit Adaptive Indexed(alpha color " + colorNumber + ")";
	}	
}
}

class Block{
	
	public static const NUM_DIM:int = 4;
	
	private var points:Array;
	public var minCorner:uint;
	public var maxCorner:uint;
	public var midCorner:uint;
	public var publishColor:uint;
	
	private var alphaWeight:int;
	private var maxSideLengthOffset:uint;
	public var maxSideLength:uint;
	
	public function Block(points:Array, alphaWeight:int, counted:Boolean=false, minCo:uint=0, maxCo:uint=0){
		this.points = points;
		this.alphaWeight = alphaWeight;
		if(points.length < 1){
			throw new Error("points.length < 1");
		}
		
		if(counted){
			minCorner = minCo;
			maxCorner = maxCo;
		}else{
			minCorner = minDim(points);
			maxCorner = maxDim(points);
		}
		
		maxSideLengthOffset = 0;
		maxSideLength = 0;
		midCorner = 0;
		publishColor = 0;
		for(var i:int=0; i<NUM_DIM; i++){
			var offset:uint = i*8;
			var mask:uint = uint(0x000000FF << offset);
			var minC:uint = uint((minCorner&mask)>>>offset);
			var maxC:uint = uint((maxCorner&mask)>>>offset);
			midCorner |= ((uint((minC+maxC)/2)) << offset);
			if(i<3){
				publishColor |= ((uint((minC+maxC)/2)) << offset);
			}else{//means alpha
				if(minC == 0){
					//do nothing means keep 0 alpha -- transparent
				}else if(maxC == 255){
					publishColor |= (0xFF000000); //opaque
				}else{
					publishColor |= ((uint((minC+maxC)/2)) << offset); //middle
				}
			}
			var length:uint = uint(uint((maxCorner&mask)>>>offset)-uint((minCorner&mask)>>>offset));
			if(i == 3){//the rbg weight is 2 times of alpha
				if(length > maxSideLength*alphaWeight){
					maxSideLengthOffset = offset;
					maxSideLength = length;
				}
			}else{
				if(length > maxSideLength){
					maxSideLengthOffset = offset;
					maxSideLength = length;
				}
			}
		}
	}
	
	/**
	 * Splits to two Block.
	 */
	public function splite():Array{
		if(maxSideLength <= 1){
			trace("Error maxSideLength = 1 can't splite!!!");
		}
		var offset:uint = maxSideLengthOffset;
		var mask:uint = uint(0x000000FF << offset);
			
		var left:Array = new Array();
		var right:Array = new Array();
		var mid:uint = uint(midCorner & mask);
		var p:uint;
		
		var lminA:uint = uint.MAX_VALUE;
		var lminR:uint = uint.MAX_VALUE;
		var lminG:uint = uint.MAX_VALUE;
		var lminB:uint = uint.MAX_VALUE;
		var lmaxA:uint = 0;
		var lmaxR:uint = 0;
		var lmaxG:uint = 0;
		var lmaxB:uint = 0;
		var rminA:uint = uint.MAX_VALUE;
		var rminR:uint = uint.MAX_VALUE;
		var rminG:uint = uint.MAX_VALUE;
		var rminB:uint = uint.MAX_VALUE;
		var rmaxA:uint = 0;
		var rmaxR:uint = 0;
		var rmaxG:uint = 0;
		var rmaxB:uint = 0;
		var test:uint;
		
		var n:int = points.length;
		
		for(var i:int=0; i<n; i++){
			p = points[i];
			if((uint(p & mask)) <= mid){
				//min
				test = p&0xFF000000;
				if(test < lminA){
					lminA = test;
				}
				
				test = (p&0x00FF0000);
				if(test < lminR){
					lminR = test;
				}
				
				test = (p&0x0000FF00);
				if(test < lminG){
					lminG = test;
				}
				
				test = p&0x000000FF;
				if(test < lminB){
					lminB = test;
				}
				
				//max
				test = p&0xFF000000;
				if(test > lmaxA){
					lmaxA = test;
				}
				
				test = (p&0x00FF0000);
				if(test > lmaxR){
					lmaxR = test;
				}
				
				test = (p&0x0000FF00);
				if(test > lmaxG){
					lmaxG = test;
				}
				
				test = p&0x000000FF;
				if(test > lmaxB){
					lmaxB = test;
				}
				//push
				left.push(p);
			}else{
				//min
				test = p&0xFF000000;
				if(test < rminA){
					rminA = test;
				}
				
				test = (p&0x00FF0000);
				if(test < rminR){
					rminR = test;
				}
				
				test = (p&0x0000FF00);
				if(test < rminG){
					rminG = test;
				}
				
				test = p&0x000000FF;
				if(test < rminB){
					rminB = test;
				}
				
				//max
				test = p&0xFF000000;
				if(test > rmaxA){
					rmaxA = test;
				}
				
				test = (p&0x00FF0000);
				if(test > rmaxR){
					rmaxR = test;
				}
				
				test = (p&0x0000FF00);
				if(test > rmaxG){
					rmaxG = test;
				}
				
				test = p&0x000000FF;
				if(test > rmaxB){
					rmaxB = test;
				}
				right.push(p);
			}
		}
		var lmx:uint = uint(lminA|lminR|lminG|lminB);
		var rmx:uint = uint(rminA|rminR|rminG|rminB);
		var lmn:uint = uint(lmaxA|lmaxR|lmaxG|lmaxB);
		var rmn:uint = uint(rmaxA|rmaxR|rmaxG|rmaxB);
		return [new Block(left, alphaWeight, true, lmx, lmn), new Block(right, alphaWeight, true, rmx, rmn)];
	}
		
	private function minDim(ps:Array):uint{
		var p:uint = ps[0];
		var minA:uint = p&0xFF000000;
		var minR:uint = p&0x00FF0000;
		var minG:uint = p&0x0000FF00;
		var minB:uint = p&0x000000FF;
		var test:uint;
		var n:int = ps.length;
		for(var i:int=1; i<n; i++){
			p = ps[i];
			test = p&0xFF000000;
			if(test < minA){
				minA = test;
			}
			
			test = (p&0x00FF0000);
			if(test < minR){
				minR = test;
			}
			
			test = (p&0x0000FF00);
			if(test < minG){
				minG = test;
			}
			
			test = p&0x000000FF;
			if(test < minB){
				minB = test;
			}
		}
		
		return minA|minR|minG|minB;
	}
	
	private function maxDim(ps:Array):uint{
		var p:uint = ps[0];
		var maxA:uint = p&0xFF000000;
		var maxR:uint = p&0x00FF0000;
		var maxG:uint = p&0x0000FF00;
		var maxB:uint = p&0x000000FF;
		var test:uint;
		var n:int = ps.length;
		for(var i:int=1; i<n; i++){
			p = ps[i];
			test = p&0xFF000000;
			if(test > maxA){
				maxA = test;
			}
			
			test = (p&0x00FF0000);
			if(test > maxR){
				maxR = test;
			}
			
			test = (p&0x0000FF00);
			if(test > maxG){
				maxG = test;
			}
			
			test = p&0x000000FF;
			if(test > maxB){
				maxB = test;
			}
		}
		
		return maxA|maxR|maxG|maxB;
	}
}
