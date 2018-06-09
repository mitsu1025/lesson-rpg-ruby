class Armor
  attr_reader :name, :defe, :heavy
  def initialize(name, defe, heavy)
    @name = name
    @defe = defe
    @heavy = heavy
  end
end

