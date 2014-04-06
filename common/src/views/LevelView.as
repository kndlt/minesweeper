package views
{
	import controllers.LevelController;
	
	public class LevelView extends View
	{
		public function LevelView(parameters:*)
		{
			super(new LevelController(this, parameters));
		}
	}
}