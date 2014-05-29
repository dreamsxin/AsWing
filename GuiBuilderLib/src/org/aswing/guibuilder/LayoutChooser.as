package org.aswing.guibuilder{
	
import org.aswing.*;
import org.aswing.guibuilder.model.Definition;
import org.aswing.guibuilder.model.LayoutDefinition;
import org.aswing.guibuilder.model.LayoutModel;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.border.TitledBorder;
import org.aswing.border.BevelBorder;
import org.aswing.event.InteractiveEvent;
	

public class LayoutChooser{
	
	private var dialog:JFrame;
	private var layoutList:JList;
	private var propertyPane:PropertyPane;
	private var okButton:JButton;
	private var cancelButton:JButton;
	private var handler:Function;
	
	public function LayoutChooser(){
		dialog = new JFrame(null, "Layout Chooser", true);
		dialog.getTitleBar().setMaximizeButton(null);
		dialog.getTitleBar().setIconifiedButton(null);
		
		dialog.setSizeWH(400, 300);
		AsWingUtils.centerLocate(dialog);
		
		var pane:Container = dialog.getContentPane();
		layoutList = new JList();
		layoutList.setSelectionMode(JList.SINGLE_SELECTION);
		layoutList.setVisibleCellWidth(120);
		
		propertyPane = new PropertyPane();
		pane.append(propertyPane, BorderLayout.CENTER);
		
		var scroll:JScrollPane = new JScrollPane(layoutList);
		scroll.setBorder( new TitledBorder(null, "Layout") );
		pane.append(scroll, BorderLayout.WEST);
		
		okButton = new JButton("OK");
		cancelButton = new JButton("Cancel");
		var buttons:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 20));
		buttons.appendAll(okButton, cancelButton);
		pane.append(buttons, BorderLayout.SOUTH);
		
		layoutList.addSelectionListener(__layoutSelection);
		dialog.setDefaultButton(okButton);
		okButton.addActionListener(__ok);
		cancelButton.addActionListener(__cancel);
	}
	
	private function __ok(e:Event):void{
		dialog.dispose();
		var model:LayoutModel = layoutList.getSelectedValue();
		propertyPane.applyPropertiesEdited();
		handler(model);
	}
	
	private function __cancel(e:Event):void{
		dialog.dispose();
	}
	
	private function __layoutSelection(e:InteractiveEvent):void{
		if(e == null || !e.isProgrammatic()){
			propertyPane.setModel(layoutList.getSelectedValue());
		}
	}
	
	/**
	 * __handler(layoutModel:LayoutModel) null means canceled
	 */
	public function open(__handler:Function, curModel:LayoutModel):void{
		reloadData(curModel);
		dialog.show();
		handler = __handler;
	}
	
	public function reloadData(curModel:LayoutModel):void{
		var layDefs:Array = Definition.getIns().getLayouts();
		var layouts:Array = new Array();
		var selectedCur:Boolean = false;
		for each(var layDef:LayoutDefinition in layDefs){
			var m:LayoutModel = new LayoutModel(layDef);
			if(curModel != null && curModel.getName() == m.getName()){
				m = curModel;
				selectedCur = true; 
			}
			layouts.push(m);
		}
		layouts.sort();
		layoutList.setListData(layouts);
		if(selectedCur){
			layoutList.setSelectedValue(curModel);
		}else{
			layoutList.setSelectedIndex(0);
		}
		__layoutSelection(null);
	}
}
}