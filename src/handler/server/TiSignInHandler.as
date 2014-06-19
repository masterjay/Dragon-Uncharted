package handler.server
{
	import flash.events.Event;
	import flash.net.URLRequestMethod;
	
	import config.TiServerConst;
	
	import event.TiServerEvent;
	
	import model.modelPlayer;
	
	import starling.display.Sprite;

	public class TiSignInHandler extends Sprite
	{
		public function TiSignInHandler()
		{
		}

		private  var m_self:modelPlayer;
		
		public function Send_SignIn($uuid:String):void
		{
			var $json:String = '{"uuid":"'+$uuid+'"}';
			WebCommunicationHelper.instance.request("http://"+TiServerConst.HOST+"/DragonUncharted/signIn.php",$json,URLRequestMethod.POST, Receive_SignIn);
		}
		
		private  function Receive_SignIn(e:Event):void
		{
		//	log("signInCompleted :"+e.target.data);
			trace(e.target.data);
			m_self =  modelPlayer.fnGetInstance();
			m_self.decodeJSON(e.target.data)
			//var obj:Object = m_self.decodeJSON(e.target.data);
			//m_self.convert(obj);
			if(m_self.game_id == -1)
			{
				trace("sign in complete");
				//enterGame();
				var ev:TiServerEvent = new TiServerEvent(TiServerEvent.SERVER_SIGNIN_COMPLETE_EVENT)
				dispatchEvent(ev);
			}
			else
			{
				var ev2:TiServerEvent = new TiServerEvent(TiServerEvent.SERVER_ENTER_GAME_COMPLETE_EVENT)
				dispatchEvent(ev2);
			}
			
		}
	}
}