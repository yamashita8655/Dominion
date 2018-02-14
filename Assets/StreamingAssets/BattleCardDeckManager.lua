--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
BattleCardDeckManager = {}

-- シングルトン用定義
local _instance = nil
function BattleCardDeckManager.Instance() 
	if not _instance then
		_instance = BattleCardDeckManager
	end

	return _instance
end

-- メソッド定義
function BattleCardDeckManager:Initialize() 
	self.CardDeckList	= {}	-- カードデッキリスト
	self.DrawPileList 	= {}	-- 山札
	self.HandList		= {}	-- 手札
	self.DiscardList	= {}	-- 捨札
	self.ExhaustList 	= {}	-- 破棄札
	
	self.UniqueIdIndex 	= 0		-- ユニークID管理
end

-- デッキ操作
function BattleCardDeckManager:AddCardToDeckList(card) 
	table.insert(self.CardDeckList, card)
end
function BattleCardDeckManager:GetCardDeckList() 
	return self.CardDeckList
end
function BattleCardDeckManager:RemoveCardDeckList(card) 
	for i = 1, #self.CardDeckList do
		local localCard = self.CardDeckList[i]
		if localCard:GetUniqueId() == card:GetUniqueId() then
			table.remove(self.CardDeckList, i)
			break;
		end
	end
end

function BattleCardDeckManager:IssueUniqueId() 
	local id = self.UniqueIdIndex
	self.UniqueIdIndex = self.UniqueIdIndex + 1
	return id
end

