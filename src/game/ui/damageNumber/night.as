package game.ui.damageNumber
{
	import base.TiDamageNumber;
	
	import resources.GetDamageNumberMCHandler;
	
	import starling.display.MovieClip;
	
	
	public class night extends TiDamageNumber
	{
		public function night()
		{
			super();
			this.addChild(fnInit());
			
			
		}
		
		
		
		private function fnInit():MovieClip
		{
			if(m_mcNumber === null)
			{
				m_mcNumber = new starling.display.MovieClip(GetDamageNumberMCHandler.getAtlasNight().getTextures("damage_number"),24);
				fnInitNumber()
			}
			return m_mcNumber;
		}
		
		
		
	}
}