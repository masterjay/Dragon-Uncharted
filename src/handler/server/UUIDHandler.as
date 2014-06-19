package handler.server
{
	import com.laiyonghao.Uuid;

	public class UUIDHandler
	{
		public function UUIDHandler()
		{
			
		}
		//player 1 :A97445FAA85C24AC41D26A2511D26EBB
		//player 2 :A9763BA5A85D0B4141CDF4A96F645788

		private var strUUID:String
		private var strReplace:String;
		public function fnCreateUUID():void
		{
			var uuid:Uuid = new Uuid();
			strUUID = uuid.toString();
			
			for(var i:int = 0;i< 4;i++)
			{
				strUUID = strUUID.replace("-","");
				trace(strUUID)
			}
		
		}
		
		
		
	}
}