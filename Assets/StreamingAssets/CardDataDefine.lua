--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

CARD_COLOR = {
	ColorLess = 0,
	Red = 1,
	Greed = 2,
}

CARD_TYPE = {
	Damage = 0,
	Guard = 1,
}

-- クラス定義
CardTemplate = {}

-- コンストラクタ
function CardTemplate.new(id, name, color, types, typeValues, cost, description)
	local this = {
		Id = id,
		Name = name,
		Color = color,
		Types = types,
		TypeValues = typeValues,
		Cost = cost,
		Description = description,
	}
	
	this.Clone = function(self)
		local clone = CardTemplate.new(
			self.Id,
			self.Name,
			self.Color,
			self.Types,
			self.TypeValues,
			self.Cost,
			self.Description
		)
		return clone
	end

	return this
end


CardConfig = {
	CardData_0001 = CardTemplate.new(
		"CardData_0001",
		"スラッシュ",
		CARD_COLOR.ColorLess,
		{ CARD_TYPE.Damage },
		{ 5 },
		1,
		"5ダメージを与える"
	),
}

