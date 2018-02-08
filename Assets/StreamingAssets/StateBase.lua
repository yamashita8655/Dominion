--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
StateBase = {}

-- コンストラクタ
function StateBase.new()
	local this = {
		IsPause = false, -- 今のステートが、次のChangeStateで有効になるまで動作させなくする。次の有効で、自動的にfalseにする
		InitCalled = false,
	}

	-- メソッド定義
	-- 初期化
	this.Initialize = function(self)
		self.IsPause = false
	end

	-- 停止中かどうか.
	this.IsPause = function(self)
		return self.IsPause
	end

	-- ポーズする.
	this.PauseEnable = function(self)
		self.IsPause = true;
	end

	-- ポーズ解除.
	this.PauseDisable = function(self)
		self.IsPause = false;
	end

	-- 初期化前処理.
	this._OnBeforeInit = function(self)
		self.InitCalled = true;
		self:OnBeforeInit();
	end

	-- 解放処理.
	this._OnRelease = function(self)
		self.InitCalled = false;
		self:OnRelease();
	end

	-- 初期化済みかどうか.
	this.IsInitCalled = function(self)
		return self.InitCalled;
	end

	-- 初期化前処理.
	this.OnBeforeInit = function(self)
		LuaUnityDebugLog("StateBase:OnBeforeInit")
	end

	-- 初期化更新処理.
	this.OnUpdateInit = function(self, delta)
		return true;
	end

	-- 初期化後処理.
	this.OnAfterInit = function(self)
	end

	-- メイン前処理.
	this.OnBeforeMain = function(self)
	end

	-- メイン更新処理.
	this.OnUpdateMain = function(self, delta)
	end

	-- メイン後処理.
	this.OnAfterMain = function(self)
	end

	-- 終了前処理.
	this.OnBeforeEnd = function(self)
	end

	-- 終了更新処理.
	this.OnUpdateEnd = function(self, delta)
		return true;
	end

	-- 終了後処理.
	this.OnAfterEnd = function(self)
	end

	-- ステート解放時処理.
	this.OnRelease = function(self)
	end

	return this
end

