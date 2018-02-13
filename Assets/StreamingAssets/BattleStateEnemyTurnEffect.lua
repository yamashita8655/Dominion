--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStateEnemyTurnEffect = {}

-- メソッド定義

-- コンストラクタ
function BattleStateEnemyTurnEffect.new()
	local this = BattleStateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	
	-- 初期化前処理.
	this.BattleStateOnAfterInit = this.OnAfterInit
	this.OnAfterInit = function(self)
		self:BattleStateOnAfterInit()
		-- エフェクト再生
		CallbackManager.Instance():AddCallback(
			"EnemyTurnEffectCallback",
			{self},
			function(arg, unityArg)
				local self = arg[1]
				StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.EnemyTurnMain)
			end
		)
		local scene = SceneManager.Instance():GetCurrentScene()
		LuaPlayAnimator(scene.EnemyTurnStartEffectName, "Play", false, true, "LuaCallback", "EnemyTurnEffectCallback")
	end

	return this
end

