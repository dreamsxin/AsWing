package org.aswing.guibuilder.model{

import org.aswing.util.ArrayList;
import org.aswing.util.Reflection;	

/**
 * Aggregation class model definition.
 * @author iiley
 */
public class AbsAggDefinition {
	
	public var sortValue:String; // sortValue has to be public so we can access it through Array.sortOn()
	
	protected var xml:*;
	protected var name:String;
	protected var className:String;
	protected var shortClassName:String;
	protected var clazz:Class;
	protected var superDef:AbsAggDefinition;
	protected var properties:ArrayList;
	
	public function AbsAggDefinition(xml:*, superDef:AbsAggDefinition){
		this.xml = xml;
		this.superDef = superDef;
		name = xml.@name;
		sortValue = name;
		className = xml.@clazz;
		clazz = Reflection.getClass(className);
		var strs:Array = className.split(".");
		shortClassName = strs[strs.length-1];
		properties = new ArrayList();
		if(superDef){
			properties.appendAll(superDef.getProperties());
		}
		var proxml:* = xml.Property;
		for each(var node:* in proxml){
			addProDef(new ProDefinition(node));
		}
	}
	
	private function addProDef(def:ProDefinition):void{
		for(var i:int=properties.size()-1; i>=0; i--){
			var pro:ProDefinition = properties.get(i);
			if(pro.getName() == def.getName()){
				properties.setElementAt(i, def); //replace super define
				return;
			}
		}
		properties.append(def);
	}
	
	public function getName():String{
		return name;
	}
	
	public function getClassName():String{
		return className;
	}
	
	public function getShortClassName():String{
		return shortClassName;
	}
	
	public function getSuperDefinition():AbsAggDefinition{
		return superDef;
	}
	
	public function getClass():Class{
		return clazz;
	}
	
	/**
	 * ProDefinition[]
	 */
	public function getProperties():Array{
		return properties.toArray();
	}
		
}
}