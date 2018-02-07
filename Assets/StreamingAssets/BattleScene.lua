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

		-- オブジェクトベーステスト
		LuaUnityDebugLog("-----Start-----");
		testObj = ObjectBase.new();
		testObj:Initialize(Vector3.new(1,2,3), Vector3.new(0.1,2.0,3.5), "test", 300, 400);
		LuaUnityDebugLog(testObj:GetPosition().x..testObj:GetPosition().y..testObj:GetPosition().z);
		LuaUnityDebugLog(testObj:GetRotate().x..testObj:GetRotate().y..testObj:GetRotate().z);
		LuaUnityDebugLog(testObj:GetName());
		local width, height = testObj:GetSize()
		LuaUnityDebugLog(width..height);

		LuaUnityDebugLog("-----End-----");
		
		-- キャラベーステスト
		LuaUnityDebugLog("-----Start-----");
		testObj2 = CharacterBase.new();
		testObj2:Initialize(50, 30, Vector3.new(1,2,3), Vector3.new(0.1,2.0,3.5), "test", 300, 400);
		LuaUnityDebugLog(testObj2:GetNowHp());
		LuaUnityDebugLog(testObj2:GetMaxHp());
		LuaUnityDebugLog(testObj2:GetPosition().x..testObj2:GetPosition().y..testObj2:GetPosition().z);
		LuaUnityDebugLog(testObj2:GetRotate().x..testObj2:GetRotate().y..testObj2:GetRotate().z);
		LuaUnityDebugLog(testObj2:GetName());
		local width, height = testObj2:GetSize()
		LuaUnityDebugLog(width..height);
		LuaUnityDebugLog("-----End-----");
		
		-- 味方キャラテスト
		LuaUnityDebugLog("-----Player:Start-----");
		player = PlayerCharacter.new();
		player:Initialize(50, 30, Vector3.new(1,2,3), Vector3.new(0.1,2.0,3.5), "test", 300, 400);
		LuaUnityDebugLog(player:GetNowHp());
		LuaUnityDebugLog(player:GetMaxHp());
		LuaUnityDebugLog(player:GetPosition().x..player:GetPosition().y..player:GetPosition().z);
		LuaUnityDebugLog(player:GetRotate().x..player:GetRotate().y..player:GetRotate().z);
		LuaUnityDebugLog(player:GetName());
		local width, height = player:GetSize()
		LuaUnityDebugLog(width..height);
		LuaUnityDebugLog("-----Player:End-----");
		
		-- 味方キャラテスト
		LuaUnityDebugLog("-----Enemy:Start-----");
		enemy = EnemyCharacter.new();
		enemy:Initialize(50, 30, Vector3.new(1,2,3), Vector3.new(0.1,2.0,3.5), "test", 300, 400);
		LuaUnityDebugLog(enemy:GetNowHp());
		LuaUnityDebugLog(enemy:GetMaxHp());
		LuaUnityDebugLog(enemy:GetPosition().x..enemy:GetPosition().y..enemy:GetPosition().z);
		LuaUnityDebugLog(enemy:GetRotate().x..enemy:GetRotate().y..enemy:GetRotate().z);
		LuaUnityDebugLog(enemy:GetName());
		local width, height = enemy:GetSize()
		LuaUnityDebugLog(width..height);
		LuaUnityDebugLog("-----Enemy:End-----");
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

