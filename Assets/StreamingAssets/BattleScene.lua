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
		this:SceneBaseInitialize()
		LuaChangeScene("Battle", "MainCanvas")

		-- バーチャルテスト的な
		--LuaUnityDebugLog("-----Start-----")
		--state = BattleState.new()
		--state:_OnBeforeInit()
		--LuaUnityDebugLog("-----End-----")
		
		-- ステートマシンテスト
		self.StateMachine = StateMachine.new()
		self.StateMachine:Initialize()
		self.StateMachine:AddState(0, BattleState.new())
		self.StateMachine:AddState(1, BattleSecondState.new())
		self.StateMachine:ChangeState(0)
	end


	-- フェード後初期化
	this.SceneBaseAfterInitialize = this.AfterInitialize
	this.AfterInitialize = function(self)
		this:SceneBaseAfterInitialize()
	end
	
	-- 更新
	this.SceneBaseUpdate = this.Update
	this.Update = function(self, deltaTime)
		this:SceneBaseUpdate(deltaTime)
		self.StateMachine:Update(deltaTime)
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
		if buttonName == "BattleSceneChangeStateButton" then
			--SceneManager.Instance():ChangeScene(SceneNameEnum.Home)
			LuaUnityDebugLog(self.StateMachine:GetState())
			if self.StateMachine:GetState() == 0 then
				self.StateMachine:ChangeState(1)
			else
				self.StateMachine:ChangeState(0)
			end
		end
	end
	
	return this
	--return setmetatable(this, {__index = BattleScene})
end

