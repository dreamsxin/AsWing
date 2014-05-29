package org.aswing.guibuilder.model{

import org.aswing.*;
import org.aswing.util.ArrayList;	

/**
 * Component Model
 * @author iiley
 */
public class ComModel implements Model{
	public static const DISPLAY_MODEL_KEY:String = "displayModelKey";
	
	public static const ID_NAME:String = "id";
	public static const ATTR_SCOPE_NAME:String = "attr_scope";
	public static const GETTER_SCOPE_NAME:String = "getter_scope";
	
	public static const SCOPE_NONE:String = "none";
	public static const SCOPE_PRIVATE:String = "private";
	public static const SCOPE_PROTECTED:String = "protected";
	public static const SCOPE_PUBLIC:String = "public";
	public static const SCOPE_INTERNAL:String = "internal";
	
	private static var id_counter:int = 0;
	
	private var def:ComDefinition;
	private var display:Component;
	private var children:ArrayList;
	private var properties:ArrayList;
	private var container:Boolean;
	private var parent:ComModel;
	private var id:String;
	private var atrributeScope:String;
	private var getterScope:String;
	
	private var changedHandler:Function;
	
	public function ComModel(def:ComDefinition=null){
		atrributeScope = "private";
		getterScope = "public";
		id_counter++;
		if(def != null){
			var defn:String = def.getName();
			if(defn.charAt(0) == "J"){
				defn = defn.substr(1);
			}
			defn = defn.toLowerCase();
			id = defn + id_counter;
			create(def);
		}
	}
	
	public function create(def:ComDefinition):void{
		if(this.def != null){
			throw new Error("This com model is already created!");
		}
		this.def = def;
		children = new ArrayList();
		properties = new ArrayList();
		var clazz:Class = def.getClass();
		display = new clazz();
		display.putClientProperty(DISPLAY_MODEL_KEY, this);
		container = def.isContainer();
		
		var pros:Array = def.getProperties();
		for(var i:int=0; i<pros.length; i++){
			properties.append(new ProModel(pros[i]));
		}
		properties.append(new PackProModel());
		
		initProModels();
	}
	
	public function getDefinition():ComDefinition{
		return def;
	}
	
	public function getAttributeScope():String{
		return atrributeScope;
	}
	
	public function getGetterScope():String{
		return getterScope;
	}
	
	public function getID():String{
		return id;
	}
	
	/**
	 * handler(this)
	 */
	public function setChangedHandler(handler:Function):void{
		changedHandler = handler;
	}
	
	public function parse(xml:*):void{
		id = xml.@id;
		var name:String = xml.@name;
		var def:ComDefinition = Definition.getIns().getComDefinition(name);
		create(def);
		//properties
		var proxmls:* = xml.Properties.Property;
		for each(var proxml:* in proxmls){
			var pname:String = proxml.@name;
			var pro:ProModel = getPropertyModel(pname);
			if(pro){
				pro.parse(proxml);
			}
		}
		//children
		var childxmls:* = xml.Com;
		for each(var ccxml:* in childxmls){
			var cc:ComModel = new ComModel();
			cc.parse(ccxml);
			addChild(cc);
		}
	}
	
	public function encodeXML():XML{
		var xml:XML = <Com></Com>;
		xml.@name = def.getName();
		xml.@id = id;
		//properties
		var proXml:XML = <Properties></Properties>;
		xml.appendChild(proXml);
		var n:int = properties.size();
		for(var i:int=0; i<n; i++){
			var pro:ProModel = properties.get(i);
			var pxml:XML = pro.encodeXML();
			if(pxml != null){
				proXml.appendChild(pxml);
			}
		}
		
		//children
		n = children.size();
		for(i=0; i<n; i++){
			var cc:ComModel = children.get(i);
			xml.appendChild(cc.encodeXML());
		}
		return xml;
	}
	
	private function initProModels():void{
		for(var i:int=0; i<properties.size(); i++){
			var pro:ProModel = properties.get(i);
			pro.bindTo(this);
		}
	}
	
	private function getPropertyModel(name:String):ProModel{
		var n:int = properties.size();
		for(var i:int=0; i<n; i++){
			var pro:ProModel = properties.get(i);
			if(pro.getName() == name){
				return pro;
			}
		}
		return null;
	}
	
	public function applyProperty(name:String, value:ValueModel, action:String):void{
		trace(this + " apply name : " + name + ", value : " + value + ", action : " + action);
		var idChanged:Boolean = false;
		if(name == ID_NAME){
			this.id = value.getValue();
			idChanged = true;
		}else if(name == ATTR_SCOPE_NAME){
			this.atrributeScope = value.getValue();
		}else if(name == GETTER_SCOPE_NAME){
			this.getterScope = value.getValue();
		}else{
			var o:Object = getDisplay();
			o["set"+name](value.getValue());
			if(action != null && action != ""){
				o[action]();
			}
		}
		if(changedHandler != null){
			changedHandler(this, idChanged);
		}
	}
	
	public function getDisplay():Component{
		return display;
	}
	
	public function getValue():*{
		return display;
	}
	
	public function getParent():ComModel{
		return parent;
	}
	
	/**
	 * ComModel[]
	 */
	public function getChildren():Array{
		return children.toArray();
	}
	
	public function getChild(index:int):ComModel{
		return children.get(index);
	}
	
	public function getChildCount():int{
		return children.size();
	}
	
	public function getChildIndex(child:*):int{
		return children.indexOf(child);
	}
	
	/**
	 * ProModel[]
	 */	
	public function getProperties():Array{
		return properties.toArray();
	}
	
	public function getProperty(name:String):ProModel{
		for(var i:int=0; i<properties.size(); i++){
			var pro:ProModel = properties.get(i);
			if(pro.getName() == name){
				return pro;
			}
		}
		return null;
	}
		
	public function addChild(mod:ComModel, index:int=-1):void{
		if(isContainer()){
			children.append(mod, index);
			var con:* = display;// as Container;
			con.insert(index, mod.getDisplay());
			con.revalidate();
			mod.parent = this;
		}else{
			throw new Error("This is not a container, can add child!");
		}
	}
	
	public function removeChild(mod:ComModel):ComModel{
		if(!isContainer()){
			throw new Error("This is not a container, does not have child!");
		}
		if(mod.parent == this){
			children.remove(mod);
			var con:* = display;// as Container;
			con.remove(mod.getDisplay());
			con.revalidate();
			mod.parent = null;
			return mod;
		}
		return null;
	}
	
	public function isContainer():Boolean{
		return container;
	}
	
	public function toString():String{
		return id + "-[" + def.getName() + "]";
	}
}
}