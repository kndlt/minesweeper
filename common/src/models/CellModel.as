package models
{
	public class CellModel extends Model
	{
		public var isBomb:Boolean;
		public var counter:int;
		public function CellModel()
		{
			super();
			isBomb = false;
			counter = 0;
		}
	}
}