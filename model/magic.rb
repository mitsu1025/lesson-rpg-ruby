# encoding: utf-8
class Magic
  attr_reader :name, :atk, :mp
  def initialize(name, atk, mp)
    @name = name
    @atk = atk
    @mp = mp
  end
end
