package widgets
{
	import events.NavigationEvent;
	
	import feathers.controls.LayoutGroup;
	import feathers.layout.VerticalLayout;
	
	import objects.Obj;
	
	import starling.display.Button;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class GameEnd extends Obj
	{
		private var _bg:Quad;
		private var _title:Button;
		private var _playButton:Button;
		private var _mediumButton:Button;
		private var _hardButton:Button;
		public function GameEnd(hasWon:Boolean)
		{
			
			_bg = new Quad(Game.stageWidth,Game.stageHeight,0x000000);
			_bg.alpha = 0.6;
			this.addChild(_bg);
			
			var layoutGroup:LayoutGroup = new LayoutGroup();
			layoutGroup.width = Game.stageWidth;
			layoutGroup.height = Game.stageHeight;
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 20;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			layoutGroup.layout = layout;
			
			_title = new Button(Texture.empty(400,60), hasWon ? 'Success!' : 'Fail!');
			_title.textHAlign = starling.utils.HAlign.CENTER;
			_title.textVAlign = starling.utils.VAlign.CENTER;
			_title.fontSize   = 60;
			_title.fontColor  = 0xffffff;
			_title.scaleWhenDown = 1;
			layoutGroup.addChild(_title);
			
			_playButton = new Button(Texture.empty(400,60), hasWon ? 'Play Again' : 'Try Again');
			_playButton.textHAlign = starling.utils.HAlign.CENTER;
			_playButton.textVAlign = starling.utils.VAlign.CENTER;
			_playButton.fontSize   = 60;
			_playButton.fontColor  = 0xffffff;
			_playButton.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
			layoutGroup.addChild(_playButton);
			
			this.addChild(layoutGroup);
			
		}
		private function onButtonClick(event:starling.events.Event):void{
			var buttonClicked:Button = event.target as Button;
			
			var difficulty:int = 0;
			if(buttonClicked == _playButton){
				var levelConfig:LevelConfig = new LevelConfig();
				this.addChild(levelConfig);
				
			}
				
			if(difficulty){
				this.dispatchEventWith(Game.EVENT_CHANGE_SCREEN, true, {
					id: 'play',
					difficulty: difficulty
				});
			}
			
		}
	}
}