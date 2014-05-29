package org.aswing.guibuilder.code{
	
import org.aswing.guibuilder.model.FileModel;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.ProModel;	

public class CodeGenerator{
	
	private static const TAB:String = "\t";
	private static const NEWLINE:String = "\n";
	
	public static var border_id_counter:int = 0;
	public static var layout_id_counter:int = 0;
	
	private var file:FileModel;
	private var codeString:String;
	private var indent:int;
	private var allMemberComs:Array;
	
	public function CodeGenerator(file:FileModel){
		this.file = file;
		indent = 0;
	}
	
	
	/**
	 * Generates AS3 class code for this ui file.
	 */
	public function generateCode():String{
		border_id_counter = 0;
		layout_id_counter = 0;
		codeString = "";
		allMemberComs = new Array();
		addPackage();
		return codeString;
	}
	
	private function addPackage():void{
		line("package " + file.getPackageName()+"{");
		line();
		addImports();
		line();
		addClass();
		line("}");
	}
	
	private function addImports():void{
		line("import org.aswing.*;");
		line("import org.aswing.border.*;");
		line("import org.aswing.geom.*;");
		line("import org.aswing.colorchooser.*;");
		line("import org.aswing.ext.*;");
	}
	
	private function addClass():void{
		line("/**");
		line(" * " + file.getName());
		line(" */");
		lineRise("public class " + file.getName() + " extends " + file.getRootComponent().getDefinition().getShortClassName()+"{");
		line();
		line("//members define");
		addComponentMembers();
		line();
		line("/**");
		line(" * " + file.getName() + " Constructor");
		line(" */");
		addConstruction();
		line();
		line("//_________getters_________");
		line();
		addGetters();
		line();
		lineDrop("}");
	}
	
	private function addConstruction():void{
		lineRise("public function " + file.getName() + "(){");
		
		line("//component creation");
		addComponentsCreation();
		line("//component layoution");
		addComponentsLayoution();
		
		lineDrop("}");
	}
	
	private function addComponentMembers():void{
		addMembersOfChildren(file.getRootComponent());
	}
	
	private function addComponentsCreation():void{
		var root:ComModel = file.getRootComponent();
		addComponentPropertySetting("", root);
		line();
		for each(var c:ComModel in allMemberComs){
			addComponentCreation(c);
			line();
		}
	}
	
	private function addComponentsLayoution():void{
		addComponentChildrenAdding("", file.getRootComponent());
		for each(var c:ComModel in allMemberComs){
			addComponentChildrenAdding(c.getID(), c);
		}
	}
	
	private function addComponentChildrenAdding(id:String, c:ComModel):void{
		var appendStr:String = (id == "" ? "append(" : (id+".append("));
		var n:int = c.getChildCount();
		if(n > 0){
			var id:String = c.getID();
			for(var i:int=0; i<n; i++){
				var ch:ComModel = c.getChild(i);
				line(appendStr + ch.getID() + ");");
			}
			line();
		}
	}
	
	private function addComponentCreation(c:ComModel):void{
		line(c.getID() + " = new " + c.getDefinition().getShortClassName() + "();");
		addComponentPropertySetting(c.getID(), c);
	}
	
	private function addComponentPropertySetting(id:String, c:ComModel):void{
		var pros:Array = c.getProperties();
		var setStr:String = (id == "" ? "set" : id+".set");
		for each(var pro:ProModel in pros){
			var simple:String = pro.isSimpleOneLine();
			if(simple != null){
				line(setStr + pro.getName() + "(" + simple + ");");
			}else{
				var proCodeLines:Array = pro.getCodeLines();
				if(proCodeLines != null){
					var n:int = proCodeLines.length - 1;
					for(var i:int=0; i<n; i++){
						line(proCodeLines[i]);
					}
					line(setStr + pro.getName() + "(" + proCodeLines[n] + ");");
				}
			}
		}
	}
	
	private function addMembersOfChildren(parent:ComModel):void{
		var n:int = parent.getChildCount();
		for(var i:int=0; i<n; i++){
			var c:ComModel = parent.getChild(i);
			line(c.getAttributeScope() + " var " + c.getID() + ":" + c.getDefinition().getShortClassName() + ";");
			allMemberComs.push(c);
			addMembersOfChildren(c);
		}
	}
	
	private function addGetters():void{
		for each(var c:ComModel in allMemberComs){
			addGetter(c);
			line();
		}
	}
	
	private function addGetter(c:ComModel):void{
		if(c.getGetterScope() == ComModel.SCOPE_NONE){
			return;
		}
		var id:String = c.getID();
		var func:String = "get" + (id.charAt(0).toUpperCase() + id.substr(1));
		lineRise(c.getGetterScope() + " function " + func + "():" + c.getDefinition().getShortClassName()+"{");
		line("return " + id + ";");
		lineDrop("}");
	}
	
	private function line(str:String=""):void{
		for(var i:int=0; i<indent; i++){
			codeString += TAB;
		}
		codeString += str+"\n";
	}
	
	private function lineRise(str:String=""):void{
		line(str);
		indent++;
	}
	
	private function lineDrop(str:String=""):void{
		indent--;
		if(indent < 0) indent=0;
		line(str);
	}
}
}