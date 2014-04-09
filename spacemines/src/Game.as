package
{
	import feathers.themes.MetalWorksMobileTheme;
	
	import objects.Obj;
	
	import screens.InGame;
	import screens.Welcome;
	
	import starling.events.Event;
	
	public class Game extends Obj
	{
		public static var stageWidth:int = 760;
		public static var stageHeight:int = 570;
		public static const EVENT_CHANGE_SCREEN:String = 'event_game_change_screen';
		
		
		
		
		private var screen:Obj;
		
		
		public function Game()
		{
			super();
			
			// feathers theme init
			new MetalWorksMobileTheme();
			screen = new Welcome();
			this.addChild(screen);
			
			this.addEventListener(Game.EVENT_CHANGE_SCREEN, onChangeScreen);
			
			
		}
		
		private function onEnterFrame(event:Event, passedTime:Number):void {
			this.update(passedTime);
		}
		
		override public function update(passedTime:Number):void{
			this.updateChildren(passedTime);
		}
		
		private function onChangeScreen(event:Event, data:Object):void{
			//trace(JSON.stringify(data));
			switch(data.id){
				
				case 'play':
					screen = screen.replace(new InGame(data.difficulty));
					break;		
				
				case 'mainmenu':
					screen = screen.replace(new Welcome());
					break;		
			}
		}
		
		
	}
}