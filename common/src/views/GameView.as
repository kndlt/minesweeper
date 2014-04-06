package views
{
	import controllers.GameController;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class GameView extends View
	{
		
		public function GameView()
		{
			super(new GameController(this));
			
			/*
			var quad:Quad = new Quad(200,200,0x00ffff);
			this.addChild(quad);
			*/
			
		}
	}
}