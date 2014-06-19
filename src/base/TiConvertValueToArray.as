package base
{
	public class TiConvertValueToArray
	{
		public function TiConvertValueToArray()
		{
		}
		
		public static function fnConvertValueToArray(nScore:int):Array
		{
			var ar:Array =new Array();
			for(var i:int=0 ; ;i++)
			{
				var str:String = nScore.toString().charAt(i); 
				if(str=="")
				{
					break;
				}
				else
				{
					ar.push(str);
				}
			}
			return ar;
		}
	}
}