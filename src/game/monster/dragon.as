package game.monster
{
	
	
	import base.TiMonster;
	
	import config.TiMonsterConfig;
	
	import event.TiBattleEvent;
	
	import handler.TiVoiceCollector;
	
	import resources.GetBossMCHandler;
	import resources.GetDragonMCHandler;
	
	import starling.display.MovieClip;
	import starling.events.Event;
	

	public class dragon extends TiMonster
	{
		private static var m_Instance:dragon;
		
		
		public function dragon()
		{
			this.addChild(fnInitShow());
			this.addChild(fnInitAttack());
			this.addChild(fnInitWait());
			this.addChild(fnInitDie());
			this.addChild(fnInitAffect())
			var ob:MonsterObject = TiMonsterConfig.fnGetMonster(TiMonsterConfig.MONSTER_DRAGON);
		//	fnInit(m_Instance,ob.m_nLife,ob.m_nCD,ob.m_nAttatck,ob.m_LifeHill);
		//	fnHide();
		//	m_txtCD.x = 180;
		//	m_txtCD.y = 20;
		}
		
		private function fnInitShow():MovieClip
		{
			if(m_mcShow == null)
			{
				m_mcShow = new starling.display.MovieClip(GetDragonMCHandler.getAtlasShow().getTextures("appear"),12);
				m_mcShow.x = -20;
				m_mcShow.y = -305;
			}
			return m_mcShow;
		}
		
		private function fnInitAttack():MovieClip
		{
			if(m_mcAttack == null)
			{
				m_mcAttack = new starling.display.MovieClip(GetDragonMCHandler.getAtlasAttack().getTextures("attack"),40);
				m_mcAttack.x = -570;
				m_mcAttack.y = -76;
			}
			return m_mcAttack;
		}
		
		private function fnInitWait():MovieClip
		{
			if(m_mcWait == null)
			{
				m_mcWait = new starling.display.MovieClip(GetDragonMCHandler.getAtlasWait().getTextures("wait"),12);
			}
			return m_mcWait;
		}
		
		private function fnInitDie():MovieClip
		{
			if(m_mcDie == null)
			{
				m_mcDie = new starling.display.MovieClip(GetDragonMCHandler.getAtlasDie().getTextures("die"),22);
				m_mcDie.x=-128;
				m_mcDie.y=-51
			}
			return m_mcDie;
		}
		
		private function fnInitAffect():MovieClip
		{
			if(m_mcAffect == null)
			{
				m_mcAffect = new starling.display.MovieClip(GetDragonMCHandler.getAtlasAffect().getTextures("suffer"),6);
				m_mcAffect.x = 5;
				m_mcAffect.y = -50;
			}
			return m_mcAffect;
		}
		
		override protected function fnPlayShowSound(e:Event):void
		{
			if(m_mcShow.currentFrame == 1 && bDispatch==false)
			{
				bDispatch=true;
				TiVoiceCollector.fnPlayDragonShow();
			}
			fnResetDispatch(m_mcShow);
		}
		override protected function fnHitHost(e:Event):void
		{
			//trace("dragon currentframe "+ m_mcAttack.currentFrame)
			if(m_mcAttack.currentFrame == 10 || m_mcAttack.currentFrame == 20 || m_mcAttack.currentFrame== 30)
			{
				
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_HIT_HOST_EVENT)
				dispatchEvent(ev);
			}
			if(m_mcAttack.currentFrame == 0)
			{
				TiVoiceCollector.fnPlayDragonAttackGathering();
			}
			if(m_mcAttack.currentFrame==10)
			{
				TiVoiceCollector.fnPlayDragonAttack();
			}
		}
		override protected function fnPlayDieSound(e:Event):void
		{
			if(m_mcDie.currentFrame == 7 && bDispatch==false)
			{
				bDispatch = true;
				TiVoiceCollector.fnPlayDragonShow();
			}
			fnResetDispatch(m_mcDie);
		}
		
		override public function fnResetData():void
		{
			var ob:MonsterObject = TiMonsterConfig.fnGetMonster(TiMonsterConfig.MONSTER_DRAGON);
		//	fnInit(m_Instance,ob.m_nLife,ob.m_nCD,ob.m_nAttatck,ob.m_LifeHill);
		//	m_txtCD.x = 180;
		//	m_txtCD.y = 20;
		}
		
		public static function fnGetInstance():dragon
		{
			if (m_Instance == null)
			{
				m_Instance=new dragon();
			}
			return m_Instance;
		}
	}
}