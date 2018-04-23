# encoding: utf-8
class Magic
  attr_reader :name, :atk, :mp
  def initialize(name, atk, mp)
    @name = name
    @atk = atk
    @mp = mp
  end
end

class RecoveryMagic
  attr_reader :name, :hp, :mp
  def initialize(name, hp, mp)
    @name = name
    @hp = hp
    @mp = mp
  end
end
