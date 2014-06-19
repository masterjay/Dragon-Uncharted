package handler.SQLite
{
	import com.duckleg.SQLite;
	import com.laiyonghao.Uuid;
	
	import flash.events.Event;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	
	import spark.components.HGroup;
	import spark.components.Label;
	
	import event.TiplayerDataHandlerEvent;
	
	import model.modelPlayer;
	
	import starling.display.Sprite;

	public class playerDataHandler extends Sprite
	{
		public function playerDataHandler()
		{
			init();
		}
		private var player:modelPlayer = modelPlayer.fnGetInstance();
		private function init():void{
			var file:File = File.applicationStorageDirectory.resolvePath("user.db");
			var sqlite:SQLite = new SQLite();
			sqlite.addEventListener(SQLEvent.OPEN, openHandler);
			sqlite.open(file);
		}
		
		// ********************************************** event - SQLite
		private function openHandler(ev:SQLEvent):void
		{
			var sqlite:SQLite = ev.target as SQLite;
			if(sqlite.firstConnect)
			{
				var uuid:String = fnCreateUUID();
				sqlite.execute("CREATE TABLE tbUser (id INTEGER PRIMARY KEY ASC, uuid TEXT);");
				sqlite.execute("INSERT INTO tbUser (uuid) VALUES ('"+uuid+"');");
				player.uuid = uuid
			}
			else
			{
				sqlite = SQLite.getInstance();
				sqlite.addEventListener(SQLEvent.RESULT, resultHandler);
				sqlite.query("SELECT uuid FROM tbUser");
				
			}
		}
		
		private function fnCreateUUID():String
		{
			var uuid:Uuid = new Uuid();
			var strUUID:String = uuid.toString();
			
			for(var i:int = 0;i< 4;i++)
			{
				strUUID = strUUID.replace("-","");
				trace(strUUID)
			}
			return strUUID
		}
			
		
		private function resultHandler(e:SQLEvent):void
		{
			var sqlite:SQLite = e.target as SQLite;
			
			if(sqlite.lastData!=null)
			{
				var data:Array = sqlite.lastData;
				for(var i:int=0; i<data.length; i++)
				{
					player.uuid = data[i].uuid;
				}
			}
			var ev:TiplayerDataHandlerEvent = new TiplayerDataHandlerEvent(TiplayerDataHandlerEvent.PLAYER_DATA_LOAD_COMPLETE);
			dispatchEvent(ev);
		}
	}
}