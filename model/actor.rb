# encoding: utf-8
# name  名前
# HP    体力
# MP    魔力
# ATK   攻撃力
# DEF   守備力
# SPD   はやさ

class Actor
  attr_reader :name, :atk, :defe, :spd
  attr_accessor :hp, :mp  

  def initialize(name, hp, mp, atk, defe, spd)
    @name = name
    @hp = hp
    @mp = mp
    @atk = atk
    @defe = defe
    @spd = spd
  end
     

  def attack
    { atk: @atk, msg: "#{name}は、殴りかかった！" }
  end

  def defence(damage)
    @hp -= damage
    "#{name}に、#{damage}のダメージ！ (HP:#{@hp})"
  end
  def ptc
      if @hp > 100
        r = "#{name}は平気な顔をしている"
      elsif @hp > 0
        r = "#{name}は苦痛に顔を歪めている"
      else
        r = "#{name}をやっつけた！"
      end
    return r
  end
end
