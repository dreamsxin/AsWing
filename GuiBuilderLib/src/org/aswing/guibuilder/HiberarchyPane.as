package org.aswing.guibuilder{

import org.aswing.BorderLayout;
import org.aswing.JButton;
import org.aswing.JPanel;
import org.aswing.JScrollPane;
import org.aswing.JTree;
import org.aswing.LoadIcon;

public class HiberarchyPane extends JPanel{
	
	private var tree:JTree;
	private var addChildButton:JButton;
	private var addBelowButton:JButton;
	private var removeButton:JButton;
	private var upButton:JButton;
	private var downButton:JButton;
	private var leftButton:JButton;
	private var rightButton:JButton;
	
	public function HiberarchyPane(){
		super();
		
		//creating
		tree = new JTree();
		tree.setSelectionMode(JTree.SINGLE_TREE_SELECTION);
		addChildButton = new JButton(null, new LoadIcon("icons/add_child.png", 20, 20));
		addChildButton.setDisabledIcon(new LoadIcon("icons/add_child_dis.png", 20, 20));
		addChildButton.setToolTipText("Add a component to this container");
		addBelowButton = new JButton(null, new LoadIcon("icons/add_below.png", 20, 20));
		addBelowButton.setDisabledIcon(new LoadIcon("icons/add_below_dis.png", 20, 20));
		addBelowButton.setToolTipText("Add a brother component below this component");
		removeButton = new JButton(null, new LoadIcon("icons/remove.png", 20, 20));
		removeButton.setDisabledIcon(new LoadIcon("icons/remove_dis.png", 20, 20));
		removeButton.setToolTipText("Remove selected component");
		upButton = new JButton("↑");
		upButton.setToolTipText("Move up");
		downButton = new JButton("↓");
		downButton.setToolTipText("Move down");
		leftButton = new JButton("←");
		leftButton.setToolTipText("Move to parent's parent");
		rightButton = new JButton("→");
		rightButton.setToolTipText("Move to first container brother");
		
		//layouting
		setLayout(new BorderLayout());
		append(new JScrollPane(tree), BorderLayout.CENTER);
		var bottom:JPanel = new JPanel();
		bottom.appendAll(addBelowButton, addChildButton, removeButton, upButton, downButton, leftButton, rightButton);
		append(bottom, BorderLayout.SOUTH);
		
		setOperatable(false);
	}
	
	public function setOperatable(b:Boolean):void{
		addBelowButton.setEnabled(b);
		addChildButton.setEnabled(b);
		removeButton.setEnabled(b);
		upButton.setEnabled(b);
		downButton.setEnabled(b);
		leftButton.setEnabled(b);
		rightButton.setEnabled(b);
	}
	
	public function getTree():JTree{
		return tree;
	}
	
	public function getAddChildButton():JButton{
		return addChildButton;
	}
	
	public function getAddBelowButton():JButton{
		return addBelowButton;
	}
	
	public function getRemoveButton():JButton{
		return removeButton;
	}
	
	public function getUpButton():JButton{
		return upButton;
	}
	
	public function getDownButton():JButton{
		return downButton;
	}
	
	
	public function getLeftButton():JButton{
		return leftButton;
	}
	
	public function getRightButton():JButton{
		return rightButton;
	}
}
}