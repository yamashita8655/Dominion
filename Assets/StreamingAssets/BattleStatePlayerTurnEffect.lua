--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStatePlayerTurnEffect = {}

-- メソッド定義

-- コンストラクタ
function BattleStatePlayerTurnEffect.new()
	local this = StateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	-- 初期化
	this.BattleStatePlayerTurnEffectInitialize = this.Initialize
	this.Initialize = function(self)
		this:BattleStatePlayerTurnEffectInitialize()
	end
	
	-- 初期化前処理.
	this.BattleStatePlayerTurnEffectOnBeforeInit = this.OnBeforeInit
	this.OnBeforeInit = function(self)
		self:BattleStatePlayerTurnEffectOnBeforeInit()
		LuaUnityDebugLog("BattleStatePlayerTurnEffect:OnBeforeInit");
	end

	return this
end

