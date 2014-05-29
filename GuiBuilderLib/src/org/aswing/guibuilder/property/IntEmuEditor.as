package org.aswing.guibuilder.property{

public class IntEmuEditor extends AbsComboIntEditor{
	
	public function IntEmuEditor(){
		super([]);
	}
	
	override public function setEditorParam(param:String):void{
		combo.setListData(param.split(","));
	}
	
}
}