package game
{
	
	
	import event.TiBattleEvent;
	import event.TiGameEvent;
	import event.TiServerEvent;
	
	import feathers.controls.Button;
	import feathers.controls.TextInput;
	import feathers.themes.MetalWorksMobileTheme;
	
	import game.cube.cubeBreak;
	import game.monster.Solider;
	import game.monster.boss;
	import game.ui.damageNumber.zero;
	
	import handler.LoadResourcesHandler;
	import handler.SQLite.playerDataHandler;
	import handler.server.TiSignInHandler;
	
	import model.modelPlayer;
	
	import resources.GetAllResourcesHandler;
	import resources.GetBossMCHandler;
	import resources.GetTextureHandler;
	
	import sound.GameOpenSound;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class LandingPage extends Sprite
	{
		private var m_logo:Image
		private var mcatk:MovieClip
		private var m_boss:boss
		private var m_solider:Solider
		private var m_btnStart:starling.display.Button
		private var m_openingSound:GameOpenSound
		private var m_myFont:TextField
		private var m_tDelayCall:DelayedCall
		//player 1 :A97445FAA85C24AC41D26A2511D26EBB
		//player 2 :A9763BA5A85D0B4141CDF4A96F645788
		private var m_tempSignInPlayerUUID:feathers.controls.Button
		private var m_tempSignINOtherPlayerUUID:feathers.controls.Button
		private var m_signInHandler:TiSignInHandler = new TiSignInHandler();
		private var m_playerDatahandler:playerDataHandler = new playerDataHandler();
		public function LandingPage()
		{
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,fnOnAddToStage);
			super()
		}
	//	private var s:zero = new zero();

		private function fnOnAddToStage(e:Event):void
		{

			
				//m_logo = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strGAME_LOGO));
				m_logo = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("logo_x"));

				this.addChild(m_logo);
			//	m_btnStart = new Button(GetTextureHandler.fnGetTexture(GetTextureHandler.strBUTTON_START));
				m_btnStart = new starling.display.Button(GetAllResourcesHandler.getAtlasAll().getTexture("button_start"));

				m_btnStart.addEventListener(Event.TRIGGERED,fnGameStart);
					
				m_btnStart.x = this.stage.width/2 - m_btnStart.width/2
				m_btnStart.y = this.stage.height/2 + this.stage.height/4 	
					
				trace("stage width " +  this.stage.width + "height " + this.stage.height)
				m_myFont = new TextField(300,50,"Loading...","myFont",48,0xffffff);
				//m_myFont.border = true;
				this.addChild(m_myFont);
				m_myFont.x = (this.stage.width/2)-m_myFont.width/2
				m_myFont.y = this.stage.height - (this.stage.height/4);
				
				m_openingSound = new GameOpenSound();
				m_openingSound.addEventListener(TiGameEvent.SOUND_DOWNLOAD_COMPLETE,fnPlaySound);

				//m_tDelayCall =new DelayedCall(fnDelayCallCompleteHandler,1);
				//Starling.juggler.add(m_tDelayCall);
				
				//s.x = 100;
			//	s.y = 100
				LoadResourcesHandler.fnGetInstance().fnLoadResources();	

				//starling.core.Starling.juggler.add(s.m_mcZero);
				//s.m_mcZero.loop=true;
			//	var b:cubeBreak =new cubeBreak();
				//b.x = 200;
				//b.y =200;
			//	this.addChild(b);
				//b.fnPlayBreakAni();
				new MetalWorksMobileTheme();
				
				 m_tempSignInPlayerUUID = new feathers.controls.Button();
				 m_tempSignInPlayerUUID.label = modelPlayer.fnGetInstance().uuid
				// m_tempSignInPlayerUUID.label = "A97445FAA85C24AC41D26A2511D26EBB";
				// m_tempSignInPlayerUUID.label = "12345678901234567890123456789001"
				 m_tempSignInPlayerUUID.x = 50;
				 m_tempSignInPlayerUUID.y = 350;
				 m_tempSignInPlayerUUID.addEventListener(Event.TRIGGERED,SignInHandler);
				 this.addChild(m_tempSignInPlayerUUID);
				 m_tempSignINOtherPlayerUUID = new feathers.controls.Button();
					m_tempSignINOtherPlayerUUID.label = "12345678901234567890123456789001";
				 // m_tempSignINOtherPlayerUUID.label = "A9763BA5A85D0B4141CDF4A96F645788";
				 m_tempSignINOtherPlayerUUID.x = 50;
				 m_tempSignINOtherPlayerUUID.y = 400;
				 m_tempSignINOtherPlayerUUID.addEventListener(Event.TRIGGERED,SignInHandler);

			//	 this.addChild(m_tempSignINOtherPlayerUUID);
				 
				 
				 var input:TextInput = new TextInput();
				 input.text = "Hello World";
				 input.selectRange( 0, input.text.length );
				// input.addEventListener( Event.CHANGE, input_changeHandler );
				 this.addChild( input );
		}
		
		private function SignInHandler(e:Event):void
		{
			var btn:feathers.controls.Button = e.currentTarget as feathers.controls.Button;
			
			// TODO Auto Generated method stub
			m_signInHandler.addEventListener(TiServerEvent.SERVER_SIGNIN_COMPLETE_EVENT,fnSignComplete);
			m_signInHandler.addEventListener(TiServerEvent.SERVER_ENTER_GAME_COMPLETE_EVENT,fnEnterGameHandler);
			m_signInHandler.Send_SignIn(btn.label);
		}
		
		private function fnSignComplete():void
		{
			// TODO Auto Generated method stub
			m_myFont.visible = false;
			this.addChild(m_btnStart);
			m_tempSignInPlayerUUID.label = "sign in complete"
			m_tempSignInPlayerUUID.removeEventListeners();
			m_tempSignINOtherPlayerUUID.visible = false;
		}
		
		private function fnEnterGameHandler(e:TiServerEvent):void
		{
			fnGameStart();
		}
		
		private function fnPlaySound(e:TiGameEvent):void
		{
			m_openingSound.fnBtnSoundPlay();
			var ev:TiGameEvent = new TiGameEvent(TiGameEvent.INIT_COMPLETE);
			dispatchEvent(ev);
		}
		
		/*private function fnDelayCallCompleteHandler():void
		{
			m_myFont.visible = false;
			this.addChild(m_btnStart);
			Starling.juggler.remove(m_tDelayCall);
		}*/
		
		private function fnGameStart(e:Event=null):void
		{//fntest();
			// TODO Auto Generated method stub
			var ev:TiBattleEvent =new TiBattleEvent(TiGameEvent.NAVIGATION_BATTLE_START_EVENT)
				this.dispatchEvent(ev);
				m_openingSound.fnStopMusic();
				
		}
		
		private function fntest():void
		{//this.addChild(s);
		//	s.m_mcZero.stop();
			//s.m_mcZero.play()
		}
	}
}