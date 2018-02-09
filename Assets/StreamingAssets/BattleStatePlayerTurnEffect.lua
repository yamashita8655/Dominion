--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStatePlayerTurnEffect = {}

-- メソッド定義

-- コンストラクタ
function BattleStatePlayerTurnEffect.new()
	local this = BattleStateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	
	-- 初期化処理.
	this.BattleStateOnAfterInit = this.OnAfterInit
	this.OnAfterInit = function(self)
		self:BattleStateOnAfterInit()
		LuaUnityDebugLog("-----BattleStatePlayerTurnEffect-----")
		-- エフェクト再生
		CallbackManager.Instance():AddCallback(
			"PlayerTurnEffect",
			{self},
			function(arg, unityArg)
				local self = arg[1]
				StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.PlayerTurnMain)
			end
		)
		LuaPlayAnimator("PlayerTurnStartEffect", "Play", false, true, "LuaCallback", "PlayerTurnEffect")
	end

	return this
end

