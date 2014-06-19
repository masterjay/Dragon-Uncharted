package game
{
	
	import event.TiBattleEvent;
	
	import resources.GetTextureHandler;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class battlePage extends Sprite
	{
		private var m_monsterCo:MonsterCo
		private var m_HostCo:HostCo;
		private var gpA:Sprite
		private var gpB:Sprite
		public function battlePage()
		{
			super();
			this.addEventListener(Event.ENTER_FRAME,fnAddToStaged);
		}
		
		private function fnAddToStaged(e:Event):void
		{
			// TODO Auto Generated method stub
			this.removeEventListener(Event.ENTER_FRAME,fnAddToStaged);
			fnInit();
		}
		
		protected function fnInit():void
		{
			// TODO Auto-generated method stub
			gpA = new Sprite();
			this.addChild(gpA);
			gpB = new Sprite();
			this.addChild(gpB);
			m_monsterCo = new MonsterCo();
			m_monsterCo.addEventListener(TiBattleEvent.MONSTER_ATTACT_EVENT,fnMonsterAttactHandler)
			m_monsterCo.addEventListener(TiBattleEvent.MONSTER_DIE_FINISH_EVENT,fnMonsterDieHandler);
			m_monsterCo.addEventListener(TiBattleEvent.MONSTER_ATTACT_FINISH_EVENT,fnMonsterAttackFinishHandler);
			m_monsterCo.addEventListener(TiBattleEvent.MONSTER_HIT_HOST_EVENT,fnMonsterHitHostHandler);
			m_monsterCo.addEventListener(TiBattleEvent.ROUND_FINISH_EVENT,fnRoundFinishEventHandler);
			m_monsterCo.addEventListener(TiBattleEvent.SUCCESS_EVENT,fnSucessHandler);
			m_monsterCo.addEventListener(TiBattleEvent.BOSS_STAGE,fnBossStageHander);
			m_HostCo = new HostCo();
			m_HostCo.addEventListener(TiBattleEvent.HOST_DIE_FINISH_EVENT,fnHostDieHandler);
			m_HostCo.addEventListener(TiBattleEvent.HOST_ATTACT_FINISH_EVENT,fnHostAttackFinishHandler);
			m_HostCo.addEventListener(TiBattleEvent.HOST_HIT_MONSTER_EVENT,fnHostHitMonsterHandler);
			this.addChild(m_monsterCo);
			this.addChild(m_HostCo);
		}
		
		
		
		public function fnShowToStage():void
		{
			m_monsterCo.fnShowToStage();
			m_HostCo.fnShowToStage()
		}
		
		public function fnAttackMonster(nValue:int):void
		{
			
			gpA.addChild(m_monsterCo);
			gpB.addChild(m_HostCo);
			m_monsterCo.fnSuffer(nValue);
			m_HostCo.fnAttack();
		}
		
		private function fnHostAttackFinishHandler(e:TiBattleEvent):void
		{
			m_monsterCo.fnHostAttackFinish();
		}
		
		private function fnMonsterAttactHandler(e:TiBattleEvent):void
		{
			gpA.addChild(m_HostCo);
			gpB.addChild(m_monsterCo);
			m_HostCo.fnSuffer(e.m_eventArgs);
		}
		
		private function fnMonsterAttackFinishHandler(e:TiBattleEvent):void
		{
			m_HostCo.fnMonsterAttackFinish()
		}
		
		public function fnMonsterAttactCountDownMinus():void
		{
			m_monsterCo.fnMonsterAttactCountDownMinus();
		} 
		
		private function fnMonsterDieHandler(e:TiBattleEvent):void
		{
			m_HostCo.fnMonsterDieLifeHill(e.m_eventArgs)
		}
		
		private function fnHostDieHandler(e:TiBattleEvent):void
		{
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_DIE_FINISH_EVENT)
			dispatchEvent(ev);
		}
		
		private function fnHostHitMonsterHandler(e:TiBattleEvent):void
		{
			m_monsterCo.fnHit()
		}
		
		private function fnMonsterHitHostHandler(e:TiBattleEvent):void
		{
			m_HostCo.fnHit()
		}
		
		private function fnSucessHandler(e:TiBattleEvent):void
		{
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.SUCCESS_EVENT)
			dispatchEvent(ev);
		}
		
		public function fnClear():void
		{
			
			m_HostCo.fnClearHost();
			m_monsterCo.fnClearMonster();
		}
		
		private function fnBossStageHander(e:TiBattleEvent):void
		{
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.BOSS_STAGE)
			dispatchEvent(ev);
		}
		
		private function fnRoundFinishEventHandler(e:TiBattleEvent):void
		{
			// TODO Auto Generated method stub
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.ROUND_FINISH_EVENT)
				dispatchEvent(ev);
		}
	}
}