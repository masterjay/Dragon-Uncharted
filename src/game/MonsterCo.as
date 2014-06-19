package game
{
	
	import base.TiMonster;
	
	import config.TiMonsterConfig;
	
	import event.TiBattleEvent;
	
	import game.monster.Solider;
	import game.monster.boss;
	import game.monster.dragon;
	import game.ui.DamegeScore;
	import game.ui.Life;
	import game.ui.life.life_right;
	
	import model.modelEnemy;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	
	
	public class MonsterCo extends Sprite
	{
		public function MonsterCo()
		{
			super();
			this.addChild(monsterGp);
			this.addChild(m_lifePoint);
			m_lifePoint.x=270;
			m_lifePoint.y=580
			this.addChild(m_damageScore);
			m_damageScore.x= 350;
			m_damageScore.y =350;
		}
		public var m_mcMonster:TiMonster 
	//	public var m_mcHost:TiMonster =new TiMonster();
		private var monsterGp:Sprite = new Sprite();
		private var m_lifePoint:life_right = new life_right(); 
		private var m_damageScore:DamegeScore =new DamegeScore(); 
		
		public function fnMonsterAttactCountDownMinus():void
		{
			m_mcMonster.fnMonsterAttactCountDownMinus();
		} 
		
		
		public function fnShowToStage():void
		{
			monsterGp.removeChildren()
			if(TiMonsterConfig.m_nNextPoint == TiMonsterConfig.arMonsterList.length)
			{
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.SUCCESS_EVENT)
				dispatchEvent(ev);
				return;
			}
			m_mcMonster =fnGetMonster( TiMonsterConfig.arMonsterList[TiMonsterConfig.m_nNextPoint])
			m_mcMonster.addEventListener(TiBattleEvent.MONSTER_SUFFER_FINISH_EVENT,fnSufferFinishHandler);
			m_mcMonster.addEventListener(TiBattleEvent.MONSTER_ATTACT_FINISH_EVENT,fnMonsterAttackFinishHandler);
			m_mcMonster.addEventListener(TiBattleEvent.MONSTER_ATTACT_EVENT,fnMonsterAttackHandler);
			m_mcMonster.addEventListener(TiBattleEvent.MONSTER_DIE_FINISH_EVENT,fnDieFinishHandler);
			m_mcMonster.addEventListener(TiBattleEvent.SHOW_MONSTER_LIFE_EVENT,fnUpdateMonsterLife);
			m_mcMonster.addEventListener(TiBattleEvent.MONSTER_HIT_HOST_EVENT,fnHitHostHandler);
			m_mcMonster.addEventListener(TiBattleEvent.ROUND_FINISH_EVENT,fnRoundFinishEventHandler);
			fnMonsterAddtoStage();
			
			
			
		}
		
		private function fnGetMonster(str:String):TiMonster
		{
			var monster:TiMonster =  null
			switch(str)
			{
				case TiMonsterConfig.MONSTER_SOLIDER:
					monster = Solider.fnGetInstance() 
					//	monster.x = mcSoliderGp.x
					//	monster.y = mcSoliderGp.y
					monster.x = 250;
					monster.y = 400
					break;
				case TiMonsterConfig.MONSTER_BOSS:
					monster =  boss.fnGetInstance()
					//	monster.x =mcBossGp.x
					//	monster.y =mcBossGp.y
					monster.x = 250;
					monster.y = 390
					break;
				case TiMonsterConfig.MONSTER_DRAGON:
					monster = dragon.fnGetInstance()
					monster.x = 250;
					monster.y = 360
					break;
			}
		//	monster.addEventListener(TiBattleEvent.MONSTER_INIT_FINISH_EVENT,fnMonsterAddtoStage);
			monsterGp.addChild(monster);
			return monster;
		}
		
		private function fnMonsterAddtoStage():void
		{
		;
			var other:modelEnemy = modelEnemy.fnGetInstance();
			m_mcMonster.fnInit(other.max_hp,other.hp);
			if(TiMonsterConfig.m_nNextPoint ==2)
			{
				m_lifePoint.fnInitLife(other.max_hp,other.hp,true);
				var ev:TiBattleEvent = new TiBattleEvent(TiBattleEvent.BOSS_STAGE);
				dispatchEvent(ev);
			}
			else
			{
				m_lifePoint.fnInitLife(other.max_hp,other.hp,false);
		//		m_lifePoint.fnInitLife(m_mcMonster.m_nLife,false);		
			}
			
			//TiMonsterConfig.m_nNextPoint++
			if(TiMonsterConfig.m_nNextPoint==TiMonsterConfig.arMonsterList.length)
			{
				//	m_nNextPoint = 0;
				
			} 
			m_mcMonster.fnShowtoStage()
		}
		
		public function fnSuffer(nValue:int):void
		{
			if(m_mcMonster)
			{
				m_mcMonster.fnSufferValue(nValue);

			}
			else
			{
				fnRoundFinishEventHandler();
			}
			if(m_damageScore)
			{
				m_damageScore.fnScore(nValue);

			}
			
		}
		
		public function fnHit():void
		{	if(m_mcMonster)
			{
				m_mcMonster.fnHit();
			}
			
		}
		
		public function fnHostAttackFinish():void
		{
			m_mcMonster.fnHostAttackFinish()
			m_damageScore.fnShowDamageScore();
		}
		
		private function fnSufferFinishHandler(e:Event):void
		{
			var ev:TiBattleEvent = new TiBattleEvent(TiBattleEvent.MONSTER_SUFFER_FINISH_EVENT)
			dispatchEvent(ev);
			
			
		}
		
		private function fnUpdateMonsterLife(e:TiBattleEvent):void
		{
			m_lifePoint.fnShowLife(m_mcMonster.m_nHp);
		}
		
		private function fnMonsterAttackFinishHandler(e:Event):void
		{
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_ATTACT_FINISH_EVENT)
			dispatchEvent(ev);
		}
		
		private function fnDieFinishHandler(e:TiBattleEvent):void
		{
		//	m_mcMonster.visible =false;
			m_mcMonster.fnResetData();
			fnShowToStage()
			var ev:TiBattleEvent = new TiBattleEvent(TiBattleEvent.MONSTER_DIE_FINISH_EVENT)
			ev.m_eventArgs = e.m_eventArgs
			dispatchEvent(ev);
		}
		
		private function fnHitHostHandler(e:TiBattleEvent):void
		{
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_HIT_HOST_EVENT);
			dispatchEvent(ev);
		}
		
		private function fnMonsterAttackHandler(e:TiBattleEvent):void
		{
			var ev:TiBattleEvent = new TiBattleEvent(TiBattleEvent.MONSTER_ATTACT_EVENT)
			ev.m_eventArgs = e.m_eventArgs
			dispatchEvent(ev);
		}
		
		
		
		public function fnClearMonster():void
		{
			if(m_mcMonster)
			{
				m_mcMonster.removeEventListener(TiBattleEvent.MONSTER_SUFFER_FINISH_EVENT,fnSufferFinishHandler);
				m_mcMonster.removeEventListener(TiBattleEvent.MONSTER_ATTACT_FINISH_EVENT,fnMonsterAttackFinishHandler);
				m_mcMonster.removeEventListener(TiBattleEvent.MONSTER_ATTACT_EVENT,fnMonsterAttackHandler);
				m_mcMonster.removeEventListener(TiBattleEvent.MONSTER_DIE_FINISH_EVENT,fnDieFinishHandler);
				m_mcMonster.removeEventListener(TiBattleEvent.SHOW_MONSTER_LIFE_EVENT,fnUpdateMonsterLife);
				m_mcMonster.removeEventListener(TiBattleEvent.MONSTER_HIT_HOST_EVENT,fnHitHostHandler);
				m_mcMonster.removeEventListener(TiBattleEvent.ROUND_FINISH_EVENT,fnRoundFinishEventHandler);
				m_mcMonster = null
			}
			
			monsterGp.removeChildren()
			
			m_lifePoint.fnResetLife();
		}
		
		public function fnRoundFinishEventHandler(e:TiBattleEvent = null):void
		{
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.ROUND_FINISH_EVENT)
			dispatchEvent(ev);
		}
	}
}