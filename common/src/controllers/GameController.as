package controllers
{
	import models.GameModel;

	public class GameController extends Controller
	{
		public function GameController()
		{
			super(new GameModel());
		}
	}
}