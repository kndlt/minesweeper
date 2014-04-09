package objects
{
	import flash.geom.Point;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	import models.Level;

	public class Tile extends Obj
	{
		public static const TILE_WIDTH:int = 40;
		public static const TILE_HEIGHT:int = 40;
		private var _neighbors:Vector.<Tile>;
		private var _col:int;
		private var _row:int;
		private var _bg:Image;
		private var _cover:Image;
		private var _flag:Image;
		private var _isBomb:Boolean;
		private var _counter:int;
		private var _text:Button;
		private var _isOpen:Boolean;
		private var _isFlagged:Boolean;
		private var _touchDisplacement:Point;
		private var _touchDelta:Point;
		public function Tile(col:int, row:int)
		{
			_col = col;
			_row = row;
			_neighbors = new Vector.<Tile>();
			_counter = 0;
			_isFlagged = false;
			
			_bg = new Image(Assets.getAtlasCommon().getTexture("obj_sprite_cell0001"));
			_bg.width = TILE_WIDTH;
			_bg.height = TILE_HEIGHT;
			this.addChild(_bg);
			
			_text = new Button(Texture.empty(40,40), ' ');
			_text.textHAlign = starling.utils.HAlign.CENTER;
			_text.textVAlign = starling.utils.VAlign.CENTER;
			_text.fontSize   = 30;
			_text.fontColor  = 0xffffff;
			_text.scaleWhenDown = 1;
			_text.visible = false;
			this.addChild(_text);
			
			_cover =  new Image(Assets.getAtlasCommon().getTexture("obj_sprite_cell0000"));
			_cover.width = TILE_WIDTH;
			_cover.height = TILE_HEIGHT;
			this.addChild(_cover);
			
			_flag =  new Image(Assets.getAtlasCommon().getTexture("obj_sprite_cell0002"));
			_flag.width = TILE_WIDTH;
			_flag.height = TILE_HEIGHT;
			_flag.visible = false;
			this.addChild(_flag);
			
			_touchDisplacement = new Point();
			_touchDelta = new Point();
			addEventListener(TouchEvent.TOUCH, onTouch);
			
		}

		public function get neighbors():Vector.<Tile>
		{
			return _neighbors;
		}
		
		public function incrementCounter():void{
			_counter++;
			refreshText();
		}
		public function decrementCounter():void{
			_counter--;
			refreshText();
		}
		public function get isBomb():Boolean
		{
			return _isBomb;
		}

		public function plantBomb():void
		{
			if(_isBomb) return;
			_isBomb = true;
			refreshText();
			for each(var tile:Tile in _neighbors){
				tile.incrementCounter();
				this.incrementCounter();
			}
		}
		
		public function removeBomb():void
		{
			if(!_isBomb) return;
			_isBomb = false;
			refreshText();
			for each(var tile:Tile in _neighbors){
				tile.decrementCounter();
				this.decrementCounter();
			}
		}

		public function get counter():int
		{
			return _counter;
		}
		private function refreshText():void{
			if(_isBomb){
				_text.text = '*';
			} else if(_counter > 0){
				_text.text = ''+_counter;
			} else { 
				_text.text = ' ';
			}
		}

		public function get isOpen():Boolean
		{
			return _isOpen;
		}
		public function open():void{
			if(isOpen) return;
			unflag();
			_text.visible = true;
			_isOpen = true;
			_cover.visible = false;
		}
		public function flag():void{
			if(_isOpen) return;
			if(_isFlagged) return;
			_isFlagged = true;
			_flag.visible = true;
			
		}
		public function unflag():void{
			if(_isOpen) return;
			if(!_isFlagged) return;
			_isFlagged = false;
			_flag.visible = false;
			
		}
		private function onTouch(event:TouchEvent):void
		{
			
			
			if (_isOpen) return;
			var touch:Touch = event.getTouch(this, TouchPhase.ENDED);
			
			if (touch){
				if(_touchDisplacement.length < 5){	
					if(event.ctrlKey){
						this.dispatchEventWith(Level.EVENT_FLAG_TILE, true, {
							tile: this
						});
					}
					else{
						if(!_isFlagged){
							this.dispatchEventWith(Level.EVENT_OPEN_TILE, true, {
								tile: this
							});
						}
					}
					
				}
				_touchDisplacement.setTo(0,0);
			}
			var movedTouch:Touch = event.getTouch(this, TouchPhase.MOVED);
			if(movedTouch)
			{
				movedTouch.getMovement(this, _touchDelta);
				_touchDisplacement.x += _touchDelta.x;
				_touchDisplacement.y += _touchDelta.y;
				
			}
			
		}

		public function get isFlagged():Boolean
		{
			return _isFlagged;
		}


	}
}