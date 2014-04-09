package screens
{
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	
	import objects.Obj;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import widgets.GameEnd;
	import widgets.HelpWidget;
	import widgets.Level;

	public class InGame extends Obj
	{
		public static const EVENT_GAME_END:String = 'event_game_end';
		
		private var _level:Level;
		private var _tip:Button;
		private var _backButton:Button;
		private var _instructionButton:Button;
		
		public function InGame(difficulty:int)
		{
			
			_tip = new Button(Texture.empty(500,30), 'Tip: Cmd+Click or Ctrl+Click to toggle flag');
			_tip.x = Game.stageWidth  >> 1;
			_tip.y = (Game.stageHeight) - 30;
			_tip.alignPivot();
			_tip.textHAlign = starling.utils.HAlign.CENTER;
			_tip.textVAlign = starling.utils.VAlign.CENTER;
			_tip.fontSize   = 16;
			_tip.fontColor  = 0xffffff;
			_tip.scaleWhenDown = 1;
			this.addChild(_tip);
			
			_backButton = new Button(Texture.empty(80,30), 'Exit');
			_backButton.x = Game.stageWidth - 80;
			_backButton.y = 0;
			_backButton.textHAlign = starling.utils.HAlign.CENTER;
			_backButton.textVAlign = starling.utils.VAlign.CENTER;
			_backButton.fontSize   = 16;
			_backButton.fontColor  = 0xffffff;
			_backButton.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
			this.addChild(_backButton);
			
			
			_instructionButton = new Button(Texture.empty(80,30), 'How To Play');
			_instructionButton.x = 0;
			_instructionButton.y = 0;
			_instructionButton.textHAlign = starling.utils.HAlign.CENTER;
			_instructionButton.textVAlign = starling.utils.VAlign.CENTER;
			_instructionButton.fontSize   = 16;
			_instructionButton.fontColor  = 0xffffff;
			_instructionButton.addEventListener(starling.events.Event.TRIGGERED, onButtonClick);
			this.addChild(_instructionButton);
			
			
			
			_level = new Level(difficulty);
			this.addChild(_level);
			this.addEventListener(InGame.EVENT_GAME_END, onGameEnd);
			
		}
		
		private function onButtonClick(event:starling.events.Event):void{
			var buttonClicked:Button = event.target as Button;
			if(buttonClicked == _backButton){
				var alert:Alert = Alert.show( "Are you sure you want to exit?", "Exit to Main Menu", new ListCollection([
					{ label: "OK", triggered: onExitConfirmed },
					{ label: "CANCEL" }
				]) );
			}
			if(buttonClicked == _instructionButton){
				this.addChild(new HelpWidget());
			}
		}
		private function onExitConfirmed():void{
			
			this.dispatchEventWith(Game.EVENT_CHANGE_SCREEN, true, {
				id: 'mainmenu'
			});
		}
		private function onGameEnd(event:Event, data:Object):void{
			switch(data.result){
				case 'win':
					trace('won');
					this.addChild(new GameEnd(true));
					break;
				case 'lose':
					trace('lost');
					this.addChild(new GameEnd(false));
					break;
			}
		}
	}
}