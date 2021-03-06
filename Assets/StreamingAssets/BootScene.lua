﻿--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
BootScene = {}

-- コンストラクタ
function BootScene.new()
	local this = SceneBase.new()

	--this.Test = 0

	-- メソッド定義
	-- 初期化
	this.SceneBaseInitialize = this.Initialize
	this.Initialize = function(self)
		this:SceneBaseInitialize()
		--LuaSetActive("InAppRootObject", false)-- 場所が飛びまくってわかりづらいが、ここで、ゲーム開始時の情報オブジェクトを非表示にする
		LuaChangeScene("Boot", "MainCanvas")
	end
	
	-- 初期化
	this.SceneBaseAfterInitialize = this.AfterInitialize
	this.AfterInitialize = function(self)
		this:SceneBaseAfterInitialize()
		--SceneManager.Instance():ChangeScene(SceneNameEnum.Quest)
		--SceneManager.Instance():ChangeScene(SceneNameEnum.Title)
		--SceneManager.Instance():ChangeScene(SceneNameEnum.Battle)
		--SceneManager.Instance():ChangeScene(SceneNameEnum.Custom)
		--SceneManager.Instance():ChangeScene(SceneNameEnum.Gacha)
		--SceneManager.Instance():ChangeScene(SceneNameEnum.Home)
--		FileIOManager.Instance():Load(this.EndSaveFileLoadCallback)
		TimerCallbackManager:AddCallback({}, self.SceneChange, 1) 
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
	
	-- シーン変更
	-- AfterInitializeで行っていない理由は、同一フレーム上で、FadeObjectのアクティブのオンオフを行ってしまう、正常に動かなくなってしまうから
	this.SceneChange = function()
		SceneManager.Instance():ChangeScene(SceneNameEnum.Battle)
	end
	
	-- セーブファイル読み込み終了時コールバック処理
	this.EndSaveFileLoadCallback = function()
		LuaUnityDebugLog("EndSaveFileLoadCallback")
		customSelectIndex = SaveObject.CustomScene_SelectIndex
		GameManager.Instance():SetSelectPlayerCharacterData(PlayerCharacterConfig[customSelectIndex])

		GameManager:SetKarikariValue(SaveObject.CustomScene_HaveKarikariValue)
		--GameManager:SetKarikariValue(1000)
		
		GameManager:SetMochiPointValue(SaveObject.HaveMochiPointValue)
		GameManager:SetBillingPointValue(SaveObject.HaveBillingPointValue)
		GameManager:SetSpecialPointValue(SaveObject.HaveSpecialPointValue)
		
		LuaUnityDebugLog("ChangeSceneBefore")

		--SceneManager.Instance():ChangeScene(SceneNameEnum.Quest)
		SceneManager.Instance():ChangeScene(SceneNameEnum.Title)
		--SceneManager.Instance():ChangeScene(SceneNameEnum.Custom)
		--SceneManager.Instance():ChangeScene(SceneNameEnum.Gacha)
		--SceneManager.Instance():ChangeScene(SceneNameEnum.Home)
	end
	
	return this
end

