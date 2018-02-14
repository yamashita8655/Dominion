--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
BattleScene = {}

-- コンストラクタ
function BattleScene.new()
	local this = SceneBase.new()

	this.StateMachine = nil

	-- 外部(主にステートマシンに対して)公開用
	this.PlayerTurnStartEffectName = ""
	this.EnemyTurnStartEffectName = ""
	this.BattleSceneName = "battlescene"

	-- メソッド定義
	-- 初期化
	this.SceneBaseInitialize = this.Initialize
	this.Initialize = function(self)
		LuaChangeScene("Battle", "MainCanvas")

		-- オブジェクトの初期設定
		if self.IsInitialized == false then
			-- マネージャ初期化
			BattleSceneCharacterDataManager.Instance():Initialize()
			PrefabManager.Instance():Initialize()
			DamageNumberEffectManager.Instance():Initialize()
			BattleCardDeckManager.Instance():Initialize()

			-- TODO 仮でデッキ構築してみる
			for i = 1, 10 do
				local uid = BattleCardDeckManager.Instance():IssueUniqueId()
				local card = CardBase.new(
					uid,
					CardConfig.CardData_0001,
					Vector3.new(0, 0, 0),
					Vector3.new(0, 0, 0),
					"Card"..i,
					256,
					256
				)
				BattleCardDeckManager.Instance():AddCardToDeckList(card)
			end

			-- ダメージ数値作成
			DamageNumberEffectManager.Instance():CreateDamageEffect(self.BattleSceneName, "BattleSceneEffectRoot")

			local player = PlayerCharacter.new()
			player:Initialize(3, 3, 100, 100, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), "Player", 256, 256)
			local enemy = EnemyCharacter.new()
			enemy:Initialize(100, 100, Vector3.new(0, 0, 0), Vector3.new(0, 0, 0), "Player", 256, 256)
			
			BattleSceneCharacterDataManager.Instance():SetPlayerCharacter(player)
			BattleSceneCharacterDataManager.Instance():SetEnemyCharacter(enemy)

			-- 操作するオブジェクトを探して登録
			-- エフェクトをアタッチするルート
			LuaFindObject("BattleSceneEffectRoot")

			-- ターン開始時のエフェクト
			self.PlayerTurnStartEffectName = PrefabManager.Instance():LoadPrefabObject(self.BattleSceneName, "PlayerTurnStartEffect", "BattleSceneEffectRoot")
			LuaSetActive(self.PlayerTurnStartEffectName, false)
			self.EnemyTurnStartEffectName = PrefabManager.Instance():LoadPrefabObject(self.BattleSceneName, "EnemyTurnStartEffect", "BattleSceneEffectRoot")
			LuaSetActive(self.EnemyTurnStartEffectName, false)
			
			-- 各プレイヤーのゲージとHPテキスト
			LuaFindObject("BattleScenePlayerImage")
			LuaFindObject("BattleScenePlayerHpGauge")
			LuaFindObject("BattleScenePlayerNowHpText")
			LuaFindObject("BattleScenePlayerMaxHpText")
			LuaFindObject("BattleSceneEnemyImage")
			LuaFindObject("BattleSceneEnemyHpGauge")
			LuaFindObject("BattleSceneEnemyNowHpText")
			LuaFindObject("BattleSceneEnemyMaxHpText")

			-- コスト設定
			LuaFindObject("BattleScenePlayerNowCostText")
			LuaFindObject("BattleScenePlayerMaxCostText")

			LuaSetText("BattleScenePlayerNowHpText", player:GetNowHp())
			LuaSetText("BattleScenePlayerMaxHpText", player:GetMaxHp())
			LuaSetText("BattleSceneEnemyNowHpText", enemy:GetNowHp())
			LuaSetText("BattleSceneEnemyMaxHpText", enemy:GetMaxHp())
			LuaSetScale("BattleScenePlayerHpGauge", player:GetNowHp()/player:GetMaxHp(), 1, 1)
			LuaSetScale("BattleSceneEnemyHpGauge", enemy:GetNowHp()/enemy:GetMaxHp(), 1, 1)
			
			-- ステートマシンマネージャテスト
			StateMachineManager.Instance():Initialize()
			StateMachineManager.Instance():CreateStateMachineMap(STATEMACHINE_NAME.Battle)
			StateMachineManager.Instance():AddState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.PlayerTurnEffect, BattleStatePlayerTurnEffect.new())
			StateMachineManager.Instance():AddState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.PlayerTurnMain, BattleStatePlayerTurnMain.new())
			StateMachineManager.Instance():AddState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.EnemyTurnEffect, BattleStateEnemyTurnEffect.new())
			StateMachineManager.Instance():AddState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.EnemyTurnMain, BattleStateEnemyTurnMain.new())
			
		end

		-- 初期化終わったら、これを呼ぶ。
		this:SceneBaseInitialize()
	end


	-- フェード後初期化
	this.SceneBaseAfterInitialize = this.AfterInitialize
	this.AfterInitialize = function(self)
		this:SceneBaseAfterInitialize()
		StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, BATTLE_STATE_DEFINE.PlayerTurnEffect)
	end

	-- 更新
	this.SceneBaseUpdate = this.Update
	this.Update = function(self, deltaTime)
		this:SceneBaseUpdate(deltaTime)
		--self.StateMachine:Update(deltaTime)
		StateMachineManager.Instance():Update(STATEMACHINE_NAME.Battle, deltaTime)
	end

	-- 終了
	this.SceneBaseEnd = this.End
	this.End = function(self)
		this:SceneBaseEnd()
	end

	-- 有効かどうか
	this.IsActive = function(self)
		return self.IsActive
	end

	-- コールバック
	this.OnClickButton = function(self, buttonName)
		local state = StateMachineManager.Instance():GetStateBase(STATEMACHINE_NAME.Battle)
		state:OnClickButton(buttonName)

		-- TODO アクセスチェック
		--LuaUnityDebugLog(CardConfig.CardData_0001.Id)
		--LuaUnityDebugLog(CardConfig.CardData_0001.CardColor)
		--LuaUnityDebugLog(CardConfig.CardData_0001.CardTypes[1])
		--LuaUnityDebugLog(CardConfig.CardData_0001.CardTypeValues[1])
	end

	return this
	--return setmetatable(this, {__index = BattleScene})
end

