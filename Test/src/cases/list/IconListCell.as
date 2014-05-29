package cases.list
{
	import org.aswing.DefaultListCell;
	import org.aswing.*;
	import cases.*;

	public class IconListCell extends DefaultListCell
	{
		public function IconListCell()
		{
			super();
		}
		
		override public function setCellValue(value:*) : void {
			if(this.value != value){
				this.value = value;
				getJLabel().setText(value.toString());
				if(Math.random() > 0.5){
					getJLabel().setIcon(new ColorIcon(new ASColor(Math.random()*0xFFFFFF), 10+Math.random()*30, 10+Math.random()*30));
				}else{
					getJLabel().setIcon(new CircleIcon(new ASColor(Math.random()*0xFFFFFF), 10+Math.random()*30, 10+Math.random()*30));
				}
			}
		}
		
	}
}