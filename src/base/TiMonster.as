package base
{
	
	import event.TiBattleEvent;
	
	import feathers.controls.Button;
	import feathers.themes.MetalWorksMobileTheme;
	
	import model.modelEnemy;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	

	public class TiMonster extends Sprite
	{
		public function TiMonster()
		{
		}
		//private var m_mcMonster:TiMonster
		private var m_nAttackCD:int=1
		private var m_nAttackCDcount:int=1
		private var m_nMaxHp:int=100	
		public var m_nHp:int
		private var m_nAttackValue:int
		private var m_nMonsterAttackPoint:int = 300 
	//	private var m_nDiePoint:int
		private var m_other:modelEnemy = modelEnemy.fnGetInstance();
		
		protected var m_mcAttack:starling.display.MovieClip
		protected var m_mcWait:starling.display.MovieClip;
		protected var m_mcDie:MovieClip;
		protected var m_mcAffect:MovieClip;
		protected var m_mcShow:MovieClip;
		protected var m_txtCD:TextField
		
		protected var bDispatch:Boolean=false;
		public function fnInit(nMaxHp,nHp:int):void
		{
			this.removeChild(m_txtCD);
		//	m_mcMonster =mc;
		//	m_nAttackCD = nAttackCD  
		//	m_nAttackCDcount = m_nAttackCD
			m_nMaxHp = nMaxHp
			m_nHp = nHp;
		//	m_nMonsterAttackPoint = nAttackPoint
		//	m_nDiePoint = nDiePoint
			fnHide();
			m_txtCD =new TextField(100,20,"","myFont",20,0xffffff);
			m_txtCD.hAlign = HAlign.LEFT
			//this.addChild(m_txtCD);
			
			fnCurrentCD(m_nAttackCDcount)
		//	var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_INIT_FINISH_EVENT)
			//	dispatchEvent( ev);

		}
		
		private function fnHide():void
		{
			this.m_mcShow.visible =false;
			this.m_mcWait.visible =false;
			this.m_mcAttack.visible = false;
			this.m_mcAffect.visible =false;
			this.m_mcDie.visible = false;
		}
		
		public function fnShowtoStage():void
		{
			fnHide();
			this.m_mcShow.visible = true;
			m_mcShow.addEventListener(Event.COMPLETE,fnShowtoStageFinish);
			m_mcShow.addEventListener(EnterFrameEvent.ENTER_FRAME,fnPlayShowSound);
			starling.core.Starling.juggler.add(m_mcShow);

		}
		
		public function fnWaiting():void
		{
			fnWait();
		}
		
		protected function fnPlayShowSound(e:Event):void
		{
			
		}
		private function fnShowtoStageFinish(e:Event):void
		{
			starling.core.Starling.juggler.remove(m_mcShow);
			m_mcShow.removeEventListeners()
			fnWait();
			
		}
		
		private function fnAttack():void
		{
			fnHide();
			this.m_mcAttack.visible = true;
			m_mcAttack.addEventListener(Event.COMPLETE,fnAttackFinish);
			m_mcAttack.addEventListener(EnterFrameEvent.ENTER_FRAME,fnHitHost);
			starling.core.Starling.juggler.add(m_mcAttack);
			m_mcAttack.loop=false;
			m_mcAttack.stop();
			m_mcAttack.play();
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_ATTACT_EVENT)
		//	ev.m_eventArgs = m_nMonsterAttackPoint
			ev.m_eventArgs = m_other.attack;
			dispatchEvent(ev);
		}
		
		protected function fnHitHost(e:Event):void
		{
			//var mc:MovieClip = e.currentTarget as MovieClip
			//if(mc.currentFrameLabel == "HIT")
			//{
			//	var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_HIT_HOST_EVENT)
				//dispatchEvent(ev);
			//}	
		}
		
		private function fnAttackFinish(e:Event):void
		{
			m_mcAttack.removeEventListeners();
			starling.core.Starling.juggler.remove(m_mcAttack);
			m_mcAttack.removeEventListener(EnterFrameEvent.ENTER_FRAME,fnHitHost);
			fnWait();
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_ATTACT_FINISH_EVENT)
			dispatchEvent(ev);
			var ev2:TiBattleEvent =new TiBattleEvent(TiBattleEvent.ROUND_FINISH_EVENT)
			dispatchEvent(ev2);
		}
			
			 
		
		
		public function fnSufferValue(nValue:int):void
		{
			m_nAttackValue = nValue
			
		}
		
		public function fnHit():void
		{
			fnHide();
			this.m_mcAffect.visible = true;
			m_mcAffect.addEventListener(Event.COMPLETE,fnSufferFinish);
			starling.core.Starling.juggler.add(m_mcAffect);
			m_mcAffect.loop=false;
			m_mcAffect.stop();
			m_mcAffect.play();
		}
		
		private function fnSufferFinish(e:Event):void
		{
			
				m_mcAffect.removeEventListener(Event.ENTER_FRAME,fnSufferFinish);
				starling.core.Starling.juggler.remove(m_mcAffect);

				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_SUFFER_FINISH_EVENT)
				dispatchEvent(ev);
				fnWait();
			
		}
		
		public function fnHostAttackFinish():void
		{
			m_nHp-=m_nAttackValue
			if(m_nHp<=0)
			{
				m_nHp = 0;
				fnDie()
			}	
			else
			{
				fnCountDownAttack();
			}
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.SHOW_MONSTER_LIFE_EVENT);
			dispatchEvent(ev);
		}
		
		private function fnDie():void
		{
			
			fnHide();
			this.m_mcDie.visible = true;
			m_mcDie.addEventListener(Event.COMPLETE,fnDieFinish);
			m_mcDie.addEventListener(EnterFrameEvent.ENTER_FRAME,fnPlayDieSound);
			starling.core.Starling.juggler.add(m_mcDie);
			m_mcDie.loop=false
			m_mcDie.stop();
			m_mcDie.play();
			
		}
		
		protected function fnPlayDieSound(e:Event):void
		{
			
		}
		
		private function fnDieFinish(e:Event):void
		{
			fnHide();
			m_mcDie.removeEventListeners()
			starling.core.Starling.juggler.remove(m_mcDie);
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_DIE_FINISH_EVENT)
		//	ev.m_eventArgs = m_nDiePoint
			dispatchEvent(ev);	
			var ev2:TiBattleEvent =new TiBattleEvent(TiBattleEvent.ROUND_FINISH_EVENT)
			dispatchEvent(ev2);
			
			
		}
		private function fnCountDownAttack():void
		{
			m_nAttackCDcount-- 
			if(m_nAttackCDcount == 0)
			{
				fnAttack()
				m_nAttackCDcount = m_nAttackCD
			}
			else
			{
				fnWait();
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.ROUND_FINISH_EVENT)
				dispatchEvent(ev);
			}
			fnCurrentCD(m_nAttackCDcount)
		}
		
		protected function fnCurrentCD(nAttactCDcount:int):void
		{
			m_txtCD.text = "cd "+ nAttactCDcount;
		}
		
		public function fnMonsterAttactCountDownMinus():void
		{
			fnCountDownAttack();
		}
		
		private function fnWait():void
		{
			fnHide();
			this.m_mcWait.visible =true;
			starling.core.Starling.juggler.add(m_mcWait);

		}
		
		protected function fnResetDispatch(mc:MovieClip):void
		{
			var nTotalFrames:int = mc.numFrames
			nTotalFrames--
			if(nTotalFrames == mc.currentFrame && bDispatch==true)
			{
				bDispatch = false;
				//trace("bDispatch =false")
			}
		}
		
		public function fnResetData():void
		{
			
		}
	}
}