--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- プレハブ名を指定して、読み込み、オブジェクト名を返す
-- オブジェクト操作は、このマネージャを通して行うルールとする
-- 削除は、呼び出し元で行った場合は、責任をもって管理する事

-- クラス定義
PrefabManager = {}

-- シングルトン用定義
local _instance = nil
function PrefabManager.Instance() 
	if not _instance then
		_instance = PrefabManager
	end

	return _instance
end

-- メソッド定義
--function PrefabManager.Initialize(self)と同じ 
function PrefabManager:Initialize() 
	self.PrefabCounter = 0
	self.PrefabNameList = {}
end

-- プレハブの読み込んで、新規でオブジェクトを生成する
function PrefabManager:LoadPrefabObject(sceneName, prefabName, rootObjectName)
	local name = prefabName..self.PrefabCounter
	LuaLoadPrefabAfter(sceneName, prefabName, name, rootObjectName)
	self.PrefabCounter = self.PrefabCounter + 1
	table.insert(self.PrefabNameList, name);

	return name
end

-- とはいえ、全部この関数を経由して操作させると大変なので、
-- この関数呼び出しを目印にして、このコールバックの中でのみ、自由に呼び出し元で操作できるようにするルールとしておく
function PrefabManager:StartPrefabOperation(prefabName, callback)
	local name = self.PrefabNameList[prefabName]
	if name == nil then
		name = ""
	end
	
	callback(name)
end

-- 生成したオブジェクトを削除
function PrefabManager:DestroyPrefab()
	for key, val in pairs(self.PrefabNameList) do
		LuaUnityDestroyObject(val)
	end
end

