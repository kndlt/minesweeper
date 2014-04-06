package controllers
{
	import models.CellModel;
	
	import views.View;
	
	public class CellController extends Controller
	{
		private var _cellModel:CellModel;
		public function CellController(view:View, parameters:*)
		{
			super(view, new CellModel());
			_cellModel = CellModel(this.model);
		}
		
		public function isBomb():Boolean{
			return _cellModel.isBomb;
		}
		public function plantBomb():void{
			_cellModel.isBomb = true;
			_cellModel.counter++;
		}
		public function incrementCounter():void{
			_cellModel.counter++;
		}
		public function getCounter():int{
			return _cellModel.counter;
		}
	}
}