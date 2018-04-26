# encoding: utf-8
# name  名前
# HP    体力
# MP    魔力
# ATK   攻撃力
# DEF   守備力
# SPD   はやさ
# MAX_HP  最大体力
# MAX_MP  最大魔力
# team   敵味方の識別子
class Actor
  attr_reader :name, :atk, :defe, :spd, :max_hp, :max_mp
  attr_accessor :hp, :mp, :team

  def initialize(name, hp, mp, atk, defe, spd, team = nil)
    @name = name
    @hp = hp
    @mp = mp
    @atk = atk
    @defe = defe
    @spd = spd
    @max_hp = hp
    @max_mp = mp
    @team = team
  end

  def attack
    { atk: @atk, msg: "#{name}は、殴りかかった！" }
  end

  def defence(damage)
    @hp -= damage
    "#{name}に、#{damage}のダメージ！ (HP:#{@hp})"
  end
end
