--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStatePlayerTurnMain = {}

-- メソッド定義

-- コンストラクタ
function BattleStatePlayerTurnMain.new()
	local this = StateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	-- 初期化
	this.BattleStatePlayerTurnMainInitialize = this.Initialize
	this.Initialize = function(self)
		this:BattleStatePlayerTurnMainInitialize()
	end
	
	-- 初期化前処理.
	this.BattleStatePlayerTurnMainOnBeforeInit = this.OnBeforeInit
	this.OnBeforeInit = function(self)
		self:BattleStatePlayerTurnMainOnBeforeInit()
		LuaUnityDebugLog("BattleStatePlayerTurnMain:OnBeforeInit");
	end

	return this
end

