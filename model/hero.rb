# encoding: utf-8
require_relative './actor'
require_relative './item'
require_relative './recover'
require_relative './armor'

class Hero < Actor
  attr_accessor :weapon, :recover, :armor

  def ptc
    defe = self.defe
    if @armor.nil?
      return super
    else
      defe += @armor.defe
      "#{self.name}は、#{@armor.name}を装備して防御力が#{@armor.defe}上がっている"
    end
  end
 
  def attack
    return super if @weapon.nil?
    return super if @recover.nil?
    random = Random.new.rand(5)
    if random == 3
      { atk: @weapon.atk, msg: "!!!#{name}は#{@weapon.name}を使った!!!" }
    elsif random == 4
      self.hp += @recover.hp
      { atk: @recover.atk, msg: "*****#{name}は#{@recover.name}を唱えた！HPを#{@recover.hp}回復！さらに攻撃!" }
    else
      super
    end
  end
end
