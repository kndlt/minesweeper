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

	public class LevelConfig extends Obj
	{
		private var _bg:Quad;
		private var _title:Button;
		private var _easyButton:Button;
		private var _mediumButton:Button;
		private var _hardButton:Button;
		public function LevelConfig()
		{
			
			_bg = new Quad(Game.stageWidth,Game.stageHeight,0x000000);
			_bg.alpha = 0.9;
			this.addChild(_bg);
			
			var layoutGroup:LayoutGroup = new LayoutGroup();
			layoutGroup.width = Game.stageWidth;
			layoutGroup.height = Game.stageHeight;
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = 20;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			layoutGroup.layout = layout;
			
			_title = new Button(Texture.empty(400,60), 'Select Difficulty');
			_title.textHAlign = starling.utils.HAlign.CENTER;
			_title.textVAlign = starling.utils.VAlign.CENTER;
			_title.fontSize   = 60;
			_title.fontColor  = 0xffffff;
			_title.scaleWhenDown = 1;
			layoutGroup.addChild(_title);
			
			_easyButton = new Button(Texture.empty(400,60), '- Easy -');
			_easyButton.textHAlign = starling.utils.HAlign.CENTER;
			_easyButton.textVAlign = starling.utils.VAlign.CENTER;
			_easyButton.fontSize   = 60;
			_easyButton.fontColor  = 0xffffff;
			_easyButton.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
			layoutGroup.addChild(_easyButton);
			
			_mediumButton = new Button(Texture.empty(400,60), '- Medium -');
			_mediumButton.textHAlign = starling.utils.HAlign.CENTER;
			_mediumButton.textVAlign = starling.utils.VAlign.CENTER;
			_mediumButton.fontSize   = 60;
			_mediumButton.fontColor  = 0xffffff;
			_mediumButton.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
			layoutGroup.addChild(_mediumButton);
			
			_hardButton = new Button(Texture.empty(400,60), '- Hard -');
			_hardButton.textHAlign = starling.utils.HAlign.CENTER;
			_hardButton.textVAlign = starling.utils.VAlign.CENTER;
			_hardButton.fontSize   = 60;
			_hardButton.fontColor  = 0xffffff;
			_hardButton.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
			layoutGroup.addChild(_hardButton);
			
			this.addChild(layoutGroup);
			
		}
		private function onButtonClick(event:starling.events.Event):void{
			var buttonClicked:Button = event.target as Button;
			
			var difficulty:int = 0;
			if(buttonClicked == _easyButton)   difficulty = 1  
			if(buttonClicked == _mediumButton) difficulty = 2;
			if(buttonClicked == _hardButton)   difficulty = 3;
			
			if(difficulty){
				this.dispatchEventWith(Game.EVENT_CHANGE_SCREEN, true, {
					id: 'play',
					difficulty: difficulty
				});
			}
								
		}
	}
}