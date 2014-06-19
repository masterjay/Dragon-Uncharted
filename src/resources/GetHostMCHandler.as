package resources
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GetHostMCHandler extends Sprite
	{
		public function GetHostMCHandler()
		{
			super();
		}
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		[Embed(source="../resources/assets/host/host_show.png")]
		public static const TextureHostShow:Class
		[Embed(source="../resources/assets/host/host_show.xml",mimeType="application/octet-stream")]
		public static const XmlHostShow:Class
		public static var strTextureHostShow:String = "TextureHostShow"
		
		public static var TextureAtlasHostShow:TextureAtlas
		
		public static function getAtlasHostShow():TextureAtlas
		{		
			if(TextureAtlasHostShow == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureHostShow)
				var xml:XML = XML(new XmlHostShow());
				TextureAtlasHostShow = new TextureAtlas(texture,xml)
			}
			return TextureAtlasHostShow;
		}
		
		
		[Embed(source="../resources/assets/host/host_attack.png")]
		public static const TextureHostAttack:Class
		[Embed(source="../resources/assets/host/host_attack.xml",mimeType="application/octet-stream")]
		public static const XmlHostAttack:Class
		public static var strTextureHostAttack:String = "TextureHostAttack"

		public static var TextureAtlasHostAttack:TextureAtlas

		public static function getAtlasHostAttack():TextureAtlas
		{		
			if(TextureAtlasHostAttack == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureHostAttack)
				var xml:XML = XML(new XmlHostAttack());
				TextureAtlasHostAttack = new TextureAtlas(texture,xml)
			}
		return TextureAtlasHostAttack;
		}
		
		
		[Embed(source="../resources/assets/host/host_wait.png")]
		public static const TextureHostWait:Class
		[Embed(source="../resources/assets/host/host_wait.xml",mimeType="application/octet-stream")]
		public static const XmlHostWait:Class
		public static var strTextureHostWait:String = "TextureHostWait"
		
		public static var TextureAtlasHostWait:TextureAtlas
		
		public static function getAtlasHostWait():TextureAtlas
		{		
			if(TextureAtlasHostWait == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureHostWait)
				var xml:XML = XML(new XmlHostWait());
				TextureAtlasHostWait = new TextureAtlas(texture,xml)
			}
			return TextureAtlasHostWait;
		}
		
		[Embed(source="../resources/assets/host/host_die.png")]
		public static const TextureHostDie:Class
		[Embed(source="../resources/assets/host/host_die.xml",mimeType="application/octet-stream")]
		public static const XmlHostDie:Class
		public static var strTextureHostDie:String = "TextureHostDie"
		
		public static var TextureAtlasHostDie:TextureAtlas
		
		public static function getAtlasHostDie():TextureAtlas
		{		
			if(TextureAtlasHostDie == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureHostDie)
				var xml:XML = XML(new XmlHostDie());
				TextureAtlasHostDie = new TextureAtlas(texture,xml)
			}
			return TextureAtlasHostDie;
		}
		
		[Embed(source="../resources/assets/host/host_affect.png")]
		public static const TextureHostAffect:Class
		[Embed(source="../resources/assets/host/host_affect.xml",mimeType="application/octet-stream")]
		public static const XmlHostAffect:Class
		public static var strTextureHostAffect:String = "TextureHostAffect"
		
		public static var TextureAtlasHostAffect:TextureAtlas
		
		public static function getAtlasHostAffect():TextureAtlas
		{		
			if(TextureAtlasHostAffect == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureHostAffect)
				var xml:XML = XML(new XmlHostAffect());
				TextureAtlasHostAffect = new TextureAtlas(texture,xml)
			}
			return TextureAtlasHostAffect;
		}
		
		
		private static function fnGetMovieClipTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new GetHostMCHandler[name]();
				gameTextures[name] = starling.textures.Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
		
	}
}