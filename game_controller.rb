# encoding: utf-8
Dir['./model/*.rb'].each { |file| require file }

class GameController
  attr_reader :hero, :monster
  def initialize(hero, monster)
    @hero = hero
    @monster = monster
  end

  def run
    # 先行，後攻きめ
    playears = [@hero, @monster].sort! do |a, b|
      b.spd <=> a.spd
    end

    # 終了を満たすまで繰り返し
    turn = 0
    until gameset?(playears)
      turn += 1
      playears.each do |player|
        enemies = playears - [player]
        # FIXME: 複数の敵を考慮する
        enemy = enemies[0]
        attack_faith(player, enemy, turn)
        break if enemy.hp <= 0
      end
    end
  end

  private

  def attack_faith(attacker, defencer, turn)
    status = attacker.attack
    damege = [status[:atk] - defencer.defe, 0].max
    def_msg = defencer.defence(damege)
    def_ptc = defencer.ptc
    broadcastingan(status[:msg], def_msg, def_ptc, turn)
  end

  def gameset?(players)
    players.each do |player|
      return true if player.hp <= 0
    end
    false
  end

  def broadcastingan(atk_msg, def_msg, def_ptc, turn)
    p "#-----#{turn}ターン-----#"
    p atk_msg
    p def_msg
    p def_ptc
  end
end
