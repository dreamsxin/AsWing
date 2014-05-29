package org.aswing.guibuilder{

import org.aswing.JPopupMenu;
import org.aswing.guibuilder.model.ComDefinition;
import org.aswing.JMenuItem;
import flash.events.Event;

public class ComponentMenu extends JPopupMenu{
	
	private var selectionHandler:Function;
	
	public function ComponentMenu(){
		super();
	}
	
	/**
	 * ComDefinition[]
	 */
	public function setComponents(coms:Array):void {
		// Sort items
		coms.sortOn( "sortValue" );
		
		for each(var def:ComDefinition in coms){
			var item:JMenuItem = addMenuItem(def.getName());
			item.putClientProperty("comDef", def);
			item.addActionListener(__itemSelected);
		}
	}
	
	private function __itemSelected(e:Event):void{
		var item:JMenuItem = e.currentTarget as JMenuItem;
		var def:ComDefinition = item.getClientProperty("comDef");
		if(selectionHandler != null){
			selectionHandler(def);
		}
	}
	
	/**
	 * handler(def:ComDefinition)
	 */
	public function setItemSelectionHandler(handler:Function):void{
		selectionHandler = handler;
	}
}
}