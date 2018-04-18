# encoding: utf-8
class Item
  attr_reader :name, :atk, :defe
  def initialize(name, atk, defe)
    @name = name
    @atk = atk
    @defe = defe
  end
end
