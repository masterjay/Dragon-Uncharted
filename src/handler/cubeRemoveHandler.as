package handler
{
	
	
	import base.TiCube;
	
	import event.TiCubeEvent;
	
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	import config.TiStageConst;
	
	

	public class cubeRemoveHandler extends starling.events.EventDispatcher
	{ 
		public function cubeRemoveHandler() 
		{
		}
		private var m_color:String=""
		private var m_arReadyRemoveCube:Array =new Array();	
		private var m_arRemoveArList:Array = new Array();
		//private var m_tJugeTime:Timer =new Timer(100,1)
		private var m_tJugeTime:DelayedCall

		private var m_nMarkRemoveCount:int = 0;	
		public var m_bInitStage:Boolean =true;
		public function fnJudgeCube():void
		{
			m_arRemoveArList =new Array();
			var index:int
			var colorCount:int = 1
			var cube:TiCube
			var i:int = 0;
			var j:int=1;
			var cubeNew:TiCube
			for(i=0;i<TiStageConst.m_cubeHashMap.size();i++)
			{
				cube = TiStageConst.m_cubeHashMap.getValue(i);
				m_color = cube.m_cubeColor	
				m_arReadyRemoveCube =new Array();
				
				
				index = cube.m_cubeIndex % TiStageConst.COL_MAX
				colorCount = 1
				m_arReadyRemoveCube.push(cube);
				
				for(j=1 ;j<TiStageConst.COL_MAX - index; j++)
				{
					cubeNew = TiStageConst.m_cubeHashMap.getValue(cube.m_cubeIndex + j);
					if(m_color == cubeNew.m_cubeColor)
					{
						colorCount ++
						m_arReadyRemoveCube.push(cubeNew);
					}
					else
					{
						
						break 
					}
				}
				if(colorCount>=3)
				{
					for each(var cubeR:TiCube in m_arReadyRemoveCube) 
					{
						cubeR.m_bRemove=true;
					//	cubeHashMap.put(cubeR.m_cubeIndex,cubeR);
					}
					//m_arRemoveArList.push(m_arReadyRemoveCube);
				}
				
				index = cube.m_cubeIndex / TiStageConst.COL_MAX
				colorCount = 1
				m_arReadyRemoveCube =new Array();
				m_arReadyRemoveCube.push(cube);
				var doNumbers:int = TiStageConst.ROW_MAX - index-1
				for( j = 0 ; j < doNumbers; j++)
				{
					var selectIndex:int = cube.m_cubeIndex + (j+1)*TiStageConst.COL_MAX
					if(selectIndex < TiStageConst.m_cubeHashMap.size())
					{
						cubeNew = TiStageConst.m_cubeHashMap.getValue(selectIndex);
						if(m_color == cubeNew.m_cubeColor)
						{
							colorCount ++
							m_arReadyRemoveCube.push(cubeNew);
						}
						else
						{
							
							break 
						}
					}
				}
				if(colorCount>=3)
				{
					for each(var cubeC:TiCube in m_arReadyRemoveCube) 
					{
						cubeC.m_bRemove=true;
					//	cubeHashMap.put(cubeC.m_cubeIndex,cubeC);
					}
				//	m_arRemoveArList.push(m_arReadyRemoveCube);
				}
			}
			fnRemoveMarkCount();
			//m_tJugeTime.addEventListener(TimerEvent.TIMER_COMPLETE,fnGroupCubeToArray);
			//m_tJugeTime.start();
			//m_tJugeTime.reset(fnGroupCubeToArray, 1);
			m_tJugeTime = new DelayedCall(fnGroupCubeToArray, 0.1);
			Starling.juggler.add(m_tJugeTime);

			fnJudgeAllCubeRemoveFlag()

			
		}
		
		private function fnRemoveMarkCount():void
		{
			for each(var cube:TiCube in TiStageConst.m_cubeHashMap.values())
			{
				if(cube.m_bRemove)
				{
					m_nMarkRemoveCount++
				}
			}
		}
		
		private function fnJudgeAllCubeRemoveFlag():void
		{
			var color:String=""
			var noNeedRemoveCount:int = 0
			var ar:Array =new Array();
			var cubeLeft:TiCube
			var cubeRight:TiCube
			var cubeDown:TiCube
			var cubeMarkArray:Array =new Array();
			var cubeMark:TiCube
			var currentRowIndex:int = 0;
			var currentColIndex:int = 0;
			var pointNextLayerIndex:int = 0;
			var cubeSeed:TiCube
			for(var i:int=0; i< TiStageConst.m_cubeHashMap.size() ; i++)
			{
				cubeSeed= TiStageConst.m_cubeHashMap.getValue(i);
				if(color =="" && cubeSeed.m_bRemove && cubeSeed.m_bGrouped ==false)
				{
					color = cubeSeed.m_cubeColor
					cubeSeed.m_bGrouped = true;
					/*cubeDown = TiStageConst.m_cubeHashMap.getValue(i + TiStageConst.COL_MAX)
					if(cubeDown.m_bRemove && cubeDown.m_cubeColor == color )
					{
						cubeDown.m_bGrouped =true;
						cubeMarkArray.push(cubeDown);
					}
					*/
					break;
				}
				/*if(cube.m_bRemove && cube.m_cubeColor == color)
				{
					ar.push(cube);
					cube.m_bRemove = false;
					TiStageConst.m_cubeHashMap.put(cube.m_cubeIndex,cube);
				}
				else
				{
					if(!cube.m_bRemove)
					{
						noNeedRemoveCount++
					}
					
				}*/
			}
			fnLayerGroup(cubeSeed);
			//fnGroupRight(cubeSeed);
		/*	currentColIndex = cube.m_cubeIndex % TiStageConst.COL_MAX
			currentRowIndex = int (cube.m_cubeIndex / TiStageConst.COL_MAX);
			
			while(currentColIndex < TiStageConst.COL_MAX)
			{
				cube = TiStageConst.m_cubeHashMap.getValue((currentRowIndex+1)+currentColIndex)
				if(cube.m_bGrouped)
				{
					fnLayerGroup(cube);
				}
				currentColIndex++
			}*/
		/*	for(var j:int=0;j<cubeMarkArray.length;j++)
			{
				cubeMark = cubeMarkArray[j] as TiCube;
			}
			
				
			if(currentColIndex == TiStageConst.COL_MAX)
			{
				pointNextLayerIndex = cube.m_cubeIndex + TiStageConst.COL_MAX
			}
			else
			{
				
			}
			var groupDownArray:Array =new Array();	
			if(nCurrentRowIndex < TiStageConst.ROW_MAX)
			{
				for(var i:int = 0 ;i<TiStageConst.COL_MAX;i++)
				{
					var cubeCheck:TiCube = TiStageConst.m_cubeHashMap.getValue((nCurrentRowIndex * TiStageConst.COL_MAX) + i);
					{
						if(cubeCheck.m_bGrouped)
						{
							groupDownArray.push(cubeCheck);		
						}
					}
				}
			}*/
			//if()
			/*if(ar.length>0)
			{
				m_arRemoveArList.push(ar)	
			}
			
			if(noNeedRemoveCount != TiStageConst.m_cubeHashMap.size())
			{
				fnJudgeAllCubeRemoveFlag(TiStageConst.m_cubeHashMap)
			}
			else
			{
				var a:int=0
			}*/
		}
		
		private function fnLayerGroup(cube:TiCube):void
		{
			if(cube == null)
			{
				return;
			}
			var pointCube:TiCube = TiStageConst.m_cubeHashMap.getValue(cube.m_cubeIndex);
			var nCurrentColIndex:int =  pointCube.m_cubeIndex % TiStageConst.COL_MAX
			var nCurrentRowIndex:int =  pointCube.m_cubeIndex / TiStageConst.COL_MAX
		//	var cubeDown:TiCube = TiStageConst.m_cubeHashMap.getValue(pointCube.m_cubeIndex + TiStageConst.COL_MAX)
			
		
				
			var cubeLeftSeed:TiCube = fnGroupLeft(cube)
			var cubeRightSeed:TiCube =  fnGroupRight(cube)
			var cubeDownSeed:TiCube =  fnGroupDown(cube)
			var cubeUpSeed:TiCube =  fnGroupUp(cube)
			if(cubeLeftSeed == null && cubeRightSeed==null && cubeUpSeed==null && cubeDownSeed ==null)
			{
				// stop	
			}
			else
			{
				if(cubeLeftSeed)
				{
					fnLayerGroup(cubeLeftSeed);	
				}
				if(cubeRightSeed)
				{
					fnLayerGroup(cubeRightSeed);
				}
				if(cubeDownSeed)
				{
					fnLayerGroup(cubeDownSeed);	
				}
				if(cubeUpSeed)
				{
					fnLayerGroup(cubeUpSeed);	
				}
			}
		}
		
		private function fnGroupLeft(cube:TiCube):TiCube
		{
			var nCurrentColIndex:int =  cube.m_cubeIndex % TiStageConst.COL_MAX	
			//var cubeDown:TiCube = TiStageConst.m_cubeHashMap.getValue(pointCube.m_cubeIndex + TiStageConst.COL_MAX)
		
			if(nCurrentColIndex-1 >= 0)
			{
				var pointCube:TiCube =  TiStageConst.m_cubeHashMap.getValue(cube.m_cubeIndex-1)
				if(pointCube.m_bGrouped == false && pointCube.m_cubeColor == cube.m_cubeColor && pointCube.m_bRemove)
				{
					pointCube.m_bGrouped = true;
					return pointCube
				}
				
				//nCurrentColIndex-- 
			}
			return null
		}
		
		private function fnGroupRight(cube:TiCube):TiCube
		{
			var nCurrentColIndex:int =  cube.m_cubeIndex % TiStageConst.COL_MAX	
			//var cubeDown:TiCube = TiStageConst.m_cubeHashMap.getValue(pointCube.m_cubeIndex + TiStageConst.COL_MAX)
			
			if(nCurrentColIndex+1 < TiStageConst.COL_MAX)
			{
				var pointCube:TiCube =  TiStageConst.m_cubeHashMap.getValue(cube.m_cubeIndex+1)
				if(pointCube.m_bGrouped == false && pointCube.m_cubeColor == cube.m_cubeColor && pointCube.m_bRemove)
				{
					pointCube.m_bGrouped = true;
					return pointCube;
				}
				
				//nCurrentColIndex++ 
			}
			return null;
		}
		
		private function fnGroupDown(cube:TiCube):TiCube
		{
			//var nCurrentColIndex:int =  pointCube.m_cubeIndex % TiStageConst.COL_MAX	
			if(cube.m_cubeIndex + TiStageConst.COL_MAX < TiStageConst.m_cubeHashMap.size())
			{
				var pointCube:TiCube = TiStageConst.m_cubeHashMap.getValue(cube.m_cubeIndex + TiStageConst.COL_MAX)
				if(pointCube)
				{
					if(pointCube.m_bGrouped == false &&  pointCube.m_cubeColor == cube.m_cubeColor && pointCube.m_bRemove)
					{
						pointCube.m_bGrouped = true;
						return pointCube
					}
				}
			}
			return null
		}
		
		private function fnGroupUp(cube:TiCube):TiCube
		{
			//var nCurrentColIndex:int =  pointCube.m_cubeIndex % TiStageConst.COL_MAX
			if(cube.m_cubeIndex - TiStageConst.COL_MAX > 0)
			{
				var pointCube:TiCube = TiStageConst.m_cubeHashMap.getValue(cube.m_cubeIndex - TiStageConst.COL_MAX)
				if(pointCube)
				{
					if(pointCube.m_bGrouped ==false && pointCube.m_cubeColor == cube.m_cubeColor && pointCube.m_bRemove)
					{
						pointCube.m_bGrouped = true;
						return pointCube
					}
				}	
			}
			return null;
		}
		
		private function fnGroupCubeToArray():void
		{
			var ar:Array =new Array();
			for each(var cube:TiCube in TiStageConst.m_cubeHashMap.values())
			{
				if(cube.m_bRemove && cube.m_bGrouped == true)
				{
					cube.m_bRemove = false;
					ar.push(cube);
				}
			}
			if(ar.length>0)
			{
				m_arRemoveArList.push(ar);
			}
					
			m_nMarkRemoveCount = m_nMarkRemoveCount - ar.length
			if(m_nMarkRemoveCount == 0)
			{
				Starling.juggler.remove(m_tJugeTime);

				var ev:TiCubeEvent
				if(m_bInitStage)
				{
					ev =new TiCubeEvent(TiCubeEvent.CUBE_REMOVE_INIT_MARK_COMPLETE)
					ev.m_arRemove = m_arRemoveArList
					this.dispatchEvent(ev);	
				}
				else
				{
					ev =new TiCubeEvent(TiCubeEvent.CUBE_REMOVE_MARK_COMPLETE)
					ev.m_arRemove = m_arRemoveArList
					this.dispatchEvent(ev);	
				}
			
			}
			else
			{
				//m_tJugeTime.start();
				m_tJugeTime = new DelayedCall(fnGroupCubeToArray, 0.1);
				Starling.juggler.add(m_tJugeTime);
				fnJudgeAllCubeRemoveFlag()
			}
		}
	}
}