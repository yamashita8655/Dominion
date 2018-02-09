--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
BattleSceneCharacterDataManager = {}

-- シングルトン用定義
local _instance = nil
function BattleSceneCharacterDataManager.Instance() 
	if not _instance then
		_instance = BattleSceneCharacterDataManager
	end

	return _instance
end

-- メソッド定義
function BattleSceneCharacterDataManager:Initialize() 
	self.PlayerCharacter = nil
	self.EnemyCharacter = nil
end

-- プレイヤーの登録
function BattleSceneCharacterDataManager:SetPlayerCharacter(character) 
	self.PlayerCharacter = character
end
function BattleSceneCharacterDataManager:GetPlayerCharacter() 
	return self.PlayerCharacter
end

-- 敵の登録
function BattleSceneCharacterDataManager:SetEnemyCharacter(enemy) 
	self.EnemyCharacter = enemy
end
function BattleSceneCharacterDataManager:GetEnemyCharacter() 
	return self.EnemyCharacter
end

