package{

import flash.display.Sprite;

import org.aswing.AsWingManager;
import org.aswing.JFrame;
import org.aswing.JScrollPane;
import org.aswing.JTable;
import org.aswing.VectorListModel;
import org.aswing.table.PropertyTableModel;

[SWF (width="400", height="450")]
public class PropertyTableTest extends Sprite{
	
	private var listData:VectorListModel;
	private var table:JTable;
	
	public function PropertyTableTest(){
		super();
		
		AsWingManager.initAsStandard(this);
		listData = new VectorListModel(
			[{name:"iiley", sex:1, age:26, score:99}, 
 			{name:"Comeny", sex:0, age:24, score:100}, 
 			{name:"Tom", sex:1, age:30, score:98},
 			{name:"Lita", sex:0, age:16, score:36}]
		);
		
		var tableModel:PropertyTableModel = new PropertyTableModel(
			listData, 
			["Student Name", "Sex", "Score"], 
			["name", "sex", "score"], 
			[null, new SexTranslator(), null]
		);
		
		table = new JTable(tableModel);
		
		var frame:JFrame = new JFrame(null, "PropertyTableTest");
		frame.setContentPane(new JScrollPane(table));
		
		frame.setSizeWH(300, 240);
		frame.show();
				
		//just for test add row
		addData({name:"Added name", sex:1, age:6, score:9});
	}
	
	public function addData(obj:Object):void{
		listData.append(obj);
	}
}
}

import org.aswing.table.PropertyTranslator;

class SexTranslator implements PropertyTranslator{
	
	public function translate(info:*, key:String):*{
		var sex:int = info[key];
		if(sex == 0){
			return "female";
		}else{
			return "male";
		}
	}
}