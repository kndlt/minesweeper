package controllers
{
	import models.Model;
	
	import starling.events.EventDispatcher;
	
	import views.View;
	
	public class Controller extends EventDispatcher
	{

		/*
		* model is set via constructor only
		* this controller should have exclusive access to this model
		*/
		private var _model:Model;
		protected function get model():Model { return _model; }
		
		/*
		* view is set via constructor only 
		*/
		private var _view:View;
		protected function get view():View   { return _view; }
		
		/*
		* constructors are called in view classess. 
		* you must supply a model and a view
		* most likely, you will be doing the following in your view constructor:
		* super(new YourController(this));
		*/
		public function Controller(view:View, model:Model)
		{
			super();
			_model = model;
			_view  = view;
		}
		
		/*
		* update function which is called every frame
		*/
		public function update(passedTime:Number):void
		{
			updateChildren(passedTime);
		}
		
		/*
		* update all the children
		*/
		private function updateChildren(passedTime:Number):void{
			for( var i:Number = 0; i < _view.numChildren;i++){
				var view:View = View(_view.getChildAt(i));
				view.controller.update(passedTime);
			}
		}
		
		/*
		* removes the entity 
		*/
		public function remove():void{
			onRemove();
			_view.removeFromParent(true);
		}
		
		/*
		* called when the entity is about to be removed
		*/
		protected function onRemove():void{	
			// abstract
		}
		
		/*
		* call this when you want to replace this entity with some other entity
		* ex: _view = _view.controller.replace(new GameView()); // to reset game view
		*/
		public function replace(newView:View):View{
			var index:int = _view.parent.getChildIndex(_view);
			var wasParent:View = _view.parent as View;
			this.remove();
			wasParent.addChildAt(newView,index);
			return newView;
		}

		/*
		* (proxy) 
		* check if parameter exists, if it does return the param,
		* otherwise return default value
		*/
		protected function withDefault(value, defaultValue = null):*
		{
			if(value===null || value===undefined) return defaultValue;
			return value;
		}
				
	}
}