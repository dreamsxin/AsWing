package componetset{

import org.aswing.table.DefaultTextCell;
import cases.*;
import org.aswing.*;

public class SexIconCell extends DefaultTextCell{
	
	private var male_icon:Icon;
	private var female_icon:Icon;
	
	public function SexIconCell(){
		super();
		male_icon = new CircleIcon(ASColor.RED, 18, 18);
		female_icon = new ColorIcon(ASColor.BLUE, 18, 18);
	}
	
	override public function setCellValue(value:*) : void {
		this.value = value;
		setText(value.toString());
		if(value){
			setIcon(male_icon);
		}else{
			setIcon(female_icon);
		}
	}
}
}