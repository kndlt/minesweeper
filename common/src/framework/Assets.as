package framework 
{
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	
	public class Assets
	{
		private static var gameTexture:Dictionary = new Dictionary();
		
		private static var atlasCommon:TextureAtlas;
		
		[Embed(source="../../../data/textures/AtlasCommon.png")]
		public static const AtlasCommon:Class;		
		[Embed(source="../../../data/textures/AtlasCommon.xml", mimeType="application/octet-stream")]
		public static const AtlasCommonXml:Class;
		
		public static function getAtlasCommon():TextureAtlas{
			if(atlasCommon == null){
				var texture:Texture = getTexture("AtlasCommon");
				var xml:XML = XML(new AtlasCommonXml());
				//trace(texture);
				atlasCommon = new TextureAtlas(texture,xml);
			}
			return atlasCommon;
		}
		
		public static function getTexture(name:String):Texture{
			if(gameTexture[name] == undefined){
				var bitmap:Bitmap = new Assets[name]();
				gameTexture[name] = Texture.fromBitmap(bitmap);
			}
			return gameTexture[name];
		}
	}

}