package game.ui.life
{
	import game.ui.Life;
	
	import resources.GetLifeMCHandler;
	import resources.GetStartCountDownMCHandler;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	public class life_right extends Life
	{
		
	//	private var m_mclife:MovieClip
		public function life_right()
		{
			super();
			this.addChild(fnInitLifeBase());
			this.addChild(fnInitLifeAni());
			this.addChild(m_txtLife);
		}
		
		private function fnInitLifeAni():MovieClip
		{
			m_mcLife = new starling.display.MovieClip(GetLifeMCHandler.getAtlasLifeRight().getTextures("lifePoint"),24);
			return m_mcLife;
		}
		
		/*override protected function fnShowLifeAni():void
		{
			m_mcLife.loop=false;
			Starling.juggler.add(m_mcLife);
			m_mcLife.stop();
			m_mcLife.play();
		}
		*/
		
	}
}