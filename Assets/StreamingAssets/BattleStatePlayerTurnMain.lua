--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
BattleStatePlayerTurnMain = {}

-- メソッド定義

-- コンストラクタ
function BattleStatePlayerTurnMain.new()
	local this = BattleStateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	
	-- 初期化処理.
	this.BattleStateOnAfterInit = this.OnAfterInit
	this.OnAfterInit = function(self)
		self:BattleStateOnAfterInit()
	end
	
	-- クリックイベントの処理
	this.BattleStateOnClickButton = this.OnClickButton
	this.OnClickButton = function(self, buttonName)
		-- ターン終了ボタン
		if buttonName == "BattleSceneTurnEndButton" then
			StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.EnemyTurnEffect)
		end
		
		-- 仮の攻撃ボタン。本来は、カードをドラッグして攻撃
		if buttonName == "BattleScenePlayerAttackButton" then
			LuaUnityDebugLog("-----ATTACK-----")
			local enemy = BattleSceneCharacterDataManager.Instance():GetEnemyCharacter()
			local damage = 10
			enemy:AddNowHp(-damage)
			LuaSetText("BattleSceneEnemyNowHpText", enemy:GetNowHp())
			LuaSetText("BattleSceneEnemyMaxHpText", enemy:GetMaxHp())
			LuaSetScale("BattleSceneEnemyHpGauge", enemy:GetNowHp()/enemy:GetMaxHp(), 1, 1)

			-- ダメージ表示
			DamageNumberEffectManager.Instance():Play(
				"BattleSceneEnemyImage",
				damage,
				function()
				end
			)

			-- コストを減らしてみる
			local player = BattleSceneCharacterDataManager.Instance():GetPlayerCharacter()
			local nowCost = player:GetNowCost()
			nowCost = nowCost - 1
			LuaSetText("BattleScenePlayerNowCostText", nowCost)

			StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.EnemyTurnEffect)
		end
	end

	return this
end

