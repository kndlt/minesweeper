package objects
{
	
	import starling.display.Sprite;	
	
	public class Obj extends Sprite
	{
		protected var initialized:Boolean = false;
		//protected var clip:MovieClip;
		public function Obj() {
			super();
		}
		
		public function update(passedTime:Number):void {
			this.updateChildren(passedTime);
		}
		
		protected function updateChildren(passedTime:Number):void{
			var item:Object;
			for( var i:Number = 0; i < this.numChildren;i++){
				item = this.getChildAt(i);
				if(item is Obj) (Obj(item)).update(passedTime);
			}
		}
		
		public function resize():void {
			this.resizeChildren();
		}
		protected function resizeChildren():void{
			var item:Object;
			for( var i:Number = 0; i < this.numChildren;i++){
				item = this.getChildAt(i);
				if(item is Obj) (Obj(item)).resize();
			}
		}
		
		public function remove():Obj{
			onRemove();
			this.removeFromParent(true);
			return null;
		}
		
		public function replace(newObj:Obj):Obj{
			var index:int = parent.getChildIndex(this);
			var wasParent:Obj = this.parent as Obj;
			this.remove();
			wasParent.addChildAt(newObj,index);
			return newObj;
		}

		protected function onRemove():void{	

		}

	}
}