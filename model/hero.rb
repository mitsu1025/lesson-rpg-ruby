# encoding: utf-8
require_relative './actor'
require_relative './item'

class Hero < Actor
  attr_accessor :weapon, :armor

  def attack
    return super if @weapon.nil?
  end
end
