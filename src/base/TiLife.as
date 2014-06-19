package base
{
	import flash.display.MovieClip;
	
	import spark.components.Group;
	
	import feathers.controls.Label;
	
	import starling.display.Sprite;

	public class TiLife extends Sprite
	{
		public function TiLife()
		{
		}
		
		private var m_nAllLife:int  
		private var m_bUseQuestion:Boolean =false;
		private var m_lifeLabel:Label
		
		public function fnInit(nLife:int,bUseQuestion:Boolean):void
		{
			m_nAllLife = nLife
			m_bUseQuestion = bUseQuestion
			fnShowAllLife(nLife)
			m_lifeLabel = new Label();
			this.addChild(m_lifeLabel);
		}
		
		public function fnResetLife():void
		{
			
			
		}
		
		private function fnShowAllLife(nValue:int):void
		{
			
			
			
		}
		
		public function fnShowLife(nValue:int):void
		{
			
			
		}
		
		private function fnScore(nValue:int):void
		{
			
		}
		
		private function fnPercent(nValue:int):void
		{
			
			
		}
		
		
	}
}