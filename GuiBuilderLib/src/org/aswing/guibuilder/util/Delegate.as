package org.aswing.guibuilder.util{

public class Delegate{
	
	public static function create(func:Function, ...args):Function{
		var fun:Function = function(...arg):void{
			var ar:Array = arg;
			func.apply(null, ar.concat(args));
		}
		return fun;
	}
	
}
}