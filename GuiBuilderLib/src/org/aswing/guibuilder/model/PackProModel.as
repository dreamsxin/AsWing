package org.aswing.guibuilder.model{
	
import org.aswing.geom.IntDimension;
	

public class PackProModel extends ProModel{
	
	public function PackProModel(){
		super(new PackProDefinition());
	}
	
	override public function valueChanged(v:ValueModel):void{
		var cm:ComModel = owner as ComModel;
		cm.getDisplay().pack();
		var size:IntDimension = cm.getDisplay().getSize();
		var pro:ProModel = cm.getProperty("Size");
		var xml:XML = <Property label="Size" name="Size" type="IntDimension" action="revalidate"></Property>;
		var valueStr:String = "<Value value='" + (size.width+","+size.height) + "'/>";
		xml.appendChild(new XML(valueStr));
		pro.parse(xml);
	}
	
	override public function bindTo(c:Model):void{
		owner = c;
	}
	
	override protected function captureDefaultProperty(name:String):ValueModel{
		return null;
	}
}
}