# encoding: utf-8
Dir['./model/*.rb'].each { |file| require file }

class GameController
  attr_reader :hero, :monster
  def initialize(hero, monster)
    @hero = hero
    @monster = monster
    @players = []

    @hero.team = "hero" if @hero.team.nil?
    @hero.mode = "auto" if hero.mode.nil?
    @players.push(@hero)

    if @monster.kind_of?(Array)
      @monster.each do |m|
        m.team = "monster" if m.team.nil?
        @players.push(m)
      end
    else
      @monster.team = "monster" if @monster.team.nil?
      @players.push(@monster)
    end

    @teams = extract_team(@players)
  end

  def run
    players = @players

    # 行動順決め(spd順に並び替え)
    players.sort! do |a, b|
      b.spd <=> a.spd
    end

    system('clear')
    # 終了を満たすまで繰り返し
    turn = 0
    until gameset?(players)
      turn += 1
      players.each do |player|
        break if player.hp <= 0
        enemies = []
        (players - [player]).each do |suspect|
          if enemy?(suspect, player)
            enemies.push(suspect)
          end
        end

        # 勇者がプレーヤー操作の場合
        if player.team == "hero" && player.mode == "manual"
          # 自分と敵のステータスを表示
          puts "\n[-------------------------------------------------]"
          puts "[#{player.name}]  HP: #{player.hp}, MP: #{player.mp}"
          puts "[Enemy list]"
          enemy_num = 0
          enemies.each do |enemy|
            puts " No.[#{enemy_num}] #{enemy.name} (HP: #{enemy.hp})"
            enemy_num += 1
          end
          puts ""

          #### 行動入力パターン
          # 1. 攻撃する相手を選んで攻撃する。 →　敵の番号を入力 (0～)
          # 2. 回復魔法を唱える
          # 3. 逃げる(強制終了) → "escape"

          puts "[command list]"
          num = 0
          enemies.each do |enemy|
            puts "[#{num}] #{enemy.name} を攻撃する"
            num += 1
          end
          puts "[#{num}] #{player.recovery_magic.name} を唱える。" if player.can_use_recovery_magic?
          puts "[#{num+1}] 逃げる。"

          print "行動入力:"
          order = gets.chomp()
          order = order.to_i
          p order
          puts ""

          # enemyを選択
          enemy = enemies[order]
        else
          num = [enemies.length, 1].max
          random = Random.new.rand(num)
          enemy = enemies[random]
        end

        # 攻撃する敵をランダムで選ぶ
        # num = [enemies.length, 1].max
        # random = Random.new.rand(num)
        # enemy = enemies[random]

        attack_faith(player, enemy, turn)
      end
    end
  end

  private

  def attack_faith(attacker, defencer, turn)
    status = attacker.attack
    def_msg = ""
    if !status[:atk].nil?
      damege = [status[:atk] - defencer.defe, 0].max
      def_msg = defencer.defence(damege)
    end
    broadcastingan(status[:msg], def_msg, turn)
  end

  def gameset?(players)
    # true条件：同一チームの全てのメンバーのHPが0以下になる
    @teams.each do |team|
      hps = []
      players.each do |player|
        if team == player.team
          hps.push(player.hp)
        end
      end
      return true if (hps.select do |hp| hp > 0 end).empty?
    end
    false
  end

  def broadcastingan(atk_msg, def_msg, turn)
    p "#-----#{turn}ターン-----#"
    p atk_msg
    p def_msg if !def_msg.empty?
  end

  def enemy?(suspect, player)
    return false if suspect.hp <= 0
    if !suspect.team.nil? || !player.team.nil?
      return false if suspect.team == player.team
    end
    true
  end

  def extract_team(players)
    teams = []
    players.each do |player|
      teams.push(player.team)
    end
    teams.uniq
  end
end
