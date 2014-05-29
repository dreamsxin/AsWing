package cases
{
	
import flash.display.Sprite;
import org.aswing.*;
import org.aswing.event.ListItemEvent;
import org.aswing.border.LineBorder;
import flash.events.Event;
import cases.list.*;

public class List extends Sprite
{
	private var frame:JFrame;
    private var list:JList;
    private var listData:VectorListModel;
    
	
	public function List()
	{
		super();
		
        frame = new JFrame(null, "List With Diff Height Items");
        
        var arr:Array = new Array();
        
        //list40
		//for(var i:Number=0; i<40; i++){
		//	arr.push("Item " + i);
		//}
        //list60
        var str:String = "A long String with many many many many A long String with many many many many many chars!!!";
        for(var i:int=0; i<60; i++){
            var startI:Number = Math.floor(Math.random()*40);
            var length:Number =  Math.floor(Math.random()*(str.length - startI));
            arr.push(i + " " + str.substr(startI, length));
        }
        
        //list100000
        
        //for(var i:int=0; i<100000; i++){
       //     arr.push("Item " + i);
       // }
        
        listData = new VectorListModel(arr);
        //list40
        //list = new JList(listData, new GeneralListCellFactory(IconListCell, false, false));
        //list.setBorder(new LineBorder(null, ASColor.RED, 3));
        //list60
        //list = new JList(listData, new GeneralListCellFactory(IconListCell, false, true));
        //list100000
        list = new JList(listData);
        
        var centerPane:JPanel = new JPanel(new BorderLayout());
        var scrollPane:JScrollPane = new JScrollPane(list);
        scrollPane.setBorder(new LineBorder());
        centerPane.append(scrollPane, BorderLayout.CENTER);
        
        var addButton:JButton = new JButton("Add Item");
        addButton.addActionListener(__addItem);
        var removeButton:JButton = new JButton("Remove Item");
        removeButton.addActionListener(__removeItem);
        var buttonPane:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
        buttonPane.append(addButton);
        buttonPane.append(removeButton);
        centerPane.append(buttonPane, BorderLayout.SOUTH);
        
        frame.setContentPane(centerPane);
        
        list.addEventListener(ListItemEvent.ITEM_CLICK, __onItemClick);

        frame.setLocationXY(50, 50);
        frame.setSizeWH(300, 250);
        frame.show();        
	}
		
    
    private function __onItemClick(e:ListItemEvent):void{
        //trace("-- list : " + e.target);
        //trace("-- value : " + e.getValue());
        //trace("-- cell : " + e.getCell());
    }
    
    private function __addItem(e:Event):void{
        listData.append("Added Item " + Math.floor(Math.random()*1000));
        list.scrollToBottomLeft();
    }
    private function __removeItem(e:Event):void{
    	//listData.append("Added Item " + Math.floor(Math.random()*1000));
        //listData.removeAt(0);
        listData.clear();
        //list.scrollToTopLeft();
    }
}
}