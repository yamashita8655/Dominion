--直接Unityには登録しないスクリプト。いわゆる、ライブラリ化した奴

-- クラス定義
-- キャラ基本クラス
-- ステートにクリックは要らないけど、ゲーム実装する際に必要な共有イベントがいくつかあるので
-- その為のベースクラス
BattleStateBase = {}

-- メソッド定義

-- コンストラクタ
function BattleStateBase.new()
	local this = StateBase.new()
	
	-- メンバ変数

	-- メソッド定義
	-- クリックイベントの処理
	this.OnClickButton = function(self, buttonName)
	end

	return this
end

