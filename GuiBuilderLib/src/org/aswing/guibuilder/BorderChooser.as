package org.aswing.guibuilder{

import org.aswing.*;
import org.aswing.guibuilder.model.*;
import flash.events.Event;
import org.aswing.border.TitledBorder;
import org.aswing.event.InteractiveEvent;

public class BorderChooser{

	private var dialog:JFrame;
	private var borderList:JList;
	private var propertyPane:PropertyPane;
	private var okButton:JButton;
	private var cancelButton:JButton;
	private var handler:Function;
	
	public function BorderChooser(){
		dialog = new JFrame(null, "Border Chooser", true);
		dialog.getTitleBar().setMaximizeButton(null);
		dialog.getTitleBar().setIconifiedButton(null);
		var pane:Container = dialog.getContentPane();
		borderList = new JList();
		borderList.setSelectionMode(JList.SINGLE_SELECTION);
		borderList.setVisibleCellWidth(120);
		propertyPane = new PropertyPane();
		dialog.setSizeWH(400, 300);
		AsWingUtils.centerLocate(dialog);
		dialog.x += Math.random()*20-40;
		dialog.y += Math.random()*20-40;
		okButton = new JButton("OK");
		cancelButton = new JButton("Cancel");
		var scroll:JScrollPane = new JScrollPane(borderList);
		scroll.setBorder(new TitledBorder(null, "Border"));
		pane.append(scroll, BorderLayout.WEST);
		pane.append(propertyPane, BorderLayout.CENTER);
		var buttons:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 20));
		buttons.appendAll(okButton, cancelButton);
		pane.append(buttons, BorderLayout.SOUTH);
		
		borderList.addSelectionListener(__borderSelection);
		dialog.setDefaultButton(okButton);
		okButton.addActionListener(__ok);
		cancelButton.addActionListener(__cancel);
	}
	
	private function __ok(e:Event):void{
		dialog.dispose();
		var model:BorderModel = borderList.getSelectedValue();
		propertyPane.applyPropertiesEdited();
		handler(model);
	}
	
	private function __cancel(e:Event):void{
		dialog.dispose();
	}
	
	private function __borderSelection(e:InteractiveEvent):void{
		if(e == null || !e.isProgrammatic()){
			propertyPane.setModel(borderList.getSelectedValue());
		}
	}
	
	/**
	 * __handler(borderModel:BorderModel) null means canceled
	 */
	public function open(__handler:Function, curModel:BorderModel):void{
		reloadData(curModel);
		dialog.show();
		handler = __handler;
	}
	
	public function reloadData(curModel:BorderModel):void{
		var borDefs:Array = Definition.getIns().getBorders();
		var borders:Array = new Array();
		var selectedCur:Boolean = false;
		for each(var borDef:BorderDefinition in borDefs){
			var m:BorderModel = new BorderModel(borDef);
			if(curModel != null && curModel.getName() == m.getName()){
				m = curModel;
				selectedCur = true; 
			}
			borders.push(m);
		}
		borderList.setListData(borders);
		if(selectedCur){
			borderList.setSelectedValue(curModel);
		}else{
			borderList.setSelectedIndex(0);
		}
		__borderSelection(null);
	}	
	
}
}