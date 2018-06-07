# encoding: utf-8
require_relative './actor'
require_relative './item'
require_relative './recover'

class Hero < Actor
  attr_accessor :weapon, :armor

  def attack
    return super if @weapon.nil?
    return super if @armor.nil?
    random = Random.new.rand(5)
    if random == 3
      { atk: @weapon.atk, msg: "!!!#{name}は、#{@weapon.name}を使った!!!" }
    elsif random == 4
      self.hp += @armor.hp
      { msg: "*****#{name}は、#{@armor.name}を唱えた！*****" }
    else
      super
    end
  end
end
