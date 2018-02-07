--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義

MACHINE_STATE = {
	NONE			= 1,
	BEFORE_INIT		= 2,
	UPDATE_INIT		= 3,
	AFTER_INIT		= 4,
	BEFORE_MAIN		= 5,
	UPDATE_MAIN		= 6,
	AFTER_MAIN		= 7,
	BEFORE_END		= 8,
	UPDATE_END		= 9,
	AFTER_END		= 10,
	RELEASE			= 11,
}

StateMachine = {}

-- コンストラクタ
function StateMachine.new()
	local this = {
		NowState = nil,
		ManageState = MACHINE_STATE.NONE,
		State = 0,
		NextState = 0,
		PrevState = 0,
		SaveState = 0,
		StateMap = {},
	}

	-- メソッド定義
	-- 初期化
	this.Initialize = function(self)
		self.NowState    = nil
		self.ManageState = MACHINE_STATE.NONE
		self.State       = 0
		self.NextState   = 0
		self.PrevState   = 0
		self.SaveState   = 0
		self.StateMap    = {}
	end
	
	-- 停止中かどうか.
	this.Update = function(self, delta)
		if self.NowState == nil then
			return
		end

		if self.ManageState == MACHINE_STATE.BEFORE_INIT then
			if self.NowState:IsPause() == true then
				-- ポーズ状態だったら、即メインのアップデート処理状態にする
				self.ManageState = MACHINE_STATE.UPDATE_MAIN
				self.NowState:PauseDisable()
			else
				self.ManageState = MACHINE_STATE.UPDATE_INIT
				self.NowState:_OnBeforeInit()
			end
		
		elseif self.ManageState == MACHINE_STATE.UPDATE_INIT then
			isEnd = self.NowState:OnUpdateInit(delta)
			if isEnd == true then
				self.ManageState = MACHINE_STATE.AFTER_INIT
			end
	
		elseif self.ManageState == MACHINE_STATE.AFTER_INIT then
			self.ManageState = MACHINE_STATE.BEFORE_MAIN
			self.NowState:OnAfterInit()
		
		elseif self.ManageState == MACHINE_STATE.BEFORE_MAIN then
			self.ManageState = MACHINE_STATE.UPDATE_MAIN
			self.NowState:OnBeforeMain()
		
		elseif self.ManageState == MACHINE_STATE.UPDATE_MAIN then
			self.NowState:OnUpdateMain(delta)
		
		elseif self.ManageState == MACHINE_STATE.AFTER_MAIN then
			self.ManageState = MACHINE_STATE.BEFORE_END
			self.NowState:OnAfterMain()
		
		elseif self.ManageState == MACHINE_STATE.BEFORE_END then
			self.ManageState = MACHINE_STATE.UPDATE_END
			self.NowState:OnBeforeEnd()
		
		elseif self.ManageState == MACHINE_STATE.UPDATE_END then
			isEnd = self.NowState:OnUpdateEnd(delta)
			if isEnd == true then
				self.ManageState = MACHINE_STATE.AFTER_END
			end
		
		elseif self.ManageState == MACHINE_STATE.AFTER_END then
			self.ManageState = MACHINE_STATE.RELEASE
			self.NowState:OnAfterEnd()

		elseif self.ManageState == MACHINE_STATE.RELEASE then
			self.ManageState = MACHINE_STATE.BEFORE_INIT
			if self.NowState:IsPause() ~= true then
				self.NowState:_OnRelease()
			end
			
			self.PrevState = self.State
			self.State = self.NextState
			
			-- TODO あとできちんとした処理に修正する
			self.NowState = self.StateMap[self.State..""]
		end
	end
	
	-- 解放処理.
	this.Release = function(self)
		for key, val in pairs(self.StateMap) do
			if val:IsInitCalled() == true then
				val:_OnRelease()
			end
		end
		self.StateMap = {}
		self.NowState = nil
	end
	
	-- ステートの変更.
	this.ChangeState = function(self, stateType)
		-- 仮 ここ、直す必要がある。途中で呼び出された場合に、流れがおかしくなる可能性がある
		if (self.ManageState ~= MACHINE_STATE.AFTER_INIT) and
		   (self.ManageState ~= MACHINE_STATE.UPDATE_MAIN)		then
			LuaUnityDebugLog("StateMachine::changeState")
			LuaUnityDebugLog(self.ManageState.." state isnt use changeState")
		end

		if self.NowState ~= nil then
			self.NextState = stateType
			self.ManageState = MACHINE_STATE.AFTER_MAIN
		else
			self.NowState = self.StateMap[stateType..""]
			self.ManageState = MACHINE_STATE.BEFORE_INIT
		end
	end
	
	-- 今居るステートを保存して、戻れるようにしておく.
	this.ChangeSaveState = function(self)
		this.changeState(self. SaveState)
	end
	
	-- 今のステートを保存して、次回戻ってきた際に初期化処理を呼ばないようにしたステートの変更.
	this.ChangeStateNowStatePause = function(self, stateType)
		if (self.ManageState ~= MACHINE_STATE.AFTER_INIT) and
		   (self.ManageState ~= MACHINE_STATE.UPDATE_MAIN)		then
			LuaUnityDebugLog("StateMachine::changeState")
			LuaUnityDebugLog(self.ManageState.." state isnt use changeState")
		end

		if self.NowState ~= nil then
			self.NowState:PauseEnable()
			self.NextState = stateType
			self.ManageState = MACHINE_STATE.RELEASE-- 即リリース状態にしているが、PAUSEをかけているので、リリースの処理は呼び出されない
		else
			self.NowState = self.StateMap[stateType..""]
			self.ManageState = MACHINE_STATE.BEFORE_INIT
		end
	end

	-- ステートの追加.
	this.AddState = function(self, stateType, state)
		if self.StateMap[stateType..""] ~= nil then
			return
		end
		self.StateMap[stateType..""] = state-- ステートタイプを文字列変換して、連想配列のキーにする
	end
	
	-- ステートの取得.
	this.GetState = function(self)
		return self.State
	end
	
	-- 一個前のステートの取得.
	this.GetPrevState = function(self)
		return self.PrevState
	end
	
	-- ステートのセーブ
	this.SaveState = function(self)
		self.SaveState = self.State
	end
	
	-- セーブしたステートの取得.
	this.GetSaveState = function(self)
		return self.SaveState
	end

	-- ステート本体の取得.
	this.GetStateBase = function(self)
		return self.NowState
	end
	
	return this
end
