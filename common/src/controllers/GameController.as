package controllers
{
	import models.GameModel;
	
	import views.View;

	public class GameController extends Controller
	{
		public function GameController(view:View)
		{
			super(new GameModel(), view);
		}
	}
}