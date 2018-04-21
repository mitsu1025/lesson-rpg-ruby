# encoding: utf-8
require_relative './actor'
require_relative './item'

class Hero < Actor
  attr_accessor :weapon, :armor

  def initialize(name, hp, mp, atk, defe, spd)
    super
    @physical_atk = atk
    @physical_defe = defe
  end

  def equip_weapon
    return @atk = @physical_atk if @weapon.nil?
    @atk = @physical_atk + @weapon.atk
    p "#{name}は#{@weapon.name}を装備した。(攻撃力:#{@physical_atk}->#{atk})"
  end

  def equip_armor
    return @defe = @physical_defe if @armor.nil?
    @defe = @physical_defe + @armor.defe
    p "#{name}は#{@armor.name}を装備した。(守備力:#{@physical_defe}->#{defe})"
  end

  def attack
    return super if @weapon.nil?
    { atk: @atk, msg: "#{name}は、#{@weapon.name}で殴りかかった！" }
  end
end
