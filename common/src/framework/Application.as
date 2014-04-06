package framework
{
	import controllers.Controller;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import views.GameView;
	import views.View;

	/*
	 *	starling application bootstrap
	 */
	public class Application extends Sprite
	{
		// stage dimensions can be accesed in a static way
		public static var stageWidth:int = 760;
		public static var stageHeight:int = 570;
		
		// root view
		private var _view:View;

		// boostrap
		public function Application()
		{
			_view = new GameView();
			this.addChild(_view);
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
		}
		
		// update
		private function onEnterFrame(event:Event, passedTime:Number):void {
			_view.controller.update(passedTime);
			
		}
		
	}
}