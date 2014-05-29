package org.aswing.guibuilder{

public class LookAndFeelInfo{
	
	private var name:String;
	private var clazz:String;
	private var path:String;
	
	public function LookAndFeelInfo(name:String, clazz:String, path:String){
		this.name = name;
		this.clazz = clazz;
		this.path = path;	
	}
	
	public function getName():String{
		return name;
	}
	
	public function getClazz():String{
		return clazz;
	}
	
	public function getPath():String{
		return path;
	}
	
	public function toString():String{
		return name;
	}
}
}