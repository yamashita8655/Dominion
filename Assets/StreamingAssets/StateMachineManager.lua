--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
StateMachineManager = {}

-- シングルトン用定義
local _instance = nil
function StateMachineManager.Instance() 
	if not _instance then
		_instance = StateMachineManager
	end

	return _instance
end

-- メソッド定義
function StateMachineManager:Initialize() 
	self.StateMachineMap = {}
end

-- ステートマシンマップの作成.
function StateMachineManager:CreateStateMachineMap(machineName)
	local machine = StateMachine.new()
	machine:Initialize()
	self.StateMachineMap[machineName..""] = machine
end
	
-- ステートマシンの解放.
function StateMachineManager:Release(machineName)
	if self.StateMachineMap[machineName..""] ~= nil then
		self.StateMachineMap[machineName..""]:Release()
		self.StateMachineMap[machineName..""] = nil
	end
end
	
-- ステートの追加.
function StateMachineManager:AddState(machineName, stateType, state)
	if self.StateMachineMap[machineName..""] == nil then
		return
	end
	self.StateMachineMap[machineName..""]:AddState(stateType, state)
end

-- ステートの変更.
function StateMachineManager:ChangeState(machineName, stateType)
	if self.StateMachineMap[machineName..""] ~= nil then
		self.StateMachineMap[machineName..""]:ChangeState(stateType)
	end
end

-- 保存していたステートに変更.
function StateMachineManager:ChangeSaveState(machineName)
	if self.StateMachineMap[machineName..""] ~= nil then
		self.StateMachineMap[machineName..""]:ChangeSaveState()
	end
end

-- 現在のステート状態を保存して、ステートの変更.
function StateMachineManager:ChangeStateNowStatePause(machineName, stateType)
	if self.StateMachineMap[machineName..""] ~= nil then
		self.StateMachineMap[machineName..""]:changeStateNowStatePause(stateType)
	end
end

-- 更新.
function StateMachineManager:Update(machineName, delta)
	if self.StateMachineMap[machineName..""] ~= nil then
		self.StateMachineMap[machineName..""]:Update(delta)
	end
end

-- 一つ前のステートタイプの取得.
function StateMachineManager:GetPrevState(machineName)
	local state = nil
	if self.StateMachineMap[machineName..""] ~= nil then
		state = self.StateMachineMap[machineName..""]:GetPrevState()
	end
	
	return state;
end

-- ステートタイプの取得.
function StateMachineManager:GetState(machineName)
	local state = nil
	if self.StateMachineMap[machineName..""] ~= nil then
		state = self.StateMachineMap[machineName..""]:GetState()
	end
	
	return state;
end

-- ステートのセーブ.
function StateMachineManager:SaveState(machineName)
	if self.StateMachineMap[machineName..""] ~= nil then
		self.StateMachineMap[machineName..""]:SaveState()
	end
end

-- セーブしたステートの取得.
function StateMachineManager:GetSaveState(machineName)
	local state = nil
	if self.StateMachineMap[machineName..""] ~= nil then
		state = self.StateMachineMap[machineName..""]:GetSaveState()
	end

	return state;
end

-- ステート本体の取得.
function StateMachineManager:GetStateBase(machineName)
	local state = nil
	if self.StateMachineMap[machineName..""] ~= nil then
		state = self.StateMachineMap[machineName..""]:GetStateBase()
	end

	return state;
end
