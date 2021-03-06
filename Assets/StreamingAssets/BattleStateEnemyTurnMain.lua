﻿--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStateEnemyTurnMain = {}

-- メソッド定義

-- コンストラクタ
function BattleStateEnemyTurnMain.new()
	local this = BattleStateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	
	-- 初期化前処理.
	this.BattleStateOnAfterInit = this.OnAfterInit
	this.OnAfterInit = function(self)
		self:BattleStateOnAfterInit()
		
		local player = BattleSceneCharacterDataManager.Instance():GetPlayerCharacter()
		local damage = 10
		player:AddNowHp(-damage)
		LuaSetText("BattleScenePlayerNowHpText", player:GetNowHp())
		LuaSetText("BattleScenePlayerMaxHpText", player:GetMaxHp())
		LuaSetScale("BattleScenePlayerHpGauge", player:GetNowHp()/player:GetMaxHp(), 1, 1)
			
		-- ダメージ表示
		DamageNumberEffectManager.Instance():Play(
			"BattleScenePlayerImage",
			damage,
			function()
			end
		)
		
		StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.PlayerTurnEffect)
	end

	return this
end

