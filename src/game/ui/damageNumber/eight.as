package game.ui.damageNumber
{
	import base.TiDamageNumber;
	
	import resources.GetDamageNumberMCHandler;
	
	import starling.display.MovieClip;
	
	
	public class eight extends TiDamageNumber
	{
		public function eight()
		{
			super();
			this.addChild(fnInit());
			
			
		}
		
		
		
		private function fnInit():MovieClip
		{
			if(m_mcNumber === null)
			{
				m_mcNumber = new starling.display.MovieClip(GetDamageNumberMCHandler.getAtlasEight().getTextures("damage_number"),24);
				fnInitNumber()
			}
			return m_mcNumber;
		}
		
		
		
	}
}