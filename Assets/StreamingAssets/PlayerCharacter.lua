--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
PlayerCharacter = {}

-- メソッド定義

-- コンストラクタ
function PlayerCharacter.new()
	local this = CharacterBase.new()
	
	-- メンバ変数
	this.NowCost = 0
	this.MaxCost = 0

	-- メソッド定義
	-- 初期化
	this.PlayerCharacterInitialize = this.Initialize
	this.Initialize = function(self, nowCost, maxCost, nowHp, maxHp, position, rotate, name, width, height)
		this:PlayerCharacterInitialize(nowHp, maxHp, position, rotate, name, width, height)
		self.NowCost = nowCost
		self.MaxCost = maxCost
	end
	
	-- 現在コスト設定
	this.SetNowCost = function(self, cost)
		self.NowCost = cost
	end
	this.GetNowCost = function(self)
		return self.NowCost
	end
	this.AddNowCost = function(self, value)
		self.NowCost = self.NowCost + value
		if self.NowCost < 0 then
			self.NowCost = 0
		end
	end
	
	-- 最大コスト設定
	this.SetMaxCost = function(self, cost)
		self.MaxCost = cost
	end
	this.GetMaxCost = function(self)
		return self.MaxCost
	end
	this.AddMaxCost = function(self, value)
		self.MaxCost = self.MaxCost + value
		if self.MaxCost < 0 then
			self.MaxCost = 0
		end
	end

	-- 様々な状態から、コスト情報の更新をする
	this.ResetCost = function(self)
		self.MaxCost = 3
		self.NowCost = 3
	end
	
	-- サンプル
	--this.Function = function(self)
	--end

	return this
end

