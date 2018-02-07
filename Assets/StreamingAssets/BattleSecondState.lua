--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleSecondState = {}

-- メソッド定義

-- コンストラクタ
function BattleSecondState.new()
	local this = StateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	-- 初期化
	this.BattleStateInitialize = this.Initialize
	this.Initialize = function(self)
		this:BattleStateInitialize()
	end
	
	-- 初期化前処理.
	this.BattleSecondStateOnBeforeInit = this.OnBeforeInit
	this.OnBeforeInit = function(self)
		self:BattleSecondStateOnBeforeInit()
		LuaUnityDebugLog("BattleSecondState:OnBeforeInit")
	end

	return this
end

