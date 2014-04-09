package controllers
{
	import models.LevelModel;
	
	import starling.display.Quad;
	
	import views.CellView;
	import views.LevelView;
	import views.View;
	
	public class LevelController extends Controller
	{
		private var _levelModel:LevelModel;
		private var _levelView:LevelView;
		
		public function LevelController(view:View, parameters:*)
		{
			super(view, new LevelModel());
			_levelModel = LevelModel(this.model);	
			_levelView  = LevelView(this.view);
			
			// initialize the map
			_levelModel.numCol    = withDefault(parameters.numCol, 10);
			_levelModel.numRow    = withDefault(parameters.numRow, 10);
			_levelModel.field     = new Vector.<CellController>();
			_levelModel.bombCount = 0;
			
			_levelView.addChild(new Quad(100,100));
			
			trace('Creating Level');
			// initialize the grid
			for(var i:int=0; i<_levelModel.numRow; i++){
				for(var j:int=0; j<_levelModel.numCol; j++){
					var cellParameters:* = {
						row : i,
						col : j
					};
					var cellView:CellView = new CellView(cellParameters);
					_levelModel.field.push(cellView.controller);
					//this.view.addChild(cellView);
				}	
			}
			
			// plant mines
			var tryCount:int = Math.floor(_levelModel.numCol * _levelModel.numRow *0.06); 
			var bombCount:int
			for(var k:int=0; k<tryCount;k++){
				
				var index:int = Math.floor(Math.random() * _levelModel.numCol * _levelModel.numRow);
				var cellController:CellController = _levelModel.field[index];
				if(cellController.isBomb()) continue;
				cellController.plantBomb();
				notifyNeighbors(index % _levelModel.numCol, int(index / _levelModel.numCol))
				bombCount++;
			}
			
			traceLevel();
			
		}
		
		private function notifyNeighbors(col:int, row:int):void{
			for(var i:int=row-1; i<row+1; i++){
				for(var j:int=col-1; j<col+1; j++){
					if(i<0 || i >= _levelModel.numRow) continue;
					if(j<0 || j >= _levelModel.numCol) continue;
					var index:int =  _levelModel.numCol * i + j;
					_levelModel.field[index].incrementCounter();
				}	
			}
		}
		
		private function traceLevel(){
			for(var i:int=0; i<_levelModel.numRow; i++){
				for(var j:int=0; j<_levelModel.numCol; j++){
					var index:int =  _levelModel.numCol * i + j;
					var cellController:CellController = _levelModel.field[index];
					if(cellController.isBomb()) trace(' *');
					else trace(' ' + cellController.getCounter());
				}	
				trace('\n');
			}
		}
	}
}