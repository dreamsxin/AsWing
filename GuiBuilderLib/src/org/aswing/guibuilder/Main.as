package org.aswing.guibuilder{

import flash.display.*;
import flash.events.*;
import flash.geom.Point;
import flash.net.*;

import org.aswing.ASColor;
import org.aswing.AsWingManager;
import org.aswing.AssetPane;
import org.aswing.BorderLayout;
import org.aswing.Component;
import org.aswing.Insets;
import org.aswing.JMenu;
import org.aswing.JMenuBar;
import org.aswing.JMenuItem;
import org.aswing.JOptionPane;
import org.aswing.JPanel;
import org.aswing.JSeparator;
import org.aswing.JSplitPane;
import org.aswing.JWindow;
import org.aswing.LoadIcon;
import org.aswing.SoftBox;
import org.aswing.SolidBackground;
import org.aswing.UIManager;
import org.aswing.VectorListModel;
import org.aswing.border.BevelBorder;
import org.aswing.border.EmptyBorder;
import org.aswing.event.*;
import org.aswing.geom.IntRectangle;
import org.aswing.guibuilder.code.CodeGenerator;
import org.aswing.guibuilder.code.HaxeCodeGenerator;
import org.aswing.guibuilder.model.ComDefinition;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.Definition;
import org.aswing.guibuilder.model.FileModel;
import org.aswing.guibuilder.util.TextLoader;
import org.aswing.plaf.basic.background.FrameBackground;
import org.aswing.tree.DefaultMutableTreeNode;
import org.aswing.tree.DefaultTreeModel;
import org.aswing.tree.TreeModel;
import org.aswing.tree.TreePath;


public class Main extends JWindow{
	
	private var preview:Sprite;
	private var selContainer:Sprite; //trigger preview components selection
	private var selTrigger:Sprite; //trigger preview components selection
	private var rangeEditor:RangeEditor;
	private var previewRangeShape:Shape;
	private var newMenu:JMenu;
	protected var toolBarPane:ToolBarPane;
	private var filePane:FilePane;
	private var hiberarchyPane:HiberarchyPane;
	private var propertyPane:PropertyPane;
	private var componentMenu:ComponentMenu;
	
	private var emptyTreeModel:TreeModel;
	
	protected var files:VectorListModel;
	protected var curCom:ComModel;
	protected var curFile:FileModel;
	protected var workspacePath:String;
	protected var rootPath:String;
	
	public function Main(owner:DisplayObjectContainer){
		super(owner, false);
		AsWingManager.setRoot(this);
		setBackgroundDecorator(new SolidBackground(new ASColor(0xF1F3F1)));
		emptyTreeModel = new DefaultTreeModel(new DefaultMutableTreeNode("Empty"));
		files = new VectorListModel();
		
		preview = new Sprite();
		preview.mouseEnabled = false;
		previewRangeShape = new Shape();
		preview.addChild(previewRangeShape);
		var previewPane:AssetPane = new AssetPane(preview);
		previewPane.setBackground(ASColor.GRAY.brighter());
		previewPane.setBorder(new BevelBorder(null, BevelBorder.LOWERED));
		previewPane.setFocusable(true);
		
		selContainer = new Sprite();
		selTrigger = new Sprite();
		selContainer.addChild(selTrigger);
		selTrigger.addEventListener(MouseEvent.MOUSE_DOWN, __selTriggerDown);
		rangeEditor = new RangeEditor();
		previewPane.setForegroundDecorator(new SelTriggerGround(selContainer, selTrigger));
		rangeEditor.addTo(selContainer);
		
		toolBarPane = new ToolBarPane();
		toolBarPane.setOpaque(false);
		toolBarPane.getSaveButton().setEnabled(false);
		var menuBar:JMenuBar = new JMenuBar();
		newMenu = new JMenu("New");
		menuBar.addMenu(newMenu);
		filePane = new FilePane();
		hiberarchyPane = new HiberarchyPane();
		propertyPane = new PropertyPane(true);
		componentMenu = new ComponentMenu();
		
		var pane:JPanel = new JPanel(new BorderLayout());
		var topBar:SoftBox = SoftBox.createHorizontalBox(2);
		topBar.setOpaque(true);
		topBar.setBackground(new ASColor(0xA5CE1C));
		topBar.setBorder(new EmptyBorder(null, new Insets(2, 4, 0, 0)));
		topBar.appendAll(menuBar, new JSeparator(JSeparator.VERTICAL), toolBarPane);
		pane.append(topBar, BorderLayout.NORTH);
		
		var centerCenter:JSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, false, previewPane, propertyPane);
		centerCenter.setResizeWeight(0.68);
		
		var left:JSplitPane = new JSplitPane(JSplitPane.VERTICAL_SPLIT, false, filePane, hiberarchyPane);
		left.setResizeWeight(0.3);
		
		var center:JSplitPane = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, false, left, centerCenter);
		center.setResizeWeight(0.21);
		pane.append(center, BorderLayout.CENTER);
		
		setContentPane(pane);
		
		initModels();
	}
	
	private function initModels():void{
		new TextLoader("def.xml", __defLoaded).execute();
	}
	
	private function __defLoaded(text:String):void{
		if(text != null){
			filePane.getList().setModel(files);
			Definition.getIns().init(new XML(text));
			
			var components:Array = Definition.getIns().getComponents();
			componentMenu.setComponents(components);
			
			for(var i:int=0; i<components.length; i++){
				var cmp:ComDefinition = components[i];
				if(cmp.isContainer()){
					var menu:JMenuItem = newMenu.addMenuItem(cmp.getName());
					menu.addActionListener(__newPane);
					menu.putClientProperty("comDef", cmp);
				}
			}
			
			initHandlers();
		}else{
			JOptionPane.showMessageDialog("Error", "Can't find definition file!", null, this);
		}
	}
	
	private var curCreateComDef:ComDefinition;
	private function __newPane(e:Event):void{
		var menu:JMenuItem = e.currentTarget as JMenuItem;
		curCreateComDef = menu.getClientProperty("comDef");
		ClassNameChooser.getIns().open(__newComSelected);
	}
	
	protected var cacheClassName:String;
	protected var cachePkgName:String;
	private function __newComSelected(className:String, pkgName:String):void{
		if(isFileExists(className, pkgName)){
			JOptionPane.showMessageDialog("Error", "The name is already exists!", null, this);
			return;
		}
		if(!checkIsExists(className, pkgName)){
			createNewFile(className, pkgName);
		}
	}
	
	protected function checkIsExists(className:String, pkgName:String):Boolean{
		return false;
	}
	
	private function createNewFile(className:String, pkgName:String):void{
		var f:FileModel = new FileModel(new ComModel(curCreateComDef), className, pkgName);
		files.append(f, 0);
		setCurrentFile(files.first());
		f.setChangeHandler(__fileChanged);
	}
	
	protected function __fileChanged(f:FileModel):void{
		files.valueChanged(f);
	}
	
	protected function __override(result:int):void{
		if(result == JOptionPane.YES){
			createNewFile(cacheClassName, cachePkgName);
		}
	}
	
	protected function initHandlers():void{
		toolBarPane.getSaveButton().addActionListener(__save);
		toolBarPane.getOpenButton().addActionListener(__open);
		toolBarPane.getCloseButton().addActionListener(__close);
		toolBarPane.getGenerateCodeButton().addActionListener(__generateCode);
		toolBarPane.getGenerateComCodeButton().addActionListener(__generateSelection);
		toolBarPane.getRevalidateButton().addActionListener(__revalidateSelection);
		filePane.getList().addEventListener(SelectionEvent.LIST_SELECTION_CHANGED, __fileSelection);
		hiberarchyPane.getAddChildButton().addActionListener(__addChildCom);
		hiberarchyPane.getAddBelowButton().addActionListener(__addChildComBelow);
		hiberarchyPane.getRemoveButton().addActionListener(__removeChildCom);
		hiberarchyPane.getUpButton().addActionListener(__upChildCom);
		hiberarchyPane.getDownButton().addActionListener(__downChildCom);
		hiberarchyPane.getLeftButton().addActionListener(__leftChildCom);
		hiberarchyPane.getRightButton().addActionListener(__rightChildCom);
		componentMenu.setItemSelectionHandler(__addChildComSelected);
		
		hiberarchyPane.getTree().setModel(emptyTreeModel);
		toolBarPane.getCloseButton().setEnabled(false);
		toolBarPane.getGenerateCodeButton().setEnabled(false);
		toolBarPane.getGenerateComCodeButton().setEnabled(false);
		toolBarPane.getRevalidateButton().setEnabled(false);
		toolBarPane.getAboutButton().addActionListener(__showAbout);
		toolBarPane.getRangeCheck().addActionListener(__fileRangeChanged);
		toolBarPane.getPreviewCheck().addActionListener(__previewChanged);
		
		toolBarPane.getLAFsCombo().setModel(LookAndFeelManager.getIns().getLookAndFeels());
		toolBarPane.getLAFsCombo().addActionListener(__lafSelectionChanged);
		loadSetting();
	}
	
	protected function getAboutWords():String{
		return "Version:1.0\nDate:2007-10-7\nCreated by aswing.org";
	}
	
	private function __showAbout(e:Event):void{
		var op:JOptionPane = JOptionPane.showMessageDialog(
			"About AsWing GuiBuilder", 
			getAboutWords(), 
			__about, 
			this, true, new LoadIcon("icons/app_128.png", 128, 128), 
			JOptionPane.OK|JOptionPane.CANCEL);
		op.getOkButton().setText("Open AsWing Home");
		op.getCancelButton().setText("Close");
		op.getOkButton().revalidate();
	}
	
	private function __about(result:int):void{
		if(result == JOptionPane.OK){
			navigateToURL(new URLRequest("http://www.aswing.org"), "_blank");
		}
	}
	
	private function __lafSelectionChanged(e:Event):void{
		trace("__lafSelectionChanged " + toolBarPane.getLAFsCombo().getSelectedItem());
		if(toolBarPane.getLAFsCombo().getSelectedItem() != null){
			LookAndFeelManager.getIns().setLookAndFeel(toolBarPane.getLAFsCombo().getSelectedItem());
			saveSetting();
		}
	}
	
	protected function loadSetting():void{
		
	}
	
	protected function saveSetting():void{
		
	}
	
	private function __close(e:Event):void{
		if(curFile != null){
			if(!curFile.isSaved()){
				JOptionPane.showMessageDialog(
					"Tip", 
					"Do you need to save it before close?", 
					__closeAnswered, this, true, null, 
					JOptionPane.YES|JOptionPane.NO|JOptionPane.CANCEL); 
			}else{
				__closeAnswered(JOptionPane.NO);
			}
		}
	}
	
	private function __closeAnswered(result:int):void{
		if(result == JOptionPane.YES){
			__save(null);
			files.remove(curFile);
			setCurrentFile(null);
		}else if(result == JOptionPane.NO){
			files.remove(curFile);
			setCurrentFile(null);
		}
	}
	
	private function __revalidateSelection(e:Event):void{
		if(curCom != null){
			curCom.getDisplay().invalidatePreferSizeCaches();
			curCom.getDisplay().revalidate();
		}
	}
	
	private function __generateCode(e:Event):void{
		if(curFile != null){
			var generator:CodeGenerator = new CodeGenerator(curFile);
			var code:String = generator.generateCode();
			var hxGe:HaxeCodeGenerator = new HaxeCodeGenerator(curFile);
			var hxCode:String = hxGe.generateCode();
			CodeWindow.getIns().showCode(
				curFile.getPackageName() + "." + curFile.getName(), 
				code, hxCode);
		}
	}
	
	private function __generateSelection(e:Event):void{
		if(curCom != null){
			var fm:FileModel = new FileModel(curCom, curCom.getID(), "yourpackage", true);
			var generator:CodeGenerator = new CodeGenerator(fm);
			var code:String = generator.generateCode();
			var hxGe:HaxeCodeGenerator = new HaxeCodeGenerator(fm);
			var hxCode:String = hxGe.generateCode();
			CodeWindow.getIns().showCode(
				fm.getPackageName() + "." + fm.getName(), 
				code, hxCode);
		}
	}
	
	protected function getXMLSavePath(className:String, pkgName:String):String{
		var pkg:String = pkgName.split(".").join("/");
		return workspacePath + pkg + "/" + className + ".xml";
	}
	
	private function __save(e:Event):void{
		if(curFile != null){
			save(curFile);
		}
	}
	
	protected function save(file:FileModel):void{
	}
	
	protected function open():void{
	}
		
	private function __open(e:Event):void{
		open();
	}
	
	private function __addChildComSelected(def:ComDefinition):void{
		if(curCom){
			var comM:ComModel = new ComModel(def);
			if(isAddBelow || !curCom.isContainer()){
				var index:int = curCom.getParent().getChildIndex(curCom) + 1;
				curFile.addComponent(curCom.getParent(), comM, index);
			}else{
				curFile.addComponent(curCom, comM);
				hiberarchyPane.getTree().expandPath(new TreePath(curFile.getPath(curCom)));
			}
			hiberarchyPane.getTree().setSelectionPath(new TreePath(curFile.getPath(comM)), false);
		}
	}
	
	private var isAddBelow:Boolean = false;
	private function __addChildCom(e:Event):void{
		isAddBelow = false;
		componentMenu.show(hiberarchyPane.getAddChildButton(), 0, 0);
	}
	
	private function __addChildComBelow(e:Event):void{
		isAddBelow = true;
		componentMenu.show(hiberarchyPane.getAddBelowButton(), 0, 0);
	}
	
	private function __removeChildCom(e:Event):void{		
		if(curCom){
			if(curCom == curFile.getRoot()){
				JOptionPane.showMessageDialog("Tip", "Can't delete root component!", null, this);
			}else{
				var selRow:int = hiberarchyPane.getTree().getSelectionRow();
				var parent:ComModel = curCom.getParent();
				
				// Remove selection rectangle if it is currently bound to the component that is about to be deleted
				if( rangeEditor.getBoundComp() == curCom.getDisplay() ) {
					rangeEditor.bindTo( null );
				}
				
				curFile.removeComponent(curCom);
				if(selRow > 0){
					hiberarchyPane.getTree().setSelectionRow(selRow-1, false);
				}
			}
		}
	}
	private function __upChildCom(e:Event):void{
		var mod:ComModel = curCom;
		var par:ComModel = curCom.getParent();
		var index:int = par.getChildIndex(mod);
		var path:TreePath = hiberarchyPane.getTree().getSelectionPath();
		curFile.removeComponent(mod);
		curFile.addComponent(par, mod, index-1);
		hiberarchyPane.getTree().setSelectionPath(path, false);
	}
	private function __downChildCom(e:Event):void{
		var mod:ComModel = curCom;
		var par:ComModel = curCom.getParent();
		var index:int = par.getChildIndex(mod);
		var path:TreePath = hiberarchyPane.getTree().getSelectionPath();
		curFile.removeComponent(mod);
		index++;
		if(index > par.getChildCount()){
			index=0;
		}
		curFile.addComponent(par, mod, index);
		hiberarchyPane.getTree().setSelectionPath(path, false);
	}
	private function __leftChildCom(e:Event):void{
		var mod:ComModel = curCom;
		var leftPar:ComModel = getLeftContainer(mod);
		if(leftPar != null){
			curFile.removeComponent(mod);
			curFile.addComponent(leftPar, mod);
			hiberarchyPane.getTree().setSelectionPath(new TreePath(curFile.getPath(leftPar)), false);
		}
	}
	private function __rightChildCom(e:Event):void{
		var mod:ComModel = curCom;
		var rightPar:ComModel = this.getRightContainer(mod);
		if(rightPar != null){
			curFile.removeComponent(mod);
			curFile.addComponent(rightPar, mod);
			hiberarchyPane.getTree().expandPath(new TreePath(curFile.getPath(rightPar.getParent())));
			hiberarchyPane.getTree().setSelectionPath(new TreePath(curFile.getPath(rightPar)), false);
		}
	}
	
	private function __fileSelection(e:SelectionEvent):void{
		setCurrentFile(filePane.getList().getSelectedValue());
	}
	
	private function __comSelection(e:TreeSelectionEvent):void{
		if(e.isProgrammatic()){
			return;
		}
		if(hiberarchyPane.getTree().getSelectionPath() != null){
			setCurrentCom(hiberarchyPane.getTree().getSelectionPath().getLastPathComponent());
		}else{
			setCurrentCom(null);
		}
	}
		
	protected function isFileExists(name:String, pkg:String):Boolean{
		for(var i:int=0; i<files.size(); i++){
			var f:FileModel = files.get(i);
			if(f.getName() == name && f.getPackageName() == pkg){
				return true;
			}
		}
		return false;
	}
	
	private function createPanelModel():ComModel{
		return new ComModel(Definition.getIns().getComDefinition("JPanel"));
	}
	
	protected function setCurrentFile(file:FileModel):void{
		toolBarPane.getCloseButton().setEnabled(file != null);
		toolBarPane.getSaveButton().setEnabled(file != null);
		toolBarPane.getGenerateCodeButton().setEnabled(file != null);
		if(curFile != file){
			var oldFile:FileModel = curFile;
			curFile = file;
			filePane.getList().setSelectedValue(file);
			var rootCom:Component;
			if(oldFile != null){
				preview.removeChild(oldFile.getDisplay());
				rootCom = oldFile.getRootComponent().getDisplay();
				rootCom.removeEventListener(MovedEvent.MOVED, __fileRangeChanged);
				rootCom.removeEventListener(ResizedEvent.RESIZED, __fileRangeChanged);
			}
			if(file != null){
				hiberarchyPane.getTree().setModel(file);
				preview.addChild(file.getDisplay());
				file.revalidate();
				rootCom = file.getRootComponent().getDisplay();
				rootCom.addEventListener(MovedEvent.MOVED, __fileRangeChanged);
				rootCom.addEventListener(ResizedEvent.RESIZED, __fileRangeChanged);
			}else{
				hiberarchyPane.getTree().setModel(emptyTreeModel);
			}
			setCurrentCom(null);
			if(file != null){
				hiberarchyPane.getTree().addEventListener(TreeSelectionEvent.TREE_SELECTION_CHANGED, __comSelection);
				hiberarchyPane.getTree().setSelectionRow(0, false);
			}else{
				hiberarchyPane.getTree().removeEventListener(TreeSelectionEvent.TREE_SELECTION_CHANGED, __comSelection);
			}
			__fileRangeChanged();
		}
	}
	
	protected function setCurrentCom(comModel:ComModel):void{
		if(comModel == null){
			hiberarchyPane.getTree().clearSelection();
			rangeEditor.bindTo(null);
		}else if(curFile){
			var path:TreePath = new TreePath(curFile.getPath(comModel));
			hiberarchyPane.getTree().setSelectionPath(path);
			hiberarchyPane.getTree().makePathVisible(path);
			hiberarchyPane.getTree().scrollPathToVisible(path);
		}
		this.curCom = comModel;
		propertyPane.setModel(comModel);
		hiberarchyPane.setOperatable(comModel != null);
		toolBarPane.getRevalidateButton().setEnabled(comModel != null);
		toolBarPane.getGenerateComCodeButton().setEnabled(comModel != null);
		if(comModel != null){
			rangeEditor.bindTo(comModel.getDisplay());
			
			if(comModel == curFile.getRoot()){
				hiberarchyPane.setOperatable(false);
				hiberarchyPane.getAddChildButton().setEnabled(true);
			}
			
			hiberarchyPane.getAddChildButton().setEnabled(curCom.isContainer());
			
			if(getLeftContainer(curCom) != null){
				hiberarchyPane.getLeftButton().setEnabled(true);
			}else{
				hiberarchyPane.getLeftButton().setEnabled(false);
			}
			
			if(getRightContainer(curCom) != null){
				hiberarchyPane.getRightButton().setEnabled(true);
			}else{
				hiberarchyPane.getRightButton().setEnabled(false);
			}
			
			hiberarchyPane.revalidate();
		}
	}
	
	private function getLeftContainer(c:ComModel):ComModel{
		var parent:ComModel = curCom.getParent();
		if(parent != null){
			return parent.getParent();
		}
		return null;
	}
	
	private function getRightContainer(c:ComModel):ComModel{
		var parent:ComModel = c.getParent();
		if(parent != null){
			var index:int = parent.getChildIndex(c);
			var n:int = parent.getChildCount();
			for(var i:int=1; i<n; i++){
				index--;
				if(index < 0){
					index = n-1;
				}
				if(parent.getChild(index).isContainer()){
					return parent.getChild(index);
				}
			}
		}
		return null;
	}
	
	private function __fileRangeChanged(e:Event=null):void{
		previewRangeShape.graphics.clear();
		if(curFile != null && toolBarPane.getRangeCheck().isSelected()){
			var color:ASColor = UIManager.getColor("window");
			if(color == null){
				color = new ASColor(0xCCCCCC);
			}
			var rect:IntRectangle = curFile.getRootComponent().getDisplay().getComBounds();
			previewRangeShape.graphics.beginFill(color.getRGB());
			previewRangeShape.graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			previewRangeShape.graphics.endFill();
		}
	}
	
	private function __previewChanged(e:Event=null):void{
		if(toolBarPane.getPreviewCheck().isSelected()){
			selTrigger.visible = false;
		}else{
			selTrigger.visible = true;
		}
	}
	
	//______________________
	
	private function __selTriggerDown(e:MouseEvent):void{
		var unders:Array = preview.stage.getObjectsUnderPoint(new Point(e.stageX, e.stageY));
		var n:int = unders.length;
		for(var i:int=n-1; i>=0; i--){
			var cc:Component = unders[i] as Component;
			if(cc){
				var mm:ComModel  = cc.getClientProperty(ComModel.DISPLAY_MODEL_KEY);
				if(mm){
					//sel it next frame to make the edited property input box focus lost and validate the value
					AsWingManager.callNextFrame(function():void{
						setCurrentCom(mm);
					});
					return;
				}
			}
		}
		setCurrentCom(null);
	}
}
}

import org.aswing.*;
import flash.display.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
	

class SelTriggerGround implements GroundDecorator{
	
	private var trigger:Sprite;
	private var container:Sprite;
	
	public function SelTriggerGround(con:Sprite, t:Sprite){
		container = con;
		trigger = t;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, b:IntRectangle):void{
		trigger.graphics.clear();
		trigger.graphics.beginFill(0, 0);
		trigger.graphics.drawRect(b.x, b.y, b.width, b.height);
		trigger.graphics.endFill();
	}
	
	public function getDisplay(c:Component):DisplayObject{
		return container;
	}
}