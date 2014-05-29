package org.aswing.guibuilder.model{
	
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.guibuilder.PropertySerializer;
import org.aswing.guibuilder.util.MathUtils;

/**
 * Property Definition
 * @author iiley
 */
public class ProDefinition{
	
	private var xml:XML;
	private var name:String;
	private var label:String;
	private var type:String;
	private var action:String;
	private var defaultValue:XMLList;
	private var editorParam:String;
	private var tooltip:String;
	private var category:String;
	private var order:int;
	
	public function ProDefinition(xml:XML){
		this.xml = xml;
		label = xml.@label;
		name = xml.@name;
		type = xml.@type;
		action = xml.@action;
		editorParam = xml.@editorParam;
		defaultValue = xml.Value;
		tooltip = xml.@tooltip;
		category = xml.@category;
		order = MathUtils.parseInteger(xml.@order);
		if(editorParam == "") editorParam = null;
		if(tooltip == "") tooltip = null;
		if(category == "") category = null;
	}
	
	public function getName():String{
		return name;
	}
	
	public function getLabel():String{
		return label;
	}
	
	public function getDefaultValue():XMLList{
		return defaultValue;
	}
	
	public function getAction():String{
		return action;
	}
	
	public function getEditorParam():String{
		return editorParam;
	}
	
	public function getTooltip():String{
		return tooltip;
	}
	
	public function getCategory():String{
		return category;
	}
	
	public function getOrder():int{
		return order;
	}
	
	public function createPropertySerializer():PropertySerializer{
		var clazz:Class = Definition.getIns().getProTypeDefinition(type).getSerializerClass();
		return new clazz() as PropertySerializer;
	}
	
	public function createPropertyEditor():PropertyEditor{
		var clazz:Class = Definition.getIns().getProTypeDefinition(type).getEditorClass();
		var editor:PropertyEditor = new clazz() as PropertyEditor;
		editor.setSerializer(createPropertySerializer());
		return editor;
	}
}
}