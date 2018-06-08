# encoding: utf-8
require_relative './actor'
require_relative './item'
require_relative './recover'

class Hero < Actor
  attr_accessor :weapon, :recover, :armor

  def attack
    return super if @weapon.nil?
    return super if @recover.nil?
    random = Random.new.rand(5)
    if random == 3
      { atk: @weapon.atk, msg: "!!!#{name}は、#{@weapon.name}を使った!!!" }
    elsif random == 4
      self.hp += @recover.hp
      { atk: @weapon.atk, msg: "*****#{name}は、#{@recover.name}を唱えた！*****" }
    else
      super
    end
  end
end
