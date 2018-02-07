--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
ObjectBase = {}

-- コンストラクタ
function ObjectBase.new()
	local this = {
		Position = Vector3.new(0, 0, 0),
		Rotate = Vector3.new(0, 0, 0),
		Name = "",
		Width = 0,
		Height = 0,
	}

	-- メソッド定義
	-- 初期化
	this.Initialize = function(self, position, rotate, name, width, height)
		self.Position = position
		self.Rotate = rotate
		self.Name = name
		self.Width = width
		self.Height = height
	end
	
	-- 座標取得
	this.GetPosition = function(self)
		return self.Position
	end
	-- 座標設定
	this.SetPosition = function(self, positionx, positiony, positionz)
		self.Position.x = positionx
		self.Position.y = positiony
		self.Position.z = positionz
	end

	-- サイズ取得
	this.GetSize = function(self) 
		return self.Width, self.Height
	end
	-- サイズ設定
	this.SetSize = function(self, width, height) 
		self.Width = width
		self.Height = height
	end

	-- 回転率取得
	this.GetRotate = function(self) 
		return self.Rotate
	end
	-- 回転率設定
	this.SetRotate = function(self, rotatex, rotatey, rotatez) 
		self.Rotate.x = rotatex
		self.Rotate.y = rotatey
		self.Rotate.z = rotatez
	end

	-- 名前取得
	this.GetName = function(self) 
		return self.Name
	end
	-- 名前設定
	this.SetName = function(self, name) 
		self.Name = name
	end
	
	-- メタテーブルセット
	--return setmetatable(this, {__index = ObjectBase})
	return this
end

