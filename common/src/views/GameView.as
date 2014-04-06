package views
{
	import controllers.GameController;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class GameView extends View
	{
		
		public function GameView(parameters:*)
		{
			super(new GameController(this, parameters));
			
			/*
			var quad:Quad = new Quad(200,200,0x00ffff);
			this.addChild(quad);
			*/
			
		}
	}
}