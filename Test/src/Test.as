package {

import cases.DateChooserCase;

import flash.display.*;
import flash.events.Event;
import flash.filters.*;
import flash.text.*;


[SWF (width="360", height="300", backgroundColor="0x006666")]
public class Test extends Sprite{
	
	public function Test(){
		super();
		
		if(stage != null){
			init();
		}else{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(e:Event=null):void{
		//AsWingManager.initAsStandard(this, true, false);
		this.stage.frameRate = 25;
		//create other case instance here to test others
		//for example change below with addChild(new Button());
		//to test buttons.
		//UIManager.setLookAndFeel(new AeonLAF());
		addChild(new DateChooserCase());
		
		var date:Date = new Date(2000, 1, 1);
		trace(date);
		date.setDate(30);
		trace(date);
		date.setDate(30);
		trace(date);
	}
}
}

