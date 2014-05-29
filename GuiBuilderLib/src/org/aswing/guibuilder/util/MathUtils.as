package org.aswing.guibuilder.util{

public class MathUtils{
	
	public static function parseInteger(str:String, radix:uint=0):int{
		var i:int = parseInt(str, radix);
		if(isNaN(i)){
			return 0;
		}
		return i;
	}
	
	public static function parseNumber(str:String):Number{
		var i:Number = parseFloat(str);
		if(isNaN(i)){
			return 0;
		}
		return i;
	}
	
}
}