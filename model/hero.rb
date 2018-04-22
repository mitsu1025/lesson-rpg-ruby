# encoding: utf-8
require_relative './actor'
require_relative './item'

class Hero < Actor
  attr_accessor :weapon, :armor, :recovery_magic

  def initialize(name, hp, mp, atk, defe, spd)
    super
    @physical_atk = atk
    @physical_defe = defe
  end

  def attack
    if can_use_recovery_magic? 
      random = Random.new.rand(5)
      if random == 4
        self.mp -= @recovery_magic.mp
        self.hp = [@recovery_magic.hp + self.hp, self.max_hp].min
        return { atk: nil, msg: "#{name}は、#{@recovery_magic.name}を唱えた。"}
      end
    end

    return super if @weapon.nil?
    { atk: @atk, msg: "#{name}は、#{@weapon.name}で殴りかかった！" }
  end

  def equip
    equip_weapon
    equip_armor
  end

  private

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

  def can_use_recovery_magic?
    return false if @recovery_magic.nil?
    return false if (@mp - @recovery_magic.mp) < 0
    true
  end
end
