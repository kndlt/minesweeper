package widgets
{
	import feathers.controls.LayoutGroup;
	import feathers.layout.TiledRowsLayout;
	
	import objects.Obj;
	import objects.Tile;
	
	import screens.InGame;
	
	import starling.events.Event;

	public class Level extends Obj
	{
		public static const EVENT_OPEN_TILE:String = 'event_level_open_tile'
		public static const EVENT_FLAG_TILE:String = 'event_level_flag_tile'
		private var _grid:Vector.<Tile>;
		private var _numCol:int;
		private var _numRow:int;
		private var _total:int;
		private var _started:Boolean;
		private var _isOver:Boolean;
		public function Level(difficulty:int)
		{
			
			_grid   = new Vector.<Tile>();
			_numRow = 5 + difficulty*2;
			_numCol = _numRow;
			_total  = _numRow * _numCol;
			_started = false; 
			_isOver = false;
			
			
			makeGrid();
			connectNeibors();
			plantBombs();
			
			this.addEventListener(Level.EVENT_OPEN_TILE, onOpenTile);
			this.addEventListener(Level.EVENT_FLAG_TILE, onFlagTile);
			
		}
		private function makeGrid():void{
			var group:LayoutGroup = new LayoutGroup();
			var layout:TiledRowsLayout = new TiledRowsLayout();
			layout.useSquareTiles = true;
			group.width = Tile.TILE_WIDTH*_numCol;
			group.height = Tile.TILE_HEIGHT*_numRow;
			group.layout = layout;
			
			for(var i:int = 0;i<_total;i++){
				var tile:Tile = new Tile(colOf(i), rowOf(i));
				group.addChild(tile);
				_grid.push(tile);	
			}
			group.alignPivot();
			group.x = Game.stageWidth>>1;
			group.y = Game.stageHeight>>1;
			this.addChild(group);
		}
		private function connectNeibors():void{
			//var result:Vector.<Tile> = new Vector.<Tile>();
			for(var i:int = 0;i<_total;i++){
				var tile:Tile = _grid[i];
				var col:int = colOf(i);
				var row:int = rowOf(i);
				for(var r:int=row-1;r<=row+1;r++){
					for(var c:int=col-1;c<=col+1;c++){
						if(r < 0 || c < 0 || r >= _numRow || c >= _numCol || indexOf(c,r)==i){
							continue;
						}
						tile.neighbors.push(tileAt(c,r));
					}	
				}
			}
		}
		private function plantBombs():void{
			var tryCount:int = int(_total * 0.1) + 1;
			
			for(var i:int = 0;i<tryCount;i++){
				var randomIndex:int = int(Math.random()*_total);
				var tile:Tile = _grid[randomIndex];
				tile.plantBomb();
			}
		}
		private function colOf(index:int):int{
			return int(index % _numCol);
		}
		private function rowOf(index:int):int{
			return int(index / _numCol);
		}
		private function indexOf(col:int,row:int):int{
			return row*_numCol + col;
		}
		public function tileAt(col, row):Tile{
			return _grid[indexOf(col,row)];
		}

		public function get grid():Vector.<Tile>
		{
			return _grid;
		}
		
		private function onFlagTile(event:Event, data:Object):void
		{
			if(_isOver) return;
			
			var tile:Tile = data.tile as Tile;
			
			if(!_started) return;
			if(tile.isOpen) return;
			if(tile.isFlagged) tile.unflag();
			else tile.flag();
		}
		private function onOpenTile(event:Event, data:Object):void
		{
			if(_isOver) return
			var tile:Tile = data.tile as Tile;
			if(!_started){
				// if this is first click, remove the bomb from 3x3 area
				if(tile.isBomb) tile.removeBomb();
				if(tile.counter>0) {
					for each(var neighbor:Tile in tile.neighbors){
						if(neighbor.isBomb){
							neighbor.removeBomb();
						}
					}
				}
				_started = true;
			}		
			openTileRecursive(tile);
			checkWinCondition();
		}
		
		private function checkWinCondition():void{
			var unclaimedCount:int = 0;
			for each(var tile:Tile in _grid){
				if(tile.isBomb || tile.isOpen) continue;
				unclaimedCount++;
			}
			if(unclaimedCount == 0){
				flagAllRemainingBombs();
				this.dispatchEventWith(InGame.EVENT_GAME_END, true, {
					result: 'win'
				});
				_isOver = true;
			}
		}
		private function flagAllRemainingBombs():void{
			for each(var tile:Tile in _grid){
				if(tile.isBomb && !tile.isFlagged) tile.flag();
			}
		}
		
		private function gameOver():void{
			trace('Stepped on a mine');
			//reveal all mines
			for(var i:int = 0;i<_total;i++){
				var tile:Tile = _grid[i];
				if(tile.isBomb && !tile.isOpen) tile.open();
			}
			_isOver = true;
			
			this.dispatchEventWith(InGame.EVENT_GAME_END, true, {
				result: 'lose'
			});
		}
		private function openTileRecursive(tile:Tile):void{
			tile.open();
			
			if(tile.isBomb){
				// game over
				gameOver();
				return;
			}
			if(tile.counter>0){
				// detect
				trace('Mine Near By');
				return;
			}
			
			// propagate search
			for each(var neighbor:Tile in tile.neighbors){
				if(neighbor.isOpen || neighbor.isBomb) continue;
				openTileRecursive(neighbor);
				
			}
		
		}

		 
	}
}