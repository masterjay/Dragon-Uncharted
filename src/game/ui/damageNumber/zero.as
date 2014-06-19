package game.ui.damageNumber
{
	import base.TiDamageNumber;
	
	
	import resources.GetDamageNumberMCHandler;
	
	import starling.display.MovieClip;
	
	
	public class zero extends TiDamageNumber
	{
		public function zero()
		{
			super();
			this.addChild(fnInitZero());
			
			
		}
		private static var m_Instance:zero;
		
		
		private function fnInitZero():MovieClip
		{
			if(m_mcNumber === null)
			{
				m_mcNumber = new starling.display.MovieClip(GetDamageNumberMCHandler.getAtlasZero().getTextures("damage_number"),24);
				fnInitNumber()
			}
			return m_mcNumber;
		}
		
		
		
	}
}