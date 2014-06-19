package resources
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import lib.common.resource.TiLocaleTermHelper;
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GetSoliderMCHandler extends Sprite
	{
		public function GetSoliderMCHandler()
		{
			super();
		}
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		[Embed(source="../resources/assets/solider/solider_show.png")]
		public static const TextureShow:Class
		[Embed(source="../resources/assets/solider/solider_show.xml",mimeType="application/octet-stream")]
		public static const XmlShow:Class
		public static var strTextureShow:String = "TextureShow"
		
		public static var TextureAtlasShow:TextureAtlas
		
		public static function getAtlasShow():TextureAtlas
		{		
			if(TextureAtlasShow == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureShow)
				var xml:XML = XML(new XmlShow());
				TextureAtlasShow = new TextureAtlas(texture,xml)
			}
			return TextureAtlasShow;
		}
		
		
		[Embed(source="../resources/assets/solider/solider_attack.png")]
		public static const TextureAttack:Class
		[Embed(source="../resources/assets/solider/solider_attack.xml",mimeType="application/octet-stream")]
		public static const XmlAttack:Class
		public static var strTextureAttack:String = "TextureAttack"

		public static var TextureAtlasAttack:TextureAtlas

		public static function getAtlasAttack():TextureAtlas
		{		
			if(TextureAtlasAttack == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureAttack)
				var xml:XML = XML(new XmlAttack());
				TextureAtlasAttack = new TextureAtlas(texture,xml)
			}
		return TextureAtlasAttack;
		}
		
		
		[Embed(source="../resources/assets/solider/solider_wait.png")]
		public static const TextureWait:Class
		[Embed(source="../resources/assets/solider/solider_wait.xml",mimeType="application/octet-stream")]
		public static const XmlWait:Class
		public static var strTextureWait:String = "TextureWait"
		
		public static var TextureAtlasWait:TextureAtlas
		
		public static function getAtlasWait():TextureAtlas
		{		
			if(TextureAtlasWait == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureWait)
				var xml:XML = XML(new XmlWait());
				TextureAtlasWait = new TextureAtlas(texture,xml)
			}
			return TextureAtlasWait;
		}
		
		[Embed(source="../resources/assets/solider/solider_die.png")]
		public static const TextureDie:Class
		[Embed(source="../resources/assets/solider/solider_die.xml",mimeType="application/octet-stream")]
		public static const XmlDie:Class
		public static var strTextureDie:String = "TextureDie"
		
		public static var TextureAtlasDie:TextureAtlas
		
		public static function getAtlasDie():TextureAtlas
		{		
			if(TextureAtlasDie == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureDie)
				var xml:XML = XML(new XmlDie());
				TextureAtlasDie = new TextureAtlas(texture,xml)
			}
			return TextureAtlasDie;
		}
		
		[Embed(source="../resources/assets/solider/solider_affect.png")]
		public static const TextureAffect:Class
		[Embed(source="../resources/assets/solider/solider_affect.xml",mimeType="application/octet-stream")]
		public static const XmlAffect:Class
		public static var strTextureAffect:String = "TextureAffect"
		
		public static var TextureAtlasAffect:TextureAtlas
		
		public static function getAtlasAffect():TextureAtlas
		{		
			if(TextureAtlasAffect == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureAffect)
				var xml:XML = XML(new XmlAffect());
				TextureAtlasAffect = new TextureAtlas(texture,xml)
			}
			return TextureAtlasAffect;
		}
		
		[Embed(source="../resources/assets/solider/soliderAll.png")]
		public static const TextureAll:Class
		[Embed(source="../resources/assets/solider/soliderAll.xml",mimeType="application/octet-stream")]
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
				var bitmap:Bitmap = new GetSoliderMCHandler[name]();
				gameTextures[name] = starling.textures.Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
		
	}
}