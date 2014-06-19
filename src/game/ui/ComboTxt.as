package game.ui
{
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class ComboTxt extends Sprite
	{
		private var m_txtCombo:TextField
		public function ComboTxt()
		{
			super();
			m_txtCombo = new TextField(190,48,"","myFont",48,0xffffff);
			this.addChild(m_txtCombo);
		}
		
		public function fnUpdateComboTxt(nCombo:int):void
		{
			m_txtCombo.text = "Combo :" + nCombo;
		}
		
		public function fnClearComboTxt():void
		{
			m_txtCombo.text ="";
		}
	}
}