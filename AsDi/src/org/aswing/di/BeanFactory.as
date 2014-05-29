package org.aswing.di{

import flash.utils.getDefinitionByName;
import flash.xml.XMLNode;
import flash.utils.Dictionary;

/**
 * The bean factory class.
 * @author iiley
 */
public class BeanFactory{
	
	public static const TAG_BEAN:String = "Bean";
	public static const TAG_ID:String = "id";
	public static const TAG_CLASS:String = "class";
	public static const TAG_PREINSTANT:String = "preInstant";
	public static const TAG_PROPERTY:String = "Property";
	public static const TAG_NAME:String = "name";
	public static const TAG_VALUE_BEAN:String = "valueBean";
	public static const TAG_VALUE_INSTANCE:String = "valueInstance";
	public static const TAG_VALUE_STRING:String = "valueString";
	public static const TAG_VALUE_FLOAT:String = "valueFloat";
	public static const TAG_VALUE_INT:String = "valueInt";
	public static const TAG_VALUE_BOOL:String = "valueBool";
	
	private var idMap:Dictionary;
	private var beans:Array;
	
	public function BeanFactory(){
		idMap = new Dictionary();
		beans = new Array();
	}
	
	/**
	 * Builds beans configed in a xml node.
	 * @param config the beans nodes' parent node.
	 */
	public function build(config:XMLNode):void{
		prepareBuild(config);
		preBuildBeans();
	}
	
	/**
	 * Returns the bean with <code>id</code>, if bean with this id does not exists, null will 
	 * be returned.
	 * @return the bean or null.
	 */
	public function getBean(id:String):*{
		var bean:BeanMaker = idMap[id];
		if(bean != null){
			if(!bean.isInstanted()){
				buildBean(bean);
			}
			return bean.instance;
		}
		return null;
	}
	
	/**
	 * Returns whether or not the bean with <code>id</code> exists.
	 * @return true exists, false not.
	 */
	public function constansBean(id:String):Boolean{
		return idMap[id] != null;
	}
	
	/**
	 * Returns the instanted beans list which is specified cl instance
	 */
	public function getBeanListWithClass(cl:Class):Array{
		var values:Array = beans;
		var list:Array = new Array();
		for(var i:int=0; i<values.length; i++){
			var bean:BeanMaker = values[i];
			if(bean.isInstanted()){
				if(bean.instance is cl){
					list.push(bean.instance);
				}
			}
		}
		return list;
	}
	
	public static function reflectInstant(className:String):*{
		var assetClass:Class = null;
		try{
			assetClass = getDefinitionByName(className) as Class;
		}catch(e:Error){
		}
		if(assetClass != null){
			return new assetClass();
		}else{
			throw new Error("No class found : " + className);
		}
		return null;
	}	

	protected function prepareBuild(config:XMLNode):void{
		for(var node:XMLNode=config.firstChild; node!=null; node=node.nextSibling){
			if(node.nodeName == TAG_BEAN){
				var id:String = node.attributes[TAG_ID];
				var className:String = node.attributes[TAG_CLASS];
				var pre:String = node.attributes[TAG_PREINSTANT];
				var preInstant:Boolean = false;
				if(pre != null && pre.toLowerCase() == "true"){
					preInstant = true;
				}
				var bean:BeanMaker = new BeanMaker(id, className, preInstant);
				prepareProperties(bean, node);
				putBean(bean);
			}else{
				trace("Unkown bean tag : " + node);
			}
		}
	}

	protected function preBuildBeans():void{
		for(var i:int=0; i<beans.length; i++){
			var bean:BeanMaker = beans[i];
			if(bean.preInstant && !bean.isInstanted()){
				buildBean(bean);
			}
		}
	}
	
	protected function buildBean(bean:BeanMaker):void{
		if(!bean.isInstanted()){
			trace("build bean : " + bean, this);
			bean.instant();
			if(!bean.isPropertiesSet){
				setProperties(bean);
				bean.isPropertiesSet = true;
			}
		}
	}
	
	protected function putBean(bean:BeanMaker):void{
		if(idMap.containsKey(bean.id)){
			trace(idMap.getValue(bean.id));
			throw new Error("Id confic of bean " + bean);
		}
		beans.push(bean);
		idMap.put(bean.id, bean);
	}
	
	protected function prepareProperties(bean:BeanMaker, bnode:XMLNode):void{
		for(var node:XMLNode=bnode.firstChild; node!=null; node=node.nextSibling){
			if(node.nodeName == TAG_PROPERTY){
				bean.addProperty(node.attributes);
			}else{
				trace("unkown property tag : " + node);
			}
		}
	}
	
	protected function setProperties(bean:BeanMaker):void{
		if(!bean.isInstanted()){
			throw new Error("Not instanted yet!");
		}
		if(!bean.isPropertiesSet){
			var pros:Array = bean.properties;
			for(var i:int=0; i<pros.length; i++){
				var pro:BeanProperty = pros[i];
				var name:String = pro.getPropertyName();
				var beanIns:* = bean.instance;
				var proValue:* = getPropertyValue(pro);
				
				if(beanIns[name] is Function && beanIns[name] != null){
					if(proValue !== undefined){
						beanIns[name](proValue);
					}else{
						beanIns[name]();
					}
				}else{
					beanIns[name] = proValue;
				}
			}
		}
	}
	
	protected function getPropertyValue(pro:BeanProperty):*{
		if(pro[TAG_VALUE_BEAN] != null){
			return getBean(pro[TAG_VALUE_BEAN]);
		}else if(pro[TAG_VALUE_INSTANCE] != null){
			return reflectInstant(pro[TAG_VALUE_INSTANCE]);
		}else if(pro[TAG_VALUE_STRING] != null){
			return pro[TAG_VALUE_STRING];
		}else if(pro[TAG_VALUE_FLOAT] != null){
			return parseFloat(pro[TAG_VALUE_FLOAT]);
		}else if(pro[TAG_VALUE_INT] != null){
			return parseInt(pro[TAG_VALUE_INT]);
		}else if(pro[TAG_VALUE_BOOL] != null){
			return pro[TAG_VALUE_BOOL].toLowerCase() == "true"
		}else{
			return undefined;
		}		
	}
}

}