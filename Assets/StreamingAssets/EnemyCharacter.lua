--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
EnemyCharacter = {}

-- メソッド定義

-- コンストラクタ
function EnemyCharacter.new()
	local this = CharacterBase.new()
	
	-- メンバ変数
	--this.Member = 0.0

	-- メソッド定義
	-- 初期化
	this.EnemyCharacterInitialize = this.Initialize
	this.Initialize = function(self, nowHp, maxHp, position, rotate, name, width, height)
		this:EnemyCharacterInitialize(nowHp, maxHp, position, rotate, name, width, height)
		--self.Member = member
	end
	
	-- サンプル
	--this.Function = function(self)
	--end

	return this
end

