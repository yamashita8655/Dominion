--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStatePlayerTurnMain = {}

-- メソッド定義

-- コンストラクタ
function BattleStatePlayerTurnMain.new()
	local this = BattleStateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	
	-- 初期化処理.
	this.BattleStateOnAfterInit = this.OnAfterInit
	this.OnAfterInit = function(self)
		self:BattleStateOnAfterInit()
	end
	
	-- クリックイベントの処理
	this.BattleStateOnClickButton = this.OnClickButton
	this.OnClickButton = function(self, buttonName)
		if buttonName == "BattleSceneTurnEndButton" then
			StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.EnemyTurnEffect)
		end
	end

	return this
end

