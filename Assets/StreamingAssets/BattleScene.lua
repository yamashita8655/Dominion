--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
BattleScene = {}

-- コンストラクタ
function BattleScene.new()
	local this = SceneBase.new()

	this.StateMachine = nil

	-- メソッド定義
	-- 初期化
	this.SceneBaseInitialize = this.Initialize
	this.Initialize = function(self)
		LuaChangeScene("Battle", "MainCanvas")

		-- オブジェクトの初期設定
		if self.IsInitialized == false then
			-- 操作するオブジェクトを探して登録
			-- エフェクトをアタッチするルート
			LuaFindObject("BattleSceneEffectRoot")

			-- ターン開始時のエフェクト
			LuaLoadPrefabAfter("battlescene", "PlayerTurnStartEffect", "PlayerTurnStartEffect", "BattleSceneEffectRoot")
			LuaSetActive("PlayerTurnStartEffect", false)
			LuaLoadPrefabAfter("battlescene", "EnemyTurnStartEffect", "EnemyTurnStartEffect", "BattleSceneEffectRoot")
			LuaSetActive("EnemyTurnStartEffect", false)
			
			-- 各プレイヤーのゲージとHPテキスト
			LuaFindObject("BattleScenePlayerHpGauge")
			LuaFindObject("BattleScenePlayerNowHpText")
			LuaFindObject("BattleScenePlayerMaxHpText")
			LuaFindObject("BattleSceneEnemyHpGauge")
			LuaFindObject("BattleSceneEnemyNowHpText")
			LuaFindObject("BattleSceneEnemyMaxHpText")
			
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
		--if buttonName == "BattleSceneChangeStateButton" then
		--	--SceneManager.Instance():ChangeScene(SceneNameEnum.Home)
		--	if StateMachineManager.Instance():GetState(STATEMACHINE_NAME.Battle) == 0 then
		--		StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, 1)
		--	else
		--		StateMachineManager.Instance():ChangeState(STATEMACHINE_NAME.Battle, 0)
		--	end
		--end
	end

	return this
	--return setmetatable(this, {__index = BattleScene})
end

