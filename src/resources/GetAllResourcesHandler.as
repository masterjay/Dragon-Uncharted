package resources
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GetAllResourcesHandler extends Sprite
	{
		public function GetAllResourcesHandler()
		{
			super();
		}
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		[Embed(source="../resources/assets/allresources/allResources.png")]
		public static const TextureAll:Class
		[Embed(source="../resources/assets/allresources/allResources.xml",mimeType="application/octet-stream")]
		public static const XmlAll:Class
		public static var strTextureAll:String = "TextureAll"
		
		public static var TextureAtlasAll:TextureAtlas
		
		public static function getAtlasAll():TextureAtlas
		{		
			if(TextureAtlasAll == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureAll)
				var xml:XML = XML(new XmlAll());
				TextureAtlasAll = new TextureAtlas(texture,xml)
			}
			return TextureAtlasAll;
		}
		
		
	
		
		
		private static function fnGetMovieClipTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new GetAllResourcesHandler[name]();
				gameTextures[name] = starling.textures.Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
		
	}
}