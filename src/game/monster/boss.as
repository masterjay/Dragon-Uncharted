package game.monster
{
	
	
	import base.TiMonster;
	
	import event.TiBattleEvent;
	
	import handler.TiVoiceCollector;
	
	import resources.GetBossMCHandler;
	
	import starling.display.MovieClip;
	import starling.events.Event;
	import config.TiMonsterConfig;
	

	public class boss extends TiMonster
	{
		private static var m_Instance:boss;
		
		
		public function boss()
		{
			this.addChild(fnInitShow());
			this.addChild(fnInitAttack());
			this.addChild(fnInitWait());
			this.addChild(fnInitDie());
			this.addChild(fnInitAffect())
			var ob:MonsterObject = TiMonsterConfig.fnGetMonster(TiMonsterConfig.MONSTER_BOSS);
		//	fnInit(m_Instance,ob.m_nLife,ob.m_nCD,ob.m_nAttatck,ob.m_LifeHill);
		//	fnHide();
		//	m_txtCD.x = 130;
		//	m_txtCD.y = 0;
		}
		
		private function fnInitShow():MovieClip
		{
			if(m_mcShow == null)
			{
				m_mcShow = new starling.display.MovieClip(GetBossMCHandler.getAtlasShow().getTextures("boss1_in"),17);
				m_mcShow.x = -38;
				m_mcShow.y = -157
			
			}
			return m_mcShow;
		}
		
		private function fnInitAttack():MovieClip
		{
			if(m_mcAttack == null)
			{
				m_mcAttack = new starling.display.MovieClip(GetBossMCHandler.getAtlasAttack().getTextures("boss1_atk"),19);

				m_mcAttack.x = -269;
				m_mcAttack.y = -66
			}
			return m_mcAttack;
		}
		
		private function fnInitWait():MovieClip
		{
			if(m_mcWait == null)
			{
				m_mcWait = new starling.display.MovieClip(GetBossMCHandler.getAtlasWait().getTextures("boss1_stp"),12);
			}
			return m_mcWait;
		}
		
		private function fnInitDie():MovieClip
		{
			if(m_mcDie == null)
			{
				m_mcDie = new starling.display.MovieClip(GetBossMCHandler.getAtlasDie().getTextures("boss1_die"),22);
				m_mcDie.x = -100;
				m_mcDie.y = -60
			}
			return m_mcDie;
		}
		
		private function fnInitAffect():MovieClip
		{
			if(m_mcAffect == null)
			{
				m_mcAffect = new starling.display.MovieClip(GetBossMCHandler.getAtlasAffect().getTextures("boss1_Affect"),16);
				m_mcAffect.x = 40;
				m_mcAffect.y = -11
			}
			return m_mcAffect;
		}
		override protected function fnPlayShowSound(e:Event):void
		{
			if(m_mcShow.currentFrame == 7 && bDispatch==false)
			{
				bDispatch = true;
				TiVoiceCollector.fnPlayDar();
			}
			fnResetDispatch(m_mcShow);
		}
		
		override protected function fnHitHost(e:Event):void
		{
			if(m_mcAttack.currentFrame == 7 && bDispatch==false)
			{
				bDispatch=true
				TiVoiceCollector.fnPlayAttack();
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_HIT_HOST_EVENT)
				dispatchEvent(ev);
			}
			fnResetDispatch(m_mcAttack);
		}
		override protected function fnPlayDieSound(e:Event):void
		{
			if(m_mcDie.currentFrame == 1  && bDispatch==false)
			{
				bDispatch = true;
				TiVoiceCollector.fnPlayDie();
			}
			fnResetDispatch(m_mcDie);
		}
		
		override public function fnResetData():void
		{
			var ob:MonsterObject = TiMonsterConfig.fnGetMonster(TiMonsterConfig.MONSTER_BOSS);
			//fnInit(m_Instance,ob.m_nLife,ob.m_nCD,ob.m_nAttatck,ob.m_LifeHill);
			//m_txtCD.x = 130;
			//m_txtCD.y = 0;
		}
		
		public static function fnGetInstance():boss
		{
			if (m_Instance == null)
			{
				m_Instance=new boss();
			}
			return m_Instance;
		}
	}
}