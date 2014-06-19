package resources
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GetLifeMCHandler extends Sprite
	{
		public function GetLifeMCHandler()
		{
			super();
		}
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		
		[Embed(source="../resources/assets/life/life_left.png")]
		private static const TextureLifeLeft:Class
		[Embed(source="../resources/assets/life/life_left.xml",mimeType="application/octet-stream")]
		private static const XmlStartLifeLeft:Class
		private static var strTextureLifeLeft:String = "TextureLifeLeft"

		private static var TextureAtlasLifeLeft:TextureAtlas

		public static function getAtlasLifeLeft():TextureAtlas
		{		
			if(TextureAtlasLifeLeft == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureLifeLeft)
				var xml:XML = XML(new XmlStartLifeLeft());
				TextureAtlasLifeLeft = new TextureAtlas(texture,xml)
			}
		return TextureAtlasLifeLeft;
		}
		
		
		[Embed(source="../resources/assets/life/life_right.png")]
		private static const TextureLifeRight:Class
		[Embed(source="../resources/assets/life/life_right.xml",mimeType="application/octet-stream")]
		private static const XmlStartLifeRight:Class
		private static var strTextureLifeRight:String = "TextureLifeRight"
		
		private static var TextureAtlasLifeRight:TextureAtlas
		
		public static function getAtlasLifeRight():TextureAtlas
		{		
			if(TextureAtlasLifeRight == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureLifeRight)
				var xml:XML = XML(new XmlStartLifeRight());
				TextureAtlasLifeRight = new TextureAtlas(texture,xml)
			}
			return TextureAtlasLifeRight;
		}
		
		
		
		private static function fnGetMovieClipTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new GetLifeMCHandler[name]();
				gameTextures[name] = starling.textures.Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
		
	}
}