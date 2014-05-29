package org.aswing.di{

/**
 * IOC internal use
 * @author iiley
 */
public class BeanMaker{
	
	public var id:String;
	public var className:String;
	public var preInstant:Boolean;
	public var properties:Array;
	public var instance:*;
	public var isPropertiesSet:Boolean = true;
	
	public function BeanMaker(id:String, className:String, preInstant:Boolean=false){
		this.id = id;
		this.className = className;
		this.preInstant = preInstant;
		properties = [];
	}
	
	public function instant():*{
		if(instance == null){
			instance = BeanFactory.reflectInstant(className);
		}
		return instance;
	}
	
	public function isInstanted():Boolean{
		return instance != null;
	}
	
	public function addProperty(attributes:Object):void{
		properties.push(new BeanProperty(attributes));
		isPropertiesSet = false;
	}
	
	public function toString():String{
		return "[BeanMaker id:" + id + ", class:" + className + "]"
	}
}
}