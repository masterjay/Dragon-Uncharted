package base
{
	import flash.events.MouseEvent;
	
	import spark.components.Group;
	
	import config.TiStageConst;
	
	import event.TiCubeEvent;
	
	import game.cube.cubeBreak;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class TiCube extends Sprite
	{
		
		public static const BLUE:String="BLUE"
		public static const RED:String="RED"
		public static const GREEN:String="GREEN"
		public static const PINK:String="PINK"
		public static const YELLOW:String="YELLOW"
		public static const INVISIBLE:String="INVISIBLE"
			
		public var m_cubeColor:String; 
		public var m_cubeIndex:int; 
		public var m_MouseOver:Boolean =false;	
		public var m_MouseDown:Boolean =false;
		public var m_bRemove:Boolean =false;
		public var m_bCubeFall:Boolean = false;
		public var m_bLastCubeInArray:Boolean=false;
		public var m_bLastCubeInArrayCollection:Boolean=false;
		public var m_bGrouped:Boolean=false;
		private var m_break:cubeBreak 

		public function TiCube(color:String)
		{
			m_cubeColor = color
		//	this.addEventListener(TouchEvent.TOUCH,fnMouseDownHandler);
		//	this.addEventListener(TouchEvent.TOUCH,fnMouseUpHandler);
		//	this.addEventListener(TouchEvent.TOUCH,fnMouseOverHandler);
		//	this.addEventListener(TouchEvent.TOUCH,fnMouseOutHandler);
		//	this.addEventListener(TouchEvent.TOUCH,fnMouseMoveHandler);
			m_break = new cubeBreak();
			this.addChild(m_break);
			m_break.visible = false;
		
		
		}
		
		public function fnCreateCube():void
		{
			
		}
		
		public function fnMoveCube():void
		{
			
		}
		
		public function fnDeleteCube():void
		{
			
		}
		
		private function fnMouseOverHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			//trace("touch.phase "+touch.phase)
			//if(touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.MOVED)
			if(touch)
			{
				if(touch.phase == TouchPhase.HOVER  )
				{
					var cube:TiCube = e.currentTarget as TiCube
					//if(cube.m_cubeIndex == this.m_cubeIndex)
					//{
					//	m_MouseOver =true
					trace( "index " + this.m_cubeIndex +"mouseOver "+ m_MouseOver)	
					//	}
					var ev:TiCubeEvent = new TiCubeEvent(TiCubeEvent.CUBE_OVER_EVENT)
					ev.m_nCubeIndex = this.m_cubeIndex;
					//	dispatchEvent(ev);
				}
				
			}
		
			//	trace("over")
		}
		
		private function fnMouseOutHandler(e:TouchEvent):void
		{
			var ob:Object = e.getTouch(e.target as DisplayObject, TouchPhase.HOVER) 
				if(ob)
				{
					trace("ob")
				}
				else if(ob == null)
				{
					trace("null")
				}
				/*	var touch:Touch = e.getTouch(stage);
			if(touch.phase == TouchPhase.HOVER)
			{
				var cube:TiCube = e.currentTarget as TiCube
				if(cube.m_cubeIndex != this.m_cubeIndex)
				{
					m_MouseOver =false
					trace( "index " + this.m_cubeIndex +"mouseOut "+ m_MouseOver)	

				}
			}
		//	trace("out")*/
		}
		
		private function fnMouseUpHandler(e:MouseEvent):void
		{
			
		}
		
		private function fnMouseDownHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					
					var cube:TiCube = e.currentTarget as TiCube
						if(cube.m_cubeIndex == this.m_cubeIndex)
						{
							m_MouseDown =true
						}
					
				}
			}
			
		}
		
		
		
		private function fnMouseMoveHandler(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			{
				var cube:TiCube = e.currentTarget as TiCube

				if(touch)
				{
					if(touch.phase == TouchPhase.MOVED)
					{
						trace( "index " + cube.m_cubeIndex +" mouseMove ")	
						
						
					}
				}
				
			}
		}
		
		public function fnPlayBreakAni():void
		{
			m_break.visible = true;
			m_break.addEventListener(TiCubeEvent.CUBE_BREAK_END_EVENT,fnCubeBreakComplete);
			m_break.fnPlayBreakAni();
			
		}
		
		private function fnCubeBreakComplete(e:TiCubeEvent):void
		{
			var ev:TiCubeEvent = new TiCubeEvent(TiCubeEvent.CUBE_BREAK_END_EVENT);
			this.dispatchEvent(ev);

		}
		
		public function fnInit():void
		{
			m_bCubeFall = false;
			m_bLastCubeInArray =false
			m_bLastCubeInArrayCollection=false;
			m_bRemove = false;
			m_bGrouped=false;
		}
	}
}