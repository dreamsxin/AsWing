package cases
{
import flash.display.Sprite;
import org.aswing.*;
import org.aswing.tree.*;
import flash.events.Event;


public class TreeBig extends Sprite
{
	public function TreeBig()
	{
		super();
		doBigTreeTest();
	}
	
	private var tree:JTree;
	private var frame:JFrame;
	
	public function doBigTreeTest():void {
		frame = new JFrame(null, "TreeBig");
		var pane:JPanel = new JPanel(new BorderLayout());
		
        var root:DefaultMutableTreeNode = new DefaultMutableTreeNode(createItem("JTree"));
		var parent:DefaultMutableTreeNode;
	
		parent = new DefaultMutableTreeNode(createItem("folder1"));
		root.append(parent);
		var i:int;
		for(i=0; i<100; i++){
			parent.append(new DefaultMutableTreeNode(createItem("item one " + i)));
		}
		
		parent = new DefaultMutableTreeNode(createItem("folder2"));
		root.append(parent);
		for(i=0; i<500; i++){
			parent.append(new DefaultMutableTreeNode(createItem("item two " + i)));
		}

		parent = new DefaultMutableTreeNode(createItem("folder3"));
		root.append(parent);
		for(i=0; i<100; i++){
			parent.append(new DefaultMutableTreeNode(createItem("item three " + i)));
		}
				
        var model:DefaultTreeModel = new DefaultTreeModel(root);		
		
		tree = new JTree();
		tree.setModel(model);
		tree.setFixedCellWidth(100);
		tree.setRootVisible(false);
		pane.append(new JScrollPane(tree), BorderLayout.CENTER);
		var button:JButton = new JButton("Expand");
		pane.append(button, BorderLayout.SOUTH);
		frame.setContentPane(pane);
		button.addActionListener(__repaintTree);
		
		frame.setSizeWH(200, 400);
		frame.show();
	}
	
	private function createItem(value:String):*{
		return value;
	}
	
	private function __repaintTree(e:Event):void{
		tree.expandPath(tree.getPathForRow(2));
		tree.expandPath(tree.getPathForRow(1));
	}
}
}