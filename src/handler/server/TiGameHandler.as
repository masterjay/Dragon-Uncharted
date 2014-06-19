package handler.server
{
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	import flash.utils.setTimeout;
	
	import config.TiServerConst;
	
	import enum.enumGameState;
	import enum.enumRoundState;
	
	import event.TiGameEvent;
	import event.TiGameFlowEvent;
	import event.TiServerEvent;
	
	import model.modelBase;
	import model.modelEnemy;
	import model.modelEnterGameComplete;
	import model.modelGame;
	import model.modelPlayer;
	import model.modelRound;
	
	import starling.display.Sprite;

	public class TiGameHandler extends Sprite
	{
		public function TiGameHandler()
		{
		} 
		public var m_game:modelGame;
		private var m_self:modelPlayer = modelPlayer.fnGetInstance();
		private var m_other:modelEnemy = modelEnemy.fnGetInstance();
		public var m_round:modelRound = new modelRound();

		public function fnSend_EnterGame():void
		{
			var $json:String = '{"uuid":"'+m_self.uuid+'","game_id":'+m_self.game_id+'}';
			WebCommunicationHelper.instance.request("http://"+TiServerConst.HOST+"/DragonUncharted/enterGame.php",$json,URLRequestMethod.POST, fnReceive_EnterGame);
		}
		
		private function fnReceive_EnterGame(e:Event):void
		{
			//trace("enterGameCompleted :"+e.target.data); 
			if(!m_game)
			{
				m_game = new modelGame();
			}
			trace(e.target.data);
			var jsonObject:Object = JSON.parse(e.target.data);
			
			m_game.convert(jsonObject.game);
			
			for each(var player_:Object in m_game.players)
			{
				if(player_.uuid == m_self.uuid)
				{
					m_self.convert(player_);
					m_self.max_hp = m_self.hp;
					
				}
				else
				{
					m_other.convert(player_);
					m_other.max_hp = m_other.hp;
				}
			}
			
			
			/*var jsonObject:Object = m_game.decodeJSON(e.target.data) ;
			var modelEnter:modelEnterGameComplete = new modelEnterGameComplete();
			modelEnter.game = jsonObject.game;
			modelEnter.round = jsonObject.round;
			if(jsonObject.game)
			{
				m_game.convert(jsonObject.game)
			}
				s
			for each(var player_:Object in m_game.players)
			{
				if(player_.uuid == m_self.uuid)
				{
					m_self.convert(player_);
					break;
				}
			}*/
			/// initial game info
			switch(m_game.state)
			{
				case enumGameState.PARING:
				{
					/// show waiting...
					var ev:TiGameFlowEvent = new TiGameFlowEvent(TiGameFlowEvent.GAME_FLOW_EVENT,TiGameFlowEvent.GAME_PAYING)
						dispatchEvent(ev);
					trace("game patying");	
					break;
				}
				case enumGameState.PLAYING:
				{
					if(jsonObject.round !="")
					{
						m_round.convert(jsonObject.round);
					}
					m_self.convert(m_game.players[(m_self.seat_no)]);
					m_other.convert(m_game.players[(m_self.seat_no ^ 1)]);
					fnDetect_RoundState();
					break;
				}
				case enumGameState.GAMEOVER:
				{
					/// show result
					break;
				}
			}
			
			
		}
	/*	private function UI_UpdatePlayer():void
		{
			var len:int = m_game.player_max;
			var print:String = "";
			var sn:String;
			var hp:int, attack:int, defend:int;
			for(var i:int = 0; i<len ; i++)
			{
				sn = (m_self.seat_no == i)?"<"+(i+1)+">":(i+1).toString();
				hp = m_round.hp && m_round.hp[i] ? m_round.hp[i] : m_game.players[i].hp;
				attack = m_round.attack && m_round.attack[i] != null? m_round.attack[i] : m_game.players[i].attack;
				defend = m_round.defend && m_round.defend[i] != null ? m_round.defend[i] : m_game.players[i].defend;
				print += sn+"."+m_game.players[i].uuid+"\n HP:"+hp+" Attack:"+attack+" Defend:"+defend+"\n\n";
			}
			trace(print,true);
		}*/
		
		
		
		
		
		
		
		public function fnSend_StartRound():void
		{
			var $json:String = '{"uuid":"'+m_self.uuid+'"}';
			WebCommunicationHelper.instance.request("http://"+TiServerConst.HOST+"/DragonUncharted/startRound.php",$json,URLRequestMethod.POST, fnReceive_StartRound);
		}
		
		private function fnReceive_StartRound(e:Event):void
		{
			trace("\n Receive_StartRound :"+e.target.data);
			//			_rounds[_game.round_no]
			var obj_:Object = JSON.parse(e.target.data);
			m_game.round_no = obj_.round_no;
			m_round.convert(obj_);
			
			fnDetect_RoundState();
		}
		
		public function fnSend_EndRound():void
		{
			var $json:String = '{"uuid":"'+m_self.uuid+'","round_id":"'+m_round.id+'","attack":'+m_self.attack+',"defend":'+int(Math.random() * m_self.defend)+'}';
			//			var $json:String = '{"uuid":"'+_self.uuid+'","round_id":"'+_round.id+'","attack":'+1+',"defend":'+1+'}';
			WebCommunicationHelper.instance.request("http://"+TiServerConst.HOST+"/DragonUncharted/endRound.php",$json,URLRequestMethod.POST, fnReceive_EndRound);
			
		}
		
		private function fnReceive_EndRound(e:Event):void
		{
			trace("\n Receive_EndRound :"+e.target.data);
			m_round.decodeJSON(e.target.data);
			fnDetect_RoundState();
		}
		
		public function fnSend_OverRound():void
		{
			var $json:String = '{"uuid":"'+m_self.uuid+'","round_id":"'+m_round.id+'"}';
			WebCommunicationHelper.instance.request("http://"+TiServerConst.HOST+"/DragonUncharted/overRound.php",$json,URLRequestMethod.POST, fnReceive_OverRound);
		}
		
		private function fnReceive_OverRound(e:Event):void
		{
			trace("\n Receive_OverRound :"+e.target.data);
			
			m_round.decodeJSON(e.target.data);
			fnDetect_RoundState();
		}
		
		private function fnDetect_RoundState():void
		{
			/// no round start
			var ev:TiGameFlowEvent
			if(m_round.id == null && m_round.state == enumRoundState.CREATED)
			{
				 ev = new TiGameFlowEvent(TiGameFlowEvent.GAME_FLOW_EVENT,TiGameFlowEvent.GAME_READY);
				dispatchEvent(ev);
				trace("game ready")
			}
			else
			{
				/// 拿到這些狀態再對應UI要做什麼呈現
				switch(m_round.state)
				{
					/// 等待中，再送出startRound()等待狀態改變
					case enumRoundState.ROUND_START_WAITING:
						ev = new TiGameFlowEvent(TiGameFlowEvent.GAME_FLOW_EVENT,TiGameFlowEvent.ROUND_START_WAITING)
						break;
					/// 趕快開始玩看看剩多少時間
					case enumRoundState.ROUND_START:
						ev = new TiGameFlowEvent(TiGameFlowEvent.GAME_FLOW_EVENT,TiGameFlowEvent.ROUND_START)
						if(m_round &&  m_round.hp)
						{
							m_self.hp = m_round.hp[m_self.seat_no];
							m_other.hp = m_round.hp[m_other.seat_no];
						}
						
						
						break;
					/// 等待中，再送出endRound()等待狀態改變
					case enumRoundState.ROUND_END_WAITING:
						ev = new TiGameFlowEvent(TiGameFlowEvent.GAME_FLOW_EVENT,TiGameFlowEvent.ROUND_END_WAITING)
						break;
					/// 秀此Round結果
					case enumRoundState.ROUND_END:
						ev = new TiGameFlowEvent(TiGameFlowEvent.GAME_FLOW_EVENT,TiGameFlowEvent.ROUND_END)
						if(m_round && m_round.attack)
						{
							m_self.attack = m_round.attack[m_self.seat_no];
							m_other.attack = m_round.attack[m_other.seat_no];
						}
						
						break;
					/// 等待中，再送出overRound()等待狀態改變
					case enumRoundState.ROUND_OVER_WAITING:
						ev = new TiGameFlowEvent(TiGameFlowEvent.GAME_FLOW_EVENT,TiGameFlowEvent.ROUND_OVER_WAITING)
						break;
					/// 秀轉到下一Round
					case enumRoundState.ROUND_OVER:
						ev = new TiGameFlowEvent(TiGameFlowEvent.GAME_FLOW_EVENT,TiGameFlowEvent.ROUND_OVER)
						break;
					default:
						trace("detectRoundState Round state "+m_round.state+" error");
						break;
				}
				if(ev)
				{
					dispatchEvent(ev);
				}
			}
		}
		
		public function fnReset():void
		{
			modelPlayer.fnGetInstance().fnReset();
			modelEnemy.fnGetInstance().fnReset();
			m_game = new modelGame();
			m_round = new modelRound();
		}
		
		
	}
}