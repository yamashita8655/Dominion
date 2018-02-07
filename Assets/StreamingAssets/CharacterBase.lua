--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
CharacterBase = {}

-- メソッド定義

-- コンストラクタ
function CharacterBase.new()
	local this = ObjectBase.new()
	
	-- メンバ変数
	this.NowHp = 0.0
	this.MaxHp = 0.0

	-- メソッド定義
	-- 初期化
	this.ObjectBaseInitialize = this.Initialize
	this.Initialize = function(self, nowHp, maxHp, position, rotate, name, width, height)
		this:ObjectBaseInitialize(position, rotate, name, width, height)
		self.NowHp = nowHp
		self.MaxHp = maxHp
	end
	
	-- 現在HP取得
	this.GetNowHp = function(self)
		return self.NowHp
	end
	-- 現在HP上書き
	this.SetNowHp = function(self, value)
		self.NowHp = value
	end
	-- 現在HP加算
	this.AddNowHp = function(self, addValue)
		self.NowHp = self.NowHp + addValue
	end
	
	-- 最大HP取得
	this.GetMaxHp = function(self)
		return self.MaxHp
	end
	-- 最大HP上書き
	this.SetMaxHp = function(self, value)
		self.MaxHp = value
	end
	-- 最大HP加算
	this.AddMaxHp = function(self, addValue)
		self.MaxHp = self.MaxHp + addValue
	end
	
	-- サンプル
	--this.Function = function(self)
	--end

	-- メタテーブルセット
	--return setmetatable(this, {__index = CharacterBase})
	return this
end

