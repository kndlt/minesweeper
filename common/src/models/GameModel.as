package models
{
	

	public class GameModel extends Model
	{
		public static const DIFFICULTY_EASY:int   = 1;
		public static const DIFFICULTY_MEDIUM:int = 2;
		public static const DIFFICULTY_HARD:int   = 3;
		
		public var difficulty:int;
		public function GameModel()
		{
			super();
		}
	}
}