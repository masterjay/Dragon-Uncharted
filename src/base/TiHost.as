package base
{
	
	import config.TiMonsterConfig;
	
	import event.TiBattleEvent;
	
	import game.monster.MonsterObject;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class TiHost extends Sprite
	{
		public function TiHost()
		{
		}
	//	private var m_mcHost:TiHost;
		private var m_nAttackCD:int=1
		private var m_nAttackCDcount:int = 1
		public var m_nHp:int
		private var m_nMaxHp:int
		private var m_nAttackValue:int
		
		protected var m_mcAttack:starling.display.MovieClip
		protected var m_mcWait:starling.display.MovieClip;
		protected var m_mcDie:starling.display.MovieClip;
		protected var m_mcAffect:starling.display.MovieClip;
		protected var m_mcShow:starling.display.MovieClip;
		protected var m_txtName:TextField
		protected var bDispatch:Boolean=false;
		public function fnInit(nMaxHp,nHp):void
		{
		//	m_mcHost =mc;
			//m_nAttackCD = nAttackCD  
			m_nAttackCDcount = m_nAttackCD
			m_nHp = nHp;
			m_nMaxHp = nMaxHp
			fnHide();
			m_txtName =new TextField(100,20,"You","myFont",20,0xffffff);
			m_txtName.hAlign = HAlign.LEFT
			this.addChild(m_txtName);
			m_txtName.x = 60;
			m_txtName.y = -10
			//var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_INIT_FINISH_EVENT)
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
		
		public function fnShowToStage():void
		{
			fnHide();
			this.m_mcShow.visible = true;
			starling.core.Starling.juggler.add(m_mcShow);
			m_mcShow.loop=false;
			m_mcShow.stop()
			m_mcShow.play()
			m_mcShow.addEventListener(starling.events.Event.COMPLETE,fnShowtoStageFinish);
		}
		
		public function fnWaiting():void
		{
			fnWait();
		}
		private function fnShowtoStageFinish(e:starling.events.Event):void
		{
			
			m_mcShow.removeEventListener(starling.events.Event.COMPLETE,fnShowtoStageFinish);
			starling.core.Starling.juggler.remove(m_mcShow);

			fnWait();
			
		}
		
		
		public function fnAttack():void
		{
			//if(m_bAttack)
			{
				//	m_bAttack = false
				fnHide();
				this.m_mcAttack.visible = true;
				m_mcAttack.addEventListener(Event.COMPLETE,fnAttackFinish);
				m_mcAttack.addEventListener(EnterFrameEvent.ENTER_FRAME,fnHitMonster);
				starling.core.Starling.juggler.add(m_mcAttack);
				m_mcAttack.loop=false;
				m_mcAttack.stop();
				m_mcAttack.play();
			}
		}
		
		
		
		protected function fnHitMonster(e:Event):void
		{
			//var mc:MovieClip = e.currentTarget as MovieClip
			//if(mc.currentFrameLabel == "HIT")
			{
			//	var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_HIT_MONSTER_EVENT)
				//dispatchEvent(ev);
			}
		}
		
		private function fnAttackFinish(e:Event=null):void
		{

				

			m_mcAttack.removeEventListener(Event.COMPLETE,fnAttackFinish);
			starling.core.Starling.juggler.remove(m_mcAttack);
		
			fnWait();
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_ATTACT_FINISH_EVENT)
			dispatchEvent(ev);
			 
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
			m_mcAffect.play()
		}
		
		private function fnSufferFinish(e:starling.events.Event):void
		{
			m_mcAffect.removeEventListener(Event.COMPLETE,fnSufferFinish);
			starling.core.Starling.juggler.remove(m_mcAffect);

			fnWait();
			
		}
		
		public function fnMonsterAttackFinish():void
		{
			m_nHp-=m_nAttackValue
			if(m_nHp<=0)
			{
				m_nHp = 0;
				fnDie()
			}	
			else
			{
				fnWait();
			}
			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.SHOW_HOST_LIFE_EVENT)
				dispatchEvent(ev);
		}
		
		private function fnDie():void
		{
			fnHide();
			this.m_mcDie.visible = true;
			starling.core.Starling.juggler.add(m_mcDie);
			m_mcDie.addEventListener(Event.COMPLETE,fnDieFinish);
			m_mcDie.loop=false;
			m_mcDie.stop();
			m_mcDie.play();
		}
		
		private function fnDieFinish(e:starling.events.Event):void
		{
			m_mcDie.removeEventListener(Event.COMPLETE,fnDieFinish);
			starling.core.Starling.juggler.remove(m_mcDie);

			var ev:TiBattleEvent =new TiBattleEvent(TiBattleEvent.HOST_DIE_FINISH_EVENT)
			dispatchEvent(ev);	
			
			
		}
		private function fnCountDownAttact():void
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
			}
		}
		
		private function fnWait():void
		{
			fnHide();
			this.m_mcWait.visible =true;
			starling.core.Starling.juggler.add(m_mcWait);
			
		}
		
		public function fnMonsterDieLifeHill(nPoint:int):void
		{
			m_nHp +=nPoint
			if(m_nHp > m_nMaxHp)
			{
				m_nHp = m_nMaxHp
			}
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