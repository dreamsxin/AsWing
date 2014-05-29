package org.aswing.guibuilder.code{
	
import org.aswing.guibuilder.model.BorderDefinition;
import org.aswing.guibuilder.model.BorderModel;
import org.aswing.guibuilder.model.ComModel;
import org.aswing.guibuilder.model.Definition;
import org.aswing.guibuilder.model.FileModel;
import org.aswing.guibuilder.model.LayoutDefinition;
import org.aswing.guibuilder.model.LayoutModel;
import org.aswing.guibuilder.model.ProModel;

/**
 * @author Johan Coppens
 */
public class HaxeCodeGenerator{
	
	private static const TAB:String = "\t";
	private static const NEWLINE:String = "\n";
	
	public static var border_id_counter:int = 0;
	public static var layout_id_counter:int = 0;
	
	private var file:FileModel;
	private var codeString:String;
	private var indent:int;
	private var allMemberComs:Array;
	private var usedClasses:Array;
	
	public function HaxeCodeGenerator(file:FileModel){
		this.file = file;
		indent = 0;
	}
	
	
	/**
	 * Generates Haxe class code for this ui file.
	 */
	public function generateCode():String {
		
		border_id_counter = 0;
		layout_id_counter = 0;
		codeString = "";
		
		allMemberComs = new Array();
		initAllMemberComs(file.getRootComponent());
		
		usedClasses = new Array();
		initUsedClasses();
		

		addPackage();
		return codeString;
	}
	
	private function addPackage():void{
		line("package " + file.getPackageName() + ";");
		line();
		addImports();
		line();
		addClass();
		//line("}");
	}
	
	private function addImports():void {
		//add an import for each used component
		line("//importing used component classes");
		for each(var c:String in usedClasses){
			line("import " + c + ";");
		}
		
		//add geom import
		line("//importing aswing geom classes");
		line("import org.aswing.geom.IntDimension;");
		line("import org.aswing.geom.IntPoint;");
		line("import org.aswing.geom.IntRectangle;");
		
		//add layout classes
		line("//importing aswing layout classes");
		var layDefs:Array = Definition.getIns().getLayouts();
		var layouts:Array = new Array();
		for each(var layDef:LayoutDefinition in layDefs){
			var lm:LayoutModel = new LayoutModel(layDef);
			line("import " + lm.getDef().getClassName() + ";");
		}
		
		//add border classes
		line("//importing aswing border classes");
		var borDefs:Array = Definition.getIns().getBorders();
		var borders:Array = new Array();
		for each(var borDef:BorderDefinition in borDefs){
			var bm:BorderModel = new BorderModel(borDef);
			line("import " + bm.getDef().getClassName() + ";");
		}
		
		//add some additional classes
		line("//importing some additional classes");
		line("import org.aswing.ASColor;");
		line("import org.aswing.AsWingConstants;");		
	}
	
	private function addClass():void{
		line("/**");
		line(" * " + file.getName());
		line(" */");
		lineRise("class " + file.getName() + " extends " + file.getRootComponent().getDefinition().getShortClassName()+"{");
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
		lineRise("public function new(){");
		line("super();");
		
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
	private function initAllMemberComs(parent:ComModel):void {
		var n:int = parent.getChildCount();
		for(var i:int=0; i<n; i++){
			var c:ComModel = parent.getChild(i);
			allMemberComs.push(c);
			initAllMemberComs(c);
		}
	}
	private function initUsedClasses():void {
		//add the root component class name
		usedClasses.push(file.getRootComponent().getDefinition().getClassName());
		//add all member class names
		for each(var c:ComModel in allMemberComs){
			if(!inArray(c.getDefinition().getClassName(), usedClasses)){
				usedClasses.push(c.getDefinition().getClassName());
			}
		}
	}
	//helper function for initUsedClasses
	private function inArray( b:Object, a:Array ):Boolean {
		for each ( var o:Object in a ) {
			if (o === b) {
				return true;
			}
		}
		return false;
	}
	private function translateScope(scope:String):String{
		if(scope == ComModel.SCOPE_PROTECTED){
			return ComModel.SCOPE_PRIVATE;
		}else if(scope == ComModel.SCOPE_INTERNAL){
			return ComModel.SCOPE_PUBLIC;
		}
		return scope;
	}
	private function addMembersOfChildren(parent:ComModel):void{
		var n:int = parent.getChildCount();
		for(var i:int=0; i<n; i++){
			var c:ComModel = parent.getChild(i);
			line(translateScope(c.getAttributeScope()) + " var " + c.getID() + ":" + c.getDefinition().getShortClassName() + ";");
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
		lineRise(translateScope(c.getGetterScope()) + " function " + func + "():" + c.getDefinition().getShortClassName()+"{");
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