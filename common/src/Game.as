package
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class Game extends Sprite
	{
		public static var stageWidth:int = 760;//760 for facebook
		public static var stageHeight:int = 570;//570 for facebook
		
		public function Game(){
			var quad:Quad = new Quad(200,200,0x00ffff);
			this.addChild(quad);
		}
	}
}