package game.ui
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.themes.MetalWorksMobileTheme;
	
	import resources.GetAllResourcesHandler;
	import resources.GetStartCountDownMCHandler;
	import resources.GetTextureHandler;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	public class Life extends Sprite
	{
		protected var m_txtLife:TextField
		private var m_nAllLife:int
		private var m_imgLifeBase:Image
		private var m_bUseQuestion:Boolean =false;
		protected var m_mcLife:MovieClip
		private var m_nStopFrame:int
		
		public function Life()
		{
			super();
			new MetalWorksMobileTheme();
			m_txtLife = new TextField(190,24,"?????? / ??????","myFont",24,0xffffff);
			
			m_txtLife.hAlign =HAlign.CENTER
			m_txtLife.border=false;
		}
		
		protected function fnInitLifeBase():Image
		{
		//	m_imgLifeBase = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strLIFE_BASE_BASE));
			m_imgLifeBase = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("life_base"));

			m_imgLifeBase.x = -19;
			m_imgLifeBase.y = -6
			return m_imgLifeBase;
		}
		
		public function fnInitLife(nAllLife:int,nLife:int,bUseQuestion:Boolean):void
		{
			
			m_nAllLife = nAllLife
			m_bUseQuestion = bUseQuestion;
			fnUpdateLife(nLife);
			fnShowLifeAni(nLife);
		}
		protected function fnShowLifeAni(nLife:int):void
		{
			var nPercent:Number = (nLife/m_nAllLife)*m_mcLife.numFrames;
			m_nStopFrame = Math.round(nPercent);
			
			m_mcLife.loop=false;
			m_mcLife.addEventListener(EnterFrameEvent.ENTER_FRAME,fnLifeEnterFrame);
			Starling.juggler.add(m_mcLife);
			m_mcLife.stop();
			m_mcLife.play();
		}
		
		private function fnLifeEnterFrame(e:Event):void
		{
			if(m_mcLife.currentFrame == m_nStopFrame)
			{
				m_mcLife.pause();
			}
		}
		
		
		public function fnShowLife(nValue:int):void
		{
			fnUpdateLife(nValue);
			fnPercent(nValue);
		}
		
		private function fnUpdateLife(nValue:int):void
		{
			if(m_bUseQuestion)
			{
				m_txtLife.text=  "?????? / ??????";
			}
			else
			{
				m_txtLife.text=  nValue +" / "+ m_nAllLife;
			}
			
			
		}
		
		private function fnPercent(nValue:int):void
		{
			if(m_mcLife == null)
			{
				return;
			}
		
				var nPercent:Number = (nValue/m_nAllLife)*m_mcLife.numFrames;
				var nFrame:int = Math.round(nPercent);
				if(nFrame == 50)
				{
					nFrame = 49
				}
					m_mcLife.currentFrame = nFrame
					m_mcLife.pause();
			
				
				if(nPercent<15)
				{
					m_bUseQuestion =false
					fnUpdateLife(nValue)
				}
			
			
		}
		
		public function fnResetLife():void
		{
			m_txtLife.text=  "?????? / ??????";
			m_mcLife.currentFrame = 0
			m_mcLife.pause();
		}
	}
}