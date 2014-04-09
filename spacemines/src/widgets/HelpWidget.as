package widgets
{
	import objects.Obj;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class HelpWidget extends Obj
	{
		private var _tip:Button;
		private var _backButton:Button;
		private var _bg:Quad;
		public function HelpWidget()
		{
			super();
			
			_bg = new Quad(Game.stageWidth,Game.stageHeight,0x000000);
			_bg.alpha = 0.9;
			this.addChild(_bg);
			
			_tip = new Button(Texture.empty(500,300), 'Instructions:\nClaim all the safe tiles without hitting on the mines. You can claim the tile by clicking on the tiles. When you see a tile with number N on a tile, that means that there are N neighboring mines within its 3x3 neighbors. So be careful!');
			_tip.x = Game.stageWidth  >> 1;
			_tip.y = Game.stageHeight  >> 1;
			_tip.alignPivot();
			_tip.textHAlign = starling.utils.HAlign.LEFT;
			_tip.textVAlign = starling.utils.VAlign.CENTER;
			_tip.fontSize   = 16;
			_tip.fontColor  = 0xffffff;
			_tip.scaleWhenDown = 1;
			this.addChild(_tip);
			
			_backButton = new Button(Texture.empty(80,30), 'Close');
			_backButton.x = Game.stageWidth - 80;
			_backButton.y = 0;
			_backButton.textHAlign = starling.utils.HAlign.CENTER;
			_backButton.textVAlign = starling.utils.VAlign.CENTER;
			_backButton.fontSize   = 16;
			_backButton.fontColor  = 0xffffff;
			_backButton.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
			this.addChild(_backButton);
		}
		
		private function onButtonClick(event:starling.events.Event):void{
			var buttonClicked:Button = event.target as Button;
			if(buttonClicked == _backButton){
				this.remove();
			}
		}
	}
}