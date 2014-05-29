package org.aswing.plaf.basic{

import org.aswing.Component;
import org.aswing.JClosableTabbedPane;
import org.aswing.event.TabCloseEvent;
import org.aswing.plaf.basic.tabbedpane.BasicClosableTabbedPaneTab;
import org.aswing.plaf.basic.tabbedpane.ClosableTab;
import org.aswing.plaf.basic.tabbedpane.Tab;

import flash.display.DisplayObject;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * Basic imp for JClosableTabbedPane UI.
 * @author iiley
 */
public class BasicClosableTabbedPaneUI extends BasicTabbedPaneUI{
	
	public function BasicClosableTabbedPaneUI(){
		super();
	}	
	
    override protected function getPropertyPrefix():String {
        return "ClosableTabbedPane.";
    }
	
	protected function getClosableTab(i:int):ClosableTab{
    	return ClosableTab(tabs[i]);
	}
	
    override protected function setTabProperties(header:Tab, i:int):void{
    	super.setTabProperties(header, i);
    	ClosableTab(header).getCloseButton().setEnabled(
    		JClosableTabbedPane(tabbedPane).isCloseEnabledAt(i)
    		&& tabbedPane.isEnabledAt(i));
    }
	
	override protected function installListeners():void{
		super.installListeners();
		tabbedPane.addEventListener(MouseEvent.CLICK, __onTabPaneClicked);
	}
	
	override protected function uninstallListeners():void{
		super.uninstallListeners();
		tabbedPane.removeEventListener(MouseEvent.CLICK, __onTabPaneClicked);
	}
	
	override protected function __onTabPanePressed(e:Event):void{
		if((prevButton.hitTestMouse() || nextButton.hitTestMouse())
			&& (prevButton.isShowing() && nextButton.isShowing())){
			return;
		}
		var index:int = getMousedOnTabIndex();
		if(index >= 0 && tabbedPane.isEnabledAt(index) && !isButtonEvent(e, index)){
			tabbedPane.setSelectedIndex(index);
		}
	}
	
    /**
     * Just override this method if you want other LAF headers.
     */
    override protected function createNewTab():Tab{    	
    	var tab:Tab = getInstance(getPropertyPrefix() + "tab") as Tab;
    	if(tab == null){
    		tab = new BasicClosableTabbedPaneTab();
    	}
    	tab.initTab(tabbedPane);
    	tab.getTabComponent().setFocusable(false);
    	return tab;
    }
    
	protected function isButtonEvent(e:Event, index:int):Boolean{
		var eventTarget:DisplayObject = e.target as DisplayObject;
		if(eventTarget){
			var button:Component = getClosableTab(index).getCloseButton();
			if(button == eventTarget || button.contains(eventTarget)){
				return true;
			}
		}
		return false;
	}
	
	protected function __onTabPaneClicked(e:Event):void{
		var index:int = getMousedOnTabIndex();
		if(index >= 0 && tabbedPane.isEnabledAt(index) && isButtonEvent(e, index)){
			tabbedPane.dispatchEvent(new TabCloseEvent(index));
		}
	}	
}
}