package views
{
	import controllers.Controller;
	
	
	import starling.display.Sprite;
	
	public class View extends Sprite
	{
		private var _controller:Controller;
		
		public function View(controller:Controller)
		{
			super();
			_controller = controller;
		}

		public function get controller():Controller
		{
			return _controller;
		}

	}
}