package resources
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GetCubeMCHandler extends Sprite
	{
		public function GetCubeMCHandler()
		{
			super();
		}
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		[Embed(source="../resources/assets/cube/cube_break.png")]
		public static const TextureCubeBreak:Class;
		[Embed(source="../resources/assets/cube/cube_break.xml",mimeType="application/octet-stream")]
		public static const XmlCubeBreak:Class;
		public static var strTextureCubeBreak:String = "TextureCubeBreak"
		
		public static var TextureAtlasCubeBreak:TextureAtlas
		
		public static function getAtlasCubeBreak():TextureAtlas
		{		
			if(TextureAtlasCubeBreak == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureCubeBreak)
				var xml:XML = XML(new XmlCubeBreak());
				TextureAtlasCubeBreak = new TextureAtlas(texture,xml)
			}
			return TextureAtlasCubeBreak;
		}
		
		
		private static function fnGetMovieClipTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new GetCubeMCHandler[name]();
				gameTextures[name] = starling.textures.Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
		
	}
}