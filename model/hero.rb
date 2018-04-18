# encoding: utf-8
require_relative './actor'
require_relative './item'

class Hero < Actor
  attr_accessor :weapon, :armor

  def attack
    if !@weapon.nil? && !@weapon.empty?
    else
      super
    end
  end
end
