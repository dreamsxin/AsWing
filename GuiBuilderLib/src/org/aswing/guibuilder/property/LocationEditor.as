package org.aswing.guibuilder.property{

import org.aswing.Component;
import org.aswing.event.MovedEvent;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;
	

public class LocationEditor extends IntPointEditor{
	
	private var ownerDisplay:Component;
	private var handApllying:Boolean;
	
	public function LocationEditor(){
		super();
	}
	
	override protected function handApply():void{
		handApllying = true;
		__apply(null);
		handApllying = false;
	}	
	
	override public function bindTo(p:ProModel):void{
		if(ownerDisplay){
			ownerDisplay.removeEventListener(MovedEvent.MOVED, __ownerDisplayMoved);
		}
		super.bindTo(p);
		if(p){
			ownerDisplay = p.getOwner().getValue() as Component;
			if(ownerDisplay){
				ownerDisplay.addEventListener(MovedEvent.MOVED, __ownerDisplayMoved);
			}
		}
	}
	
	private function __ownerDisplayMoved(e:MovedEvent):void{
		if(!handApllying){
			fillValue(new SimpleValue(e.getNewLocation()), false);
			applyProperty();
		}
	}
	
}
}