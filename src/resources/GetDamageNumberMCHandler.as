package resources
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class GetDamageNumberMCHandler extends Sprite
	{
		public function GetDamageNumberMCHandler()
		{
			super();
		}
		
		private static var gameTextures:Dictionary = new Dictionary();
		
		[Embed(source="../resources/assets/damageNumber/damage_number0.png")]
		public static const TextureZero:Class
		[Embed(source="../resources/assets/damageNumber/damage_number0.xml",mimeType="application/octet-stream")]
		public static const XmlZero:Class
		public static var strTextureZero:String = "TextureZero"
		
		public static var TextureAtlasZero:TextureAtlas
		
		public static function getAtlasZero():TextureAtlas
		{		
			if(TextureAtlasZero == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureZero)
				var xml:XML = XML(new XmlZero());
				TextureAtlasZero = new TextureAtlas(texture,xml)
			}
			return TextureAtlasZero;
		}
		
		
		
		[Embed(source="../resources/assets/damageNumber/damage_number1.png")]
		public static const TextureOne:Class
		[Embed(source="../resources/assets/damageNumber/damage_number1.xml",mimeType="application/octet-stream")]
		public static const XmlOne:Class
		public static var strTextureOne:String = "TextureOne"
		
		public static var TextureAtlasOne:TextureAtlas
		
		public static function getAtlasOne():TextureAtlas
		{		
			if(TextureAtlasOne == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureOne)
				var xml:XML = XML(new XmlOne());
				TextureAtlasOne = new TextureAtlas(texture,xml)
			}
			return TextureAtlasOne;
		}
		
		[Embed(source="../resources/assets/damageNumber/damage_number2.png")]
		public static const TextureTwo:Class
		[Embed(source="../resources/assets/damageNumber/damage_number2.xml",mimeType="application/octet-stream")]
		public static const XmlTwo:Class
		public static var strTextureTwo:String = "TextureTwo"
		
		public static var TextureAtlasTwo:TextureAtlas
		
		public static function getAtlasTwo():TextureAtlas
		{		
			if(TextureAtlasTwo == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureTwo)
				var xml:XML = XML(new XmlTwo());
				TextureAtlasTwo = new TextureAtlas(texture,xml)
			}
			return TextureAtlasTwo;
		}
		
		
		[Embed(source="../resources/assets/damageNumber/damage_number3.png")]
		public static const TextureThree:Class
		[Embed(source="../resources/assets/damageNumber/damage_number3.xml",mimeType="application/octet-stream")]
		public static const XmlThree:Class
		public static var strTextureThree:String = "TextureThree"
		
		public static var TextureAtlasThree:TextureAtlas
		
		public static function getAtlasThree():TextureAtlas
		{		
			if(TextureAtlasThree == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureThree)
				var xml:XML = XML(new XmlThree());
				TextureAtlasThree = new TextureAtlas(texture,xml)
			}
			return TextureAtlasThree;
		}
		
		[Embed(source="../resources/assets/damageNumber/damage_number4.png")]
		public static const TextureFour:Class
		[Embed(source="../resources/assets/damageNumber/damage_number4.xml",mimeType="application/octet-stream")]
		public static const XmlFour:Class
		public static var strTextureFour:String = "TextureFour"
		
		public static var TextureAtlasFour:TextureAtlas
		
		public static function getAtlasFour():TextureAtlas
		{		
			if(TextureAtlasFour == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureFour)
				var xml:XML = XML(new XmlFour());
				TextureAtlasFour = new TextureAtlas(texture,xml)
			}
			return TextureAtlasFour;
		}
		
		[Embed(source="../resources/assets/damageNumber/damage_number5.png")]
		public static const TextureFive:Class
		[Embed(source="../resources/assets/damageNumber/damage_number5.xml",mimeType="application/octet-stream")]
		public static const XmlFive:Class
		public static var strTextureFive:String = "TextureFive"
		
		public static var TextureAtlasFive:TextureAtlas
		
		public static function getAtlasFive():TextureAtlas
		{		
			if(TextureAtlasFive == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureFive)
				var xml:XML = XML(new XmlFive());
				TextureAtlasFive = new TextureAtlas(texture,xml)
			}
			return TextureAtlasFive;
		}
		
		[Embed(source="../resources/assets/damageNumber/damage_number6.png")]
		public static const TextureSix:Class
		[Embed(source="../resources/assets/damageNumber/damage_number6.xml",mimeType="application/octet-stream")]
		public static const XmlSix:Class
		public static var strTextureSix:String = "TextureSix"
		
		public static var TextureAtlasSix:TextureAtlas
		
		public static function getAtlasSix():TextureAtlas
		{		
			if(TextureAtlasSix == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureSix)
				var xml:XML = XML(new XmlSix());
				TextureAtlasSix = new TextureAtlas(texture,xml)
			}
			return TextureAtlasSix;
		}
		
		[Embed(source="../resources/assets/damageNumber/damage_number7.png")]
		public static const TextureSeven:Class
		[Embed(source="../resources/assets/damageNumber/damage_number7.xml",mimeType="application/octet-stream")]
		public static const XmlSeven:Class
		public static var strTextureSeven:String = "TextureSeven"
		
		public static var TextureAtlasSeven:TextureAtlas
		
		public static function getAtlasSeven():TextureAtlas
		{		
			if(TextureAtlasSeven == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureSeven)
				var xml:XML = XML(new XmlSeven());
				TextureAtlasSeven = new TextureAtlas(texture,xml)
			}
			return TextureAtlasSeven;
		}
		
		[Embed(source="../resources/assets/damageNumber/damage_number8.png")]
		public static const TextureEight:Class
		[Embed(source="../resources/assets/damageNumber/damage_number8.xml",mimeType="application/octet-stream")]
		public static const XmlEight:Class
		public static var strTextureEight:String = "TextureEight"
		
		public static var TextureAtlasEight:TextureAtlas
		
		public static function getAtlasEight():TextureAtlas
		{		
			if(TextureAtlasEight == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureEight)
				var xml:XML = XML(new XmlEight());
				TextureAtlasEight = new TextureAtlas(texture,xml)
			}
			return TextureAtlasEight;
		}
		
		[Embed(source="../resources/assets/damageNumber/damage_number9.png")]
		public static const TextureNight:Class
		[Embed(source="../resources/assets/damageNumber/damage_number9.xml",mimeType="application/octet-stream")]
		public static const XmlNight:Class
		public static var strTextureNight:String = "TextureNight"
		
		public static var TextureAtlasNight:TextureAtlas
		
		public static function getAtlasNight():TextureAtlas
		{		
			if(TextureAtlasNight == null)
			{
				var texture:Texture = fnGetMovieClipTexture(strTextureNight)
				var xml:XML = XML(new XmlNight());
				TextureAtlasNight = new TextureAtlas(texture,xml)
			}
			return TextureAtlasNight;
		}
		
		
		private static function fnGetMovieClipTexture(name:String):Texture
		{
			if(gameTextures[name] == undefined)
			{
				var bitmap:Bitmap = new GetDamageNumberMCHandler[name]();
				gameTextures[name] = starling.textures.Texture.fromBitmap(bitmap);
			}
			return gameTextures[name];
		}
		
		
		
	}
}