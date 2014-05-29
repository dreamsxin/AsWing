package org.aswing.guibuilder.model{

import org.aswing.util.HashMap;	

/**
 * Definition manager
 * @author iiley
 */
public class Definition{
	
	public static const TAG_COM:String = "Com";
	
	private static var ins:Definition;
	
	public static function getIns():Definition{
		if(ins == null){
			new Definition();
		}
		return ins;
	}
	
	private var protypes:HashMap;
	private var components:HashMap;
	private var layouts:HashMap;
	private var layoutsClassMap:HashMap;
	private var borders:HashMap;
	private var bordersClassMap:HashMap;
	
	private var orderComponents:Array;
	private var orderLayouts:Array;
	private var orderBorders:Array;
	
	public function Definition(){
		if(ins){
			throw new Error("Sington can't be instant more than once!");
		}
		ins = this;
		protypes = new HashMap();
		components = new HashMap();
		orderComponents = new Array();
		orderLayouts = new Array();
		layouts = new HashMap();
		layoutsClassMap = new HashMap();
		
		borders = new HashMap();
		bordersClassMap = new HashMap();
		orderBorders = new Array();
	}
	
	public function init(xml:XML):void{
		//generate property types
		var typexml:* = xml.Types.Type;
		for each(var type:XML in typexml){
			var t:ProTypeDefinition = new ProTypeDefinition(type);
			protypes.put(t.getName(), t);
		}
		
		//generate components
		var baseCom:ComDefinition = new ComDefinition(xml.Components.BaseComponent, null);
		var baseCon:ComDefinition = new ComDefinition(xml.Components.BaseContainer, baseCom);
		components.put(baseCom.getName(), baseCom);
		components.put(baseCon.getName(), baseCon);
		
		var comxml:* = xml.Components.Com;
		for each(var cc:XML in comxml){
			var superName:String = cc.@sup;
			var c:ComDefinition = new ComDefinition(cc, getComDefinition(superName));
			components.put(c.getName(), c);
			if(cc.name() == TAG_COM){
				orderComponents.push(c);
			}
		}
		
		var layxml:* = xml.Layouts.Layout;
		for each(var ll:XML in layxml){
			superName = ll.@sup;
			var lay:LayoutDefinition = new LayoutDefinition(ll, getLayoutDefinition(superName));
			layouts.put(lay.getName(), lay);
			layoutsClassMap.put(lay.getClassName(), lay);
			orderLayouts.push(lay);
		}
		
		var borxml:* = xml.Borders.Border;
		for each(var bb:XML in borxml){
			superName = bb.@sup;
			var bor:BorderDefinition = new BorderDefinition(bb, getBorderDefinition(superName));
			borders.put(bor.getName(), bor);
			bordersClassMap.put(bor.getClassName(), bor);
			orderBorders.push(bor);
		}
	}
	
	public function getComDefinition(name:String):ComDefinition{
		return components.getValue(name);
	}
	
	public function getLayoutDefinition(name:String):LayoutDefinition{
		return layouts.getValue(name);
	}
	
	public function getLayoutDefinitionWithClassName(className:String):LayoutDefinition{
		return layoutsClassMap.getValue(className);
	}	
	
	public function getProTypeDefinition(type:String):ProTypeDefinition{
		return protypes.getValue(type);
	}
	
	public function getBorderDefinitionWithClassName(className:String):BorderDefinition{
		return bordersClassMap.getValue(className);
	}	
	
	public function getBorderDefinition(type:String):BorderDefinition{
		return borders.getValue(type);
	}
	
	/**
	 * Returns ComDefinition[]
	 */
	public function getComponents():Array{
		return orderComponents.concat();
	}
	
	/**
	 * Returns LayoutDefinition[]
	 */
	public function getLayouts():Array{
		return orderLayouts.concat();
	}
	
	/**
	 * Returns BorderDefinition[]
	 */
	public function getBorders():Array{
		return orderBorders.concat();
	}
}
}