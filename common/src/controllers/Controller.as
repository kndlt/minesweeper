package controllers
{
	import models.Model;
	
	import starling.events.EventDispatcher;
	
	public class Controller extends EventDispatcher
	{
		private var _model:Model;
		public function Controller(model:Model)
		{
			super();
			_model = model;
		}

		public function get model():Model
		{
			return _model;
		}

	}
}