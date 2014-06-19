package game
{
	import flash.events.MouseEvent;
	
	import base.TiCube;
	
	import config.TiStageConst;
	
	import event.TiBattleEvent;
	import event.TiCubeEvent;
	import event.TiGameEvent;
	import event.TiGameFlowEvent;
	
	import handler.TiVoiceCollector;
	
	import resources.GetAllResourcesHandler;
	import resources.GetTextureHandler;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class GameStage extends Sprite
	{
		public function GameStage()
		{
			super();
			fnInit();
		}

		private var cbs:cubeStage = cubeStage.fnGetInstance();
		private var m_moveCube:TiCube
		private var cubeGp:Sprite =new Sprite();
		private var m_SelectedCuebe:TiCube
		private var m_bSelected:Boolean = false;
		private var m_bAlreadChangeCube:Boolean = false;
		private var m_lastIndex:int = 0	

		private function fnInit():void
		{
			//var image:Image = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strCUBE_STAGE_BACKGROUND));
			var image:Image = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("cubeStage"));
			this.addChild(image);
			//var stageBaseImg:Image = new Image(GetTextureHandler.fnGetTexture(GetTextureHandler.strCUBE_STAGE_BASE));
			var stageBaseImg:Image = new Image(GetAllResourcesHandler.getAtlasAll().getTexture("stage_base"));
			this.addChild(stageBaseImg);
			stageBaseImg.y = 400; 
				
			this.addChild(cbs);
			this.addChild(cubeGp);
			cbs.addEventListener(TiCubeEvent.CUBE_DOWN_EVENT,fnMouseDownHandler);
			this.addEventListener(TouchEvent.TOUCH,fnMouseUpHandler);
			cbs.addEventListener(TiCubeEvent.CUBE_MOVE_EVENT,fnCubeMoveHandler);
			//cubeGp.visible=false
			cbs.addEventListener(TiBattleEvent.ROUND_FINISH_EVENT,fnRoundFinishHandler);
			cbs.addEventListener(TiCubeEvent.CUBE_PLUS_COMPLETE,fnCubePlusCompleteHandler);
			cbs.addEventListener(TiGameFlowEvent.ROUND_TIME_FINISH,fnRoundTimeFinishHandler);
		}
		
		
		private function fnMouseDownHandler(e:TiCubeEvent):void
		{
			if(!cbs.m_bEnableMouseUpHandler)
			{
				return;
			}
			var cube:TiCube =  cbs.fnGetMouseClickCube();
			trace(cube.m_cubeIndex);
			m_moveCube = cbs.fnCreatePhoxyCube(cube.m_cubeColor);
			cubeGp.addChild(m_moveCube);
			m_SelectedCuebe = e.m_cube 
			cbs.m_SelectedCuebe = m_SelectedCuebe
			m_SelectedCuebe.alpha =0
			m_bSelected = true;
			cbs.m_bSelectedCube = m_bSelected
			
			
			cubeGp.x = cube.x  
			cubeGp.y = cube.y 
			
		}
		
		private function fnRoundTimeFinishHandler(e:TiGameFlowEvent):void
		{
			fnMouseUpHandler();
		}
		
		private function fnMouseUpHandler(e:TouchEvent = null):void
		{
			if(e)
			{
				var touch:Touch = e.getTouch(stage);
				if(touch)
				{
					if(touch.phase != TouchPhase.ENDED)
					{
						return;	
					}
				}
			}
			
			
			if(!cbs.m_bEnableMouseUpHandler)
			{
				return;
			}
			cbs.m_bEnableMouseUpHandler = false 
			
			if(m_SelectedCuebe)
			{
				m_SelectedCuebe.m_MouseDown =false;
				m_SelectedCuebe.m_MouseOver =false;
				m_SelectedCuebe.alpha =1	
				m_bSelected = false;
				cbs.m_bSelectedCube = m_bSelected
				m_SelectedCuebe = null
				cubeGp.removeChildren()
				cbs.fnGameTimeStop();
			}
			if(m_bAlreadChangeCube)
			{
				cbs.fnJudgeCube();	
				/// temp  use
			//	cbs.m_bEnableMouseUpHandler = true 

			}
			else
			{
				cbs.m_bEnableMouseUpHandler = true 
			}
		}
		
		private function fnCubeMoveHandler(e:TiCubeEvent):void
		{
			if(!m_bSelected )
			{
				return;
			}
			
			var cube:TiCube = cbs.fnGetMouseOverCube();
			if(!cube)
			{
				return;
			}
			cubeGp.x = e.m_po.x  
			cubeGp.y = e.m_po.y 
			fnChangeCube();
		}
		
		
		private function fnChangeCube():void
		{
			var cubeNew:TiCube = cbs.fnGetMouseOverCube();
			if(m_lastIndex ==-1)
			{
				m_lastIndex = cubeNew.m_cubeIndex
			}
			else
			{
				if(m_lastIndex == cubeNew.m_cubeIndex)
				{
					return;
				}
			}
			var cubeNewIndex:int = cubeNew.m_cubeIndex
			m_lastIndex = cubeNewIndex
			var cubeOld:TiCube = TiStageConst.m_cubeHashMap.getValue(m_SelectedCuebe.m_cubeIndex);
			var tempOb:Object =new Object();
			tempOb.x = cubeNew.x
			tempOb.y = cubeNew.y
			cubeNew.x = cubeOld.x
			cubeNew.y = cubeOld.y	
			cubeOld.x = tempOb.x
			cubeOld.y = tempOb.y
			cubeOld.alpha=0;
			cubeNew.visible=true;
			
			
			cbs.stageGp.addChildAt(cubeNew,cubeOld.m_cubeIndex);
			cbs.stageGp.addChildAt(cubeOld,cubeNewIndex);
			cubeNew.m_MouseOver = false;
			cubeOld.m_MouseOver = false
			cubeNew.m_MouseDown = false;
			cubeOld.m_MouseDown = false
			
			
			tempOb.m_cubeIndex = cubeNew.m_cubeIndex
			cubeNew.m_cubeIndex = cubeOld.m_cubeIndex
			cubeOld.m_cubeIndex = tempOb.m_cubeIndex	 
		//	trace("cubeNew.m_cubeIndex "+ cubeNew.m_cubeIndex)
		//	trace("cubeOld.m_cubeIndex "+ cubeOld.m_cubeIndex);
			TiStageConst.m_cubeHashMap.put(cubeOld.m_cubeIndex,cubeOld);
			TiStageConst.m_cubeHashMap.put(cubeNew.m_cubeIndex,cubeNew);
			TiVoiceCollector.fnPlaySwapCube();
			cbs.fnGameTimeUiStart();
			m_bAlreadChangeCube = true;
		}
		
		private function fnCubePlusCompleteHandler(e:TiCubeEvent):void
		{
			cbs.m_bEnableMouseUpHandler = true 
			m_bAlreadChangeCube =false;
		}
		
		private function fnRoundFinishHandler(e:TiBattleEvent):void
		{
		//	fnGameTimeReset();
			cbs.m_bEnableMouseUpHandler = true 
			m_bAlreadChangeCube =false;
		}
	}
}