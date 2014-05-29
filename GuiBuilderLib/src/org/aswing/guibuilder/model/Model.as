package org.aswing.guibuilder.model{

public interface Model extends ValueModel{
	
	function applyProperty(name:String, value:ValueModel, action:String):void;
		
	function getProperties():Array;
		
	function parse(xml:*):void;
	
	function encodeXML():XML;
}
}