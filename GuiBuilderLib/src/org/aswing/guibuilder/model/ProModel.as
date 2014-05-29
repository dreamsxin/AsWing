package org.aswing.guibuilder.model{

import org.aswing.guibuilder.DefaultValueHelper;
import org.aswing.guibuilder.PropertySerializer;	

/**
 * Property Model
 * @author iiley
 */
public class ProModel{
	
	public static const NONE_VALUE_SET:SimpleValue = new SimpleValue(null);
	
	protected var def:ProDefinition;
	protected var owner:Model;
	protected var value:ValueModel;
	protected var noneValue:Boolean; //whether or not set this property a value
	protected var defaultValue:ValueModel;
	protected var valueXML:XML;
	protected var valueSerializer:PropertySerializer;
	
	public function ProModel(def:ProDefinition){
		this.def = def;
		noneValue = true;
		valueSerializer = def.createPropertySerializer();
	}
	
	public function getDef():ProDefinition{
		return def;
	}
	
	public function valueChanged(v:ValueModel):void{
		trace("valueChanged : " + v);
		if(v === NONE_VALUE_SET){
			value = undefined;
			noneValue = true;
			owner.applyProperty(def.getName(), defaultValue, def.getAction());
		}else{
			value = v;
			noneValue = false;
			owner.applyProperty(def.getName(), v, def.getAction());
		}
	}
		
	public function getValue():ValueModel{
		if(noneValue){
			return NONE_VALUE_SET;
		}else{
			return value;
		}
	}
		
	public function isNoValueSet():Boolean{
		return noneValue;
	}
	
	public function bindTo(c:Model):void{
		owner = c;
		defaultValue = captureDefaultProperty(def.getName());
		var defaultValueXML:XMLList = def.getDefaultValue();
		if(defaultValueXML != null && defaultValueXML.length() >0){
			trace("defaultValueXML[0] : " + defaultValueXML[0].toXMLString());
			valueChanged(valueSerializer.decodeValue(defaultValueXML[0], this));
		}
	}
	
	public function parse(xml:XML):void{
		var valueXML:XMLList = xml.Value;
		if(valueXML != null && valueXML.length() > 0){
			valueChanged(valueSerializer.decodeValue(valueXML[0], this));
		}
	}
	
	public function encodeXML():XML{
		if(noneValue){
			return null;
		}
		var xml:XML = <Property></Property>;
		xml.@name = getName();
		xml.@type = def.getName();
		xml.appendChild(valueSerializer.encodeValue(value, this));
		return xml;
	}
	
	public function getOwner():Model{
		return owner;
	}
	
	protected function captureDefaultProperty(name:String):ValueModel{
		if(valueSerializer is DefaultValueHelper){
			var helper:DefaultValueHelper = valueSerializer as DefaultValueHelper;
			if(helper.isNeedHelp(name, owner)){
				return helper.getDefaultValue(name, owner);
			}
		}
		var o:Object = owner.getValue();
		var v:* = undefined;
		try{
			v = o["get"+name]();
		}catch(e:Error){
			try{
				v = o["is"+name]();
			}catch(e:Error){}
		}
		return new SimpleValue(v);
	}
	
	/**
	 * (0, n-2) line are the property creation, last line is the property name, for example:
	 * [ "var border3:LineBorder = new LineBorder();", 
	 *   "border3.setThickness(4);", 
	 *   "border3"
	 * ]
	 */
	public function getCodeLines():Array{
		if(noneValue){
			return null;
		}
		return valueSerializer.getCodeLines(value, this);
	}
	
	/**
	 * Just one string to represent the value, for example "new ASColor(0xff0000, 1)";
	 * If just one string can't, return null, then getCodeLines will be called.
	 */
	public function isSimpleOneLine():String{
		if(noneValue){
			return null;
		}
		return valueSerializer.isSimpleOneLine(value, this);
	}
	
	public function getLabel():String{
		return def.getLabel();
	}
	
	public function getName():String{
		return def.getName();
	}
}
}