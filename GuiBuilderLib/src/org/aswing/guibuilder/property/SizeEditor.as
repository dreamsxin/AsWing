package org.aswing.guibuilder.property{

import org.aswing.Component;
import org.aswing.event.ResizedEvent;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.model.SimpleValue;

public class SizeEditor extends IntDimensionEditor{
		
	private var ownerDisplay:Component;
	private var handApllying:Boolean;
	
	public function SizeEditor(){
		super();
	}
	
	override protected function handApply():void{
		handApllying = true;
		__apply(null);
		handApllying = false;
	}
	
	override public function bindTo(p:ProModel):void{
		if(ownerDisplay){
			ownerDisplay.removeEventListener(ResizedEvent.RESIZED, __ownerDisplayResized);
		}
		super.bindTo(p);
		if(p){
			ownerDisplay = p.getOwner().getValue() as Component;
			if(ownerDisplay){
				ownerDisplay.addEventListener(ResizedEvent.RESIZED, __ownerDisplayResized);
			}
		}
	}
	
	private function __ownerDisplayResized(e:ResizedEvent):void{
		if(!handApllying){
			fillValue(new SimpleValue(e.getNewSize()), false);
			applyProperty();
		}
	}
}
}