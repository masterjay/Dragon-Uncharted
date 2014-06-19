package game.monster
{
	import base.TiMonster;
	
	import config.TiMonsterConfig;
	
	import event.TiBattleEvent;
	
	import handler.TiVoiceCollector;
	
	import model.modelEnemy;
	
	import resources.GetSoliderMCHandler;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	import ui.monster.MonsterObject;
	import ui.monster.TiMonsterConfig;
	
	public class Solider extends TiMonster
	{
		public function Solider()
		{
			super();
			this.addChild(fnInitShow());
			this.addChild(fnInitAttack());
			this.addChild(fnInitWait());
			this.addChild(fnInitDie());
			this.addChild(fnInitAffect())
			var ob:MonsterObject = TiMonsterConfig.fnGetMonster(TiMonsterConfig.MONSTER_SOLIDER);
			//fnInit(m_Instance,ob.m_nLife,ob.m_nCD,ob.m_nAttatck,ob.m_LifeHill);
			
			//m_txtCD.x = 130;
			//m_txtCD.y = 0;
		}
		
		private static var m_Instance:Solider;
		
		private function fnInitShow():MovieClip
		{
			if(m_mcShow == null)
			{
				//m_mcShow = new starling.display.MovieClip(GetSoliderMCHandler.getAtlasShow().getTextures("soldier1_in"),17);
				m_mcShow = new starling.display.MovieClip(GetSoliderMCHandler.getAtlasShow().getTextures("soldier1_in"),17);
				
				m_mcShow.x = -38;
				m_mcShow.y = -168
			}
			return m_mcShow;
		}
		
		private function fnInitAttack():MovieClip
		{
			if(m_mcAttack == null)
			{
				m_mcAttack = new starling.display.MovieClip(GetSoliderMCHandler.getAtlasAttack().getTextures("soldier1_atk"),19);
			//	m_mcAttack = new starling.display.MovieClip(GetSoliderMCHandler.getAtlasAll().getTextures("soldier1_atk"),19);
				
				m_mcAttack.x = -270
				m_mcAttack.y = -85;
			}
			return m_mcAttack;
		}
		
		private function fnInitWait():MovieClip
		{
			if(m_mcWait == null)
			{
				m_mcWait = new starling.display.MovieClip(GetSoliderMCHandler.getAtlasWait().getTextures("soldier1_stp"),12);
				
			}
			return m_mcWait;
		}
		
		private function fnInitDie():MovieClip
		{
			if(m_mcDie == null)
			{
				m_mcDie = new starling.display.MovieClip(GetSoliderMCHandler.getAtlasDie().getTextures("soldier1_die"),30);
				m_mcDie.x = -100;
				m_mcDie.y = -75
			}
			return m_mcDie;
		}
		
		private function fnInitAffect():MovieClip
		{
			if(m_mcAffect == null)
			{
				m_mcAffect = new starling.display.MovieClip(GetSoliderMCHandler.getAtlasAffect().getTextures("soldier1_Affect"),6);
				m_mcAffect.x = 25;
				m_mcAffect.y = -5
			}
			return m_mcAffect;
		}
		
		override protected function fnPlayShowSound(e:Event):void
		{
			if(m_mcShow.currentFrame == 7  && bDispatch==false)
			{
				bDispatch=true
				TiVoiceCollector.fnPlayDar();
			}
			fnResetDispatch(m_mcShow);
		}
		
		
		override protected function fnHitHost(e:Event):void
		{
			
			if(m_mcAttack.currentFrame == 7 && bDispatch==false)
			{
				bDispatch=true
			//	trace("m_mcAttack.currentFrame "+ m_mcAttack.currentFrame)
				TiVoiceCollector.fnPlayAttack();
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.MONSTER_HIT_HOST_EVENT)
				dispatchEvent(ev);
			}
			fnResetDispatch(m_mcAttack);
		}
		
		override protected function fnPlayDieSound(e:Event):void
		{	trace("m_mcDie.currentframe " + m_mcDie.currentFrame);
			if(m_mcDie.currentFrame == 1 && bDispatch==false)
			{
				bDispatch=true
				TiVoiceCollector.fnPlayDie();
			}
			fnResetDispatch(m_mcDie);
		}
		
		override public function fnResetData():void
		{
			var ob:MonsterObject = TiMonsterConfig.fnGetMonster(TiMonsterConfig.MONSTER_SOLIDER);
		//	fnInit(m_Instance,ob.m_nLife,ob.m_nCD,ob.m_nAttatck,ob.m_LifeHill);
		//	m_txtCD.x = 130;
		//	m_txtCD.y = 0;
		}
		
		public static function fnGetInstance():Solider
		{
			if (m_Instance == null)
			{
				m_Instance=new Solider();
			}
			return m_Instance;
		}
	}
}