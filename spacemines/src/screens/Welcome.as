package screens
{
	import objects.Obj;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	
	import widgets.LevelConfig;

	public class Welcome extends Obj
	{
		private var _playButton:Button;
		private var _title:Button;
		private var _bg:Quad;
		private var _levelConfig:LevelConfig;
		public function Welcome()
		{
			_bg = new Quad(Game.stageWidth,Game.stageHeight,0x000000);
			this.addChild(_bg);
			
			_title = new Button(Texture.empty(700,300), 'SpaceMines');
			_title.x = Game.stageWidth  >> 1;
			_title.y = (Game.stageHeight >> 1) -50;
			_title.alignPivot();
			_title.textHAlign = starling.utils.HAlign.CENTER;
			_title.textVAlign = starling.utils.VAlign.CENTER;
			_title.fontSize   = 80;
			_title.fontColor  = 0xffffff;
			_title.scaleWhenDown = 1;
			this.addChild(_title);
			
			
			_playButton = new Button(Texture.empty(300,60), '- Click To Play -');
			_playButton.x = Game.stageWidth  >> 1;
			_playButton.y = (Game.stageHeight >> 1) + 100;
			_playButton.alignPivot();
			_playButton.textHAlign = starling.utils.HAlign.CENTER;
			_playButton.textVAlign = starling.utils.VAlign.CENTER;
			_playButton.fontSize   = 60;
			_playButton.fontColor  = 0xffffff;
			_playButton.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
			this.addChild(_playButton);
			
		}
		
		
		private function onButtonClick(event:starling.events.Event):void{
			var buttonClicked:Button = event.target as Button;
			if(buttonClicked == _playButton){
				
				_levelConfig = new LevelConfig();
				this.addChild(_levelConfig);
					
				
			}
		}
	}
}