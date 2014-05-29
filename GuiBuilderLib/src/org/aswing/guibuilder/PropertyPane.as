package org.aswing.guibuilder{

import org.aswing.BorderLayout;
import org.aswing.JLabel;
import org.aswing.JPanel;
import org.aswing.JScrollPane;
import org.aswing.JSeparator;
import org.aswing.JViewport;
import org.aswing.SoftBox;
import org.aswing.border.TitledBorder;
import org.aswing.ext.Folder;
import org.aswing.ext.Form;
import org.aswing.ext.FormRow;
import org.aswing.guibuilder.model.Model;
import org.aswing.guibuilder.model.ProDefinition;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.util.HashMap;
import org.aswing.util.HashSet;
import org.aswing.util.ArrayList;

public class PropertyPane extends JPanel{
	
	private var box:SoftBox;
	private var editorsMap:HashMap;
	private var editorRowMap:HashMap;
	private var curEditors:Array;
	private var commonFolder:Folder;
	private var featureFolder:Folder;
	private var layoutFolder:Folder;
	private var commonForm:Form;
	private var featureForm:Form;
	private var layoutForm:Form;
	private var nocateForm:Form;
	
	private var commonOrders:ArrayList;
	private var featureOrders:ArrayList;
	private var layoutOrders:ArrayList;
	private var nocateOrders:ArrayList;
	
	private var useCategory:Boolean;
	
	public function PropertyPane(useCategory:Boolean=false){
		super();
		this.useCategory = useCategory;
		setBorder(new TitledBorder(null, "Properties"));
		setLayout(new BorderLayout());
		box = SoftBox.createVerticalBox(2);
		var vp:JViewport = new JViewport(box);
		vp.setVerticalAlignment(JViewport.TOP);
		vp.setHorizontalAlignment(JViewport.LEFT);
		append(new JScrollPane(vp));
		
		nocateOrders = new ArrayList();
		
		if(useCategory){
			commonOrders = new ArrayList();
			featureOrders = new ArrayList();
			layoutOrders = new ArrayList();
			
			commonFolder = new Folder("Common");
			commonFolder.setExpanded(true);
			featureFolder = new Folder("Feature");
			featureFolder.setExpanded(true);
			layoutFolder = new Folder("Layout");
			layoutFolder.setExpanded(true);
			commonForm = new Form();
			featureForm = new Form();
			layoutForm = new Form();
		
			commonFolder.setContentPane(commonForm);
			commonFolder.setVisible(false);
			
			featureFolder.setContentPane(featureForm);
			featureFolder.setVisible(false);
			
			layoutFolder.setContentPane(layoutForm);
			layoutFolder.setVisible(false);
		}
		
		nocateForm = new Form();
		
		if(useCategory){
			box.appendAll(
				commonFolder, 
				featureFolder, 
				layoutFolder, 
				new JSeparator(JSeparator.HORIZONTAL), 
				nocateForm);
		}else{
			box.append(nocateForm);
		}
		
		editorsMap = new HashMap();
		editorRowMap = new HashMap();
		curEditors = [];
	}
	
	public function setModel(model:Model):void{
		curEditors = [];
		var curEditorsSet:HashSet = new HashSet();
		if(model != null){
			var pros:Array = model.getProperties();
			for each(var pro:ProModel in pros){
				var editor:PropertyEditor = getCreateEditor(pro.getDef());
				editor.setEditorParam(pro.getDef().getEditorParam());
				editor.getDisplay().setToolTipText(pro.getDef().getTooltip());
				editor.bindTo(pro);
				curEditorsSet.add(editor);
			}
		}
		var editors:Array = editorsMap.values();
		for each(var ed:PropertyEditor in editors){
			setEditorVisible(ed, curEditorsSet.contains(ed));
		}
		box.revalidate();
	}
	
	private function setEditorVisible(editor:PropertyEditor, v:Boolean):void{
		var row:FormRow = editorRowMap.getValue(editor);
		if(row){
			row.setVisible(v);
			if(v){
				row.revalidate();
				curEditors.push(editor);
			}
		}
	}
	
	private function addEditor(label:String, editor:PropertyEditor, def:ProDefinition):void{
		var jlabel:JLabel = nocateForm.createLeftLabel(label);
		jlabel.setFont(jlabel.getFont().changeBold(true));
		
		var row:FormRow = new FormRow(jlabel, editor.getDisplay());
		editorRowMap.put(editor, row);
		if(!useCategory){
			insertEditor(nocateForm, nocateOrders, def.getOrder(), row);
		} else if(def.getCategory() == "Common"){
			commonFolder.setVisible(true);
			insertEditor(commonForm, commonOrders, def.getOrder(), row);
		}else if(def.getCategory() == "Feature"){
			featureFolder.setVisible(true);
			insertEditor(featureForm, featureOrders, def.getOrder(), row);
		}else if(def.getCategory() == "Layout"){
			layoutFolder.setVisible(true);
			insertEditor(layoutForm, layoutOrders, def.getOrder(), row);
		}else{
			insertEditor(nocateForm, nocateOrders, def.getOrder(), row);
		}
	}
	
	private function insertEditor(form:Form, orders:ArrayList, order:int, row:FormRow):void{
		var n:int = orders.size();
		for(var i:int=0; i<n; i++){
			if(orders.get(i) > order){
				orders.append(order, i);
				form.insert(i, row);
				return;
			}
		}
		orders.append(order);
		form.append(row);
	}
	
	public function applyPropertiesEdited():void{
		for each(var editor:PropertyEditor in curEditors){
			editor.applyProperty();
		}
	}
	
	public function getCreateEditor(def:ProDefinition):PropertyEditor{
		if(editorsMap.containsKey(def.getName())){
			return editorsMap.getValue(def.getName());
		}
		var editor:PropertyEditor = def.createPropertyEditor();
		editorsMap.put(def.getName(), editor);
		addEditor(def.getLabel(), editor, def);
		return editor;
	}
}
}