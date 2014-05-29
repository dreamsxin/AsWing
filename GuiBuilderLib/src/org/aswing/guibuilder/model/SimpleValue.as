package org.aswing.guibuilder.model{

public class SimpleValue implements ValueModel{
	
	private var value:*;
	
	public function SimpleValue(v:*){
		value = v;
	}
	
	public function getValue():*{
		return value;
	}
	
	public function toString():String{
		return value+"";
	}
}
}