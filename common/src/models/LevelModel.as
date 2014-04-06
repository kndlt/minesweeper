package models
{
	import controllers.CellController;
	
	import views.CellView;

	public class LevelModel extends Model
	{
		public var numCol:int;
		public var numRow:int;
		public var bombCount:int;
		public var field:Vector.<CellController>; 
		
		
		public function LevelModel()
		{
			super();
		}
		
		
	}
}