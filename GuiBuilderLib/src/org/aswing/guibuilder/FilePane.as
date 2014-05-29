package org.aswing.guibuilder{

import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.border.TitledBorder;
import org.aswing.JLabel;
import org.aswing.JList;
import org.aswing.BorderLayout;
import org.aswing.JScrollPane;

public class FilePane extends JPanel{
	
	private var list:JList;
	
	public function FilePane(){
		super(new BorderLayout());
		list = new JList();
		list.setVisibleCellWidth(80);
		list.setSelectionMode(JList.SINGLE_SELECTION);
		append(new JScrollPane(list));
		setBorder(new TitledBorder(null, "Files"));
	}
	
	public function getList():JList{
		return list;
	}
}
}