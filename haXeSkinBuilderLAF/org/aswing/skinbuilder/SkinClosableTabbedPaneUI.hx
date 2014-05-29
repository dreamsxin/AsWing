package org.aswing.skinbuilder;

import org.aswing.plaf.basic.tabbedpane.ClosableTab;
import flash.events.MouseEvent;
import org.aswing.plaf.basic.tabbedpane.Tab;
import org.aswing.JClosableTabbedPane;
import org.aswing.event.TabCloseEvent;
import org.aswing.Component;
import flash.events.Event;
import flash.display.DisplayObject; 
import org.aswing.skinbuilder.SkinTabbedPaneUI;
class SkinClosableTabbedPaneUI extends SkinTabbedPaneUI{
	
	public function new(){
		super();
	}
	
    override private function getPropertyPrefix():String{
        return "ClosableTabbedPane.";
    }
	
	private function getClosableTab(i:Int):ClosableTab{
    	return flash.Lib.as(tabs[i],ClosableTab);
	}
	
    override private function setTabProperties(header:Tab, i:Int):Void{
    	super.setTabProperties(header, i);
    	flash.Lib.as(header,ClosableTab).getCloseButton().setEnabled(
    		flash.Lib.as(tabbedPane,JClosableTabbedPane).isCloseEnabledAt(i)
    		&& tabbedPane.isEnabledAt(i));
    }
	
	override private function installListeners():Void{
		super.installListeners();
		tabbedPane.addEventListener(MouseEvent.CLICK, __onTabPaneClicked);
	}
	
	override private function uninstallListeners():Void{
		super.uninstallListeners();
		tabbedPane.removeEventListener(MouseEvent.CLICK, __onTabPaneClicked);
	}
	
	override private function __onTabPanePressed(e:Event):Void{
		if((prevButton.hitTestMouse() || nextButton.hitTestMouse())
			&& (prevButton.isShowing() && nextButton.isShowing())){
			return;
		}
		var index:Int= getMousedOnTabIndex();
		if(index >= 0 && tabbedPane.isEnabledAt(index) && !isButtonEvent(e, index)){
			tabbedPane.setSelectedIndex(index);
		}
	}
	    
	private function isButtonEvent(e:Event, index:Int):Bool{
		var eventTarget:DisplayObject = flash.Lib.as(e.target,DisplayObject)	;
		if(eventTarget!=null)	{
			var button:Component = getClosableTab(index).getCloseButton();
			if(button == eventTarget || button.contains(eventTarget)){
				return true;
			}
		}
		return false;
	}
	
	private function __onTabPaneClicked(e:Event):Void{
		var index:Int= getMousedOnTabIndex();
		if(index >= 0 && tabbedPane.isEnabledAt(index) && isButtonEvent(e, index)){
			tabbedPane.dispatchEvent(new TabCloseEvent(index));
		}
	}	
}