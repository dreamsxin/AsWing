package org.aswing.guibuilder{

import org.aswing.JFrame;
import org.aswing.guibuilder.property.LabelInput;
import org.aswing.JButton;
import org.aswing.JTextField;
import org.aswing.ext.Form;
import org.aswing.JPanel;
import org.aswing.FlowLayout;
import flash.events.Event;
import org.aswing.JOptionPane;
import org.aswing.AsWingUtils;	

public class ClassNameChooser{
	
	private static var ins:ClassNameChooser;
	
	public static function getIns():ClassNameChooser{
		if(ins == null){
			new ClassNameChooser();
		}
		return ins;
	}
	
	private var dialog:JFrame;
	private var classInput:JTextField;
	private var pkgInput:JTextField;
	private var okButton:JButton;
	private var cancelButton:JButton;
	
	private var handler:Function;
	
	public function ClassNameChooser(){
		if(ins){
			throw new Error("Singtion error!");
		}
		ins = this;
		
		dialog = new JFrame(null, "Enter Full Class Name");
		dialog.getTitleBar().setMaximizeButton(null);
		dialog.getTitleBar().setIconifiedButton(null);
		classInput = new JTextField("MyPane", 12);
		pkgInput = new JTextField("test", 12);
		okButton = new JButton("OK");
		cancelButton = new JButton("Cancel");
		
		var form:Form = new Form();
		form.addRow(form.createRightLabel("Class Name"), classInput);
		form.addRow(form.createRightLabel("Package Name"), pkgInput);
		var bar:JPanel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10));
		bar.appendAll(okButton, cancelButton);
		form.append(bar);
		
		dialog.setContentPane(form);
		dialog.pack();
		AsWingUtils.centerLocate(dialog);
		dialog.setDefaultButton(okButton);
		okButton.addActionListener(__ok);
		cancelButton.addActionListener(__cancel);
	}
	
	private function __ok(e:Event):void{
		if(classInput.getText() != "" && pkgInput.getText() != ""){
			dialog.dispose();
			handler(classInput.getText(), pkgInput.getText());
		}else{
			JOptionPane.showMessageDialog("Tip", "Please complete the names.", null, dialog);
		}
	}
	
	private function __cancel(e:Event):void{
		dialog.dispose();
	}
	
	/**
	 * handler(className:String, pkgName:String);
	 */
	public function open(handler:Function):void{
		this.handler = handler;
		dialog.pack();
		dialog.show();
	}
	
	public function getClassInput():JTextField{
		return classInput;
	}
	
	public function getPkgInput():JTextField{
		return pkgInput;
	}
	
	public function getOkButton():JButton{
		return okButton;
	}
	
	public function getCancelButton():JButton{
		return cancelButton;
	}
	
}
}