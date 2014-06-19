package game.host
{
	
	
	import base.TiHost;
	
	import config.TiMonsterConfig;
	
	import event.TiBattleEvent;
	import event.TiGameEvent;
	
	import game.monster.MonsterObject;
	
	import handler.TiVoiceCollector;
	
	import model.modelPlayer;
	
	import resources.GetHostMCHandler;
	import resources.GetTextureHandler;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Host extends TiHost
	{
		private static var m_Instance:Host;
		
		
		public function Host()
		{
			
		}
		public function fnLoadResources():void
		{
			this.addChild(fnInitShow());
			this.addChild(fnInitAttack());
			this.addChild(fnInitWait());
			this.addChild(fnInitDie());
			this.addChild(fnInitAffect())
			var player:modelPlayer = modelPlayer.fnGetInstance()
		//	fnInit(m_Instance,1,3000);
			var ev:TiGameEvent =new TiGameEvent(TiGameEvent.LOAD_RESOURCES_FINISH_EVENT);
			dispatchEvent(ev);
		}
		
		private function fnInitShow():MovieClip
		{
			if(m_mcShow == null)
			{
				m_mcShow = new starling.display.MovieClip(GetHostMCHandler.getAtlasHostShow().getTextures("appear"),17);
				m_mcShow.x = -80;
				m_mcShow.y = -120
			}
			return m_mcShow;
		}
		
		private function fnInitAttack():MovieClip
		{
			if(m_mcAttack == null)
			{
				m_mcAttack = new starling.display.MovieClip(GetHostMCHandler.getAtlasHostAttack().getTextures("attack"),19);
				m_mcAttack.x = -27;
				m_mcAttack.y = -53;
			}
			return m_mcAttack;
		}
		
		private function fnInitWait():MovieClip
		{
			if(m_mcWait == null)
			{
				m_mcWait = new starling.display.MovieClip(GetHostMCHandler.getAtlasHostWait().getTextures("wait"),12);
			}
			return m_mcWait;
		}
		
		private function fnInitDie():MovieClip
		{
			if(m_mcDie == null)
			{
				m_mcDie = new starling.display.MovieClip(GetHostMCHandler.getAtlasHostDie().getTextures("die"),22);
				m_mcDie.x = -113
				m_mcDie.y = -45
			}
			return m_mcDie;
		}
		
		private function fnInitAffect():MovieClip
		{
			if(m_mcAffect == null)
			{
				m_mcAffect = new starling.display.MovieClip(GetHostMCHandler.getAtlasHostAffect().getTextures("suffer"),6);
				m_mcAffect.x = -30;
				m_mcAffect.y = -13
			}
			return m_mcAffect;
		}
		
		override protected function fnHitMonster(e:Event):void
		{
			if(m_mcAttack.currentFrame == 8 && bDispatch==false)
			{
				bDispatch=true;
				TiVoiceCollector.fnPlayAttack();
				var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_HIT_MONSTER_EVENT)
				dispatchEvent(ev);
			}
			fnResetDispatch(m_mcAttack);
				
			
		}
		
		override public function fnResetData():void
		{
			fnInit(3000,3000);
		}
		
		public static function fnGetInstance():Host
		{
			if (m_Instance == null)
			{
				m_Instance=new Host();
			}
			return m_Instance;
		}
	}
}