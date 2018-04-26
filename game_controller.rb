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

        if player.team == "hero" && player.mode == "manual"
          # 勇者がプレーヤー操作の場合
          show_status(player)
          show_enemy_list(enemies)
          show_command_list(player, enemies)

          enemies_num = count_enemies(enemies)
          while true
            print "行動入力:"
            order = gets.chomp()
            break if correct_order?(order, enemies_num, player)
          end
          puts ""

          set_command(player, order)
          # enemyを選択
          enemy = enemies[order.to_i]
        else
          num = [enemies.length, 1].max
          random = Random.new.rand(num)
          enemy = enemies[random]
        end

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

  def count_enemies(enemies)
    num = 0
    enemies.each do |enemy|
      num += 1
    end
    num
  end

  def correct_order?(order, enemies_num, player)
    return true if order == "0"
    # 逃げるコマンド
    return true if order == "."
    # 回復魔法コマンド
    return true if (order == "r" && player.can_use_recovery_magic?)
    return true if (order.to_i > 0 && order.to_i < enemies_num)
    false
  end

  def show_status(player)
    puts "\n-------------------------------------------------"
    puts "#{player.name}\n HP:#{player.hp}\n MP:#{player.mp}\n\n"
  end

  def show_enemy_list(enemies)
    puts "[Enemies List]"
    enemy_num = 0
    enemies.each do |enemy|
      puts " No.#{enemy_num} #{enemy.name} (HP: #{enemy.hp})"
      enemy_num += 1
    end
    puts ""
  end

  def show_command_list(player, enemies)
    puts "[Command List]"
    num = 0
    enemies.each do |enemy|
      puts " [#{num}] \"#{enemy.name}\" を攻撃する"
      num += 1
    end
    puts " [r] #{player.recovery_magic.name} を唱える" if player.can_use_recovery_magic?
    puts " [.] 逃げる\n\n"
  end

  def set_command(player, order)
    if order == "."
      puts "#{player.name}は逃げ出した..."
      exit
    elsif order == "r"
      player.command = "recovery_magic"
    else
      player.command = "attack"
    end
  end
end
