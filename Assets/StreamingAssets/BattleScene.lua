--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
BattleScene = {}

-- コンストラクタ
function BattleScene.new()
	local this = SceneBase.new()

	--this.Test = 0

	-- メソッド定義
	-- 初期化
	this.SceneBaseInitialize = this.Initialize
	this.Initialize = function(self)
		this:SceneBaseInitialize()
		LuaChangeScene("Battle", "MainCanvas")
	end


	-- フェード後初期化
	this.SceneBaseAfterInitialize = this.AfterInitialize
	this.AfterInitialize = function(self)
		this:SceneBaseAfterInitialize()
		testObj = ObjectBase.new();
		LuaUnityDebugLog(testObj:GetPosition().x..testObj:GetPosition().y..testObj:GetPosition().z);
	end
	
	-- 更新
	this.SceneBaseUpdate = this.Update
	this.Update = function(self, deltaTime)
		this:SceneBaseUpdate(deltaTime)
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
		if buttonName == "" then
			--SceneManager.Instance():ChangeScene(SceneNameEnum.Home)
		end
	end
	
	return this
	--return setmetatable(this, {__index = BattleScene})
end

