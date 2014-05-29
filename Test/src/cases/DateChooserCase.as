package cases{

import flash.display.Sprite;

import org.aswing.Insets;
import org.aswing.JFrame;
import org.aswing.border.EmptyBorder;
import org.aswing.event.InteractiveEvent;
import org.aswing.ext.DateChooser;
import org.aswing.ext.DateRange;


/**
 * @author iiley (Burstyx Studio)
 */
public class DateChooserCase extends Sprite{
	
	public function DateChooserCase(){
		super();
		
		var frame:JFrame = new JFrame(this, "Date Chooser");
		var chooser:DateChooser = new DateChooser();
		chooser.setDisabledDays([0, 6]);
		chooser.setAllowMultipleSelection(true);
		chooser.setBorder(new EmptyBorder(null, new Insets(4)));
		chooser.setDisabledRanges([
			new DateRange(new Date(2011, 2, 15), new Date(2011, 2, 25)), 
			DateRange.singleDay(new Date())]);
		frame.setContentPane(chooser);
		frame.pack();
		frame.show();
		
		chooser.addEventListener(InteractiveEvent.SELECTION_CHANGED, __selection);
	}
	
	private function __selection(e:InteractiveEvent):void{
		var chooser:DateChooser = e.currentTarget as DateChooser;
		var str:String = "";
		if(e.isProgrammatic()){
			str += "---Programmatic";
		}else{
			str += "+++";
		}
		trace(str + " : " + chooser.getSelectedDates());
	}
}
}