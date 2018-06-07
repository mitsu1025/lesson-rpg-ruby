# encoding: utf-8
require_relative './actor'
require_relative './item'

class Hero < Actor
  attr_accessor :weapon, :armor

  def attack
    return super if @weapon.nil?
    random = Random.new.rand(5)
    if random == 3
      { atk: @weapon.atk, msg: "!!!#{name}は、#{@weapon.name}を使った!!!" }
    else
      super
    end
  end
end
