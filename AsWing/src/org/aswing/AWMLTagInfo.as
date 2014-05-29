package org.aswing{


/**
 * This class used to store a basic info of a awml tag.
 * @author iiley (Burstyx Studio)
 */
public class AWMLTagInfo{
	
	/**
	 * the tag name
	 */
	public var tag:String;
	
	/**
	 * the id in awml tag
	 */
	public var id:String;
	
	/**
	 * the class value for css style
	 */
	public var clazz:String;
	
	/**
	 * the css style inline value
	 */
	public var style_inline:String;
	
	/**
	 * Is this tag empty
	 */
	public function get empty():Boolean{
		return null == tag;
	}
}
}