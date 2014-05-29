package{

import flash.display.*;
import org.aswing.*;
//import org.aswing.skinbuilder.*;
import cases.*;
import cases.table.TableDemo;

[SWF (width="400", height="450", backgroundColor="0xFFFFFF")]
public class SkinBuilderTest extends Sprite{
	
	public function SkinBuilderTest(){
		super();
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.stageFocusRect = false;
		//UIManager.setLookAndFeel(new SkinBuilderLAF());
		AsWingManager.setRoot(this);
		//create other case instance here to test others
		//for example change below with addChild(new Button());
		//to test buttons.
		addChild(new NormalMenu());
	}
}
}