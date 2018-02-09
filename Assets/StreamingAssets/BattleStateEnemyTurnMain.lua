--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStateEnemyTurnMain = {}

-- メソッド定義

-- コンストラクタ
function BattleStateEnemyTurnMain.new()
	local this = StateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	-- 初期化
	this.BattleStateEnemyTurnMainInitialize = this.Initialize
	this.Initialize = function(self)
		this:BattleStateEnemyTurnMainInitialize()
	end
	
	-- 初期化前処理.
	this.BattleStateEnemyTurnMainOnBeforeInit = this.OnBeforeInit
	this.OnBeforeInit = function(self)
		self:BattleStateEnemyTurnMainOnBeforeInit()
		LuaUnityDebugLog("BattleStateEnemyTurnMain:OnBeforeInit");
	end

	return this
end

