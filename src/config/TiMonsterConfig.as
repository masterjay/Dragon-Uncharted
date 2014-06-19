package config
{
	import spark.components.Group;
	import game.monster.MonsterObject;

	public class TiMonsterConfig extends Object
	{
		public function TiMonsterConfig() 
		{
		}
		public static const MONSTER_SOLIDER:String ="MONSTER_SOLIDER"
		public static const MONSTER_BOSS:String ="MONSTER_BOSS"
		public static const MONSTER_DRAGON:String ="MONSTER_DRAGON"

		private static const COMBE_BONUS:Number =0.25 	
		public static var m_nNextPoint:int = 0
		private static const m_obSolider:MonsterObject = new MonsterObject(3000,1,300,500);
		private static const m_obBoss:MonsterObject = new MonsterObject(5000,1,450,1000);
		private static const m_obDragon:MonsterObject = new MonsterObject(8000,1,900,3000);
		public static const arMonsterList:Array = new Array(MONSTER_SOLIDER,MONSTER_BOSS,MONSTER_DRAGON)
		
		public static function fnGetMonster(str:String):MonsterObject
		{
			var ob:MonsterObject
			switch(str)
			{
				case MONSTER_SOLIDER:
					ob =  m_obSolider
					break;
				case MONSTER_BOSS:
					ob =  m_obBoss
					break;
				case MONSTER_DRAGON:
					ob =  m_obDragon
					break;
			}
			return ob
		}
		
		public static function fnAttactDamage(value:int, combe:int):int
		{
			var nDamage:int = value + (value *combe * COMBE_BONUS);
			return nDamage
		}
	}
}