package cases
{
import flash.display.Sprite;
import org.aswing.*;
import flash.events.Event;
import org.aswing.tree.DefaultTreeModel;
import org.aswing.tree.DefaultMutableTreeNode;

public class Tree extends Sprite
{
	public function Tree()
	{
		super();
		doTreeTest();
	}
	
	private var tree:JTree;
	private var frame:JFrame;
	
	public function doTreeTest():void {
		frame = new JFrame(null, "TreeTest");
		var pane:JPanel = new JPanel(new BorderLayout());
		tree = new JTree();
		tree.setEditable(true);
		tree.setRowHeight(20);
		//tree.setFixedCellWidth(80);
		pane.append(new JScrollPane(tree), BorderLayout.CENTER);
		var button:JButton = new JButton("Expand");
		pane.append(button, BorderLayout.SOUTH);
		frame.setContentPane(pane);
		button.addActionListener(__repaintTree);
		
		//tree.setModel(new DefaultTreeModel(new DefaultMutableTreeNode("tree")));
		tree.setRootVisible(false);
		
		frame.setSizeWH(200, 200);
		frame.show();
	}
	
	private function __repaintTree(e:Event):void{
		tree.expandPath(tree.getPathForRow(1));
		tree.expandPath(tree.getPathForRow(0));
	}
}
}