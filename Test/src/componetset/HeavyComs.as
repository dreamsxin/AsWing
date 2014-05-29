package componetset{
	
import org.aswing.*;
import org.aswing.border.*;
import org.aswing.table.*;
import org.aswing.table.sorter.*;

public class HeavyComs extends JPanel{
	
	public function HeavyComs(){
		super(new BorderLayout());
		name = "HeavyComponents";
		
		var list:Component = createList();
		
		var tree:JTree = new JTree();
		
		var table:Component = createTable();
		
		var top:Box = Box.createHorizontalBox(2);
		top.append(list);
		top.append(new JScrollPane(tree));
		top.setPreferredHeight(200);
		top.setBorder(new TitledBorder(null, "List and Tree"));
		
		append(top, BorderLayout.NORTH);
		
		table.setBorder(new TitledBorder(null, "Table(DataGrid)"));
		
		append(table, BorderLayout.CENTER);
	}
	
	private function createList():Component{
		var arr:Array = new Array();
        var str:String = "A long String with many many many many A long String with many many many many many chars!!!";
        for(var i:int=0; i<60; i++){
            var startI:Number = Math.floor(Math.random()*40);
            var length:Number =  Math.floor(Math.random()*(str.length - startI));
            arr.push(i + " " + str.substr(startI, length));
        }
        var listData:VectorListModel = new VectorListModel(arr);
        var list:JList = new JList(listData, new GeneralListCellFactory(IconListCell, false, false));
        list.setBorder(new LineBorder(null, ASColor.RED, 3));
        return new JScrollPane(list);
	}
	
	private function createTable():Component{
		
		var data:Array = [["iiley", 100, true, 23, 33, "the last"], 
		  ["I dont know who", -12, false, 13, 33, "the last"],
		  ["A little cute girl", 98765, false, 0, 33, "the last2"], 
		  ["Therion1", 99, true, 23, 33, "the last3"],
		  ["Therion2", 99, true, 63, 33, "the last4"],
		  ["Therion3", 99, true, 23, 33, "the last5"],
		  ["Therion4", 99, true, 23, 33, "the last5"]];
		for(var i:Number=0; i<100; i++){
			data.push(["other"+i, i, Math.random()<0.5, 13, 323, i+"last"]);
		}
		var column:Array = ["name", "score", "male", "number", "number", "last"];
		
		var model:DefaultTableModel = (new DefaultTableModel()).initWithDataNames(data, column);
		model.setColumnClass(1, "Number");
		model.setColumnClass(2, "Boolean");
		
		var sorter:TableSorter = new TableSorter(model);
		var table:JTable = new JTable(sorter);
		table.setRowHeight(22);
		sorter.setTableHeader(table.getTableHeader());
		sorter.setColumnSortable(4, false);
		sorter.setSortingStatus(3, TableSorter.ASCENDING);
		
		
		var combEditor:DefaultComboBoxCellEditor = new DefaultComboBoxCellEditor();
		combEditor.getComboBox().setListData(["Therion1", "Therion2", "Therion3", "Therion4"]);
		table.getColumn("name").setCellEditor(combEditor);
		table.getColumn("male").setCellFactory(new GeneralTableCellFactory(SexIconCell));
		table.setDefaultCellFactory("Object", new GeneralTableCellFactory(PoorTextCell));
		table.setBorder(new EmptyBorder(new LineBorder(null, ASColor.RED, 2), new Insets(5, 5, 5, 5)));
		table.setRowSelectionInterval(10, 13);
		table.setAutoResizeMode(JTable.AUTO_RESIZE_OFF);
		var scrollPane:JScrollPane = new JScrollPane(table); 
		return scrollPane;
	}
}
}