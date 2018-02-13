--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
DamageNumberEffectManager = {}

-- シングルトン用定義
local _instance = nil
function DamageNumberEffectManager.Instance() 
	if not _instance then
		_instance = DamageNumberEffectManager
	end

	return _instance
end

-- メソッド定義
--function DamageNumberEffectManager.Initialize(self)と同じ 
function DamageNumberEffectManager:Initialize() 
	self.MaxValue = 30
	self.SpawnFlagList = {}
	self.PrefabName = "DamageNumberEffect"
	self.TextObjectName = "DamageNumberEffectText"
end

-- プレハブの読み込んで、新規でオブジェクトを生成する
function DamageNumberEffectManager:CreateDamageEffect(sceneName, defaultRootObjectName)
	for i = 1, self.MaxValue do
		local name = self.PrefabName..i
		LuaLoadPrefabAfter(sceneName, self.PrefabName, name, defaultRootObjectName)
		LuaFindChildrenObject(name, self.TextObjectName, self.TextObjectName..i)
		LuaSetActive(name, false)
		table.insert(self.SpawnFlagList, false);
	end
end

-- とはいえ、全部この関数を経由して操作させると大変なので、
-- この関数呼び出しを目印にして、このコールバックの中でのみ、自由に呼び出し元で操作できるようにするルールとしておく
function DamageNumberEffectManager:Play(parentName, damageValue, endCallback)
	for i = 1, self.MaxValue do
		if self.SpawnFlagList[i] == false then
			local name = self.PrefabName..i
			local textName = self.TextObjectName..i
			LuaSetText(self.TextObjectName..i, damageValue)
			self.SpawnFlagList[i] = true
			local index = i
			TimerCallbackManager:AddCallback(
				{self},
				function(argList)
					self = argList[1]
					-- エフェクト再生
					CallbackManager.Instance():AddCallback(
						"DamageNumberEffectCallback"..index,
						{self},
						function(arg, unityArg)
							local self = arg[1]
							self.SpawnFlagList[index] = false
							endCallback()
						end
					)
					LuaPlayAnimator(name, "Play", false, true, "LuaCallback", "DamageNumberEffectCallback"..index)
				end,
				0.1
			) 
			LuaUnityDebugLog("PLAY")
			break
		end
	end
end

-- 生成したオブジェクトを削除
function DamageNumberEffectManager:DestroyObject()
	for i = 1, self.MaxValue do
		local name = self.PrefabName..i
		LuaUnityDestroyObject(name)
	end
	self.SpawnFlagList = {}
end

