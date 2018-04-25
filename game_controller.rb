# encoding: utf-8
Dir['./model/*.rb'].each { |file| require file }

class GameController
  attr_reader :hero, :monster
  def initialize(hero, monster)
    @hero = hero
    @monster = monster
    @players = []

    @hero.team = "hero" if @hero.team.nil?
    # @hero.mode = "auto" if hero.mode.nil?
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

        # 攻撃する敵をランダムで選ぶ
        num = [enemies.length, 1].max
        random = Random.new.rand(num)
        enemy = enemies[random]

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

  def manual_mode_broadcastingan(atk_msg, def_msg, turn)
  end

  def enemy?(suspect, player)
    return false if suspect.hp <= 0
    if !suspect.team.nil? ||  !player.team.nil?
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
