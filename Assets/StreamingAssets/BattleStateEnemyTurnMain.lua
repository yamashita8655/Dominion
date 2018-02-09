--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStateEnemyTurnMain = {}

-- メソッド定義

-- コンストラクタ
function BattleStateEnemyTurnMain.new()
	local this = BattleStateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	
	-- 初期化前処理.
	this.BattleStateOnAfterInit = this.OnAfterInit
	this.OnAfterInit = function(self)
		self:BattleStateOnAfterInit()
		StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.PlayerTurnEffect)
	end

	return this
end

