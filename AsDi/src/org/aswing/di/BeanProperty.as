package org.aswing.di{

/**
 * IOC internal use
 * @author iiley
 */
public class BeanProperty{
	
	public var attributes:Object;
	
	public function BeanProperty(attributes:Object){
		this.attributes = attributes;
	}
	
	public function getPropertyName():String{
		return attributes[BeanFactory.TAG_NAME];
	}
}
}