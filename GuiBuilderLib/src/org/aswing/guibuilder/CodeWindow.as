package org.aswing.guibuilder{
	
import flash.events.Event;
import flash.system.System;

import org.aswing.AsWingUtils;
import org.aswing.BorderLayout;
import org.aswing.FlowLayout;
import org.aswing.JButton;
import org.aswing.JFrame;
import org.aswing.JPanel;
import org.aswing.JScrollPane;
import org.aswing.JTabbedPane;
import org.aswing.JTextArea;
	

public class CodeWindow{
	
	private static var ins:CodeWindow;
	public static function getIns():CodeWindow{
		if(ins == null){
			new CodeWindow();
		}
		return ins;
	}
	
	private var dialog:JFrame;
	private var pane:JTabbedPane;
	private var copyButton:JButton;
	private var closeButton:JButton;
	private var asText:JTextArea;
	private var hxText:JTextArea;
	
	public function CodeWindow(){
		if(ins){
			throw new Error("Sington Error!");
		}
		ins = this;
		dialog = new JFrame(null, "CodePreview", false);
		pane = new JTabbedPane();
		asText = new JTextArea();
		hxText = new JTextArea();
		pane.appendTab(new JScrollPane(asText), "ActionScript");
		pane.appendTab(new JScrollPane(hxText), "haXe");
		
		copyButton = new JButton("Copy Code");
		closeButton = new JButton("Close");
		var bp:JPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT, 10));
		bp.appendAll(copyButton, closeButton);
		dialog.getContentPane().append(pane, BorderLayout.CENTER);
		dialog.getContentPane().append(bp, BorderLayout.SOUTH);
		
		copyButton.addActionListener(__copy);
		closeButton.addActionListener(__close);
		
		dialog.setSizeWH(600, 400);
		AsWingUtils.centerLocate(dialog);
	}
	
	private function __copy(e:Event):void{
		var str:String;
		if(pane.getSelectedIndex() == 0){
			str = asText.getText();
		}else{
			str = hxText.getText();
		}
		System.setClipboard(str);
	}
	
	private function __close(e:Event):void{
		dialog.dispose();
	}
	
	public function showCode(title:String, asCode:String, hxCode:String):void{
		dialog.show();
		dialog.setTitle(title);
		asText.setText(asCode);
		hxText.setText(hxCode);
	}
}
}