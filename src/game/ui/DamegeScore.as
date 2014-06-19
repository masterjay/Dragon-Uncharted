package game.ui
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.events.FlexEvent;
	
	import base.TiConvertValueToArray;
	import base.TiDamageNumber;
	
	import game.ui.damageNumber.eight;
	import game.ui.damageNumber.five;
	import game.ui.damageNumber.four;
	import game.ui.damageNumber.night;
	import game.ui.damageNumber.one;
	import game.ui.damageNumber.seven;
	import game.ui.damageNumber.six;
	import game.ui.damageNumber.three;
	import game.ui.damageNumber.two;
	import game.ui.damageNumber.zero;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	
	public class DamegeScore extends Sprite
	{
		public function DamegeScore()
		{
			super();
			fnInit();
		}
		
		private var m_removeTime:DelayedCall
		//private var :DelayedCall =new DelayedCall(fnShowScore,0.5)	
		private var m_dealyTimeBatch:DelayedCall
		private var m_Score:int  	
		private var m_arNumber:Array;
		private var m_index:int
		private var scoreGp:Sprite = new Sprite();
		
		private function fnInit():void
		{
			// TODO Auto-generated method stub
			//	m_dealyTime.addEventListener(TimerEvent.TIMER_COMPLETE,fnShowScore)
			//m_dealyTimeBatch.addEventListener(TimerEvent.TIMER,fnShowDamageNumberByBatch);
			this.addChild(scoreGp);
			
		}
		
		
		public function fnScore(nValue:int):void
		{
			
			m_Score = nValue
			//	m_dealyTime.start();
			//	trace(" damage " + m_Score)
		}
		
		public function fnShowDamageScore():void
		{
			fnShowScore()

		}
		
		private function fnShowScore(e:Event=null):void
		{
		//	m_dealyTimeBatch.reset()
			//m_removeTime.reset();
			fnRemove();
			var ar:Array = TiConvertValueToArray.fnConvertValueToArray(m_Score);
			ar.reverse();
			var nNextX:int
			m_index=0
			m_arNumber =new Array();
			for( var i:int = 0 ;i< ar.length ; i++)
			{
				var strNumber:String = ar[i] as String
				var mcDamage:TiDamageNumber = fnCreateNumber(strNumber);
				mcDamage.x = nNextX
			//	mcDamage.score.gotoAndStop(int(ar[i])+1);	
				//scoreGp.addElement(mcDamage);
				nNextX = nNextX - (mcDamage.width>>1)
				m_arNumber.push(mcDamage);
			}
			//m_dealyTimeBatch.start();
			fnShowDamageNumberByBatch();
			//m_removeTime.addEventListener(TimerEvent.TIMER_COMPLETE,fnRemove);
			//m_removeTime.start()
			
			Starling.juggler.add(m_dealyTimeBatch);
		//	m_removeTime =new DelayedCall(fnRemove,2)
			//Starling.juggler.add(m_removeTime);
		}
		private function fnShowDamageNumberByBatch(e:Event=null):void
		{
			if(m_index == m_arNumber.length)
			{
				return;
			}
			var mcDamage:TiDamageNumber = m_arNumber[m_index]  as TiDamageNumber
			scoreGp.addChild(mcDamage);
			mcDamage.fnPlayAni();
			//m_dealyTimeBatch.reset()
			//m_dealyTimeBatch.start()
			m_dealyTimeBatch = new DelayedCall(fnShowDamageNumberByBatch,0.1);
			Starling.juggler.add(m_dealyTimeBatch);

			m_index++
		}
		
		private function fnCreateNumber(strNumber:String):TiDamageNumber
		{
			var mc:TiDamageNumber
			switch(strNumber)
			{
				case "0" :
					mc = new zero();
					break;
				case "1" :
					mc = new one();
					break;
				case "2" :
					mc = new two();
					break;
				case "3" :
					mc = new three();
					break;
				case "4" :
					mc = new four();
					break;
				case "5" :
					mc = new five();
					break;
				case "6" :
					mc = new six();
					break;
				case "7" :
					mc = new seven();
					break;
				case "8" :
					mc = new eight();
					break;
				case "9" :
					mc = new night();
					break;
				
			}
			return mc;
		}
		private function fnRemove(e:Event = null):void
		{
			scoreGp.removeChildren()
			//	trace("remove damage")
		}
	}
}