package model
{
	
	public class modelBase
	{
		public function modelBase()
		{
		}
		
		public function decodeJSON($json:String):void
		{
			var obj_:Object = JSON.parse($json);
			//return obj_
			convert(obj_);
		}
		
		public function encodeJSON():String
		{
			return JSON.stringify(this);
		}
		
		public function convert($obj:Object):void
		{
			for( var key:String in $obj )
			{
				if(this.hasOwnProperty(key))
				{
					this[key] = $obj[key];
				}
			}
		}
	}
}