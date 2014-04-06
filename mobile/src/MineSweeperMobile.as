package
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	
	import feathers.system.DeviceCapabilities;
	
	import framework.Application;
	
	import starling.core.Starling;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	import views.GameView;
	
	[SWF(width="760", height="570", frameRate="60", backgroundColor="#000000")]
	public class MineSweeperMobile extends Sprite
	{
		private var starlingGame:Starling;
		private var debugDrawSprite:Sprite;
		public function MineSweeperMobile()
		{
			//simulate iPhone Retina - needed for consistent feathers style
			DeviceCapabilities.dpi = 326; 
			
			var iOS:Boolean = Capabilities.manufacturer.indexOf("iOS") != -1;
			Starling.multitouchEnabled = true;  // useful on mobile devices
			Starling.handleLostContext = !iOS;  // not necessary on iOS. Saves a lot of memory!
			
			
			// These settings are recommended to avoid problems with touch handling
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			// Create a Starling instance that will run the "Game" class
			var viewPort:Rectangle = RectangleUtil.fit(
				new Rectangle(0, 0, Application.stageWidth, Application.stageHeight), 
				new Rectangle(0, 0, stage.fullScreenWidth, stage.fullScreenHeight), 
				ScaleMode.SHOW_ALL, 
				false
			);
			
			
			starlingGame = new Starling(Application, stage, viewPort);			
			starlingGame.antiAliasing = 0; 
			starlingGame.showStats = false;
			starlingGame.stage.stageWidth  = Application.stageWidth; 
			starlingGame.stage.stageHeight = Application.stageHeight; 
			
			starlingGame.simulateMultitouch  = false;
			starlingGame.enableErrorChecking = false;
			
			starlingGame.start();			
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.ACTIVATE, function (e:*):void { starlingGame.start(); });
			
			NativeApplication.nativeApplication.addEventListener(
				flash.events.Event.DEACTIVATE, function (e:*):void { starlingGame.stop(true); });
		}
		
		
	}
}