----・おｋ、定義をはっきりさせる
----・Unity上のオブジェクトと関連しているのを、実体オブジェクト
----・Lua側で、処理に使っている弾情報を、弾オブジェクト
----としよう
----
----・実態オブジェクトは、マガジンリストと発射済みリストを行き来させる
----・弾オブジェクトは、その都度必要になる情報が事なるので、発射する時に新規で作っては削除する
----	⇒まぁこれも、処理のネックになりそうだったら、プールしておく方向に切り替える
----
----・弾を撃つ時に
----	・オブジェクトを
----	・オブジェクトが有効な物を取得
----		⇒有効無効の判断はどうする？
----	・取得した物を発射
----		⇒座標と角度と弾の属性とキャラタイプ等
----	・オブジェクトを
--
--function BulletManager:ShootBulletTest(posx, posy, degree, bulletConfig, characterType)
--	local canList = nil
--	local nowList = nil
--	if characterType == CharacterType.Player then
--		canList = self.PlayerBulletCanShootList
--		nowList = self.PlayerBulletNowShooting
--	elseif characterType == CharacterType.Enemy then
--		canList = self.EnemyBulletCanShootList
--		nowList = self.EnemyBulletNowShooting
--	end
--		
--	self:LocalShootBulletTest(posx, posy, degree, bulletConfig, characterType, canList, nowList)
--end
--
--function BulletManager:LocalShootBulletTest(posx, posy, degree, bulletConfig, characterType, canShootingList, nowShootingList)
--	local prefabName = bulletConfig.PrefabName
--	LuaUnityDebugLog(prefabName)
--	if #canShootingList[prefabName] == 0 then
--		return
--	end
--
--	local name = table.remove(canShootingList[prefabName], 1)
--	table.insert(nowShootingList[prefabName], name)
--
--	local moveController = nil
--	if bulletConfig.MoveType:MoveType() == MoveTypeEnum.Straight then
--		moveController = MoveControllerStraight.new()
--	elseif bulletConfig.MoveType:MoveType() == MoveTypeEnum.SinCurve then
--		moveController = MoveControllerSinCurve.new()
--	elseif bulletConfig.MoveType:MoveType() == MoveTypeEnum.Homing then
--		moveController = MoveControllerHoming.new()
--	elseif bulletConfig.MoveType:MoveType() == MoveTypeEnum.Circle then
--		moveController = MoveControllerCircle.new()
--	end
--	moveController:Initialize(bulletConfig.MoveType)--movespeed。後から設定しなおす
--	
--	local bullet = nil
--	if bulletConfig.BulletType == BulletTypeEnum.Normal then
--		bullet = NormalBullet.new(Vector3.new(posx, posy, 0), Vector3.new(0, 0, degree), name, self.BulletCounter, bulletConfig.Width, bulletConfig.Height)
--		bullet:Initialize(bulletConfig.NowHp, bulletConfig.MaxHp, bulletConfig.Attack, bulletConfig.ExistTime, bulletConfig)
--	elseif bulletConfig.BulletType == BulletTypeEnum.UseTargetPosition then
--		bullet = HomingBullet.new(Vector3.new(posx, posy, 0), Vector3.new(0, 0, degree), name, self.BulletCounter, bulletConfig.Width, bulletConfig.Height)
--		bullet:Initialize(bulletConfig.NowHp, bulletConfig.MaxHp, bulletConfig.Attack, bulletConfig.ExistTime, bulletConfig)
--	end
--
--	bullet:SetMoveController(moveController)
--	self:AddBulletList(bullet, characterType) 
--
--	--一瞬、前の弾が消えた所に表示されるので、座標をリセットする
--	--ここでやるのが正しいのか若干疑問が残る
--	LuaSetPosition(name, posx, posy, 0)
--	LuaSetRotate(name, 0, 0, degree)
--	LuaSetActive(name, true)
--end
--
--
--
--function BulletManager:CreateBullet(posx, posy, degree, bulletConfig, characterType)
--	local name = "BulletObject"..self.BulletCounter
--	LuaLoadPrefabAfter("battlescene", bulletConfig.PrefabName, name, "PlayerBulletRoot")
--	LuaFindObject(name)
--	LuaSetPosition(name, posx, posy, 0)
--	LuaSetRotate(name, 0, 0, degree)
--	
--	local moveController = nil
--	if bulletConfig.MoveType:MoveType() == MoveTypeEnum.Straight then
--		moveController = MoveControllerStraight.new()
--	elseif bulletConfig.MoveType:MoveType() == MoveTypeEnum.SinCurve then
--		moveController = MoveControllerSinCurve.new()
--	elseif bulletConfig.MoveType:MoveType() == MoveTypeEnum.Homing then
--		moveController = MoveControllerHoming.new()
--	end
--	moveController:Initialize(bulletConfig.MoveType)--movespeed。後から設定しなおす
--	
--	local bullet = nil
--	if bulletConfig.BulletType == BulletTypeEnum.Normal then
--		bullet = NormalBullet.new(Vector3.new(posx, posy, 0), Vector3.new(0, 0, degree), name, self.BulletCounter, bulletConfig.Width, bulletConfig.Height)
--		bullet:Initialize(bulletConfig.NowHp, bulletConfig.MaxHp, bulletConfig.Attack, bulletConfig.ExistTime) --this.Initialize = function(self, nowHp, maxHp, attack, existTime)
--	elseif bulletConfig.BulletType == BulletTypeEnum.UseTargetPosition then
--		bullet = HomingBullet.new(Vector3.new(posx, posy, 0), Vector3.new(0, 0, degree), name, self.BulletCounter, bulletConfig.Width, bulletConfig.Height)
--		bullet:Initialize(bulletConfig.NowHp, bulletConfig.MaxHp, bulletConfig.Attack, bulletConfig.ExistTime) --this.Initialize = function(self, nowHp, maxHp, attack, existTime)
--	end
--
--	bullet:SetMoveController(moveController)
--
--	self.BulletCounter = self.BulletCounter + 1
--	self:AddBulletList(bullet, characterType) 
--end
--
--function BulletManager:AddBulletList(bullet, characterType) 
--	if characterType == CharacterType.Player then
--		table.insert(self.PlayerBulletList, bullet)
--	elseif characterType == CharacterType.Enemy then
--		table.insert(self.EnemyBulletList, bullet)
--	end
--end
--
--function BulletManager:Update(deltaTime) 
--	local playerBulletCount = #self.PlayerBulletList
--	for i = 1 , playerBulletCount do
--		self.PlayerBulletList[i]:Update(deltaTime)
--	end
--	
--	local enemyBulletCount = #self.EnemyBulletList
--	for i = 1 , enemyBulletCount do
--		self.EnemyBulletList[i]:Update(deltaTime)
--	end
--	
--	self:CheckBulletExist(self.PlayerBulletList, self.PlayerBulletNowShooting, self.PlayerBulletCanShootList)
--	self:CheckBulletExist(self.EnemyBulletList, self.EnemyBulletNowShooting, self.EnemyBulletCanShootList)
--	
--	self:SetTargetPosition(self.PlayerBulletList) 
--	self:SetTargetPosition(self.EnemyBulletList) 
--end
--
--function BulletManager:SetTargetPosition(list) 
--	for i = 1, #list do
--		bullet = list[i]
--		if bullet:GetBulletType() == BulletTypeEnum.UseTargetPosition then
--			if bullet:GetTarget() == nil or bullet:GetTarget():IsAlive() == false then
--				if bullet:GetBulletType() == BulletTypeEnum.UseTargetPosition then
--					bulletPosition = bullet:GetPosition()
--					enemyList = EnemyManager:GetList()
--					if #enemyList == 0 then
--					else
--						enemy = enemyList[1]
--						enemyPosition = enemy:GetPosition()
--						posx = enemyPosition.x - bulletPosition.x
--						posy = enemyPosition.y - bulletPosition.y
--						length = math.sqrt((posx*posx)+(posy*posy))
--						nearLength = length
--						nearEnemy = enemy
--						for j = 2, #enemyList do
--							enemy = enemyList[j]
--							enemyPosition = enemy:GetPosition()
--							posx = enemyPosition.x - bulletPosition.x
--							posy = enemyPosition.y - bulletPosition.y
--							length = math.sqrt((posx*posx)+(posy*posy))
--							if length < nearLength then
--								nearLength = length
--								nearEnemy = enemy
--							end
--						end
--						bullet:SetTarget(nearEnemy)
--					end
--				end
--			else
--			end
--		end
--	end
--end
--
--function BulletManager:CheckBulletExist(list, nowShootingList, canShootingList) 
--	--弾の生存期間をチェックして、削除する時間があったら、Unity側のオブジェクトを消してリストから消去
--	local index = 1
--	while true do
--		if index > #list then
--			break
--		end
--
--		local bullet = list[index]
--		local IsAlive = bullet:IsAlive()
--		if IsAlive then
--			index = index + 1
--		else
--			LuaSetActive(bullet:GetName(), false)
--			local bulletConfig = bullet:GetBulletConfig()
--			local name = table.remove(nowShootingList[bulletConfig.PrefabName], 1)
--			table.insert(canShootingList[bulletConfig.PrefabName], name)
--			table.remove(list, index)
--		end
--	end
--end
--
--function BulletManager:RemoveDeadObject()
--	self:LocalRemoveDeadObject(self.PlayerBulletList, self.PlayerBulletNowShooting, self.PlayerBulletCanShootList)
--	self:LocalRemoveDeadObject(self.EnemyBulletList, self.EnemyBulletNowShooting, self.EnemyBulletCanShootList)
--end
--
--function BulletManager:LocalRemoveDeadObject(list, nowShootingList, canShootingList)
--	local index = 1
--	while true do
--		if index <= #list then
--			local obj = list[index]
--			if obj:IsAlive() == false then
--				LuaSetActive(obj:GetName(), false)
--				local bulletConfig = obj:GetBulletConfig()
--				local name = table.remove(nowShootingList[bulletConfig.PrefabName], 1)
--				table.insert(canShootingList[bulletConfig.PrefabName], name)
--				table.remove(list, index)
--			else
--				index = index + 1
--			end
--		else
--			break
--		end
--	end
--end
--
--function BulletManager:Release()
--	--self.LocalRelease(self.PlayerBulletList)
--	--self.LocalRelease(self.EnemyBulletList)
--	for i,list in pairs(self.PlayerBulletNowShooting) do
--		self.LocalRelease(list)
--	end
--	for i,list in pairs(self.PlayerBulletCanShootList) do
--		self.LocalRelease(list)
--	end
--	for i,list in pairs(self.EnemyBulletNowShooting) do
--		self.LocalRelease(list)
--	end
--	for i,list in pairs(self.EnemyBulletCanShootList) do
--		self.LocalRelease(list)
--	end
--end
--
--function BulletManager.LocalRelease(list)
--	--local index = 1
--	--while true do
--	--	if index <= #list then
--	--		local obj = list[index]
--	--		LuaUnityDebugLog("Destroy:"..obj:GetName())
--	--		LuaDestroyObject(obj:GetName())
--	--		table.remove(list, index)
--	--	else
--	--		break
--	--	end
--	--end
--	for i = 1, #list do
--		LuaDestroyObject(list[i])
--	end
--end
