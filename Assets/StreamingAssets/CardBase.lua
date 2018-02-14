--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
CardBase = {}

-- メソッド定義

-- コンストラクタ
function CardBase.new()
	local this = ObjectBase.new()
	
	-- メンバ変数
	this.UniqueId = 0
	this.CardDataConfig = nil

	-- メソッド定義
	-- 初期化
	this.CardBaseInitialize = this.Initialize
	this.Initialize = function(self, uniqueId, cardDataConfig, position, rotate, name, width, height)
		this:ObjectBaseInitialize(position, rotate, name, width, height)
		self.UniqueId = uniqueId
		self.CardDataConfig = cardDataConfig
	end
	
	this.GetUniqueId = function(self)
		return self.UniqueId
	end
	
	this.GetCardDataConfig = function(self)
		return self.CardDataConfig
	end
	
	return this
end

