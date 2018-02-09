--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStateEnemyTurnEffect = {}

-- メソッド定義

-- コンストラクタ
function BattleStateEnemyTurnEffect.new()
	local this = StateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	-- 初期化
	this.BattleStateEnemyTurnEffectInitialize = this.Initialize
	this.Initialize = function(self)
		this:BattleStateEnemyTurnEffectInitialize()
	end
	
	-- 初期化前処理.
	this.BattleStateEnemyTurnEffectOnBeforeInit = this.OnBeforeInit
	this.OnBeforeInit = function(self)
		self:BattleStateEnemyTurnEffectOnBeforeInit()
		LuaUnityDebugLog("BattleStateEnemyTurnEffect:OnBeforeInit");
	end

	return this
end

