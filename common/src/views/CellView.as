package views
{
	import controllers.CellController;
	
	import framework.Assets;
	
	import starling.display.Image;

	public class CellView extends View
	{
		private var _bg:Image;
		public function CellView(parameters:*)
		{
			super(new CellController(this, parameters));
				
			
			//_bg = new Image(Assets.getAtlasCommon().getTexture("obj_sprite_cell0000"));
			//this.addChild(_bg);
			
		}
	}
}