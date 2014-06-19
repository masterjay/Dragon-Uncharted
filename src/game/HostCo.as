package game
{
	import flash.events.Event;
	
	import base.TiConvertValueToArray;
	import base.TiHost;
	
	import event.TiBattleEvent;
	
	import feathers.controls.Label;
	
	import game.host.Host;
	import game.ui.DamegeScore;
	import game.ui.Life;
	import game.ui.life.life_left;
	
	import model.modelPlayer;
	
	import starling.display.Sprite;
	import starling.events.EventDispatcher;
	
	import ui.monster.Host;
	
	public class HostCo extends Sprite
	{
		public function HostCo()
		{
			super();
			mcHostGP = new Sprite();
			this.addChild(mcHostGP);
			
			this.addChild(m_lifePoint);
			m_lifePoint.x = 20;
			m_lifePoint.y = 580;
			this.addChild(m_damageScore);
			m_damageScore.x= 150;
			m_damageScore.y =350;
		}
		private var m_mcHost:TiHost
		private var mcHostGP:Sprite
		private var m_lifePoint:life_left = new life_left();
		private var m_damageScore:DamegeScore =new DamegeScore(); 
		public function fnShowToStage():void
		{
			m_mcHost = game.host.Host.fnGetInstance();
			m_mcHost.fnResetData();
			//m_mcHost.addEventListener(TiBattleEvent.HOST_INIT_FINISH_EVENT,fnHostAddtoStage);
			mcHostGP.addChild(m_mcHost);
			fnHostAddtoStage();
			m_mcHost.x = 80;
			m_mcHost.y = 420;
			
		}
		
		public function fnWaiting():void
		{
			m_mcHost.fnWaiting();
		}
		private function fnHostAddtoStage(e:TiBattleEvent =null):void
		{
			m_mcHost.addEventListener(TiBattleEvent.HOST_DIE_FINISH_EVENT,fnHostDieHandler);
			m_mcHost.addEventListener(TiBattleEvent.HOST_HIT_MONSTER_EVENT,fnHostHitMonsterHandler);
			m_mcHost.addEventListener(TiBattleEvent.HOST_ATTACT_FINISH_EVENT,fnHostAttackFinishHandler);
			m_mcHost.addEventListener(TiBattleEvent.SHOW_HOST_LIFE_EVENT,fnUpdateHostLife);
			
			var player:modelPlayer = modelPlayer.fnGetInstance();
			m_mcHost.fnInit(player.max_hp,player.hp);
			
			m_lifePoint.fnInitLife(player.max_hp,player.hp,false)
			m_mcHost.fnShowToStage()
		}
		public function fnAttack():void
		{
			if(m_mcHost)
			{
				m_mcHost.fnAttack()

			}
		}
		
		private function fnHostHitMonsterHandler(e:TiBattleEvent):void
		{
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_HIT_MONSTER_EVENT)
			dispatchEvent(ev);
		}
		
		private function fnHostAttackFinishHandler(e:TiBattleEvent):void
		{
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_ATTACT_FINISH_EVENT)
			dispatchEvent(ev);
		}
		public function fnSuffer(nValue:int):void
		{
			m_mcHost.fnSufferValue(nValue)
			m_damageScore.fnScore(nValue);
		}
		public function fnHit():void
		{
			m_mcHost.fnHit()
		}
		
		private function fnUpdateHostLife(e:TiBattleEvent):void
		{
			m_lifePoint.fnShowLife(m_mcHost.m_nHp);
			
		}
		
		public function fnMonsterAttackFinish():void
		{
			m_mcHost.fnMonsterAttackFinish()
			m_damageScore.fnShowDamageScore();
		}
		
		public function fnMonsterDieLifeHill(nPoint:int):void
		{
			m_mcHost.fnMonsterDieLifeHill(nPoint);
		//	lifePoint.fnShowLife(m_mcHost.m_nBlood);
		//	fnLifeHillPoint(nPoint)
		}
		
		private function fnLifeHillPoint(nPoint:int):void
		{
			/*mcLifeHill.gotoAndStop(1);
			var arLife:Array = TiConvertValueToArray.fnConvertValueToArray(nPoint);
			for(var i:int = 0 ;; i++)
			{
				if(mcLifeHill.score_point["score"+ (i+1)])
				{
					if(i<arLife.length)
					{
						mcLifeHill.score_point["score"+ (i+1)].gotoAndStop(int(arLife[i])+1);
						mcLifeHill.score_point["score"+ (i+1)].visible = true;
					}
					else
					{
						mcLifeHill.score_point["score"+ (i+1)].visible = false;
					}
				}
				else
				{
					break;
				}
			}
			mcLifeHill.gotoAndPlay(2);
			mcLifeHill.visible = true;*/
			
			 
		}
		
		private function fnHostDieHandler(e:TiBattleEvent):void
		{
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_DIE_FINISH_EVENT)
			dispatchEvent(ev);
		}
		
		public function fnClearHost():void
		{
			mcHostGP.removeChildren();
			m_mcHost =null;
			m_lifePoint.fnResetLife();
		}
		
	}
}