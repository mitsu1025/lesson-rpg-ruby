# encoding: utf-8
require_relative './actor'
require_relative './magic'

class Satan < Actor
  attr_accessor :magic_skill

  def attack
    return super if @magic_skill.nil?
    return super if (self.mp - @magic_skill.mp) < 0
    random = Random.new.rand(5)
    if random == 4
      self.mp -= @magic_skill.mp
      { atk: @magic_skill.atk, msg: "☆☆☆☆☆#{name}は、#{@magic_skill.name}を放った！☆☆☆☆☆" }
    else
      super
    end
  end
end
