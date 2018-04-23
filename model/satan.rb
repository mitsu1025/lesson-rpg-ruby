# encoding: utf-8
require_relative './actor'
require_relative './magic'

class Satan < Actor
  attr_accessor :magic_skill, :recovery_magic

  def attack
    return super if @magic_skill.nil?
    return super if (self.mp - @magic_skill.mp) < 0 || (self.mp - @recovery_magic.mp) < 0
    random = Random.new.rand(5)
    if random == 4
      self.mp -= @magic_skill.mp
      { atk: @magic_skill.atk, msg: "☆☆☆☆☆#{name}は、#{@magic_skill.name}を放った！☆☆☆☆☆" }
    elsif random == 3 && can_use_recovery_magic? 
      self.mp -= @recovery_magic.mp
      self.hp = [@recovery_magic.hp + self.hp, self.max_hp].min
      return { atk: nil, msg: "♡♡#{name}は、#{@recovery_magic.name}を唱え、体力を回復した。(HP:#{self.hp} MP:#{self.mp})♡♡"}
    else
      super
    end
  end

  private

  def can_use_recovery_magic?
    return false if @recovery_magic.nil?
    return false if (@mp - @recovery_magic.mp) < 0
    true
  end
end
