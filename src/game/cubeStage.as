package game
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.utils.flash_proxy;
	import flash.utils.setTimeout;
	
	import base.TiCommonEventDispatcher;
	import base.TiConvertValueToArray;
	import base.TiCube;
	import base.TiDisableTextField;
	
	import caurina.transitions.Tweener;
	
	import config.TiMonsterConfig;
	import config.TiMusicConfig;
	import config.TiStageConst;
	
	import event.TiBattleEvent;
	import event.TiCubeEvent;
	import event.TiGameEvent;
	import event.TiGameFlowEvent;
	
	import game.cube.BlueCube;
	import game.cube.GreenCube;
	import game.cube.InvisibleCube;
	import game.cube.PinkCube;
	import game.cube.RedCube;
	import game.cube.YellowCube;
	import game.ui.ComboTxt;
	import game.ui.DisableCubeMoveMask;
	import game.ui.GameOver;
	import game.ui.RoundTime;
	import game.ui.Victory;
	import game.ui.startCountDown;
	
	import handler.TiMusicConfig;
	import handler.TiVoiceCollector;
	import handler.cubeRemoveHandler;
	import handler.server.TiGameHandler;
	
	import model.modelEnemy;
	import model.modelGame;
	import model.modelPlayer;
	import model.modelRound;
	
	import sound.SoundControl;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	
	
	public class cubeStage extends Sprite
	{
		public function cubeStage()
		{
			super();
			this.addEventListener(starling.events.Event.ADDED_TO_STAGE,fnAddToStage);
			
		}
		private static var m_Instance: cubeStage

		private var m_cube:TiCube
		private var m_cubeHandler:cubeRemoveHandler =new cubeRemoveHandler();
		public var m_bEnableMouseUpHandler:Boolean=false;
		public var stageGp:Sprite =new Sprite();
		private var fallGp:Sprite =new Sprite();
		public var m_SelectedCuebe:TiCube
		public var m_bSelectedCube:Boolean =false;
		private var m_nCombo:int=0
		private var m_nScore:int = 0;
		private var m_nFallCount:int=0;	
		private var m_nFallCount2:int=0;	
		private var m_nBreakBatch:int=0;
		private var m_arRemoveBatch:Array =new Array();
		private var m_arFallInitCount:Array =new Array();
		private var m_nCubeOverIndex:int
		private var m_nCurrentPositionX:Number;
		private var m_nCurrentPositionY:Number;
		private var mcBattle:battlePage
		private var mcCountDown:startCountDown
		private var soundPanel:SoundControl = new SoundControl();
		private var m_txtCombo:ComboTxt = new ComboTxt();
		private var m_uiGameVictory:Victory = new Victory();
		private var m_uiGameOver:GameOver = new GameOver();
		private var m_myFontLoading:TextField
		private var m_cubeMask:DisableCubeMoveMask
		private var m_gameHandler:TiGameHandler = new TiGameHandler();
		private var m_self:modelPlayer =  modelPlayer.fnGetInstance();
		private var m_roundTime:DelayedCall
		private var m_nAttack:int
		private var m_txtRound:TextField = new TextField(400,60,"" ,"myFont",36,0xffffff);
		private var m_uiRoundTimer:RoundTime 
		private var m_txtSelf:TextField  = new TextField(400,60,"" ,"myFont",24,0xffffff);
		private var m_txtOther:TextField  = new TextField(400,60,"" ,"myFont",24,0xffffff);
		private var m_tShowToStageTime:DelayedCall
		private var m_tRoundTimeFinishWaitSendEnd:DelayedCall
		private var m_tRoundOverWaitNextRound:DelayedCall
		
		public static function fnGetInstance(): cubeStage 
		{
			if ( m_Instance == null ) 
			{
				m_Instance = new cubeStage();
			}
			return m_Instance;
		}
		
		private function fnAddToStage(e:starling.events.Event):void
		{
			this.removeEventListener(starling.events.Event.ADDED_TO_STAGE,fnAddToStage);
			fnInit();
		}
			
		private function fnInit():void
		{
			m_gameHandler.fnSend_EnterGame();
			m_gameHandler.addEventListener(TiGameFlowEvent.GAME_FLOW_EVENT,fnGameFlowEventHandler);
			this.addChild(stageGp);
			this.addChild(fallGp);
			stageGp.addEventListener(TouchEvent.TOUCH,fnMouseMoveEvent);
			stageGp.addEventListener(TouchEvent.TOUCH,fnMouseCueentPosition);
			mcBattle = new battlePage();
			mcBattle.touchable = false;
			this.addChild(mcBattle);
			
			m_uiRoundTimer = new RoundTime();
			this.addChild(m_uiRoundTimer);
			m_uiRoundTimer.x = 100;
			m_uiRoundTimer.y = 370
				
			m_txtCombo.x = 20;
			m_txtCombo.y = 400;
			mcCountDown = startCountDown.fnGetInstance();
			mcCountDown.x = this.stage.width/2 - mcCountDown.width/2
			mcCountDown.y = this.stage.height/2 - mcCountDown.height/2
			mcCountDown.visible=false;
			
			m_myFontLoading = new TextField(300,50,"Loading...","myFont",36,0xffffff);
			
			m_myFontLoading.x = (this.stage.width/2)-m_myFontLoading.width/2
			m_myFontLoading.y = 220;
			
			mcBattle.addEventListener(TiBattleEvent.HOST_DIE_FINISH_EVENT,fnLossHandler);
			mcBattle.addEventListener(TiBattleEvent.BOSS_STAGE,fnBossStagehandler);
			mcBattle.addEventListener(TiBattleEvent.ROUND_FINISH_EVENT,fnRoundFinishHandler);
			mcBattle.addEventListener(TiBattleEvent.SUCCESS_EVENT,fnVictoryHandler);
			fnInitCube();
			fnCreateMoveCubeDisableMask();
			this.addChild(m_txtRound);
			m_txtRound.x =100;
			m_txtRound.y = 50
			
			this.addChild(m_txtSelf);
			m_txtSelf.x =10
			m_txtSelf.y = 0;
			this.addChild(m_txtOther);
			m_txtOther.x = 10;
			m_txtOther.y = 30;
			
			this.addChild(mcCountDown);
			this.addChild(m_txtCombo);
			this.addChild(m_myFontLoading);
		}
		
		
		private function fnGameStartCountDown():void
		{			

			m_myFontLoading.visible=false;
			mcCountDown.visible=true;
			mcCountDown.addEventListener(TiGameEvent.COUNT_DOWN_FINISH_EVENT,fnCountDownFinishEvevntHandler);
			mcCountDown.fnPalyAni();
			soundPanel.fnSelectMusic(TiMusicConfig.SOUND_INGAME)
		}
		
		
		private function fnCountDownFinishEvevntHandler(e:TiGameEvent):void
		{
			//if(m_gameHandler.m_round.game_over)
			//{
				mcBattle.fnShowToStage();
				m_tShowToStageTime =new DelayedCall(fnStartRoundTime,2);
				Starling.juggler.add(m_tShowToStageTime)
			//}
			mcCountDown.removeEventListener(TiGameEvent.COUNT_DOWN_FINISH_EVENT,fnCountDownFinishEvevntHandler);
			//fnStartRoundTime();
		}
		
		private function fnInitCube():void
		{
			var index:int = 0;
			for(var i:int =0 ;i< TiStageConst.COL_MAX ;i ++)
			{
				for(var j:int = 0 ;j< TiStageConst.ROW_MAX;j++)
				{
					m_cube = fnCreatedCube();
					m_cube.m_cubeIndex = index
					TiStageConst.m_cubeHashMap.put(index,m_cube);
					index++
				}
			}
			m_cubeHandler.addEventListener(TiCubeEvent.CUBE_REMOVE_INIT_MARK_COMPLETE,fnAcceptRemoveArrayInitStageCube);
			m_cubeHandler.fnJudgeCube();
			//fnInitScore();
		}
		
		private function fnCreatedCube():TiCube
		{
			var ranColor:int = Math.round(Math.random()*4);
			var cube:TiCube 
			switch(ranColor)
			{
				case 0: cube = new game.cube.RedCube();
					break;
				case 1: cube = new game.cube.BlueCube();
					break;
				case 2: cube = new game.cube.YellowCube();
					break;
				case 3: cube = new game.cube.GreenCube();
					break;
				case 4: cube = new game.cube.PinkCube();
					break;
			}
			return  cube;
		}
		
		private function fnAcceptRemoveArrayInitStageCube(e:TiCubeEvent):void
		{
			var arCollection:Array = e.m_arRemove
			if(arCollection.length==0)
			{
				m_bEnableMouseUpHandler =true;
				m_cubeHandler.m_bInitStage = false
				for(var k:int = 0; k < TiStageConst.m_cubeHashMap.size() ; k++)
				{
					var cube:TiCube = TiStageConst.m_cubeHashMap.getValue(k)
						
					var nCurrentColIndex:int =  k % TiStageConst.COL_MAX
					var nCurrentRowIndex:int =  k / TiStageConst.COL_MAX
					var cubePenddingX:Number = nCurrentColIndex * TiStageConst.CUBE_PENDDING_X
					var cubePenddingY:Number = nCurrentRowIndex * TiStageConst.CUBE_PENDDING_Y

					cube.x = TiStageConst.CUBE_INIT_X + cubePenddingX
					cube.y = TiStageConst.CUBE_INIT_Y + cubePenddingY
				//	cube.width = TiStageConst.CUBE_INIT_WIDTH;
				//	cube.height = TiStageConst.CUBE_INIT_HEIGHT;	
					cube.m_cubeIndex = k 
					cube.addEventListener(TouchEvent.TOUCH,fnCubeMouseDownHandler);
					cube.addEventListener(TiCubeEvent.CUBE_OVER_EVENT,fnCubeOverHandler);
					stageGp.addChild(cube);
				}
				//fnGameStartCountDown();
				return;
			}
			for(var i:int = 0; i< arCollection.length ;i++)
			{
				var ar:Array = arCollection[i];
				for(var j:int = 0; j<ar.length;j++)
				{
					var removeCube:TiCube = ar[j];
					var newCube:TiCube = fnCreatedCube();
					newCube.m_cubeIndex = removeCube.m_cubeIndex
					TiStageConst.m_cubeHashMap.put(removeCube.m_cubeIndex,newCube)
				}
			}
			m_cubeHandler.fnJudgeCube();
		}
		
		private function fnCubeOverHandler(e:TiCubeEvent):void
		{
			m_nCubeOverIndex = e.m_nCubeIndex;
			trace("set mouse over index " + m_nCubeOverIndex)
		}
		
		private function fnCubeMouseDownHandler(e:TouchEvent):void
		{ 
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				if(touch.phase == TouchPhase.BEGAN)
				{
					trace("mouse down")
					var ev:TiCubeEvent =new TiCubeEvent(TiCubeEvent.CUBE_DOWN_EVENT)
					ev.m_cube = e.currentTarget as TiCube
					dispatchEvent(ev);	
				}
				
			}
		}
		
		private function fnMouseMoveEvent(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(touch==null)
			{
				return;
			}
			if(touch.phase != TouchPhase.MOVED)
			{
				return;
			}
			if(!m_bSelectedCube)
			{
				return;	
			}
			var ev:TiCubeEvent =new TiCubeEvent(TiCubeEvent.CUBE_MOVE_EVENT)
			var cube:TiCube = fnGetMouseOverCube();	
			ev.m_po.x = touch.globalX - (cube.width/4) 
			ev.m_po.y = touch.globalY - (cube.height/4) 
			
			dispatchEvent(ev);	
			
		}
		
		public function fnCreatePhoxyCube(color:String):TiCube
		{
			var cube:TiCube  =new InvisibleCube();
			//return cube
			switch(color)
			{
				case TiCube.BLUE:
					cube =new BlueCube();
					break;
				case TiCube.GREEN:
					cube =new GreenCube();
					break;
				case TiCube.YELLOW:
					cube =new YellowCube();
					break;
				case TiCube.PINK:
					cube =new PinkCube();
					break;
				case TiCube.RED:
					cube =new RedCube();
					break;
			}
			return cube; 
		}
		
		public function fnGetMouseClickCube():TiCube
		{
			var cube:TiCube
			/*for(var i:int = 0;i<TiStageConst.m_cubeHashMap.size();i++)
			{
				cube = TiStageConst.m_cubeHashMap.getValue(i);
				if(cube.m_MouseDown)
				{
					break;
				}
			}*/
			cube = TiStageConst.m_cubeHashMap.getValue(m_nCubeOverIndex);

			trace("cube index"+cube.m_cubeIndex)
			return cube;
		}
	
		private function fnMouseCueentPosition(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				if(touch.phase == TouchPhase.MOVED || touch.phase == TouchPhase.HOVER)
				{
				//	trace("x " +touch.globalX + "y " + touch.globalY)
					m_nCurrentPositionX = touch.globalX
					m_nCurrentPositionY = touch.globalY
					var colIndex:int = (m_nCurrentPositionX - TiStageConst.CUBE_INIT_X) / TiStageConst.CUBE_PENDDING_X
					var rowIndex:int = (m_nCurrentPositionY - TiStageConst.CUBE_INIT_Y) / TiStageConst.CUBE_PENDDING_Y
				//	trace("colIndex " + colIndex)
				//	trace("rowIndex " + rowIndex)
						if(colIndex<0)
						{
							colIndex = 0;
						}
						
						if(rowIndex < 0 )
						{
							rowIndex = 0;
						}
						if(colIndex >= TiStageConst.COL_MAX)
						{
							colIndex = TiStageConst.COL_MAX 
							colIndex --
						}
						if(rowIndex >= TiStageConst.ROW_MAX)
						{
							rowIndex = TiStageConst.ROW_MAX;
							rowIndex--
						}
					m_nCubeOverIndex = (rowIndex * 6 ) + colIndex
					//trace("rowIndex " + rowIndex)
					//trace("colIndex " + colIndex)
				}
			}
		}
		public function fnGetMouseOverCube():TiCube
		{
			
			var cube:TiCube
			
			cube = TiStageConst.m_cubeHashMap.getValue(m_nCubeOverIndex);
			
		//	trace("cube.m_nIndex " + cube.m_cubeIndex)
			return cube;
			
		}
		
		
		
		public function fnJudgeCube():void
		{
			
			m_cubeHandler.addEventListener(TiCubeEvent.CUBE_REMOVE_MARK_COMPLETE,fnAcceptRemoveArray);
			m_cubeHandler.fnJudgeCube();
		}
		
		private function fnAcceptRemoveArray(e:TiCubeEvent):void
		{
			if(e.m_arRemove.length==0)
			{
				//	m_bEnableMouseUpHandler =true;
				if(m_nCombo == 0)
				{
					//mcBattle.fnMonsterAttactCountDownMinus();
					var ev:TiCubeEvent = new TiCubeEvent(TiCubeEvent.CUBE_PLUS_COMPLETE);
					dispatchEvent(ev);
				}
				if(m_nCombo>0)
				{
			//		mcStage.lightening.visible = true;
				//	mcStage.lightening.gotoAndPlay(1);
					TiVoiceCollector.fnPlayonepoint09();
				//	mcStage.lightening.addEventListener(Event.ENTER_FRAME,fnLighteningEnterFram);
					fnLighteningEnterFram();
				}
				else
				{
					m_nCombo = 0;
					m_nScore = 0;
					m_txtCombo.fnClearComboTxt();
				}
			//	m_cubeMask.visible = true;
				return;
			}
			m_arRemoveBatch = e.m_arRemove
			m_nBreakBatch=0
			m_nFallCount=0
			m_nFallCount2=0;
			fnRemoveCube();
		}
		
		private function fnLighteningEnterFram():void
		{
			
				if(m_uiRoundTimer.fnIsPlaying() == false)
				{
					m_tRoundTimeFinishWaitSendEnd = new DelayedCall(fnWaitSendEndRound,2)
					Starling.juggler.add(m_tRoundTimeFinishWaitSendEnd);
				}
				var nPlus:int = TiMonsterConfig.fnAttactDamage(m_nScore , m_nCombo);
				var i:int = 0 ;
				var arPlus:Array = TiConvertValueToArray.fnConvertValueToArray(nPlus);
			//	fnAttactMonster(nPlus);
				m_nCombo = 0;
				m_nScore = 0;
				m_txtCombo.fnClearComboTxt();
			//	m_nTotal +=nPlus 
				m_nAttack += nPlus
				trace("attack " + m_nAttack)
				var ev:TiCubeEvent = new TiCubeEvent(TiCubeEvent.CUBE_PLUS_COMPLETE);
				dispatchEvent(ev);
			
		}
		
		private function fnAttactMonster(nValue:int):void
		{
			//mcBettle.addEventListener(TiMonsterEvent.MONSTER_SUFFER_FINISH_EVENT,fnMonsterSufferFinishHandler);
			mcBattle.fnAttackMonster(nValue);
		}
	
		private function fnRemoveCube():void
		{
			if(m_nBreakBatch < m_arRemoveBatch.length)
			{
				var ar:Array = m_arRemoveBatch[m_arRemoveBatch.length-1 - m_nBreakBatch];
				if(m_arRemoveBatch.length-1 - m_nBreakBatch == 0)
				{
					fnRemoveBybatch(ar,true)
				}
				else
				{
					fnRemoveBybatch(ar,false)
				}
				TiVoiceCollector.fnPlayCubeBreak();
				fnCountFraction(ar)
			}
		}
		
		private function fnCountFraction(ar:Array):void
		{
			var cube:TiCube = ar[int(ar.length/2)]
			var color:String = cube.m_cubeColor
			var colorFraction:int	
			var po:Point =new Point(cube.x,cube.y);
			switch(color)
			{
				case TiCube.BLUE:
					colorFraction = TiStageConst.BLUE_FRACTION
					break;
				case TiCube.PINK:
					colorFraction = TiStageConst.PINK_FRACTION
					break;
				case TiCube.YELLOW:
					colorFraction = TiStageConst.YELLOW_FRACTION
					break;
				case TiCube.GREEN:
					colorFraction = TiStageConst.GREEN_FRACTION
					break;
				case TiCube.RED:
					colorFraction = TiStageConst.RED_FRACTION
					break;
			}
			var plus:int = colorFraction*ar.length 
			var ar:Array
			if(ar.length > 3 )
			{
				plus = plus + (plus * (ar.length -3) *0.17)
			}
		//	fnPluasAni(plus,po,color)
			m_nScore +=plus
			
			var arr:Array = TiConvertValueToArray.fnConvertValueToArray(m_nScore);
			arr.reverse();
		//	for(var j:int = 0 ;j< ar.length ; j++)
			{
			//	mcStage.Score_x["score"+ (j+1)].gotoAndStop(int(ar[j])+1);
			}
		}
		
		private function fnRemoveBybatch(ar:Array,bLast:Boolean):void
		{
			for(var i :int = 0 ; i < ar.length ; i++) 
			{
				var cube:TiCube = ar[i]
				if(cube.m_cubeColor!= TiCube.INVISIBLE)
				{
					if( i == ar.length-1)
					{
						if(bLast)
						{
							cube.m_bLastCubeInArrayCollection=true;
						}
						cube.m_bLastCubeInArray=true;
						
					}
					cube.addEventListener(TiCubeEvent.CUBE_BREAK_END_EVENT,fnBreakEndhandlerByBatch);	
					cube.fnPlayBreakAni()
					
				}
			}
			m_nBreakBatch++
				m_nCombo++  	
				fnComboToText(m_nCombo);
		}
		
		private function fnComboToText(nCombo:int):void
		{
			m_txtCombo.fnUpdateComboTxt(nCombo);
		}
		
		private function fnBreakEndhandlerByBatch(e:TiCubeEvent):void
		{
			var cubeInvisible:InvisibleCube 
			var cube:TiCube = e.currentTarget as TiCube
			cubeInvisible =new InvisibleCube();
			cubeInvisible.x = cube.x
			cubeInvisible.y = cube.y
			cubeInvisible.m_cubeIndex = cube.m_cubeIndex
			stageGp.removeChildAt(cube.m_cubeIndex);
			stageGp.addChildAt(cubeInvisible,cubeInvisible.m_cubeIndex);
			TiStageConst.m_cubeHashMap.put(cubeInvisible.m_cubeIndex,cubeInvisible);
			if(cube.m_bLastCubeInArrayCollection)
			{
				fnCubeFallBeforeAni();
			}
			else
			{
				if(cube.m_bLastCubeInArray)
				{
					fnRemoveCube();
				}
			}
		}
		
		
		public function fnCubeFallBeforeAni():void
		{
			var nMaxSize:int = TiStageConst.m_cubeHashMap.size() - TiStageConst.COL_MAX
			var moveSize:int = 0;	
			var bDoAfterAnimationFunction:Boolean = true;
			for(var i:int = nMaxSize-1; i >=0 ; i--)
			{
				moveSize = 0
				var cube:TiCube = TiStageConst.m_cubeHashMap.getValue(i);
				var cubeNextLayerIndex:int = cube.m_cubeIndex + (moveSize+1) * TiStageConst.COL_MAX
				while(cubeNextLayerIndex < TiStageConst.m_cubeHashMap.size())
				{
					var cubeNextLayer:TiCube = TiStageConst.m_cubeHashMap.getValue(cubeNextLayerIndex);
					if( cube.m_cubeColor != TiCube.INVISIBLE && cubeNextLayer.m_cubeColor == TiCube.INVISIBLE)
					{
						moveSize++
							cubeNextLayerIndex = cube.m_cubeIndex + (moveSize+1) * TiStageConst.COL_MAX
					}
					else
					{
						break;
					}
				}
				if(moveSize > 0)
				{
					bDoAfterAnimationFunction = false;
					m_nFallCount++;
					fnDoCubeFallAnimation(cube,moveSize);
				}
			}
			if(bDoAfterAnimationFunction)
			{
				fnFallAnimationEnd();
			}
			//	m_fallTime.start();
		}

		
		private function fnDoCubeFallAnimation(cube:TiCube,nFallSize:int):void
		{
			var index:int = cube.m_cubeIndex + nFallSize * TiStageConst.COL_MAX
			var fallCube:TiCube = TiStageConst.m_cubeHashMap.getValue(index);
			
			var NewCubeFall:TiCube = fnCreatePhoxyCube(cube.m_cubeColor);
			NewCubeFall.x = cube.x
			NewCubeFall.y = cube.y	
			fallGp.addChild(NewCubeFall);
			Tweener.addTween(NewCubeFall, {x:fallCube.x, y:fallCube.y,scaleX:1,scaleY:1,time:0.2,onComplete:handleSwapEnd});
			var obj:Object =new Object();
			obj.x = fallCube.x
			obj.y = fallCube.y;	
			obj.m_cubeIndex = fallCube.m_cubeIndex
			
			
			fallCube.x = cube.x
			fallCube.y = cube.y
			fallCube.m_cubeIndex = cube.m_cubeIndex
			cube.x = obj.x
			cube.y = obj.y
			cube.m_cubeIndex = obj.m_cubeIndex
			cube.visible = false;
			stageGp.addChildAt(cube,cube.m_cubeIndex);
			stageGp.addChildAt(fallCube,fallCube.m_cubeIndex);
			
			TiStageConst.m_cubeHashMap.put(fallCube.m_cubeIndex,fallCube);
			TiStageConst.m_cubeHashMap.put(cube.m_cubeIndex,cube);
		}
		
		private function handleSwapEnd():void
		{
			m_nFallCount2++
			if(m_nFallCount == m_nFallCount2 )
			{
				fnFallAnimationEnd();
			}
		}
		
		private function fnFallAnimationEnd():void
		{
			fallGp.removeChildren();
			
			for(var i:int=0 ; i < TiStageConst.m_cubeHashMap.size() ; i++)
			{
				var cube:TiCube = TiStageConst.m_cubeHashMap.getValue(i);
				cube.visible = true;
				cube.m_cubeIndex = i
				cube.fnInit();
			}
			fnFAfterFallAnimation();
		}
		
		private function fnFAfterFallAnimation():void
		{
			m_arFallInitCount =new Array();
			for(var i:int = TiStageConst.m_cubeHashMap.size() -1; i >=0 ; i--)
			{
				var cubeInvisible:TiCube = TiStageConst.m_cubeHashMap.getValue(i);
				if(cubeInvisible.m_cubeColor == TiCube.INVISIBLE)
				{
					var cubeNew:TiCube = fnCreatedCube();
					cubeNew.x = cubeInvisible.x
					cubeNew.y = cubeInvisible.y
					cubeNew.m_cubeIndex = cubeInvisible.m_cubeIndex	
					cubeNew.visible =false;
					m_nFallCount++
					var cubeFall:TiCube = fnCreatePhoxyCube(cubeNew.m_cubeColor);
					var FallInitIndex:int = cubeNew.m_cubeIndex % TiStageConst.COL_MAX
					m_arFallInitCount.push(FallInitIndex);
					var FallInitBackIndex:int = cubeNew.m_cubeIndex / TiStageConst.COL_MAX	
					var FallInitIdexCube:TiCube = TiStageConst.m_cubeHashMap.getValue(FallInitIndex);
					cubeFall.x = FallInitIdexCube.x 
					cubeFall.y = FallInitIdexCube.y - ((fnGetFallInitCOunt(FallInitIndex)+1) * TiStageConst.CUBE_PENDDING_Y);
					fallGp.addChild(cubeFall);
					
				//	cubFallMove.target = cubeFall
					//cubFallMove.yTo = cubeInvisible.y 	
					//cubFallMove.play();
					
					Tweener.addTween(cubeFall, {x:cubeNew.x, y:cubeNew.y,scaleX:1,scaleY:1,time:0.3});
					stageGp.removeChildAt(cubeInvisible.m_cubeIndex);
					stageGp.addChildAt(cubeNew,cubeNew.m_cubeIndex);
					TiStageConst.m_cubeHashMap.put(cubeNew.m_cubeIndex,cubeNew);
				}
			}
			//var t:Timer=new Timer(500,1)
			//t.addEventListener(TimerEvent.TIMER_COMPLETE,fnHandleSwapEndAfterFallAnimation);
			//t.start()	
			
			var	tTime:DelayedCall = new DelayedCall(fnHandleSwapEndAfterFallAnimation, 0.5);
			Starling.juggler.add(tTime);
		}
		
		private function fnGetFallInitCOunt(init:int):int
		{
			var count:int =0;
			for(var i:int=0 ; i <m_arFallInitCount.length;i++)
			{
				if(init == m_arFallInitCount[i])
				{
					count++
				}
			}
			return  count
		}
		
		private function fnHandleSwapEndAfterFallAnimation():void
		{
			fallGp.removeChildren();
			stageGp.removeChildren();
			for(var i:int=0 ; i < TiStageConst.m_cubeHashMap.size() ; i++)
			{
				var cube:TiCube = TiStageConst.m_cubeHashMap.getValue(i);
				cube.visible = true;
				cube.m_cubeIndex = i
				cube.fnInit();
				cube.addEventListener(TouchEvent.TOUCH,fnCubeMouseDownHandler);
				stageGp.addChild(cube);
			}
			fnJudgeCube()
		}
		
		
		public function fnGameTimeUiReset():void
		{
			//mcGameTime.ani_time.gotoAndStop(1);
		}
		
		public function fnGameTimeStop():void
		{
		//	mcGameTime.ani_time.gotoAndStop(mcGameTime.ani_time.currentFrame);
		}
		
		public function fnGameTimeUiStart():void
		{
		
		}
		
		private function fnGameTimeEnterFrame():void
		{
			
		}
		
		
		
		private function fnRestartGame(e:starling.events.Event):void
		{
			TiMonsterConfig.m_nNextPoint=0;
			mcBattle.fnClear()
			
			TiStageConst.m_cubeHashMap.clear()
			stageGp.removeChildren()
			fallGp.removeChildren();
			//mcPlusGp.removeAllElements();
			m_cubeHandler.m_bInitStage =true
			this.removeChild(m_uiGameOver);
			this.removeChild(m_uiGameVictory);
			fnInitCube()
			m_gameHandler.fnSend_EnterGame();
			//fnGameStartCountDown();
		//	mcGameSucess.visible=false;
		}
		private function fnBossStagehandler(e:TiBattleEvent):void
		{
			soundPanel.fnSelectMusic(TiMusicConfig.SOUND_BOSS);
		}
		
		private function fnRoundFinishHandler(e:TiBattleEvent):void
		{
		//	m_cubeMask.visible = false;
			
			var ev:TiBattleEvent = new TiBattleEvent(TiBattleEvent.ROUND_FINISH_EVENT)
				this.dispatchEvent(ev);
				m_tRoundOverWaitNextRound = new DelayedCall(fnSendOverRound,2);
				Starling.juggler.add(m_tRoundOverWaitNextRound);
		}
		
		private function fnSendOverRound():void
		{
			m_gameHandler.fnSend_OverRound()
		}
		
		private function fnVictoryHandler(e:TiBattleEvent=null):void
		{
			this.addChild(m_uiGameVictory);
			m_uiGameVictory.x = 30
			m_uiGameVictory.y = 150	
			m_uiGameVictory.addEventListener(TiGameEvent.GAME_RESTART,fnRestartGame);
			soundPanel.fnSelectMusic(TiMusicConfig.SOUND_GAMEOVER);
			
		}
		
		private function fnLossHandler(e:TiBattleEvent = null):void
		{
			//mcGameRestart.visible=true;
			this.addChild(m_uiGameOver);
			m_uiGameOver.x = 30
			m_uiGameOver.y = 150	
			m_uiGameOver.addEventListener(TiGameEvent.GAME_RESTART,fnRestartGame);
			soundPanel.fnSelectMusic(TiMusicConfig.SOUND_GAMEOVER);
			
		}
		
		private function fnCreateMoveCubeDisableMask():void
		{
			m_cubeMask = new DisableCubeMoveMask();
			this.addChild(m_cubeMask);
			m_cubeMask.x = 107.65
			m_cubeMask.y = 128.75;	
			m_cubeMask.visible = false;
		}
		
		private function fnStartRoundTime():void
		{ trace("round time start")
		//	m_roundTime =new DelayedCall(fnRoundTimeCompleteHandler,5);
		//	Starling.juggler.add(m_roundTime);
			m_cubeMask.visible = false;
			m_uiRoundTimer.fnPalyAni();
			m_uiRoundTimer.addEventListener(TiGameFlowEvent.GAME_FLOW_EVENT,fnGameFlowEventHandler);
		}
		
	
		private function fnGameFlowEventHandler(e:TiGameFlowEvent):void
		{
			// TODO Auto Generated method stub
			m_cubeMask.visible = false;
			switch(e.detail)
			{
				case TiGameFlowEvent.GAME_PAYING:
					fnGamePayingHandler();
					m_cubeMask.visible = true;
					break;
				case TiGameFlowEvent.GAME_READY:
					fnGameReadyHandler();
					m_cubeMask.visible = true;
					break;
				case TiGameFlowEvent.ROUND_START_WAITING:
					fnRoundStartWaitingHandler();
					m_cubeMask.visible = true;
					break;
				case TiGameFlowEvent.ROUND_START:
					
					fnRoundStartHandler();
					break;
				case TiGameFlowEvent.ROUND_TIME_FINISH:
					fnRoundTimeFinishHandler();
					break;
				case TiGameFlowEvent.ROUND_END_WAITING:
					m_cubeMask.visible = true;
					fnRoundEndWaiting();
					break;
				case TiGameFlowEvent.ROUND_END:
					m_cubeMask.visible = true;
					fnEndRoundHandler();
					break;
				case TiGameFlowEvent.ROUND_OVER_WAITING:
					m_cubeMask.visible = true;
					fnOverRoundWaitingHandler();
					break;
				case TiGameFlowEvent.ROUND_OVER:
					m_cubeMask.visible = true;
					fnOverRoundHandler();
					break;
			}
			
		}
		
		private function fnGameReadyHandler():void
		{
			
		//	m_txtSelf.text = "self " +modelPlayer.fnGetInstance().uuid;
		//	m_txtOther.text = "other " + modelEnemy.fnGetInstance().uuid;
			m_txtRound.text = "Game Ready ,Round " + m_gameHandler.m_game.round_no;
			m_gameHandler.fnSend_StartRound();
		}
		
		
		
		private function fnGamePayingHandler():void
		{
			m_txtRound.text = "connect to other player" ;
			setTimeout(m_gameHandler.fnSend_EnterGame,1000);
		}
		
		
		
		private function fnRoundStartWaitingHandler():void
		{
			// TODO Auto Generated method stub
			m_txtRound.text = "Round start waiting" ;
			setTimeout(m_gameHandler.fnSend_StartRound,1000);
			
		}
		
		private function fnRoundStartHandler():void
		{
			//fnStartRoundTime();
			fnGameStartCountDown();
			m_txtRound.text ="Round start " + m_gameHandler.m_game.round_no;
			
			
			
		}
		
		private function fnRoundTimeFinishHandler():void
		{
			trace("round time finish")
			var self:modelPlayer =  modelPlayer.fnGetInstance();
			self.attack = m_nAttack
			self.defend = 0;
			m_nAttack = 0;
			m_txtRound.text = "time finish"
				
			m_tRoundTimeFinishWaitSendEnd = new DelayedCall(fnWaitSendEndRound,1)
			Starling.juggler.add(m_tRoundTimeFinishWaitSendEnd);
			
			var ev:TiGameFlowEvent = new TiGameFlowEvent(TiGameFlowEvent.ROUND_TIME_FINISH);
			dispatchEvent(ev);
		}
		
		private function fnWaitSendEndRound():void
		{
			m_gameHandler.fnSend_EndRound();
		}
		
		private function fnRoundEndWaiting():void
		{
			m_txtRound.text = "End Round waiting";
			setTimeout(m_gameHandler.fnSend_EndRound,1000);
		}
		
		private function fnEndRoundHandler():void
		{
			m_txtRound.text = "End Round ";
			 var self:modelPlayer = modelPlayer.fnGetInstance()
			 m_cubeMask.visible = true;
			fnAttactMonster(self.attack)
		}
		
		private function fnOverRoundWaitingHandler():void
		{
			m_txtRound.text = "Over Round waiting";
			setTimeout(m_gameHandler.fnSend_OverRound,1000)
		}
		
		private function fnOverRoundHandler():void
		{
			if(m_gameHandler.m_round.game_over)
			{
				fnGameOverResetUI();	
				m_gameHandler.fnReset();
			}
			else
			{
				fnOverOneRound();
			}
		}
		
		private function fnOverOneRound():void
		{
			m_txtRound.text = "Over Round ";
			m_tRoundOverWaitNextRound = new DelayedCall(fnStartNewRound,2);
			Starling.juggler.add(m_tRoundOverWaitNextRound)
			//fnGameStartCountDown();
		}
		
		private function fnStartNewRound():void
		{
			m_gameHandler.fnSend_StartRound()
			m_txtRound.text = "sned start new Round ";
		}
		
		private function fnGameOverResetUI():void
		{
			if(m_gameHandler.m_round.winner == modelPlayer.fnGetInstance().uuid)
			{
				fnVictoryHandler();
			}
			else
			{
				fnLossHandler();
			}
			
		}
	}
}