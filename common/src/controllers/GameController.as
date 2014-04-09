package controllers
{
	import models.GameModel;
	
	import views.LevelView;
	import views.View;

	public class GameController extends Controller
	{
		private var _gameModel:GameModel;
		private var _levelView:LevelView;
		
		public function GameController(view:View, parameters:*)
		{
			super(view, new GameModel());
		
			// configure game
			_gameModel = GameModel(model);
			_gameModel.difficulty = withDefault(parameters.difficulty, GameModel.DIFFICULTY_EASY);
		
			// add level
			var levelParameters:Object = {
				numCol: 10 + _gameModel.difficulty,
				numRow: 10 + _gameModel.difficulty
			};
			_levelView = new LevelView(levelParameters);
			this.view.addChild(_levelView);
			
		}
	}
}